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
import "../common/utils.js" as Utils

Item {
    id: background
    property string state
    opacity: ( state == "selected" || state == "pressed"
              || state == "hovered" ) ? 1.0 : 0.0
    Behavior on opacity {NumberAnimation {duration: 100 ; easing.type: Easing.OutQuad}}
    Rectangle {
        color: background.state == "selected" && unity2dConfiguration.formFactor !== "tv"  ? "#44ffffff" : "#00000000"
        border.color: "#44CCCCCC"
        border.width: unity2dConfiguration.formFactor === "tv" ? 0 : 1
        anchors{
            fill: parent
            margins: unity2dConfiguration.formFactor === "tv" ? -5 :  -10
            bottomMargin: unity2dConfiguration.formFactor === "tv" ? 1 : 0
        }
        Rectangle {
            anchors.fill: parent
            visible:  unity2dConfiguration.formFactor === "tv" ? false : true
            color: "#28FFFFFF"
            gradient: Gradient {
                GradientStop { position: 0; color: "#42FFFFFF" }
                GradientStop { position: 0.5; color: "#28CCCCCC" }
                GradientStop { position: 1; color: "#42FFFFFF" }

            }
        }
        Image {
            anchors.fill: parent
            opacity: .88
            visible:  unity2dConfiguration.formFactor !== "tv" ? false : true
            source: "artwork/selection_glow.png"
            smooth: false
        }
    }
}
