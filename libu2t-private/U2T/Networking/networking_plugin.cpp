#include "networking_plugin.h"
#include <qqml.h>

// local
#include "availabledevices.h"
#include "appletproxymodel.h"
#include "connectionicon.h"
#include "enabledconnections.h"
#include "enums.h"
#include "handler.h"
#include "networkmodel.h"
#include "networkstatus.h"


void Libu2t_PrivatePlugin::registerTypes(const char *uri)
{
    // @uri U2T.Networking
    qmlRegisterType<AppletProxyModel>(uri, 1, 0, "AppletProxyModel");
    qmlRegisterType<AvailableDevices>(uri, 1, 0, "AvailableDevices");
    qmlRegisterType<ConnectionIcon>(uri, 1, 0, "ConnectionIcon");
    qmlRegisterType<EnabledConnections>(uri, 1, 0, "EnabledConnections");
    qmlRegisterUncreatableType<Enums>(uri, 1, 0, "Enums",
                                      QStringLiteral("Can't instantiate Enums objects"));
    qmlRegisterType<Handler>(uri, 1, 0, "Handler");
    qmlRegisterType<NetworkModel>(uri, 1, 0, "NetworkModel");
    qmlRegisterType<NetworkStatus>(uri, 1, 0, "NetworkStatus");

}



