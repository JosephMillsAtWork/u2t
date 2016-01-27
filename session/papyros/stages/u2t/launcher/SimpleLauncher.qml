import QtQuick 2.0
import "../common"
import "../common/utils.js" as Utils
import "../common/units.js" as Units

FocusScope {
    id: launcher
    property string activeComponent
    signal barrierTriggered
    signal itemClicked(string id)
    property bool showMenus: true
    property bool containsMouse: declarativeView.monitoredAreaContainsMouse
    property bool animating: launcherLoaderXAnimation.running
    function hideMenu() {
        if (main.visibleMenu !== undefined) {
            main.visibleMenu.hide()
        }
        if (shelf.visibleMenu !== undefined) {
            shelf.visibleMenu.hide()
        }
    }
    function focusBFB() {
        launcher.focus = true
        videoLens.forceActiveFocus()
    }

    Rectangle {
        id: background
        anchors.fill: parent
        anchors.rightMargin: Units.tvPx(-1)
        color: baseSchema.formFactor === "tv" ? Qt.darker(baseSchema.averageBgColor,4) : "black"
        opacity: baseSchema.formFactor === "tv" ? 0.56 : 0.66
        visible: baseSchema.formFactor === "tv" || screen.isCompositingManagerRunning
        border.color: "#28ffffff"
        border.width: Units.tvPx(2)
    }
    onActiveFocusChanged: if (!activeFocus) videoLens.focus = true
    Flickable {
        anchors.fill: parent
        contentHeight: column.height
        anchors.margins: Units.tvPx(9)
        Column {
            id: column
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: Units.tvPx(9)
            height: parent.height
//fixme make active call to see if itv is fovued and if so  close the dash else change to itv
            SimpleLauncherItem {
                id: itv
                icon: "ubuntu-lens"
                active: launcher.activeComponent == "itv"
                focus: true
                enabled: true
                KeyNavigation.up: softwarecenter
                KeyNavigation.down: videoLens
                onClicked: launcher.itemClicked("itv")

            }
            SimpleLauncherItem {
                id: videoLens
                icon: "video-lens"
                active: launcher.activeComponent == "video.lens"
                enabled: true
                KeyNavigation.up: itv
                KeyNavigation.down: epg
                onClicked: launcher.itemClicked("video.lens")
            }

            SimpleLauncherItem {
                id: epg
                icon: "tvpicker"
                active: launcher.activeComponent == "epg"
                enabled: true
                KeyNavigation.up: videoLens
                KeyNavigation.down: musicLens
                onClicked: launcher.itemClicked("epg")
            }


            SimpleLauncherItem {
                id: musicLens
                icon: "music-lens"
                active: launcher.activeComponet == "musicLens"
                enabled: true
                KeyNavigation.up: epg
                KeyNavigation.down: appLens
                onClicked: launcher.itemClicked("music.lens")
            }
//            SimpleLauncherItem {
//                id: youtube
//                icon: "youtube"
//                active: launcher.activeComponet == "youtube"
//                enabled: true
//                KeyNavigation.up: musicLens
//                KeyNavigation.down: appLens
//                onClicked: launcher.itemClicked("youtube")
//            }
            SimpleLauncherItem {
                id: appLens
                icon: "app-lens"
                active: launcher.activeComponet == "applications.lens"
                enabled: true
                KeyNavigation.up: musicLens
                KeyNavigation.down: filelens
                onClicked: launcher.itemClicked("applications.lens")
            }

            SimpleLauncherItem {
                id: filelens
                icon: "files-lens"
                active: launcher.activeComponet == "files.lens"
                enabled: true
                KeyNavigation.up: appLens
                KeyNavigation.down: photolens
                onClicked: launcher.itemClicked("files.lens")
            }

            SimpleLauncherItem {
                id: photolens
                icon: "photo-lens"
                active: launcher.activeComponet == "photo.lens"
                enabled: true
                KeyNavigation.up: filelens
                KeyNavigation.down: softwarecenter
                onClicked: launcher.itemClicked("photo.lens")
            }

            SimpleLauncherItem {
                id: softwarecenter
                icon: "usc1-lens"
                active: launcher.activeComponet == "softwarecenter"
                enabled: true
                KeyNavigation.up: photolens
                KeyNavigation.down: itv
                onClicked: launcher.itemClicked("softwarecenter")
            }
        }
    }
}
