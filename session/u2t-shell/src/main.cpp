#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "iconprovider.h"
#include <QStandardPaths>

#include <QQmlContext>
//#include <QIcon>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
//    QString posibleThemes;
//    QStringList themeList = QIcon::themeSearchPaths();
//    for (int l; l < themeList.length(); l++){
//        posibleThemes.append(themeList.at(l));
//    }


    QString homePath;
//    QStringList  s =  QStandard ::HomeLocation();
    QStringList s = QStandardPaths::standardLocations(QStandardPaths::HomeLocation);

    homePath = s.first();

    engine.addImageProvider(QString("theme"), new IconProvider);


    engine.rootContext()->setContextProperty("homePath",homePath);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
