// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../launcher"
import "../common/units.js" as Units
import "../common/utils.js" as Utils
import "../common"
FocusScope {
    id: launcher
    property string activeComponent
    signal itemClicked(string id)
    function hideMenu() {}
    function focusBFB() {
        launcher.focus = true
        systemsettingsLens.forceActiveFocus()
    }
    Rectangle {
        id: background
        anchors.fill: parent
        anchors.rightMargin: Units.tvPx(-1)
        color: unity2dConfiguration.formFactor == "tv" ? Utils.darkAubergineDesaturated : "black"
        opacity: unity2dConfiguration.formFactor == "tv" ? 0.56 : 0.66
        visible: unity2dConfiguration.formFactor == "tv" || screen.isCompositingManagerRunning

        border.color: "#28ffffff"
        border.width: Units.tvPx(2)
    }

    onActiveFocusChanged: if (!activeFocus) systemsettingsLens.focus = true

    Flickable {
        anchors.fill: parent
        contentHeight: column.height
        anchors.margins: Units.tvPx(9)

        Column {
            id: column
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: Units.tvPx(9)


    SimpleLauncherItem {
        id: systemsettingsLens
        focus: true
        height: parent.height / 12
        icon: "media-player"
        active: launcher.activeComponent == "systemsettings"

        //     KeyNavigation.up: nokiamaps
        //     KeyNavigation.down: videoLens
        onClicked: launcher.itemClicked("systemsettings")
    }
}
}
}

