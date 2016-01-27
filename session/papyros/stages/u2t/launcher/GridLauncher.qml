import QtQuick 1.0
import "../common"
import "../common/utils.js" as Utils
import "../common/units.js" as Units

FocusScope {
    id: launcher
    property string activeComponent
    signal itemClicked(string id)
    function hideMenu() {}
    function focusBFB() {
        launcher.focus = true
        videoLens.forceActiveFocus()
    }
    Rectangle{
    width: parent.width
    height: parent.height
    gradient: Gradient{
        GradientStop{position: .1;color:"#4a4c56"}
        GradientStop{position: 1;color:"#454751"}

}

    }






//    Rectangle {
//        id: background
//        anchors.fill: parent
//        anchors.rightMargin: Units.tvPx(-1)
//        color: unity2dConfiguration.formFactor == "tablet" ? "#C7C7C7": Utils.darkAubergineDesaturated
//        opacity: unity2dConfiguration.formFactor == "tablet" ? 1 : 0.66
//        visible: unity2dConfiguration.formFactor == "tablet" || screen.isCompositingManagerRunning

//        border.color: "#77ffffff"
//        border.width: Units.tvPx(13)
//    }

//    onActiveFocusChanged: if (!activeFocus) videoLens.focus = true

//    Flickable {
//        contentWidth: background.width
//        anchors.margins: Units.tvPx(9)
//        Column {
//            id: column
//            rotation: 90 + 90 +90
//            anchors.left: parent.left
//            anchors.leftMargin: 20
//            spacing: Units.tvPx(9)
//            width: 120
//            height: parent.height

//            GridLauncherItem {
//                id: itv
//                rotation: 90
//                icon: "ubuntu-lens"
//                active: launcher.activeComponent == "itv"
//                enabled: true
//                KeyNavigation.left: softwarecenter
//                KeyNavigation.right: videoLens
//                onClicked: launcher.itemClicked("itv")
//            }


//            GridLauncherItem {
//                id: videoLens
//                rotation: 90

//                icon: "video-lens"
//                focus: true
//                active: launcher.activeComponent == "video.lens"
//                enabled: true
//                KeyNavigation.left: itv
//                KeyNavigation.right: epg
//                onClicked: launcher.itemClicked("video.lens")
//            }

//            GridLauncherItem {
//                id: epg
//                icon: "tvpicker"
//                rotation: 90

//                active: launcher.activeComponent == "mythweb"
//                enabled: true
//                KeyNavigation.left: videoLens
//                KeyNavigation.right: musicLens
//                onClicked: launcher.itemClicked("mythweb")
//            }


//            GridLauncherItem {
//                id: musicLens
//                icon: "music-lens"
//                rotation: 90

//                focus: true
//                active: launcher.activeComponet == "musicLens"
//                enabled: true
//                KeyNavigation.left: epg
//                KeyNavigation.right: appLens
//                onClicked: launcher.itemClicked("music.lens")

//            }

//            GridLauncherItem {
//                id: appLens
//                icon: "app-lens"
//                focus: true
//                rotation: 90

//                active: launcher.activeComponet == "applications.lens"
//                enabled: true
//                KeyNavigation.left: musicLens
//                KeyNavigation.right: filelens
//                onClicked: launcher.itemClicked("applications.lens")
//            }

//            GridLauncherItem {
//                id: filelens
//                icon: "files-lens"
//                focus: true
//                active: launcher.activeComponet == "files.lens"
//                rotation: 90

//                enabled: true
//                KeyNavigation.left: appLens
//                KeyNavigation.right: photolens
//                onClicked: launcher.itemClicked("files.lens")
//            }

//            GridLauncherItem {
//                id: photolens
//                icon: "photo-lens"
//                focus: true
//                rotation: 90

//                active: launcher.activeComponet == "photo.lens"
//                enabled: true
//                KeyNavigation.left: filelens
//                KeyNavigation.right: softwarecenter
//                onClicked: launcher.itemClicked("photo.lens")
//            }

//            GridLauncherItem {
//                id: softwarecenter
//                icon: "usc1-lens"
//                focus: true
//                active: launcher.activeComponet == "softwarecenter"
//                enabled: true
//                rotation: 90

//                KeyNavigation.left: photolens
//                KeyNavigation.right: itv
//                onClicked: launcher.itemClicked("softwarecenter")
//            }
//        }
//    }
//}
}
