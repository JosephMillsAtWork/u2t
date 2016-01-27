import QtQuick 2.0
import "../common"
import "../common/utils.js" as Utils

Loader {
    property bool onlyOneLauncher: true
    property bool loadLauncher: !onlyOneLauncher

    id: launcherLoader
    source: if ( baseSchema.formFactor === "tv")
                "SimpleLauncher.qml"
            else if (baseSchema.formFactor === "tablet")
                "GridLauncher.qml"
            else
                "Launcher.qml"
    property variant visibilityController: visibilityController
    onLoaded: item.focus = true
    property bool launcherInHideMode: Utils.clamp(launcherSchema.hideMode, 0, 2) !== 0

//    Timer {
//        // FIXME We need this timer because otherwise changing from
//        // onlyOneLauncher to !onlyOneLauncher gets us in what seems to be a dbus deadlock
//        id: launcher2dConfigurationWorkaround
//        interval: 1
//        onTriggered: launcherLoader.onlyOneLauncher = launcherSchema.onlyOneLauncher
//    }

    VisibilityController {
        id: visibilityController
        behavior: launcherBehavior.status == Loader.Ready ? launcherBehavior.item : null
    }

    Loader {
        id: launcherBehavior

        property variant modesMap: { 0: "../common/visibilityBehaviors/AlwaysVisibleBehavior.qml",
                                     1: "../common/visibilityBehaviors/AutoHideBehavior.qml",
                                     2: "../common/visibilityBehaviors/IntelliHideBehavior.qml" }

        source:if (baseSchema.formFactor === "tv")
                   modesMap[Utils.clamp(baseSchema.hideMode, 0, 2)]
               else if (baseSchema.formFactor === "tablet")
                   return '../common/visibilityBehaviors/ImmediateHideBehavior.qml.qml'
               else if (baseSchema.formFactor === "desktop")
                   modesMap[Utils.clamp(launcherSchema.hideMode, 0, 2)]
               else
                   modesMap[Utils.clamp(launcherSchema.hideMode, 0, 2)]
    }


    Binding {
        target: launcherBehavior
        property: "item.target"
        value: launcherLoader.item
        when: launcherBehavior.status == Loader.Ready
    }

//    Binding {
//        target: declarativeView
//        property: "monitoredArea"
//        value: loadLauncher ? Qt.rect(launcherLoader.x, launcherLoader.item.y, launcherLoader.item.width, launcherLoader.item.height) : Qt.rect(0, 0, 0, 0)
//        when: launcherBehavior.status == Loader.Ready
//    }

    Binding {
        target: launcherBehavior.item
        property: "forcedVisible"
        value: visibilityController.forceVisible
    }

    Binding {
        target: launcherBehavior.item
        property: "forcedVisibleChangeId"
        value: visibilityController.forceVisibleChangeId
    }

    Binding {
        target: launcherBehavior.item
        property: "forcedHidden"
        value: visibilityController.forceHidden
    }

//    Connections {
//        target: shellManager
//        onSuperKeyHeldChanged: {
//            if (superKeyHeld) visibilityController.beginForceVisible()
//            else visibilityController.endForceVisible()
//        }
//    }

//    Connections {
//        target: launcher2dConfiguration
//        onOnlyOneLauncherChanged: {
//            launcher2dConfigurationWorkaround.start()
//        }
//    }

//    Component.onCompleted: launcherLoader.onlyOneLauncher = launcherSchema.onlyOneLauncher
}
