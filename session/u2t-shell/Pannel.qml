import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 1.4
import U2T.Indicators 1.0
import U2T.Components 1.0

Rectangle {
    id: panelView
    width: parent.width //  Screen.desktopAvailableWidth
    height: 24
    color: "#3e3e3e"


    Row{
        id: pannelIconRows
        height: parent.height
//        width: parent.width / 3
        anchors.right: parent.right
        anchors.rightMargin: 12
        spacing: 3
        IndicatorButton {
            id: stT
            width: 22
            height: 22
            text: "Speech to Text"
            image: "image://theme/" + hardware.primaryBattery.iconName
            object: SpeechToTextIndicator{
                    image: battery.image
                    width: panelView.width / 8
                    height: 40
                    anchors.right: parent.left
                    anchors.top: nmApp.bottom + 5
            }
        }







        IndicatorButton {
            id: nmApp
            width: 22
            height: 22
            text: "Network"
            image:nmRunner.image
            object: NetworkIndicator{
                    id: nmRunner
                    width: panelView.width / 8
                    anchors.right: parent.left
                    anchors.top: nmApp.bottom + 5
            }
        }
        IndicatorButton {
            id: battery
            width: 22
            height: 22
            text: "battery"
            image: "image://theme/" + hardware.primaryBattery.iconName
            object: BatteryIndicator{
                    image: battery.image
                    width: panelView.width / 8
                    height: 40
                    anchors.right: parent.left
                    anchors.top: nmApp.bottom + 5
            }
        }
        IndicatorButton {
            id: volume
            width: 22
            height: 22
            text: "Sound"
            image: "image://theme/audio-volume-high-symbolic"
            object: SoundIndicator{
                    image: volume.image
                    width: panelView.width / 5
                    anchors.right: parent.left
                    anchors.top: nmApp.bottom + 5
            }
        }
        Text {
            id: time
            text: Qt.formatDateTime(now," h:mm ap ")
            color: "white"
            font.pixelSize: 20
            anchors.verticalCenter: parent.verticalCenter
        }
        Text {
            color: "white"
            font.pixelSize: 20
            anchors.verticalCenter: parent.verticalCenter
            text: currentUser.fullName
        }
        IndicatorButton {
            id: system
            width: 22
            height: 22
            text: "Sound"
            image: "image://theme/emblem-system-symbolic"
            object: SettingsIndicator{
                    width: panelView.width / 5
                    anchors.right: parent.left
                    anchors.top: nmApp.bottom + 5
            }
        }
    }

}
