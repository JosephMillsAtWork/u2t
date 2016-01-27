import QtQuick 2.0
import GSettings 1.0
import Papyros.Indicators 0.1
import org.kde.kcoreaddons 1.0 as KCoreAddons
import "launcher"
import "common/utils.js" as Utils
import "common/units.js" as Units
import "dash"
import "dash/previews"
import "../"
import "indicators"
Item {
    id: shell
    property variant declarativeView
    property variant dashLoader
    property variant hudLoader

    property bool dashActive: baseSchema.formFactor === "tv" ? true : false
    Component.onCompleted: {
//        console.log("the Schemas for u2t " + baseSchema.keys() + " form factor= ?  " + baseSchema.formFactor)
    }

    // Set all the GSettings things
    GSettings{
        id: launcherSchema
        schema.id: "com.iheartqt.U2T.Launcher"
    }
    GSettings{
        id: dashSchema
        schema.id: "com.iheartqt.U2T.Dash"
    }
    GSettings{
        id: pannelSchema
        schema.id: "com.iheartqt.U2T.Pannel"
    }
    GSettings{
        id: baseSchema
        schema.id: "com.iheartqt.U2T"
    }
    Image {
        id: wallpaper
        anchors.fill: parent
        source: baseSchema.formFactor === "tv" ? "artwork/wallpaper.png" : baseSchema.background
        opacity:  .99
        fillMode: Image.PreserveAspectCrop
    }

    onDashLoaderChanged: {
        if (dashActive) {
            if (dashLoader === undefined)
            {
                launcherLoader.visibilityController.endForceVisible("dash")
            } else {
                launcherLoader.visibilityController.beginForceVisible("dash")
            }
        }
    }

    onHudLoaderChanged: {
        if (shellManager.hudActive && launcherSchema.hideMode !== 0) {
            if (hudLoader === undefined)
            {
                launcherLoader.visibilityController.endForceHidden("hud")
            } else {
                launcherLoader.visibilityController.beginForceHidden("hud")
            }
        }
    }
    Indicator{
        id: pannel
        width: parent.width
    }
    //Fix me add glib setting for launcher size and make a slide bar to control. set the TV launcher to be dashlauncher * 1.03
    LauncherLoader {
        id: launcherLoader
        width: if (baseSchema.formFactor === "desktop")
                   64
               else if (baseSchema.formFactor === "tv")
                   parent.width / 17
               else if (baseSchema.formFactor === "tablet")
                   parent.width
        height:  if (baseSchema.formFactor === "tablet")
                     parent.height / 5
        anchors.top: {
//            if (baseSchema.formFactor === "desktop" || baseSchema.formFactor === "tv")
            pannel.bottom
        }
        anchors.bottom: parent.bottom
        property int hiddenX: launcherSchema.launcherLocation === "left" ? -width : shell.width
        property int shownX: launcherSchema.launcherLocation === "left" ? 0 :  (shell.width) - launcherLoader.width


        Binding {
            target: launcherLoader.item
            property: "showMenus"
            value: (dashLoader === undefined || !dashLoader.item.active) &&
                   (hudLoader === undefined || !hudLoader.item.active)
        }
    }




}

