#include "session_plugin.h"
#include <qqml.h>

// local
#include "sessionmanager.h"
void Libu2t_PrivatePlugin::registerTypes(const char *uri)
{
    // @uri U2T.Session
    qmlRegisterSingletonType<SessionManager>(uri, 1, 0, "SessionManager",
            SessionManager::qmlSingleton);
}



