#include <QtCore/QProcess>
#include <QtCore/QStandardPaths>

#include <qt5xdg/xdgdesktopfile.h>

#include <QtDBus/QDBusConnection>
#include <QtDBus/QDBusError>

#include "processlauncher.h"
#include "sessionmanager.h"

Q_LOGGING_CATEGORY(LAUNCHER, "u2t.session.launcher  For DBUS !!  ")

ProcessLauncher::ProcessLauncher(SessionManager *sessionManager)
    : QDBusAbstractAdaptor(sessionManager)
    , m_sessionManager(sessionManager)
{
}

ProcessLauncher::~ProcessLauncher()
{
    closeApplications();
}

bool ProcessLauncher::registerInterface()
{
    QDBusConnection bus = QDBusConnection::sessionBus();

    if (!bus.registerObject(objectPath, this)) {
        qCWarning(LAUNCHER,
                  "Couldn't register %s D-Bus object: %s",
                  objectPath,
                  qPrintable(bus.lastError().message()));
        return false;
    }

    qCDebug(LAUNCHER) << "Registered" << interfaceName << "D-Bus interface";
    return true;
}

void ProcessLauncher::closeApplications()
{
    qCDebug(LAUNCHER) << "Terminate applications";

    // Terminate all process launched by us
    ApplicationMapIterator i(m_apps);
    while (i.hasNext()) {
        i.next();

        QString fileName = i.key();
        QProcess *process = i.value();

        i.remove();

        qCDebug(LAUNCHER) << "Terminating application from" << fileName << "with pid" << process->pid();

        process->terminate();
        if (!process->waitForFinished())
            process->kill();
        process->deleteLater();
    }
}

bool ProcessLauncher::launchApplication(const QString &appId, const QStringList &urls)
{
    const QString fileName =
            QStandardPaths::locate(QStandardPaths::ApplicationsLocation,
                                   appId + QStringLiteral(".desktop"));
    XdgDesktopFile *entry = XdgDesktopFileCache::getFile(fileName);
    if (!entry->isValid()) {
        qCWarning(LAUNCHER) << "No desktop entry found for" << appId;
        return false;
    }

    return launchEntry(entry, urls);
}

bool ProcessLauncher::launchDesktopFile(const QString &fileName, const QStringList &urls)
{
    XdgDesktopFile *entry = XdgDesktopFileCache::getFile(fileName);
    if (!entry->isValid()) {
        qCWarning(LAUNCHER) << "Failed to open desktop file" << fileName;
        return false;
    }

    return launchEntry(entry, urls);
}

bool ProcessLauncher::closeApplication(const QString &appId)
{
    const QString fileName = appId + QStringLiteral(".desktop");
    return closeEntry(fileName);
}

bool ProcessLauncher::closeDesktopFile(const QString &fileName)
{
    qCDebug(LAUNCHER) << "Closing application for" << fileName;
    return closeEntry(fileName);
}

//bool ProcessLauncher::closePid(const int &thePid)
//{
//    qCDebug(LAUNCHER) << "Closing PID FOR  for" << thePid;
//    return closeEntry(thePid);
//}

bool ProcessLauncher::launchEntry(XdgDesktopFile *entry, const QStringList &urls)
{
    QStringList args = entry->expandExecString(urls);

    if (args.isEmpty())
        return false;

    if (entry->value("Terminal").toBool())
    {
        QString term = getenv("TERM");
        if (term.isEmpty())
            term = "xterm";

        args.prepend("-e");
        args.prepend(term);
    }

    QString command = args.takeAt(0);

    qDebug() << "Launching" << args.join(" ") << "from" << entry->fileName();

    QProcess *process = new QProcess(this);
    process->setProgram(command);
    process->setArguments(args);
    process->setProcessChannelMode(QProcess::ForwardedChannels);
    m_apps[entry->fileName()] = process;
    connect(process, SIGNAL(finished(int)), this, SLOT(finished(int)));
    process->start();
    if (!process->waitForStarted()) {
        qCWarning(LAUNCHER,
                  "Failed to launch \"%s\" (%s)",
                  qPrintable(entry->fileName()),
                  qPrintable(entry->name()));
        return false;
    }

    qCDebug(LAUNCHER,
            "Launched \"%s\" (%s) with pid %lld",
            qPrintable(entry->fileName()),
            qPrintable(entry->name()),
            process->pid());










    return true;
}

bool ProcessLauncher::closeEntry(const QString &fileName)
{
    if (!m_apps.contains(fileName))
        return false;

    QProcess *process = m_apps[fileName];
    process->terminate();
    if (!process->waitForFinished())
        process->kill();
    return true;
}

//bool ProcessLauncher::closePid(const QString &thePid)
//{
//    if (!m_apps.contains(thePid))
//        return false;

//    QProcess *process = m_apps[fileName];
//    process->terminate();
//    if (!process->waitForFinished())
//        process->kill();
//    return true;
//}

void ProcessLauncher::finished(int exitCode)
{
    QProcess *process = qobject_cast<QProcess *>(sender());
    if (!process)
        return;

    QString fileName = m_apps.key(process);
    XdgDesktopFile *entry = XdgDesktopFileCache::getFile(fileName);
    if (entry) {
        qCDebug(LAUNCHER) << "Application for" << fileName << "finished with exit code" << exitCode;
        m_apps.remove(fileName);
        process->deleteLater();
    }
}

#include "moc_processlauncher.cpp"
