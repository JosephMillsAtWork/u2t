import QtQuick 2.3
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.3
Rectangle {
    id: card

    property bool showing: mouseArea.containsMouse

    property var notification

    radius: Units.dp(2)

    width: parent.width
    height: subLabel.lineCount == 1  ? 72 : 88

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        anchors.margins: -10
        hoverEnabled: true

        Rectangle {
            anchors.top: parent.top
            anchors.left: parent.left

            width: 30
            height: width
            radius: width/2

            color: "#333"

            opacity: mouseArea.containsMouse ? 1 : 0

            Behavior on opacity {
                NumberAnimation { duration: 250 }
            }

            Button {
                iconName: "navigation/close"
                anchors.centerIn: parent
//                color: "white"
//                size: Units.dp(16)

                onClicked: {
                    print("Closing...")
                    notifyServer.closeNotification(notification.hasOwnProperty("id")
                            ? notification.id : notification.notificationId)
                }
            }
        }
    }

    GridLayout {
        anchors.fill: parent

        anchors.leftMargin: 16
        anchors.rightMargin: 16

        columns: 4
        rows: 1
        columnSpacing: 16

        Item {
            id: actionItem

            Layout.preferredWidth: 40
            Layout.preferredHeight: width
            Layout.alignment: Qt.AlignCenter
            Layout.column: 1

            visible: children.length > 1 || icon.valid

            Image {
                id: icon

                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                }

                visible: valid
//                color: Theme.light.iconColor
//                size: Units.dp(24)
                width: 24
                height: 24
                source: {
                    if (!notification || !notification.iconName) {
                        return ""
                    } else if (notification.iconName.indexOf("/") === 0 ||
                            notification.iconName.indexOf("://") !== -1) {
                        return notification.iconName
                    } else {
                        return "image://theme/" + notification.iconName
                    }
                }
            }
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Layout.fillWidth: true
            Layout.column: 2

            spacing: 3

            RowLayout {
                Layout.fillWidth: true

                spacing: 8

                Label {
                    id: label

                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillWidth: true

                    elide: Text.ElideRight
//                    text: : "subheading"
                    text: notification ? notification.summary : ""
                }

                Label {
                    id: valueLabel

                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredWidth: visible ? implicitWidth : 0

                    color: Theme.light.subTextColor
                    elide: Text.ElideRight
                    horizontalAlignment: Qt.AlignHCenter
//                    style: "body1"
                    visible: text != ""
                    text: notification && notification.progress > -1
                            ? "%1%".arg(notification.progress) : ""
                }
            }

            Item {
                id: contentItem

                Layout.fillWidth: true
                Layout.preferredHeight: showing ? subLabel.implicitHeight : 0

                property bool showing: visibleChildren.length > 0

                ProgressBar {
                    visible: notification && notification.progress > -1
                    value: (notification ? notification.progress : 0)/100
                    width: parent.width
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Label {
                id: subLabel

                Layout.fillWidth: true

                color: Theme.light.subTextColor
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
//                style: "body1"

                visible: text != "" && !contentItem.showing
                text: notification ? notification.body : ""
                maximumLineCount: 2
            }
        }

        Item {
            id: secondaryItem
            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: childrenRect.width
            Layout.preferredHeight: parent.height
            Layout.column: 4

            visible: childrenRect.width > 0
        }
    }
}
