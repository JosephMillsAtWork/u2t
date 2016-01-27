#include "menu_plugin.h"
#include <qqml.h>

// local
#include "launcheritem.h"
#include "application.h"
#include "launchermodel.h"
#include "desktopfile.h"
#include "desktopfiles.h"

void Libu2t_PrivatePlugin::registerTypes(const char *uri)
{
    // @uri U2T
    qmlRegisterType<LauncherItem>(uri,1,0,"DesktopEntry");
    qmlRegisterType<DesktopFile>(uri, 1, 0, "DesktopFile");
    qmlRegisterSingletonType<DesktopFiles>(uri, 1, 0, "DesktopFiles",
            DesktopFiles::qmlSingleton);
    qmlRegisterUncreatableType<Application>(uri, 1, 0, "Application", "Applications are managed by the launcher model");
    qmlRegisterUncreatableType<QObjectListModel>(uri, 1, 0, "QObjectListModel", "For cool animations");

    qmlRegisterSingletonType<LauncherModel>(uri, 1, 0, "AppLauncherModel",
            LauncherModel::launcherSingleton);

    qmlRegisterSingletonType<LauncherModel>(uri, 1, 0, "AppSwitcherModel",
            LauncherModel::switcherSingleton);
}



