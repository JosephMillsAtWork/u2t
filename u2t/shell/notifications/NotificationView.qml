import QtQuick 2.3

Rectangle {
    anchors.fill: parent

//    opacity: desktop.overlayLayer.currentOverlay ? 0 : 1
    Behavior on opacity {
        NumberAnimation { duration: 200 }
    }

    ListView {
        id: listView

        anchors {
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            margins: 16
        }

//        opacity: desktop.overlayLayer.currentOverlays ? 0 : 1

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }

        width: 280

        verticalLayoutDirection: ListView.BottomToTop
        orientation: Qt.Vertical
        interactive: false

        model: notifyServer.notifications

        spacing: 16

        delegate: NotificationCard {
            notification: edit
        }

        add: Transition {
            SequentialAnimation {
                // Make sure the card is completely off-screen at the start of the animation
                PropertyAction { properties: "y"; value: 20 }

                ParallelAnimation {
                    NumberAnimation { property: "opacity"; from: 0; duration: animationDuration }
                    NumberAnimation { properties: "y"; duration: animationDuration }
                }
            }
        }

        addDisplaced: Transition {
            NumberAnimation { properties: "y"; duration: animationDuration }
        }

        remove: Transition {
            ParallelAnimation {
                NumberAnimation { property: "opacity"; to: 0; duration: animationDuration }
                NumberAnimation { properties: "x"; to: listView.width; duration: animationDuration }
            }
        }

        removeDisplaced: Transition {
            SequentialAnimation {
                PauseAnimation { duration: animationDuration }

                NumberAnimation { properties: "y"; duration: animationDuration }
            }
        }
    }

    property int animationDuration: 300
}
