#ifndef INDICATORS_PLUGIN_H
#define INDICATORS_PLUGIN_H

#include <QQmlExtensionPlugin>

class IndicatorsPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri);
};

#endif // INDICATORS_PLUGIN_H

