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
import Material 0.1

import Papyros.Components 0.1
import Papyros.Desktop 0.1
import Papyros.Indicators 0.1
import "../../launcher"

View {
    id: panel
    property Indicator selectedIndicator

    //backgroundColor: shell.state == "exposed" ? Qt.rgba(0,0,0,0) : Qt.rgba(0.2, 0.2, 0.2, 1)
    height: Units.dp(40)
    //elevation: 2

    Behavior on backgroundColor {
        ColorAnimation { duration: 300 }
    }

    anchors {
        left: parent.left
        right: parent.right
        top: parent.top
    }

    Row {
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            leftMargin: Units.dp(14)
        }

        spacing: Units.dp(12)

        Repeater {
            model: ["communication/email", "hardware/headset", "file/file_download", "image/image"]
            delegate: Icon {
                name: modelData
                size: parent.height * 0.45
                color: Theme.dark.iconColor
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    IndicatorView {
        indicator: DateTimeIndicator {}

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            bottom: parent.bottom
        }
    }

    Row {
        id: indicatorsRow

        anchors {
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            rightMargin: Units.dp(14)
        }

        Repeater {
            model: shell.indicators
            delegate: IndicatorView {
                indicator: modelData
            }
        }
    }
}
