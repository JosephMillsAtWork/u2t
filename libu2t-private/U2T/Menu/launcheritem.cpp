#include <QDebug>
#include <QProcess>
#include <QFile>
#include <QDir>
#include <QSettings>
#include <QTimer>
#include <QStandardPaths>
#include "mdesktopentry.h"

#include "launcheritem.h"


LauncherItem::LauncherItem(const QString &filePath, QObject *parent)
    : QObject(parent),
      m_interface("io.u2t.session", "/U2TSession", "io.u2t.launcher", QDBusConnection::sessionBus()),
      _isLaunching(false)

{
    if (!filePath.isEmpty()) {
        setFilePath(filePath);
    }

    setAllFiles();




}


LauncherItem::LauncherItem(MDesktopEntry* desktopEntry, QObject *parent)
    : QObject(parent),
      m_interface("io.u2t.session", "/U2TSession", "io.u2t.launcher", QDBusConnection::sessionBus()),
      _isLaunching(false)
{

     _desktopEntry = QSharedPointer<MDesktopEntry>(desktopEntry);

    emit this->itemChanged();

    // TODO: instead of this, match the PID of the window thumbnails with the launcher processes
    // Launching animation will be disabled if the window of the launched app shows up
//    connect(HomeWindowMonitor::instance(), SIGNAL(isHomeWindowOnTopChanged()), this, SLOT(disableIsLaunching()));
}

LauncherItem::~LauncherItem()
{
    // FIXME add signal for when this is got and expose to QML
//    connect(this,SIGNAL(fillingModel()),
//            this,SLOT(gotAll()));

}

void LauncherItem::setFilePath(const QString &filePath)
{
    if (!filePath.isEmpty()) {
        _desktopEntry = QSharedPointer<MDesktopEntry>(new MDesktopEntry(filePath));
    } else {
        _desktopEntry.clear();
    }

    emit this->itemChanged();
}


QString LauncherItem::filePath() const
{
    return !_desktopEntry.isNull() ? _desktopEntry->fileName() : QString();
}

QString LauncherItem::name() const
{
    return !_desktopEntry.isNull() ? _desktopEntry->name() : QString();
}

QString LauncherItem::nameUnlocalized() const
{
    return !_desktopEntry.isNull() ? _desktopEntry->nameUnlocalized() : QString();
}

QString LauncherItem::type() const
{
    return !_desktopEntry.isNull() ? _desktopEntry->type() : QString();
}

QString LauncherItem::url() const
{
    return !_desktopEntry.isNull() ? _desktopEntry->url() : QString();
}

QString LauncherItem::version() const
{
    return !_desktopEntry.isNull() ? _desktopEntry->version() : QString();
}

QString LauncherItem::icon() const
{
    return !_desktopEntry.isNull() ? _desktopEntry->icon() : QString();
}

QStringList LauncherItem::categories() const
{
    return !_desktopEntry.isNull() ? _desktopEntry->categories() : QStringList();
}

QString LauncherItem::comment() const
{
    return !_desktopEntry.isNull() ? _desktopEntry->comment() : QString();
}

QString LauncherItem::exec() const
{
    return !_desktopEntry.isNull() ? _desktopEntry->exec() : QString();
}

QString LauncherItem::desktopFileName() const
{
    return !_desktopEntry.isNull() ? _desktopEntry->fileName() : QString();
}

QString LauncherItem::genericName() const
{
    return !_desktopEntry.isNull() ? _desktopEntry->genericName() : QString();
}

uint LauncherItem::hash() const
{
    return !_desktopEntry.isNull() ? _desktopEntry->hash() : uint();
}

bool LauncherItem::hidden() const
{
    return !_desktopEntry.isNull() ? _desktopEntry->hidden() : false;
}

bool LauncherItem::noDisplay() const
{
    return !_desktopEntry.isNull() ? !_desktopEntry->noDisplay() : false;
}

QStringList LauncherItem::notShowIn() const
{
    return !_desktopEntry.isNull() ? _desktopEntry->notShowIn() : QStringList();
}

QStringList LauncherItem::onlyShowIn() const
{
    return !_desktopEntry.isNull() ? _desktopEntry->onlyShowIn() : QStringList();
}

QString LauncherItem::path() const
{
    return !_desktopEntry.isNull() ? _desktopEntry->path() : QString();
}

bool LauncherItem::startupNotify() const
{
    return !_desktopEntry.isNull() ? _desktopEntry->startupNotify() : false;
}

QString LauncherItem::startupWMClass() const
{
    return !_desktopEntry.isNull() ? _desktopEntry->startupWMClass() : QString();
}

bool LauncherItem::terminal() const
{
    return !_desktopEntry.isNull() ? _desktopEntry->terminal() : false;
}

QString LauncherItem::tryExec() const
{
    return !_desktopEntry.isNull() ? _desktopEntry->tryExec() : QString();
}

bool LauncherItem::isValid() const
{
    return !_desktopEntry.isNull() ? _desktopEntry->isValid() : false;
}

QStringList LauncherItem::mimeType() const
{
    return !_desktopEntry.isNull() ? _desktopEntry->mimeType() : QStringList();
}

bool LauncherItem::isLaunching() const
{
    return _isLaunching;
}

QStringList LauncherItem::getAllFiles()
{
    return m_allFiles;
}

void LauncherItem::setAllFiles()
{
//        qDebug() << "Running Init fill" ;


        QStringList paths = QStandardPaths::standardLocations(QStandardPaths::ApplicationsLocation);
        QStringList filter; filter << "*.desktop";
        QStringList allFiles;
        for (QString path : paths) {
            QStringList fileNames = QDir(path).entryList(filter);
            for (QString fileName : fileNames) {
                allFiles << path + "/" + fileName;
            }
        }
        if (m_allFiles == allFiles){
            return;
        }else{
            m_allFiles = allFiles;
            emit getAllFilesChanged();
        }
}

bool LauncherItem::launchApplication(const QString &appId, const QStringList &urls)
{
    return m_interface.call(QStringLiteral("launchApplication"), appId, urls)
            .arguments().at(0).toBool();
}

bool LauncherItem::launchDesktopFile(const QString &fileName, const QStringList &urls)
{
    return m_interface.call(QStringLiteral("launchDesktopFile"), fileName, urls)
            .arguments().at(0).toBool();







}






bool LauncherItem::closeApplication(const QString &appId)
{
    return m_interface.call(QStringLiteral("closeApplication"), appId)
            .arguments().at(0).toBool();
}

bool LauncherItem::closeDesktopFile(const QString &fileName)
{
    return m_interface.call(QStringLiteral("closeDesktopFile"), fileName)
            .arguments().at(0).toBool();
}


void LauncherItem::disableIsLaunching()
{
    if (!_isLaunching)
        return; // prevent spurious signals from all delegates
    _isLaunching = false;
    emit this->isLaunchingChanged();
}

MDesktopEntry* LauncherItem::getDesktopEntry() {
    return _desktopEntry.data();
}

//void LauncherItem::launchApplication()
//{
//    if (_desktopEntry.isNull())
//        return;

//#if defined(HAVE_CONTENTACTION)
//    LAUNCHER_DEBUG("launching content action for" << _desktopEntry->name());
//    ContentAction::Action action = ContentAction::Action::launcherAction(_desktopEntry, QStringList());
//    action.trigger();
//#else
//    LAUNCHER_DEBUG("launching exec line for" << _desktopEntry->name());

//    // Get the command text from the desktop entry
//    QString commandText = _desktopEntry->exec();

//    // Take care of the freedesktop standards things

//    commandText.replace(QRegExp("%k"), filePath());
//    commandText.replace(QRegExp("%c"), _desktopEntry->name());
//    commandText.remove(QRegExp("%[fFuU]"));

//    if (!_desktopEntry->icon().isEmpty())
//        commandText.replace(QRegExp("%i"), QString("--icon ") + _desktopEntry->icon());

//    // DETAILS: http://standards.freedesktop.org/desktop-entry-spec/latest/index.html
//    // DETAILS: http://standards.freedesktop.org/desktop-entry-spec/latest/ar01s06.html

//    // Launch the application
//    QProcess::startDetached(commandText);
//#endif

//    _isLaunching = true;
//    emit this->isLaunchingChanged();

//    // TODO: instead of this, match the PID of the window thumbnails with the launcher processes
//    // Launching animation will stop after 5 seconds
//    QTimer::singleShot(5000, this, SLOT(disableIsLaunching()));
//}
