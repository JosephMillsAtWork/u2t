/*
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
import  "../../common"
AbstractButton {
    id: button

    property alias text: textBox.text

    height: 64
    width:366

    Rectangle {
        id: background
        anchors.fill: parent

        color: "white"
        radius: 12
         Behavior on opacity {
             NumberAnimation {
                 duration: state == "hovered" || state == "selected-hovered" ? 100 : 250
             }
         }
    }

    Rectangle {
        id: border
        anchors.fill: parent
        color: "transparent"
        border.color: "white"
        border.width: 3
        radius: 12 //Units.tvPx(16)
        Behavior on opacity { NumberAnimation { duration: 250 } }
    }

    Text {
        id: textBox
        anchors.centerIn: parent
        font.pixelSize:  if (dash2dConfiguration.fullScreen !== true)
                      18
                      else
                      10
        smooth: true
        color: "white"
    }

    // Note that the glow when selected is outside the item
    BorderImage {
        id: glow
        anchors.fill: parent
        anchors.margins: -16
//FIXME FOR DESKTOP ALSO
        source: "../../common/artwork/button_glow.sci"
        Behavior on opacity { NumberAnimation { duration: 250 } }
    }

    states: [
        State {
            name: "default"
            PropertyChanges { target: glow; opacity: 0.0 }
            PropertyChanges { target: border; opacity: 0.5 }
            PropertyChanges { target: background; opacity: 0.2 }
        },
        State {
            name: "selected"
            PropertyChanges { target: glow; opacity: 1.0 }
            PropertyChanges { target: border; opacity: 0.0 }
            PropertyChanges { target: background; opacity: 0.05 }
        },
             State {
                   name: "hovered"
                  PropertyChanges { target: glow; opacity: 0.0 }
                PropertyChanges { target: border; opacity: 0.5 }
                PropertyChanges { target: background; opacity: 0.4 }
               },
              State {
               name: "selected-hovered"
               PropertyChanges { target: glow; opacity: 1.0 }
               PropertyChanges { target: border; opacity: 0.0 }
               PropertyChanges { target: background; opacity: 0.4 }
        }
    ]
}
