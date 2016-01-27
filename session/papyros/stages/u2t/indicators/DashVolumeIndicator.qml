/*
 * This file is part of unity-2d
 *
 * Copyright 2011 Canonical Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 1.0
import "../common/units.js" as Units

VolumeIndicator {
    background.width: active ? Units.tvPx(300) : width
    background.height: active ? Units.tvPx(380) : height
    background.opacity: active ? 0.5 : activeFocus ? 0.2 : 0

    Item {
        id: volumeBarClip
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: background.top
        anchors.topMargin: Units.tvPx(80)
        anchors.bottom: background.bottom
        width: background.width
        visible: background.width != Units.tvPx(80)
        opacity: active ? 1 : 0
        clip: true

        Behavior on opacity { NumberAnimation {} }

        BorderImage {
            id: volumeBarOutline
              rotation: 90
     //       anchors.bottom: volumeBarClip.bottom
              anchors.bottomMargin: 10
       //     anchors.horizontalCenter: volumeBarClip.horizontalCenter

            source: "artwork/volume_bar.sci"

            height: Units.tvPx(260)
            width: Units.tvPx(54)
        }

        BorderImage {
            id: volumeBarFiller
            source: "artwork/volume_filler.sci"
                rotation: 90
          anchors{
          horizontalCenter: volumeBarOutline.horizontalCenter
            verticalCenter: volumeBarOutline.verticalCenter
          }
          //      anchors.bottom: volumeBarOutline.bottom
            width: Units.tvPx(58)
            height: Units.tvPx(Math.round(58 + shell.volume * 202))
        }
        MouseArea {
            id: mouseArea
            anchors.fill: volumeBarOutline
            anchors.margins: Units.tvPx(19)
            enabled: active
            onClicked: {
                if (mouseY == 0) shell.volume = 1.0
                else shell.volume = Math.min((height - mouseY) / height, 1.0)
            }
            drag.target: slider
            drag.axis: "YAxis"
            drag.minimumY: 0
            drag.maximumY: height

            Item {
                id: slider
                anchors.horizontalCenter: parent.horizontalCenter
                onYChanged: if (mouseArea.drag.active) shell.volume = Math.min((mouseArea.height - y) / mouseArea.height, 1.0)
                Connections {
                    target: shell
                    onVolumeChanged: slider.y = mouseArea.height - shell.volume * mouseArea.height
                }
            }
        }
    }
}
