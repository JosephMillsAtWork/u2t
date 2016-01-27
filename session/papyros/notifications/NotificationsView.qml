/*
 * Papyros Shell - The desktop shell for Papyros following Material Design
 * Copyright (C) 2015 Michael Spencer
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.0
import Material 0.1
import Papyros.Desktop 0.1

Item {
    anchors.fill: parent

    opacity: desktop.overlayLayer.currentOverlay ? 0 : 1
    Behavior on opacity {
        NumberAnimation { duration: 200 }
    }

    ListView {
        id: listView

        anchors {
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            margins: Units.dp(16)
        }

        opacity: desktop.overlayLayer.currentOverlays ? 0 : 1

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }

        width: Units.dp(280)

        verticalLayoutDirection: shell.stageName === "classic"
                                 ? ListView.BottomToTop : ListView.TopToBottom
        orientation: Qt.Vertical
        interactive: false

        model: notifyServer.notifications

        spacing: Units.dp(16)

        delegate: NotificationCard {
            notification: edit
        }

        add: Transition {
            SequentialAnimation {
                // Make sure the card is completely off-screen at the start of the animation
                PropertyAction { properties: "y"; value: Units.dp(20) }

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
