import QtQuick 2.3
import QtQuick.Dialogs 1.2
import U2T.GSettings 1.0

Rectangle {
    width: 100
    height: 62
    color: "transparent"

    Column{
        id: headerCol
        width:  parent.width
        height: headerSettings.paintedHeight + 4
        spacing: 2
        Text {
            id: headerSettings
            text: qsTr("Settings")
            color: "white"
            font.pixelSize: 48
            //        anchors.top: parent.top
            //        anchors.topMargin: 12

        }
        Rectangle{
            width: parent.width  - 20
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            height:   1
        }
    }

    Loader{
        id: settingsSubLoader
        width: parent.width
        height: parent.height - headerCol.height
        source: "qrc:/dash/Settings/BaseSettings.qml"
        anchors.top: headerCol.bottom

    }
}
