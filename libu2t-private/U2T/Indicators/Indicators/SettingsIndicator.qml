import QtQuick 2.3
import U2T.Dialogs 1.0
Rectangle{
    id: ind
    width : 20
    height:  50 *6
    color: "#3e3e3e"

    property string image
    ListView{
        width: parent.width
        height: parent.height
        model: settingsModel
        delegate: Rectangle{
            id: baseDel
            color: ind.color
            width: parent.width
            height: 50
            Text {
                text: qsTr(name)
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: baseDel.color = "#ED7544"
                onExited: baseDel.color = ind.color
                onClicked: page.visable = true
            }
        }
    }
    ListModel{
        id:settingsModel
        ListElement{
            name: "About this computer"
            page: "AboutDialog"
            command: "false"
        }

        ListElement{
            name: "Help"
            page : "HelpDialog"
            command: "false"
        }
        ListElement{
            name: "System Settings"
            page: "systemSettingsDialog"
            command: "false"
        }
        ListElement{
            name: "Lock"
            page: ""
            command: "true"
        }
        ListElement{
            name: "Logout"
            page : "LogoutDialog"
            command: "false"
        }
        ListElement{
            name: "Suspend"
            page: "SuspendDialog"
            command: "false"
        }

        ListElement{
            name: "Logout"
            page: "LogoutDialog"
            command: "false"
        }

    }


    SystemSettingsDialog{id: systemSettingsDialog}
}


