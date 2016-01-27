TEMPLATE = app
QT += core dbus
QT -= gui
CONFIG += c++11 qt

TARGET = u2t-session

#DEFINES += QML2_IMPORT_PATH='$(qmake --query QT_INSTALL_QML)'
#DEFINES += INSTALL_PREFIX=\\\"/usr/\\\"
#DEFINES += INSTALL_BINDIR=\\\"/usr/bin/\\\"
#DEFINES += INSTALL_DATADIR=\\\"\\\"
#DEFINES += INSTALL_CONFIGDIR=\\\"\\\"
#DEFINES += INSTALL_PLUGINDIR=\\\"\\\"

LIBS += -L/usr/lib/x86_64-linux-gnu/ -lQt5Xdg
INCLUDEPATH +=/usr/include/qt5xdg

SOURCES += \
    src/main.cpp \
    src/compositorlauncher.cpp \
    src/loginmanager.cpp \
    src/processlauncher.cpp \
    src/sessionadaptor.cpp \
    src/sessionmanager.cpp \
    src/sigwatch.cpp

HEADERS += \
    src/compositorlauncher.h \
    src/loginmanager.h \
    src/processlauncher.h \
    src/sessionadaptor.h \
    src/sessionmanager.h \
    src/installpaths.h \
    src/sigwatch.h

target.path = /usr/bin/

INSTALLS += target


## SDDM
OTHER_FILES += \
    sddm/Dialogs/Settings.qml \
    sddm/Dialogs/AboutComputer.qml \
    sddm/Dialogs/TTSSettings.qml \
    sddm/Indicators/SettingsIndicator.qml \
    sddm/Indicators/PowerIndicator.qml \
    sddm/Indicators/NetworkIndicator.qml \
    sddm/Indicators/KeyboardIndicator.qml \
    sddm/Indicators/CalenderIndicator.qml \
    sddm/Indicators/BatteryIndicator.qml \
    sddm/images/input.png \
    sddm/images/arrow_navigation.png \
    sddm/images/preferences-desktop-accessibility-symbolic.svg \
    sddm/images/network-wireless-symbolic.svg \
    sddm/images/network-wireless-signal-weak-symbolic.svg \
    sddm/images/network-wireless-signal-ok-symbolic.svg \
    sddm/images/network-wireless-signal-none-symbolic.svg \
    sddm/images/network-wireless-signal-good-symbolic.svg \
    sddm/images/network-wireless-signal-excellent-symbolic.svg \
    sddm/images/network-wireless-offline-symbolic.svg \
    sddm/images/media-zip-symbolic.svg \
    sddm/images/emblem-system-symbolic.svg \
    sddm/images/battery-missing-symbolic.svg \
    sddm/images/battery-low-symbolic.svg \
    sddm/images/battery-low-charging-symbolic.svg \
    sddm/images/battery-good-symbolic.svg \
    sddm/images/battery-good-charging-symbolic.svg \
    sddm/images/battery-full-symbolic.svg \
    sddm/images/battery-full-charging-symbolic.svg \
    sddm/images/battery-full-charged-symbolic.svg \
    sddm/images/battery-empty-symbolic.svg \
    sddm/images/battery-empty-charging-symbolic.svg \
    sddm/images/battery-caution-symbolic.svg \
    sddm/images/battery-caution-charging-symbolic.svg \
    sddm/images/audio-volume-muted-symbolic.svg \
    sddm/images/audio-volume-medium-symbolic.svg \
    sddm/images/audio-volume-low-symbolic.svg \
    sddm/images/audio-volume-high-symbolic.svg \
    sddm/metadata.desktop \
    sddm/theme.conf \
    sddm/Main.qml \
    sddm/IndicatorRow.qml

sddm.files += \
    sddm/metadata.desktop \
    sddm/theme.conf \
    sddm/Main.qml \
    sddm/IndicatorRow.qml


sddmImages.files += \
    sddm/images/arrow_navigation.png \
    sddm/images/input.png \
    sddm/images/preferences-desktop-accessibility-symbolic.svg \
    sddm/images/network-wireless-symbolic.svg \
    sddm/images/network-wireless-signal-weak-symbolic.svg \
    sddm/images/network-wireless-signal-ok-symbolic.svg \
    sddm/images/network-wireless-signal-none-symbolic.svg \
    sddm/images/network-wireless-signal-good-symbolic.svg \
    sddm/images/network-wireless-signal-excellent-symbolic.svg \
    sddm/images/network-wireless-offline-symbolic.svg \
    sddm/images/media-zip-symbolic.svg \
    sddm/images/emblem-system-symbolic.svg \
    sddm/images/battery-missing-symbolic.svg \
    sddm/images/battery-low-symbolic.svg \
    sddm/images/battery-low-charging-symbolic.svg \
    sddm/images/battery-good-symbolic.svg \
    sddm/images/battery-good-charging-symbolic.svg \
    sddm/images/battery-full-symbolic.svg \
    sddm/images/battery-full-charging-symbolic.svg \
    sddm/images/battery-full-charged-symbolic.svg \
    sddm/images/battery-empty-symbolic.svg \
    sddm/images/battery-empty-charging-symbolic.svg \
    sddm/images/battery-caution-symbolic.svg \
    sddm/images/battery-caution-charging-symbolic.svg \
    sddm/images/audio-volume-muted-symbolic.svg \
    sddm/images/audio-volume-medium-symbolic.svg \
    sddm/images/audio-volume-low-symbolic.svg \
    sddm/images/audio-volume-high-symbolic.svg


sddmIndicators.files += \
    sddm/Indicators/SettingsIndicator.qml \
    sddm/Indicators/PowerIndicator.qml \
    sddm/Indicators/NetworkIndicator.qml \
    sddm/Indicators/KeyboardIndicator.qml \
    sddm/Indicators/CalenderIndicator.qml \
    sddm/Indicators/BatteryIndicator.qml


sddmDialogs.files += \
    sddm/Dialogs/Settings.qml \
    sddm/Dialogs/AboutComputer.qml
    sddm/Dialogs/TTSSettings.qml


sddmIndicators.path = /usr/share/sddm/themes/u2t/Indicators
sddmDialogs.path = /usr/share/sddm/themes/u2t/Dialogs
sddmImages.path = /usr/share/sddm/themes/u2t/Images/
sddm.path = /usr/share/sddm/themes/u2t/
INSTALLS +=  sddm sddmDialogs sddmImages sddmIndicators



## SHELL

OTHER_FILES  += \
    u2t-shell/DashLoader.qml \
    u2t-shell/LauncherLoader.qml \
    u2t-shell/main.qml \
    u2t-shell/Pannel.qml \
    u2t-shell/artwork/distributor-logo-debian.png \
    u2t-shell/artwork/user-trash.png \
    u2t-shell/dash/Dash.qml \
    u2t-shell/dash/GridComponent.qml \
    u2t-shell/dash/U2tSettings.qml \
    u2t-shell/dash/Settings/BaseSettings.qml \
    u2t-shell/dash/Settings/SettingHelper.qml \
    u2t-shell/launcher/defaultLauncher.qml \
    u2t-shell/launcher/LauncherItem.qml \
    u2t-shell/notifications/NotificationCard.qml \
    u2t-shell/notifications/NotificationView.qml \
    u2t-shell/notifications/SystemNotification.qml \
    u2t-shell/notifications/SystemNotifications.qml \
    u2t-shell/pannel/Battery.qml \
    u2t-shell/pannel/Hardware.qml \
    u2t-shell/Desktop.qml \
#    u2t-shell/desktop/Desktop.qml \
    u2t-shell/desktop/HotCorner.qml \
    u2t-shell/desktop/HotCorners.qml \
    u2t-shell/desktop/WindowSwitcher.qml \
    u2t-shell/desktop/WindowTooltip.qml \
    u2t-shell/desktop/WorkspacePreview.qml \
    u2t-shell/desktop/WorkspacesView.qml \
    u2t-shell/desktop/WorkspaceView.qml \
    u2t-shell/u2t.qml


mainqml.files += \
    u2t-shell/DashLoader.qml \
    u2t-shell/LauncherLoader.qml \
    u2t-shell/main.qml \
    u2t-shell/Pannel.qml \
    u2t-shell/metadata.desktop \
    u2t-shell/Compositor.qml \
    u2t-shell/Desktop.qml \
    u2t-shell/u2t.qml \
    u2t-shell/WindowManager.js


desktopStyle.files += \
#    u2t-shell/desktop/Desktop.qml \
    u2t-shell/desktop/HotCorner.qml \
    u2t-shell/desktop/HotCorners.qml \
    u2t-shell/desktop/WindowSwitcher.qml \
    u2t-shell/desktop/WindowTooltip.qml \
    u2t-shell/desktop/WorkspacePreview.qml \
    u2t-shell/desktop/WorkspacesView.qml \
    u2t-shell/desktop/WorkspaceView.qml



artwork.files += \
    u2t-shell/artwork/distributor-logo-debian.png \
    u2t-shell/artwork/user-trash.png \

dash.files +=\
    u2t-shell/dash/Dash.qml \
    u2t-shell/dash/GridComponent.qml \
    u2t-shell/dash/U2tSettings.qml \
    u2t-shell/dash/Settings/BaseSettings.qml \
    u2t-shell/dash/Settings/SettingHelper.qml \

launcher.files +=\
    u2t-shell/launcher/defaultLauncher.qml \
    u2t-shell/launcher/LauncherItem.qml \

notifications.files += \
    u2t-shell/notifications/NotificationCard.qml \
    u2t-shell/notifications/NotificationView.qml \
    u2t-shell/notifications/SystemNotification.qml \
    u2t-shell/notifications/SystemNotifications.qml \

pannel.files += \
    u2t-shell/pannel/Battery.qml \
    u2t-shell/pannel/Hardware.qml




mainqml.path = /usr/share/greenisland/shells/io.u2t.shell/
artwork.path = /usr/share/greenisland/shells/io.u2t.shell/artwork
dash.path = /usr/share/greenisland/shells/io.u2t.shell/dash
launcher.path = /usr/share/greenisland/shells/io.u2t.shell/launcher
notifications.path = /usr/share/greenisland/shells/io.u2t.shell/notifications
pannel.path = /usr/share/greenisland/shells/io.u2t.shell/pannel
desktopStyle.path = /usr/share/greenisland/shells/io.u2t.shell/desktop


INSTALLS += mainqml \
            artwork \
            dash \
            launcher \
            notifications \
            pannel \
            desktopStyle




papyros.files += \
    papyros/metadata.desktop \
    papyros/Compositor.qml \
    papyros/DeveloperOverlay.qml \
    papyros/HelpOverlay.qml \
    papyros/KeyboardListener.qml \
    papyros/KeyLabel.qml \
    papyros/OverlayScreen.qml \
    papyros/PowerDialog.qml \
    papyros/Shell.qml

papyrosDashBoard.files += \
    papyros/dashboard/Dashboard.qml \

papyrosDesktop.files += \
    papyros/desktop/Desktop.qml \
    papyros/desktop/HotCorner.qml \
    papyros/desktop/HotCorners.qml \
    papyros/desktop/WindowSwitcher.qml \
    papyros/desktop/WindowTooltip.qml \
    papyros/desktop/WorkspacePreview.qml \
    papyros/desktop/WorkspacesView.qml \
    papyros/desktop/WorkspaceView.qml

papyrosImages.files += \
    papyros/images/papyros-icon.png \
    papyros/images/papyros-wallpaper.png \
    papyros/images/reload.svg \
    papyros/images/sleep.svg \
    papyros/images/workspaces-expose.svg

papyrosLauncher.files += \
    papyros/launcher/AppDrawer.qml


papyrosLock.files += \
    papyros/lockscreen/Lockscreen.qml \

papyrosNotifications.files += \
    papyros/notifications/NotificationCard.qml \
    papyros/notifications/NotificationsView.qml \
    papyros/notifications/SystemNotification.qml \
    papyros/notifications/SystemNotifications.qml \

papyrosPanel.files += \
    papyros/panel/NotificationCenter.qml \
    papyros/panel/SystemCenter.qml \

papyrosStages.files += \
    papyros/stages/classic/AppLauncher.qml \
    papyros/stages/classic/ClassicStage.qml \
    papyros/stages/classic/Launcher.qml \
    papyros/stages/classic/Panel.qml \

papyrosSingleStage.files += \
    papyros/stages/Stage.qml


papyros.path = /usr/share/greenisland/shells/io.u2t.shell/papyros
papyrosDashBoard.path =/usr/share/greenisland/shells/io.u2t.shell/papyros/dashboard/
papyrosDesktop.path = /usr/share/greenisland/shells/io.u2t.shell/papyros/desktop/
papyrosImages.path =/usr/share/greenisland/shells/io.u2t.shell/papyros/images/
papyrosLauncher.path = /usr/share/greenisland/shells/io.u2t.shell/papyros/launcher/
papyrosLock.path = /usr/share/greenisland/shells/io.u2t.shell/papyros/lockscreen/
papyrosNotifications.path = /usr/share/greenisland/shells/io.u2t.shell/papyros/notifications/
papyrosPanel.path = /usr/share/greenisland/shells/io.u2t.shell/papyros/panel/
papyrosStages.path = /usr/share/greenisland/shells/io.u2t.shell/papyros/stages/classic/
papyrosSingleStage.path = /usr/share/greenisland/shells/io.u2t.shell/papyros/stages/classic/


INSTALLS += papyros \
            papyrosDashBoard \
            papyrosDesktop \
            papyrosImages \
            papyrosLauncher \
            papyrosLock \
            papyrosNotifications \
            papyrosPanel \
            papyrosStages \
            papyrosSingleStage





