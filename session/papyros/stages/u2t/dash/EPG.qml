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
import Unity2d 1.0
import "../common"
import "../common/fontUtils.js" as FontUtils
import "../common/utils.js" as Utils
import "../common/units.js" as Units
import "renderTypes"
FocusScope {
    id: epg

    property int hourSize: Units.tvPx(610)
    property int channelHeight: Units.tvPx(80)
    property int timelineHeight: Units.tvPx(32)

    DirectoryModel {
        id: channels
        path: "unity-2d:shell/dash/epgdata/channels"
    }

    Item {
        id: filters
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(35)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(20)
        anchors.right: parent.right
        anchors.rightMargin: Units.tvPx(25)
        height: titleText.paintedHeight

        TextCustom {
            id: titleText
            anchors.left: parent.left
            anchors.leftMargin: Units.tvPx(15)
            text: "TV Guide"
            fontSize: "large"
        }

        TextCustom {
            anchors.centerIn: parent
            text: "All Channels"
            fontSize: "large"
        }

        TextCustom {
            anchors.right: parent.right
            anchors.rightMargin: Units.tvPx(230)
            text: "Today"
            fontSize: "large"
        }
    }

    EPGTimeLine {
        id: timeline
        anchors.top: filters.bottom
        anchors.topMargin: Units.tvPx(40)
        anchors.left: channelHeads.right
        anchors.right: parent.right
        anchors.rightMargin: Units.tvPx(25)
        height: epg.timelineHeight

        hourSize: epg.hourSize
        contentX: mainScrollArea.contentX
        contentWidth: mainScrollArea.contentWidth
    }

    Rectangle {
        id: divider
        anchors.top: timeline.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(20)
        anchors.rightMargin: Units.tvPx(25)
        height: Units.tvPx(2)
        opacity: 0.2
    }

    ChannelHeads {
        id: channelHeads
        anchors.top: divider.bottom
        anchors.topMargin: Units.tvPx(2)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(20)
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Units.tvPx(40)
        width: Units.tvPx(200)

        contentHeight: mainScrollArea.contentHeight
        contentY: mainScrollArea.contentY

        channels: channels
        channelHeight: epg.channelHeight
        selectedChannel: (epg.activeFocus) ? mainScrollArea.selectedChannel : -1
    }

    EPGScrollArea {
        id: mainScrollArea
        anchors.top: divider.bottom
        anchors.topMargin: Units.tvPx(2)
        anchors.left: channelHeads.right
        anchors.right: parent.right
        anchors.rightMargin: Units.tvPx(25)
        anchors.bottom: channelHeads.bottom
        focus: true

        channelHeight: epg.channelHeight
        channels: channels

        hourSize: epg.hourSize
        currentTime: timeline.currentTime
        startOfTimeline: timeline.start
        endOfTimeline: timeline.end

        onNewStartOfTimeline: timeline.start = newStart
        onNewEndOfTimeline: timeline.end = newEnd

        selectionTracker: floatingSelection
    }

    Rectangle {
        id: timebar
        width: Units.tvPx(2)
        color: "white"
        anchors.top: divider.bottom
        anchors.bottom: mainScrollArea.bottom
        x: mainScrollArea.mapToItem(epg, (timeline.currentTime - timeline.start) * timeline.hourSize
                                          / Utils.MS_PER_HOUR - mainScrollArea.contentX, 0).x
        opacity: (x <= mainScrollArea.x || x >= mainScrollArea.x + mainScrollArea.width) ? 0.0 : 0.2
    }

    /* The selected item needs to have a glow around it. This can't be done if the selection is inside
       of the mainScrollArea Flickable, since it clips, so any item in contact with the margins will
       have its glow clipped.
       Therefore we are keeping the selection here, and binding its position so that it follows
       the currently selected item.

       To do this we first pass the floatingSelection object down through to the Channel objects,
       which will update its "follow" property with whatever item is currently selected.
       Then we bind its position to the translated coordinates of the item, and set a few other
       position-dependent properties that will allow to calculate the proper size of the selection.
    */
    SelectedBroadcast {
        id: floatingSelection

        x: (follow) ? mainScrollArea.x + Math.max(follow.x, mainScrollArea.contentX)
                      - mainScrollArea.contentX : 0
        y: (follow) ? mainScrollArea.y + Math.max(follow.parentChannelItem.y, mainScrollArea.contentY)
                      - mainScrollArea.contentY : 0
        distanceToEdge: (follow) ? mainScrollArea.width - Math.max(follow.x - mainScrollArea.contentX, 0) : 0
        containedWidth: (follow) ? Math.min(follow.width + Math.min(follow.x - mainScrollArea.contentX, 0),
                                            mainScrollArea.width) : 0
        opacity: (epg.activeFocus) ? 1.0 : 0.0
    }

    /* Properties needed for compliance with the pageLoader in the Dash */

    property variant model: PageModel {
        /* model.searchQuery is copied over to all lenses globalSearchQuery property */
        onSearchQueryChanged: {
            for (var i = 0; i < dash.lenses.rowCount(); i++) {
                dash.lenses.get(i).globalSearchQuery = searchQuery
            }
        }
    }
    /* Used by dash.qml to bind to declarativeView "expanded" property */
    property bool expanded: false

//    Keys.onReturnPressed: shell.play("file:///home/ubuntu/Videos/unity/local/epg/epg.mkv")

}
