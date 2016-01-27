#include "hardware_plugin.h"
#include <qqml.h>

// local
#include "hardwareengine.h"

void Libu2t_PrivatePlugin::registerTypes(const char *uri)
{
    // @uri U2T.Hardware
    // Hardware (battery and storage)

    qmlRegisterType<HardwareEngine>(uri, 1, 0, "HardwareEngine");
    qmlRegisterUncreatableType<Battery>(uri, 1, 0, "Battery",
            QStringLiteral("Cannot create Battery object"));
    qmlRegisterUncreatableType<StorageDevice>(uri, 1, 0, "StorageDevice",
            QStringLiteral("Cannot create StorageDevice object"));

}



