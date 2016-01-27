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

SystemIndicator {
    property bool extensionShown: systemBarClip.height != 0
    property alias extensionWidth: systemBarClip.width

    ownBackground: false

    Rectangle {
        id: systemBarClip
        y: indicatorsBackground.y + indicatorsBackground.height - parent.y
        x: (parent.width - width) / 2
        width: systemBarBackgroundBorder.width + systemBarBackgroundBorder.border.width
        height: active ? systemBarBackgroundBorder.height : 0
        Behavior on height { NumberAnimation { } }
        color: "transparent"
        clip: true

        Rectangle {
            id: systemBarBackground
            anchors.horizontalCenter: systemBarBackgroundBorder.horizontalCenter
            anchors.bottom: systemBarClip.bottom
            anchors.bottomMargin: systemBarBackground.radius

            color: Utils.darkAubergine
            opacity: 0.5
            height: Units.tvPx(280)
            width: Units.tvPx(100)
            radius: Units.tvPx(10)
        }

        Rectangle {
            id: systemBarBackgroundBorder
            x: border.width / 2
            anchors.bottom: systemBarClip.bottom
            anchors.bottomMargin: systemBarBackground.radius

            color: "transparent"
            height: systemBarBackground.height + border.width / 2
            width: systemBarBackground.width + border.width
            radius: systemBarBackground.radius + border.width
            opacity: 0.2
            border.color: "white"
            border.width: Units.tvPx(2)
        }

        BorderImage {
            id: systemBarOutline

            anchors.top: systemBarBackground.top
            anchors.topMargin: 10
            anchors.horizontalCenter: systemBarBackground.horizontalCenter

            source: "artwork/volume_bar.sci"

            height: systemBarBackground.height - systemBarBackground.radius
            width: Units.tvPx(54)
        }

        BorderImage {
            id: systemBarFiller
            source: "artwork/volume_filler.sci"

            anchors.horizontalCenter: systemBarOutline.horizontalCenter
            anchors.bottom: systemBarOutline.bottom
            width: Units.tvPx(58)
            height: Units.tvPx(Math.round(58 + shell.volume * 212))
        }
    }
}
