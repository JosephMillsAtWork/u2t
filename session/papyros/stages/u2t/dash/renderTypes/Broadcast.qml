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
import "../../common"
import "../../common/utils.js" as Utils
import "../../common/units.js" as Units

/*
Broadcast color and border rules:
If both onSelectedChannel and onAirNow: darkAubergine x 0.5 + 3px darkAubergine x 1.0
If onSelectedChannel: white x 0.5
If onAirNow but not offAir: white x 0.1 + 3px white x 0.5
If alternateRow: darkAubergine x 0.25
else: darkAubergine x 0.5
*/

Item {
    id: broadcast
    property variant parentChannelItem
    property string title
    property bool isSelected
    property bool isOnSelectedChannel
    property bool isOnAirNow
    property bool isOffAir

    property int scrollPosition
    property bool isCutAtStart
    property int textMargin

    Rectangle  {
        id: background
        anchors.fill: parent
        anchors.margins: Units.tvPx(1)
        anchors.rightMargin: Units.tvPx(2)
    }

    Rectangle {
        id: innerBorder
        anchors.fill: background
        anchors.margins: Units.tvPx(2)
        color: "transparent"
        border.width: Units.tvPx(3)
    }

    TextCustom {
        id: titleText
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        x: isCutAtStart ? scrollPosition - parent.x + textMargin : textMargin
        width: parent.width - x - textMargin

        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        fontSize: "small"
        text: title

        style: Text.Raised
        styleColor: "#1e1e1e"
    }

    state: {
        if (isOnSelectedChannel) return "selected"
        if (isOnAirNow && !isOffAir) return "onAir"
        return "default"
    }

    states: [
        State { name: "selected"
            PropertyChanges { target: background; color: Utils.darkAubergine; opacity: 0.5 }
            PropertyChanges { target: innerBorder; opacity: 0.0 }
            PropertyChanges { target: titleText; opacity: 1.00 }
        },
        State { name: "onAir"
            PropertyChanges { target: background; color: "black"; opacity: 0.40 }
            PropertyChanges { target: innerBorder; border.color: "white"; opacity: 0.0 }
            PropertyChanges { target: titleText; opacity: 1.00 }
        },
        State { name: "default"
            PropertyChanges { target: background; color: Utils.darkAubergine; opacity: isAlternateRow ? 0.15 : 0.25 }
            PropertyChanges { target: innerBorder; opacity: 0.0 }
            PropertyChanges { target: titleText; opacity: 0.75 }
        }
    ]
}
