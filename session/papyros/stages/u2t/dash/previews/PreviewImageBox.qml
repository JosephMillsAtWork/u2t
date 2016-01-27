/*
 * This file is part of unity-2d
 *
 * Copyright 2010-2011 Canonical Ltd.
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
import Effects 1.0
import "../../common/units.js" as Units


Rectangle {
    property bool showBackgroundImage: false
    property bool showBlackBoundary: false
    property int margin: 0
    property alias source: screenshotImage.source

    border.width: (showBlackBoundary) ? 1 : 0
    border.color: "black"

    Image {
        fillMode: Image.Stretch
        source: ( showBackgroundImage ) ? "../artwork/ubuntu_part_background.png" : ""
        smooth: true
        asynchronous: true

        anchors.fill:parent
        anchors.topMargin: Units.tvPx(1)
        anchors.leftMargin: Units.tvPx(1)


        effect: DropShadow {
            blurRadius: (showBlackBoundary) ? 30 : 0
            offset.x: 0
            offset.y: 0
            color: "#772953"
            enabled: true
        }

        Image {
            id: screenshotImage
            fillMode:Image.Stretch
            effect: DropShadow {
                blurRadius: 30
                offset.x: 0
                offset.y: 0
                color: "black"
                enabled: showBackgroundImage
            }

            anchors.fill: parent
            anchors.margins: margin + showBackgroundImage ? Units.tvPx(10) : 0
            // fillMode: Image.PreserveAspectFit
            smooth: true
            asynchronous: true
            opacity: screenshotImage.status == Image.Ready ? 1.0 : 0.0
            Behavior on opacity { NumberAnimation { duration: 350 } }

            sourceSize.width: parent.width
        }
    }
}
