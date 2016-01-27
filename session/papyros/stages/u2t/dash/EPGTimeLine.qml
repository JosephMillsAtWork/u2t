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
import "../common"
import "../common/utils.js" as Utils
import "../common/units.js" as Units
import "renderTypes"

Item {
    id: timeline

    property variant start
    property variant end
    property real hoursPerStep: 0.5
    property int hourSize
    property int stepsInScreen: Math.floor(width / steps.unit)
    property variant currentTime: currentTimeInTimeline()

    property real contentWidth
    property real contentX

    Image {
        id: previousArrow
        property bool shown: contentX > 0
        source: "artwork/left_arrow_timeline.png"
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        opacity: shown ? 1.0 : 0.0
    }

    Item {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: previousArrow.right
        anchors.right: nextArrow.left
        clip: true

        Flickable {
            anchors.fill: parent
            anchors.leftMargin: previousArrow.show ? - previousArrow.paintedWidth : 0
            anchors.rightMargin: nextArrow.shown ? - nextArrow.paintedWidth : 0

            contentWidth: timeline.contentWidth
            contentX: timeline.contentX
            clip: true

            Repeater {
                id: steps
                property int unit: timeline.hourSize * timeline.hoursPerStep
                property int total: Math.ceil((timeline.end - timeline.start) /
                                              Utils.MS_PER_HOUR / timeline.hoursPerStep)
                model: steps.total
                delegate: TextCustom {
                    anchors.top: (parent) ? parent.top : undefined
                    anchors.bottom: (parent) ? parent.bottom : undefined
                    x: index * steps.unit + Units.tvPx(23)

                    verticalAlignment: Text.AlignVCenter
                    fontSize: "small"
                    text: {
                        if (!timeline.start) return ""
                        var timestamp = new Date(timeline.start.getTime() +
                                                 index * Utils.MS_PER_HOUR * timeline.hoursPerStep)
                        return Utils.pad(String(timestamp.getHours()), 2, "0") + ":" +
                               Utils.pad(String(timestamp.getMinutes()), 2, "0")
                    }
                }
            }
        }
    }

    Image {
        id: nextArrow
        property bool shown: contentX + timeline.width < contentWidth
        source: "artwork/right_arrow_timeline.png"
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        opacity: shown ? 1.0 : 0.0
    }

    /* Update the current time once per minute.
       FIXME: I don't think it's a big deal for now if it doesn't update at the
       start of every minute, but we should do that if possible */
    Timer {
        interval: 60 * 1000
        running: true
        repeat: true
        onTriggered: timeline.currentTime = currentTimeInTimeline()
    }

    function currentTimeInTimeline() {
        if (timeline.start) {
            var now = new Date()
            return new Date(timeline.start.getFullYear(), timeline.start.getMonth(),
                            timeline.start.getDate(), now.getHours(), now.getMinutes())
        } else return null
    }
}
