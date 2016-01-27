#ifndef LIBU2T_PRIVATE_PLUGIN_H
#define LIBU2T_PRIVATE_PLUGIN_H

#include <QQmlExtensionPlugin>
#include <QQmlEngine>

class Libu2t_PrivatePlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri);

};

#endif // LIBU2T_PRIVATE_PLUGIN_H

