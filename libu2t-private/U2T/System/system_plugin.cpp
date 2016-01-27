#include "system_plugin.h"
#include <qqml.h>
#include <QQmlApplicationEngine>
#include <QStandardPaths>
#include <QGuiApplication>
#include <QQmlComponent>

// local
#include "qmlprocess.h"
#include "iconprovider.h"
#include "keyeventfilter.h"
#include "kquickconfig.h"
#include "sortfilterproxymodel.h"
#include "iconsfinder.h"

void Libu2t_PrivatePlugin::registerTypes(const char *uri)
{
    // @uri U2T.System
    qmlRegisterType<QQmlProcess>(uri, 1, 0, "QQmlProcess");
    qmlRegisterType<KQuickConfig>(uri, 1, 0, "QQmlConfig");
    qmlRegisterType<KeyEventFilter>(uri, 1, 0, "KeyEventFilter");
    qmlRegisterType<SortFilterProxyModel>(uri,1,0,"QQmlSearchModel");
    qmlRegisterType<IconsFinder>(uri,1,0,"IconHelper");
}

void Libu2t_PrivatePlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{

    Q_UNUSED(uri)
    QString homePath, u2tBinaryPath, applcationsPath, moviesPath, desktopPath, documentsPath , fontsPath
            ,musicPath,picturesPath,tempPath, dataPath,cachePath,runtimePath, configPath,downloadsPath,
            appDataPath,appconfigPath;

    homePath = QStandardPaths::standardLocations(QStandardPaths::HomeLocation).first();
    u2tBinaryPath = QGuiApplication::applicationDirPath();
    applcationsPath = QStandardPaths::standardLocations(QStandardPaths::ApplicationsLocation).first();
    moviesPath = QStandardPaths::standardLocations(QStandardPaths::MoviesLocation).first();
    desktopPath = QStandardPaths::standardLocations(QStandardPaths::DesktopLocation).first();
    documentsPath = QStandardPaths::standardLocations(QStandardPaths::DocumentsLocation).first();
    fontsPath = QStandardPaths::standardLocations(QStandardPaths::FontsLocation).first();
    musicPath = QStandardPaths::standardLocations(QStandardPaths::MusicLocation).first();
    picturesPath = QStandardPaths::standardLocations(QStandardPaths::PicturesLocation).first();
    tempPath = QStandardPaths::standardLocations(QStandardPaths::TempLocation).first();
    dataPath = QStandardPaths::standardLocations(QStandardPaths::DataLocation).first();
    cachePath = QStandardPaths::standardLocations(QStandardPaths::CacheLocation).first();
    runtimePath = QStandardPaths::standardLocations(QStandardPaths::RuntimeLocation).first();
    configPath = QStandardPaths::standardLocations(QStandardPaths::ConfigLocation).first();
    downloadsPath = QStandardPaths::standardLocations(QStandardPaths::DownloadLocation).first();
    appDataPath = QStandardPaths::standardLocations(QStandardPaths::AppDataLocation).first();
    appconfigPath = QStandardPaths::standardLocations(QStandardPaths::AppConfigLocation).first();

    engine->rootContext()->setContextProperty("homePath",homePath);
    engine->rootContext()->setContextProperty("u2tBinaryPath",u2tBinaryPath);
    engine->rootContext()->setContextProperty("applicaitonsPath",applcationsPath);
    engine->rootContext()->setContextProperty("moviesPath",moviesPath);
    engine->rootContext()->setContextProperty("desktopPath",desktopPath);
    engine->rootContext()->setContextProperty("documentsPath",documentsPath);
    engine->rootContext()->setContextProperty("fontsPath",fontsPath);
    engine->rootContext()->setContextProperty("musicPath",musicPath);
    engine->rootContext()->setContextProperty("picturesPath",picturesPath);
    engine->rootContext()->setContextProperty("tempPath",tempPath);
    engine->rootContext()->setContextProperty("dataPath",dataPath);
    engine->rootContext()->setContextProperty("cachePath",cachePath);
    engine->rootContext()->setContextProperty("runtimePath",runtimePath);
    engine->rootContext()->setContextProperty("configPath",configPath);
    engine->rootContext()->setContextProperty("downloadsPath",downloadsPath);
    engine->rootContext()->setContextProperty("appDataPath",appDataPath);
    engine->rootContext()->setContextProperty("appconfigPath",appconfigPath);

    engine->addImageProvider(QString("theme"), new IconProvider);


}



