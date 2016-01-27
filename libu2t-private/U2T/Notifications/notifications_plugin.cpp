#include "notifications_plugin.h"
#include <qqml.h>

// local
#include "notification.h"
#include "notificationserver.h"

void Libu2t_PrivatePlugin::registerTypes(const char *uri)
{
    // @uri U2T.Notifications
    qmlRegisterType<NotificationServer>(uri, 1, 0, "NotificationServer");
    qmlRegisterUncreatableType<Notification>(uri, 1, 0, "Notification", "A notification from NotificationServer");
}



