#include "sessionmanager.h"

#include <QtCore/QCoreApplication>
#include <QtCore/QTimer>
#include <QtDBus/QDBusConnection>
#include <QtDBus/QDBusError>

#include <qt5xdg/xdgautostart.h>
#include <qt5xdg/xdgdesktopfile.h>

#include "installpaths.h"
#include "compositorlauncher.h"
#include "processlauncher.h"
// #include "screensaver.h"
#include "sessionadaptor.h"
#include "sessionmanager.h"

#include <sys/types.h>
#include <signal.h>

Q_GLOBAL_STATIC(SessionManager, s_sessionManager)

SessionManager::SessionManager(QObject *parent)
    : QObject(parent)
    , m_launcher(new ProcessLauncher(this))
    , m_idle(false)
    , m_locked(false)
{
    CompositorLauncher *compositorLauncher = CompositorLauncher::instance();

    // Actions to do when the compositor is ready
    connect(compositorLauncher, &CompositorLauncher::started, this, [this] {
        // Autostart applications as soon as the compositor is ready
        QTimer::singleShot(500, this, SLOT(autostart()));
    });

}

SessionManager *SessionManager::instance()
{
    return s_sessionManager();
}

bool SessionManager::initialize()
{
    // Setup environment
    setupEnvironment();

    // Register D-Bus services
    if (!registerDBus())
        return false;

    return true;
}

bool SessionManager::isIdle() const
{
    return m_idle;
}

void SessionManager::setIdle(bool value)
{
    if (m_idle == value)
        return;

    m_idle = value;
    Q_EMIT idleChanged(value);
}

bool SessionManager::isLocked() const
{
    return m_locked;
}

void SessionManager::setLocked(bool value)
{
    if (m_locked == value)
        return;

    m_locked = value;
    Q_EMIT lockedChanged(value);
}

void SessionManager::setupEnvironment()
{
    // Set paths only if we are installed onto a non standard location
    QString path;

    if (qEnvironmentVariableIsSet("PATH")) {
        path = QStringLiteral("%1:%2").arg(INSTALL_BINDIR).arg(QString(qgetenv("PATH")));
        qputenv("PATH", path.toUtf8());
    }

    if (qEnvironmentVariableIsSet("QT_PLUGIN_PATH")) {
        path = QStringLiteral("%1:%2").arg(INSTALL_PLUGINDIR).arg(QString(qgetenv("QT_PLUGIN_PATH")));
        qputenv("QT_PLUGIN_PATH", path.toUtf8());
    }

    if (qEnvironmentVariableIsSet("QML2_IMPORT_PATH")) {
        path = QStringLiteral("%1:%2").arg(INSTALL_QMLDIR).arg(QString(qgetenv("QML2_IMPORT_PATH")));
        qputenv("QML2_IMPORT_PATH", path.toUtf8());
    }

    if (qEnvironmentVariableIsSet("XDG_DATA_DIRS")) {
        path = QStringLiteral("%1:%2").arg(INSTALL_DATADIR).arg(QString(qgetenv("XDG_DATA_DIRS")));
        qputenv("XDG_DATA_DIRS", path.toUtf8());
    }

    if (qEnvironmentVariableIsSet("XDG_CONFIG_DIRS")) {
        path = QStringLiteral("%1:%2:/etc/xdg").arg(INSTALL_CONFIGDIR).arg(QString(qgetenv("XDG_CONFIG_DIRS")));
        qputenv("XDG_CONFIG_DIRS", path.toUtf8());
    }

    if (qEnvironmentVariableIsSet("XCURSOR_PATH")) {
       path = QStringLiteral("%1:%2").arg(INSTALL_DATADIR "/icons").arg(QString(qgetenv("XCURSOR_PATH")));
        qputenv("XCURSOR_PATH", path.toUtf8());
    }

    // Set XDG environment variables
    if (qEnvironmentVariableIsEmpty("XDG_DATA_HOME")) {
        QString path = QStringLiteral("%1/.local/share").arg(QString(qgetenv("HOME")));
        qputenv("XDG_DATA_HOME", path.toUtf8());
    }
    if (qEnvironmentVariableIsEmpty("XDG_CONFIG_HOME")) {
        QString path = QStringLiteral("%1/.config").arg(QString(qgetenv("HOME")));
        qputenv("XDG_CONFIG_HOME", path.toUtf8());
    }

    // Set platform integration
    qputenv("SAL_USE_VCLPLUGIN", QByteArray("kde"));
//    qputenv("QT_PLATFORM_PLUGIN", QByteArray("Material"));
//    qputenv("QT_QPA_PLATFORMTHEME", QByteArray("Material"));
//    qputenv("QT_QUICK_CONTROLS_STYLE", QByteArray("Material"));
    // qputenv("QT_WAYLAND_DISABLE_WINDOWDECORATION", QByteArray("1"));
//    qputenv("XDG_CURRENT_DESKTOP", QByteArray("U2T"));
//    qputenv("XCURSOR_THEME", QByteArray("Adwaita"));
//    qputenv("XCURSOR_SIZE", QByteArray("16"));
}

bool SessionManager::registerDBus()
{
    QDBusConnection bus = QDBusConnection::sessionBus();

    // Start the D-Bus service
    (void)new SessionAdaptor(this);
    if (!bus.registerObject(objectPath, this)) {
        qWarning() << "Couldn't register /U2TSession D-Bus object:"
                                   << qPrintable(bus.lastError().message());
        return false;
    }
    if (!bus.registerService(interfaceName)) {
        qWarning() << "Couldn't register io.u2t.session D-Bus service:"
                                   << qPrintable(bus.lastError().message());
        return false;
    }
    qDebug() << "Registered" << interfaceName << "D-Bus interface";

    // Register process launcher service
    if (!m_launcher->registerInterface())
        return false;
    //
    // // Register screen saver interface
    // if (!m_screenSaver->registerInterface())
    //     return false;

    return true;
}

void SessionManager::autostart()
{
    Q_FOREACH (const XdgDesktopFile &entry, XdgAutoStart::desktopFileList()) {
        if (!entry.isSuitable(true, QStringLiteral("X-U2T")))
            continue;

        qDebug() << "Autostart:" << entry.name() << "from" << entry.fileName();
        m_launcher->launchEntry(const_cast<XdgDesktopFile *>(&entry), QStringList());
    }
}

void SessionManager::logOut()
{
    // Close all applications we launched
    m_launcher->closeApplications();

    // Stop the compositor
    CompositorLauncher::instance()->stop();

    // Exit
    QCoreApplication::quit();
}
