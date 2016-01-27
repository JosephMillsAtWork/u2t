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
import "../common"
AbstractButton {
    property alias icon: icon.source
    property bool active: false
    property int iconSpacing: 0
    property int iconWidth: 24
    id: lensButton
    Rectangle {
        border.color: "#66CCCCCC"
        border.width: 1
        visible: ( parent.state == "selected" )
        gradient: Gradient{
            GradientStop {position: 0; color:"#66FFFFFF" }
            GradientStop {position: .5; color:"#22FFFFFF" }
            GradientStop {position: 1;color:  "#66FFFFFF"}
        }
        anchors{
            fill: parent
        }
    }
    Image {
        id: icon
        sourceSize.width: iconWidth
        sourceSize.height: iconWidth
        width: sourceSize.width
        height: sourceSize.height
        clip: true
        anchors{
            horizontalCenter: parent.horizontalCenter
            centerIn: parent
        }
        opacity: ( parent.state == "mouseOver" || parent.state == "pressed" ) ? 1.0 : 0.57
    }

    /* Indicator arrow to show Lens active */
    Image {
        id: indicator
        source: "../common/artwork/arrow.png"
        width: sourceSize.width
        height: sourceSize.height
        smooth: true
        anchors{
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }
        rotation: 90
        visible: (active )
    }
}
