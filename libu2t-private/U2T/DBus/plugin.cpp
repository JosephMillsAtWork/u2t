#include <QtGlobal>
#include <QtQml>
#include <QQmlExtensionPlugin>


// API Version 2.0
#include "declarativedbus.h"
#include "declarativedbusadaptor.h"
#include "declarativedbusinterface.h"

class Q_DECL_EXPORT NemoDBusPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.nemomobile.dbus")
public:
    void registerTypes(const char *uri)
    {
        // QML API 2.0 (with deprecated fields removed)
        qmlRegisterUncreatableType<DeclarativeDBus>(uri, 2, 0, "DBus", "Cannot create DBus objects");
        qmlRegisterType<DeclarativeDBusAdaptor>(uri, 2, 0, "DBusAdaptor");
        qmlRegisterType<DeclarativeDBusInterface>(uri, 2, 0, "DBusInterface");
    }
};
