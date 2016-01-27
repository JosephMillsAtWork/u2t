/*
* Papyros Shell - The desktop shell for Papyros following Material Design
* Copyright (C) 2015 Michael Spencer <sonrisesoftware@gmail.com>
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
import QtQuick 2.3
import QtQuick.Layouts 1.0
import Material 0.1
import Papyros.Components 0.1
import Papyros.Desktop 0.1
import Papyros.Indicators 0.1
import org.kde.kcoreaddons 1.0 as KCoreAddons
import "../../../launcher"
import "../../../desktop"
import "../../classic"
import "../../../notifications"

Rectangle{
    id: panel
    color: baseSchema.averageBgColor
    height: 28
    property list<Indicator> indicators: [
        StorageIndicator {},
        NetworkIndicator {},
        SoundIndicator {},
        BatteryIndicator {},
        ActionCenterIndicator {} //,
//        SystemIndicator {}
    ]
    anchors {
        left: parent.left
        right: parent.right
        top: parent.top
    }

    Item {
        id: overlayLayer

        anchors {
            fill: parent
            leftMargin: stage.item.leftMargin
            rightMargin: stage.item.rightMargin
            topMargin: stage.item.topMargin
            bottomMargin: stage.item.bottomMargin
        }

        NotificationsView {
            //            color:  "grey"
        }

        onXChanged: updateOutputGeometry()
        onYChanged: updateOutputGeometry()
        onWidthChanged: updateOutputGeometry()
        onHeightChanged: updateOutputGeometry()

        function updateOutputGeometry() {
            _greenisland_output.availableGeometry = Qt.rect(x,y,width,height)
        }
    }
    Rectangle {
        id: indicatorsRow
        anchors {
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }
        width: 50
        color: panel.color
        Row {
            id: row
            anchors {
                right: parent.right
                top: parent.top
                bottom: parent.bottom
                leftMargin: Units.dp(8)
                rightMargin: Units.dp(8)
            }

            IndicatorView {
                height: parent.height
                indicator: DateTimeIndicator {}
            }
            Repeater {
                model: indicators
                delegate: IndicatorView {
                    indicator: modelData
                    onClicked: toggle()
                }
            }

        }
    }
    //    }

    Timer {
        id: delayCloseTimer
        interval: 10
    }

    Timer {
        id: previewTimer

        property var windows
        property var app
        property var caller

        interval: 1000

        function delayShow(caller, app, windows) {
            if (windowPreview.showing || delayCloseTimer.running) {
                windowPreview.windows = windows
                windowPreview.app = app
                windowPreview.open(caller, 0, Units.dp(16))
            } else {
                previewTimer.windows = windows
                previewTimer.app = app
                previewTimer.caller = caller
                restart()
            }
        }

        onTriggered: {
            windowPreview.windows = windows
            windowPreview.app = app
            windowPreview.open(previewTimer.caller, 0, Units.dp(16))
        }
    }

    WindowTooltip {
        id: windowPreview
        overlayLayer: "desktopTooltipOverlayLayer"
    }
    KCoreAddons.KUser {
        id: currentUser
    }

    MprisConnection {
        id: musicPlayer
    }

    Sound {
        id: sound

        property string iconName: sound.muted || sound.master == 0
                                  ? "av/volume_off"
                                  : sound.master <= 33 ? "av/volume_mute"
                                                       : sound.master >= 67 ? "av/volume_up"
                                                                            : "av/volume_down"

        property int notificationId: 0

        onMasterChanged: {
            soundTimer.restart()
        }

        // The master volume often has random or duplicate change signals, so this helps to
        // smooth out the signals into only real changes
        Timer {
            id: soundTimer
            interval: 10
            onTriggered: {
                if (sound.master !== volume && volume !== -1) {
                    sound.notificationId = notifyServer.notify("Sound", sound.notificationId,
                                                               "icon://" + sound.iconName, "Volume changed", "", [], {}, 0,
                                                               sound.master).id
                }
                volume = sound.master
            }

            property int volume: -1
        }
    }
    NotificationsView {
        //            color:  "grey"
    }
    HardwareEngine {
        id: hardware
    }

    NotificationServer {
        id: notifyServer
    }

    property var now: new Date()

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: now = new Date()
    }
}
