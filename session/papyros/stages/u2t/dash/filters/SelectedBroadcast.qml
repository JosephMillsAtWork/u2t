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

Rectangle {
    id: broadcast
    property variant follow: null
    property real containedWidth
    property real distanceToEdge

    color: Utils.mediumAubergine
    height: (follow) ? follow.height : 0
    width: Math.min(distanceToEdge,
                    Math.max(containedWidth,
                             fullText.implicitWidth + ((follow) ? follow.textMargin * 2: 0)))
    TextCustom {
        id: fullText
        anchors{
            fill: parent
            leftMargin: (follow) ? follow.textMargin : 0
            rightMargin: (follow) ? follow.textMargin : 0
        }
        text: (follow) ? follow.title : ""
        verticalAlignment: Text.AlignVCenter
        fontSize: "small"
        effect: DropShadow {
            blurRadius: 10
            offset.x: 0
            offset.y: 1
            color: "black"
        }
    }

    BorderImage {
        source: "artwork/EPG_glow.sci"
        anchors{
            fill: parent
            margins: -28
        }
    }

    /* HACK: In some rare cases the item text is very very long and overflows the channel's edge
       even when this component's width is as large as possible. In these cases we want to elide the
       text.

       Theoretically we could leave fullText.elide set to ElideMiddle all the time, and if the text
       is shorter nothing happens. However these seem to be some bug in QT that sometimes makes the
       text be elided even if it shouldn't.

       Unsetting the elide and setting it back after a minimal delay seems to force the Text to
       re-layout the text and have the correct behaviour.
       Possibly related to: https://bugreports.qt.nokia.com/browse/QTBUG-19206
       */
    Timer {
        id: elideHack
        interval: 1 //NOTE: 0 won't work here.
        onTriggered: fullText.elide = Text.ElideMiddle
    }
    onFollowChanged: { fullText.elide = Text.ElideNone; elideHack.restart() }
}
