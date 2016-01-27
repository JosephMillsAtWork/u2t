import QtQuick 1.0
import Unity2d 1.0
import "../common/fontUtils.js" as FontUtils
import "../common/utils.js" as Utils
import "renderTypes"

Flickable {
    id: area

    property variant startOfTimeline
    property variant endOfTimeline
    property variant currentTime

    property variant referenceTime: area.startOfTimeline
    property int hourSize
    property int channelHeight
    property int verticalScrollMargin: channelHeight * 2
    property int horizontalScrollMargin: width / 8
    property variant selectionTracker

    property variant channels
    property int selectedChannel: -1
    property variant selectedChannelItem: null

    signal newStartOfTimeline(variant newStart)
    signal newEndOfTimeline(variant newEnd)

    contentWidth: hourSize * (area.endOfTimeline - area.startOfTimeline) / Utils.MS_PER_HOUR
    contentHeight: channels.count * channelHeight
    clip: true

    /* FIXME: this is an hack. We should check when all channels have loaded and do this at that time */
    Timer {
        interval: 1000
        running: true
        onTriggered: {
            if (selectedChannel == -1) selectedChannel = 0
            if (currentTime && startOfTimeline && selectedChannelItem) {
                var itemAtTime = selectedChannelItem.getBroadcastAtTime(currentTime)
                if (itemAtTime == -1) return
                selectedChannelItem.selectedBroadcast = itemAtTime
                var newContentX = hourSize * (currentTime - startOfTimeline) / Utils.MS_PER_HOUR - area.width / 2
                contentX = newContentX

                // New reference time can't be calculated in the usual way because we're jumping in the middle of a broadcast
                // and the usual calculation assumes we just scrolled there normally
                var pixelReference = newContentX + area.width / 2
                area.referenceTime = new Date(area.startOfTimeline.getTime() + (pixelReference / hourSize * Utils.MS_PER_HOUR))
            }
        }
    }

    Behavior on contentX { NumberAnimation { easing.type: Easing.OutQuad; duration: 200 } }
    Behavior on contentY { NumberAnimation { easing.type: Easing.OutQuad; duration: 200 } }

    /* When scrolling up or down make sure that at least some more items are always visible below
       the currently selected one. This number is determined by verticalScrollMargin. */
    Keys.onDownPressed: {
        if (selectedChannel >= channels.count - 1) return
        selectedChannel++

        if (contentHeight <= height) return
        if (selectedChannel * channelHeight + channelHeight >= contentY + height - verticalScrollMargin) {
            contentY = Math.min(selectedChannel * channelHeight + channelHeight - height + verticalScrollMargin,
                                contentHeight - height)
        }
    }

    Keys.onUpPressed: {
        if (selectedChannel <= 0) {
            /* When scrolling up past the upper bounds of the EPG let the event bubble to parent so that
               whatever keyboard navigation is in place around the EPG will activate */
            event.accepted = false
            return
        }
        selectedChannel--;

        if (selectedChannel * channelHeight - contentY < verticalScrollMargin)
            contentY = Math.max(0, selectedChannel * channelHeight - verticalScrollMargin)
    }

    /* When scrolling right scroll only if the selected item's start is beyond the right
       horizontalScrollMargin. Additionally make sure that the next item's start is also inside
       this margin (the goal is to have always at least one more item visible after the next, or
       scroll to try to bring as much as the next into view). */
    Keys.onRightPressed: {
        if (selectedChannelItem == null || !selectedChannelItem.selectNext()) return

        var broadcast = selectedChannelItem.items.get(selectedChannelItem.selectedBroadcast)
        var broadcastX = hourSize * (broadcast.start - area.startOfTimeline) / Utils.MS_PER_HOUR

        var next = (selectedChannelItem.selectedBroadcast <= selectedChannelItem.items.count - 1) ?
                   selectedChannelItem.items.get(selectedChannelItem.selectedBroadcast + 1) : null
        var nextX = (next) ? hourSize * (next.start - area.startOfTimeline) / Utils.MS_PER_HOUR : 0

        var targetX
        if (broadcastX - area.contentX > area.width - area.horizontalScrollMargin ||
            (next && nextX - area.contentX > area.width - area.horizontalScrollMargin)) {
            targetX = Utils.clamp(broadcastX - area.horizontalScrollMargin,
                                  0, area.contentWidth - area.width)
        } else targetX = area.contentX

        area.contentX = targetX
        calculateReferenceTime(broadcast, targetX)
    }

    /* Scrolling left is simpler as the previous item is always visible before the left
       horizontalScrollMargin. However to minimize movement, when we decide that we have to scroll
       we try first to put the end of the current item at the right horizontalScrollMargin.
       But if doing this would put the start before the left horizontalScrollMargin, then we just
       put it at that margin. */
    Keys.onLeftPressed: {
        if (selectedChannelItem == null || !selectedChannelItem.selectPrev()) {
            /* When scrolling left past the left bounds of the EPG let the event bubble to parent so
               that whatever keyboard navigation is in place around the EPG will activate */
            event.accepted = false
            return
        }

        var broadcast = selectedChannelItem.items.get(selectedChannelItem.selectedBroadcast)
        var broadcastX = hourSize * (broadcast.start - area.startOfTimeline) / Utils.MS_PER_HOUR
        var targetX = null

        if (broadcastX - area.contentX < area.horizontalScrollMargin) {
            var broadcastWidth = hourSize * (broadcast.end - broadcast.start) / Utils.MS_PER_HOUR
            if (broadcastWidth < area.width - area.horizontalScrollMargin) {
                targetX = broadcastX + broadcastWidth - area.width + area.horizontalScrollMargin
            } else {
                targetX = broadcastX - area.horizontalScrollMargin
            }
        } else targetX = area.contentX

        targetX = Utils.clamp(targetX, 0, area.contentWidth - area.width)
        area.contentX = targetX
        calculateReferenceTime(broadcast, targetX)
    }

    function calculateReferenceTime(broadcast, newContentX) {
        var x = hourSize * (broadcast.start - area.startOfTimeline) / Utils.MS_PER_HOUR
        var size = hourSize * (broadcast.end - broadcast.start) / Utils.MS_PER_HOUR
        var distanceToEdge = newContentX + area.width - x
        var pixelReference = x + Math.min(distanceToEdge / 2, size / 2)
        area.referenceTime = new Date(area.startOfTimeline.getTime() + (pixelReference / hourSize * Utils.MS_PER_HOUR))
    }

    Column {
        id: channelsBox
        anchors.fill: parent

        Repeater {
            model: area.channels

            delegate: Channel {
                id: channel
                startOfTimeline: area.startOfTimeline
                endOfTimeline: area.endOfTimeline
                currentTime: area.currentTime
                referenceTime: area.referenceTime

                anchors.left: parent.left
                anchors.right: parent.right
                height: area.channelHeight
                hourSize: area.hourSize

                scrollPosition: area.contentX
                viewportWidth: area.width

                isSelected: area.selectedChannel == index
                isAlternateRow: index % 2 == 0

                dataSource: model.path + "/epg.xml"

                /* When each channel finishes loading its data it will emit a signal if its
                   programme data extends past the current boundaries of the global timeline, which
                   will be extended as needed.

                   Note that each Channel calculates the position of its items based on the start
                   of the global timeline. Thus as new channels are loaded other channels will
                   re-adjust their items. */
                onLoaded: {
                    if (area.startOfTimeline == undefined || start < area.startOfTimeline)
                        newStartOfTimeline(start)
                    if (area.endOfTimeline == undefined || end > area.endOfTimeline)
                        newEndOfTimeline(end)
                }

                selectionTracker: area.selectionTracker
                onIsSelectedChanged: if (isSelected) area.selectedChannelItem = channel
            }
        }
    }
}
