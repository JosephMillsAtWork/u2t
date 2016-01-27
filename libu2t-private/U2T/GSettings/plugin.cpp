#include "plugin.h"
#include "gsettings-qml.h"

void GSettingsQmlPlugin::registerTypes(const char *uri)
{
    qmlRegisterType<GSettingsQml>(uri, 1, 0, "GSettings");
    qmlRegisterUncreatableType<GSettingsSchemaQml>(uri, 1, 0, "GSettingsSchema",
                                                   "GSettingsSchema can only be used inside of a GSettings component");
}
