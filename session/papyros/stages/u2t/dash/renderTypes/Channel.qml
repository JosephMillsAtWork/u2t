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
import "../"
Item {
    id: channel
    property alias dataSource: schedule.source

    property int hourSize

    property variant startOfTimeline
    property variant endOfTimeline
    property variant referenceTime
    property variant currentTime

    property real scrollPosition
    property real viewportWidth
    property variant selectionTracker: null

    property bool isAlternateRow
    property bool isSelected

    property alias items: broadcasts
    property int selectedBroadcast: -1
    property string offAirTitle: u2d.tr("Off Air")

    signal loaded(variant start, variant end)

    XmlListModel {
        id: schedule
        query: "//broadcast"

        XmlRole { name: "pid"; query: "pid/string()" }
        XmlRole { name: "start"; query: "start/string()" }
        XmlRole { name: "end"; query: "end/string()" }
        XmlRole { name: "title"; query: "programme/display_titles/title/string()" }

        onStatusChanged: {
            if (status == XmlListModel.Ready) {
                if (schedule.count == 0) return;

                var startOfFirst = Utils.fromIso8601(schedule.get(0).start)
                var endOfLast = Utils.fromIso8601(schedule.get(schedule.count - 1).end)

                loaded(startOfFirst, endOfLast)

                /* Now we have the timeline data create gaps information and merge both into one
                   single model that we will then use to populate the view via a Repeater.
                   We create a single model instead of just using two Repeaters since we want to
                   have an ordered list that we can use to reference what broadcast is next when
                   doing keyboard navigation.

                   Gaps are Broadcast elements that are create to fill spans of time when there
                   is no programme in the loaded data.
                   Gaps usually occour between days when the channel goes off air for the night.

                   Also since schedules for channels can start at different times, we insert an
                   extra gap between the start of the global timeline and our first broadcast, as
                   well as between the end of our last broadcast and the end of the blobal timelne.
                   These are always inserted for semplicity: if there's no need for them tyhey will
                   have size zero and not be displayed. This saves lots of bookkeeping with a
                   reasonably small expense when new channels come up and alter the timeline. */
                var gaps = []
                broadcasts.append({ 'start': channel.startOfTimeline, 'end': startOfFirst,
                                    'title': offAirTitle, isOffAir: true })

                for (var i = 0; i < schedule.count; i++) {
                    var start = Utils.fromIso8601(schedule.get(i).start)
                    var end = Utils.fromIso8601(schedule.get(i).end)
                    broadcasts.append({ 'start': start, 'end': end,
                                        'title': schedule.get(i).title, isOffAir: false })

                    if (i < schedule.count - 1) {
                        var startOfNext = Utils.fromIso8601(schedule.get(i + 1).start)
                        if (end.valueOf() != startOfNext.valueOf()) {
                            broadcasts.append({ 'start': end, 'end': startOfNext,
                                                'title': offAirTitle, isOffAir: true })
                        }
                    }
                }

                broadcasts.append({ 'start': endOfLast, 'end': channel.endOfTimeline,
                                    'title': offAirTitle, isOffAir: true })

                if (channel.isSelected) selectNext()
            }
        }
    }

    onEndOfTimelineChanged: if (broadcasts.count > 0) broadcasts.setProperty(broadcasts.count - 1, 'end', endOfTimeline)
    onStartOfTimelineChanged: if (broadcasts.count > 0) broadcasts.setProperty(0, 'start', startOfTimeline)

    Item {
        id: broadcastsContainer
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        Repeater {
            model: ListModel {
                id: broadcasts
            }
            delegate: Broadcast {
                id: broadcast
                anchors.top: (parent) ? parent.top : undefined
                anchors.bottom: (parent) ? parent.bottom : undefined
                anchors.bottomMargin: Units.tvPx(1)

                width: (model.end - model.start) * channel.hourSize / Utils.MS_PER_HOUR
                x: (model.start - channel.startOfTimeline) * channel.hourSize / Utils.MS_PER_HOUR
                z: broadcasts.count - index
                parentChannelItem: channel

                title: model.title
                textMargin: Units.tvPx(15)

                scrollPosition: channel.scrollPosition
                isCutAtStart: x < scrollPosition && x + width > scrollPosition

                isOnSelectedChannel: channel.isSelected
                isOnAirNow: model.start <= currentTime &&  model.end > currentTime
                isOffAir: model.isOffAir

                isSelected: isOnSelectedChannel && index == selectedBroadcast
                onIsSelectedChanged: if (isSelected && selectionTracker) selectionTracker.follow = broadcast
            }
        }
    }

    function selectNext() {
        for (var i = selectedBroadcast + 1; i < broadcasts.count; i++)
            if (broadcasts.get(i).end - broadcasts.get(i).start > 0) {
                selectedBroadcast = i
                return true
            }
        return false
    }
    function selectPrev() {
        for (var i = selectedBroadcast - 1; i >= 0; i--)
            if (broadcasts.get(i).end - broadcasts.get(i).start > 0) {
                selectedBroadcast = i
                return true
            }
        return false
    }

    function getBroadcastAtTime(time) {
        for (var i = 0; i < broadcasts.count; i++) {
            var current = broadcasts.get(i)
            if (current.start <= time && current.end > time &&
                current.end - current.start > 0) {
                return i;
            }
        }
        return -1
    }

    onIsSelectedChanged: {
        // try to find the broadcast for this channel that is on air at the current
        // reference time
        var newSelected = getBroadcastAtTime(referenceTime)
        if (newSelected != -1) selectedBroadcast = newSelected
    }
}
























///*
// * This file is part of unity-2d
// *
// * Copyright 2010-2011 Canonical Ltd.
// *
// * This program is free software; you can redistribute it and/or modify
// * it under the terms of the GNU General Public License as published by
// * the Free Software Foundation; version 3.
// *
// * This program is distributed in the hope that it will be useful,
// * but WITHOUT ANY WARRANTY; without even the implied warranty of
// * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// * GNU General Public License for more details.
// *
// * You should have received a copy of the GNU General Public License
// * along with this program.  If not, see <http://www.gnu.org/licenses/>.
// */

//import QtQuick 1.0
//import "../../common/utils.js" as Utils
//import "../../common/units.js" as Units

//Item {
//    id: channel
//    property alias dataSource: schedule.source

//    property int hourSize

//    property variant startOfTimeline
//    property variant endOfTimeline
//    property variant referenceTime
//    property variant currentTime

//    property real scrollPosition
//    property real viewportWidth
//    property variant selectionTracker: null

//    property bool isAlternateRow
//    property bool isSelected

//    property alias items: broadcasts
//    property int selectedBroadcast: -1
//    property string offAirTitle: u2d.tr("Off Air")

//    signal loaded(variant start, variant end)
//    XmlListModel {
//        id: schedule
//        source: dash2dConfiguration.mythipBackend + "/Guide/GetProgramGuide?StartTime="+Utils.now.toISOString()+"&EndTime="+Utils.time2.toISOString()
//        query: "//ProgramGuide//*"
//        XmlRole {name: "start"; query: "StartTime/string()"}
//        XmlRole { name: "end"; query: "EndTime/string()" }
//        XmlRole { name: "title"; query: "Title/string()" }
////        XmlRole { name: "channelIcon"; query: "IconURL/string()" }
////        XmlRole { name: "channelName"; query: "ChannelName/string()" }
////        onCountChanged: {
////            console.log("Count changed to: " + count)
////        }
//        onStatusChanged: {
//            if (status == XmlListModel.Ready) {
//                if (schedule.count == 0) return;

//                var startOfFirst = Utils.fromIso8601(schedule.get(0).start)
//                var endOfLast = Utils.fromIso8601(schedule.get(schedule.count - 1).end)

//                loaded(startOfFirst, endOfLast)

//                /* Now we have the timeline data create gaps information and merge both into one
//                   single model that we will then use to populate the view via a Repeater.
//                   We create a single model instead of just using two Repeaters since we want to
//                   have an ordered list that we can use to reference what broadcast is next when
//                   doing keyboard navigation.

//                   Gaps are Broadcast elements that are create to fill spans of time when there
//                   is no programme in the loaded data.
//                   Gaps usually occour between days when the channel goes off air for the night.

//                   Also since schedules for channels can start at different times, we insert an
//                   extra gap between the start of the global timeline and our first broadcast, as
//                   well as between the end of our last broadcast and the end of the blobal timelne.
//                   These are always inserted for semplicity: if there's no need for them tyhey will
//                   have size zero and not be displayed. This saves lots of bookkeeping with a
//                   reasonably small expense when new channels come up and alter the timeline. */
//                var gaps = []
//                broadcasts.append({ 'start': channel.startOfTimeline, 'end': startOfFirst,
//                                    'title': offAirTitle, isOffAir: true })

//                for (var i = 0; i < schedule.count; i++) {
//                    var start = Utils.fromIso8601(schedule.get(i).start)
//                    var end = Utils.fromIso8601(schedule.get(i).end)
//                    broadcasts.append({ 'start': start, 'end': end,
//                                        'title': schedule.get(i).title, isOffAir: false })

//                    if (i < schedule.count - 1) {
//                        var startOfNext = Utils.fromIso8601(schedule.get(i + 1).start)
//                        if (end.valueOf() != startOfNext.valueOf()) {
//                            broadcasts.append({ 'start': end, 'end': startOfNext,
//                                                'title': offAirTitle, isOffAir: true })
//                        }
//                    }
//                }

//                broadcasts.append({ 'start': endOfLast, 'end': channel.endOfTimeline,
//                                    'title': offAirTitle, isOffAir: true })

//                if (channel.isSelected) selectNext()
//            }
//        }
//    }

//    onEndOfTimelineChanged: if (broadcasts.count > 0) broadcasts.setProperty(broadcasts.count - 1, 'end', endOfTimeline)
//    onStartOfTimelineChanged: if (broadcasts.count > 0) broadcasts.setProperty(0, 'start', startOfTimeline)

//    Item {
//        id: broadcastsContainer
//        anchors.top: parent.top
//        anchors.bottom: parent.bottom

//        Repeater {
//            model: ListModel {
//                id: broadcasts
//            }
//            delegate: Broadcast {
//                id: broadcast
//                anchors.top: (parent) ? parent.top : undefined
//                anchors.bottom: (parent) ? parent.bottom : undefined
//                anchors.bottomMargin: Units.tvPx(1)

//                width: (model.end - model.start) * channel.hourSize / Utils.MS_PER_HOUR
//                x: (model.start - channel.startOfTimeline) * channel.hourSize / Utils.MS_PER_HOUR
//                z: broadcasts.count - index
//                parentChannelItem: channel

//                title: model.title
//                textMargin: Units.tvPx(15)

//                scrollPosition: channel.scrollPosition
//                isCutAtStart: x < scrollPosition && x + width > scrollPosition

//                isOnSelectedChannel: channel.isSelected
//                isOnAirNow: model.start <= currentTime &&  model.end > currentTime
//                isOffAir: model.isOffAir

//                isSelected: isOnSelectedChannel && index == selectedBroadcast
//                onIsSelectedChanged: if (isSelected && selectionTracker) selectionTracker.follow = broadcast
//            }
//        }
//    }

//    function selectNext() {
//        for (var i = selectedBroadcast + 1; i < broadcasts.count; i++)
//            if (broadcasts.get(i).end - broadcasts.get(i).start > 0) {
//                selectedBroadcast = i
//                return true
//            }
//        return false
//    }
//    function selectPrev() {
//        for (var i = selectedBroadcast - 1; i >= 0; i--)
//            if (broadcasts.get(i).end - broadcasts.get(i).start > 0) {
//                selectedBroadcast = i
//                return true
//            }
//        return false
//    }

//    function getBroadcastAtTime(time) {
//        for (var i = 0; i < broadcasts.count; i++) {
//            var current = broadcasts.get(i)
//            if (current.start <= time && current.end > time &&
//                current.end - current.start > 0) {
//                return i;
//            }
//        }
//        return -1
//    }

//    onIsSelectedChanged: {
//        // try to find the broadcast for this channel that is on air at the current
//        // reference time
//        var newSelected = getBroadcastAtTime(referenceTime)
//        if (newSelected != -1) selectedBroadcast = newSelected
//    }
//}
