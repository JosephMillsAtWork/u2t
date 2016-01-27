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
import "../../common/utils.js" as Utils
import "../../common/units.js" as Units

Item {
    property string path
    property bool isSelected

    Image {
        id: logo
        anchors.fill: parent
        anchors.topMargin: Units.tvPx(1)
        anchors.bottomMargin: Units.tvPx(1)

        source: path + "/logo.png"
        sourceSize.width: Units.tvPx(200)
        sourceSize.height: Units.tvPx(78)
        width: sourceSize.width
        height: sourceSize.height
        opacity: (isSelected) ? 1.0 : 0.0
        asynchronous: true
    }

    Rectangle {
        anchors.fill: unselectedLogo
        color: Qt.darker(Utils.darkAubergine)
        opacity: (!isSelected) ? 1.0 : 0.0
    }

    Image {
        id: unselectedLogo
        anchors.fill: parent
        anchors.topMargin: Units.tvPx(1)
        anchors.bottomMargin: Units.tvPx(1)

        source: path + "/logo_bw.png"
        sourceSize.width: Units.tvPx(200)
        sourceSize.height: Units.tvPx(78)
        width: sourceSize.width
        height: sourceSize.height
        opacity: (!isSelected) ? 0.5 : 0.0
        asynchronous: true
    }
}
