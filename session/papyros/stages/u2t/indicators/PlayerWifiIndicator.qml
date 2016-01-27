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
import "../common/utils.js" as Utils
import "../common/units.js" as Units

WifiIndicator {
    property bool extensionShown: wifiBarClip.height != 0
    property alias extensionWidth: wifiBarClip.width

    ownBackground: false

    Rectangle {
        id: wifiBarClip
        y: indicatorsBackground.y + indicatorsBackground.height - parent.y
        x: (parent.width - width) / 2
        width: wifiBarBackgroundBorder.width + wifiBarBackgroundBorder.border.width
        height: active ? wifiBarBackgroundBorder.height : 0
        Behavior on height { NumberAnimation { } }
        color: "transparent"
        clip: true

        Rectangle {
            id: wifiBarBackground
            anchors.horizontalCenter: wifiBarBackgroundBorder.horizontalCenter
            anchors.bottom: wifiBarClip.bottom
            anchors.bottomMargin: wifiBarBackground.radius

            color: Utils.darkAubergine
            opacity: 0.5
            height: Units.tvPx(280)
            width: Units.tvPx(100)
            radius: Units.tvPx(10)
        }

        Rectangle {
            id: wifiBarBackgroundBorder
            x: border.width / 2
            anchors.bottom: wifiBarClip.bottom
            anchors.bottomMargin: wifiBarBackground.radius

            color: "transparent"
            height: wifiBarBackground.height + border.width / 2
            width: wifiBarBackground.width + border.width
            radius: wifiBarBackground.radius + border.width
            opacity: 0.2
            border.color: "white"
            border.width: Units.tvPx(2)
        }

        BorderImage {
            id: wifiBarOutline

            anchors.top: wifiBarBackground.top
            anchors.topMargin: 10
            anchors.horizontalCenter: wifiBarBackground.horizontalCenter

            source: "artwork/wifi.sci"

            height: wifiBarBackground.height - wifiBarBackground.radius
            width: Units.tvPx(354)
        }

        BorderImage {
            id: wifiBarFiller
            source: "artwork/wifi_orange.sci"

            anchors.horizontalCenter: wifiBarOutline.horizontalCenter
            anchors.bottom: wifiBarOutline.bottom
            width: Units.tvPx(358)
            height: Units.tvPx(Math.round(58 + shell.volume * 212))
        }
    }
}
