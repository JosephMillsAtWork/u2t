#include <QtQml>

class GSettingsQmlPlugin: public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "com.canonical.GSettings")

public:
    void registerTypes(const char *uri);
};
