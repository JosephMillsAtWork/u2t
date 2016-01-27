import QtQuick 2.4
import Material 0.1

View {
    anchors.centerIn: parent

    width: Units.dp(500)
    height: Units.dp(350)
    elevation: 2
    radius: Units.dp(2)

    opacity: shell.state == "developer" ? 1 : 0
    visible: opacity > 0

    Behavior on opacity {
        NumberAnimation {
            duration: 250
        }
    }

    Item {
        id: actionBar
        height: Units.dp(64)

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            leftMargin: Units.dp(20)
            rightMargin: Units.dp(20)
        }

        IconButton {
            id: closeIcon

            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
            }

            iconName: "navigation/close"
            onClicked: shell.toggleDeveloperTools()
        }

        Label {
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
            }

            text: "Developer Tools Fool"
            style: "title"
            color: "green" //Theme.light.iconColor
        }
    }

    TextEdit {
        anchors {
            left: parent.left
            right: parent.right
            top: actionBar.bottom
            bottom: parent.bottom
            margins: Units.dp(20)
        }

        readOnly: true
        text: shell.logs
    }
}
