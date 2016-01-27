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

import QtQuick 1.1
import "../common/utils.js" as Utils

Item {
    id: multiRangeSelectionBar

    property bool isFirst: true
    property bool isLast: false
    property int leftPos: 0
    property int rightPos: 100

    x: launcher2dConfiguration.launcherpostion !== "right" ? leftPos : parent.width - rightPos
    width: rightPos - leftPos
    height: childrenRect.height

    Image {
        id: leftBorder
        source: (isFirst) ? "artwork/multirange_selection_left_first.png"
                          : "artwork/multirange_selection_left.png"
        width: sourceSize.width
        height: sourceSize.height
        anchors{
            left: parent.left
            top: parent.top
        }
        mirror: Utils.isRightToLeft()
    }

    Image {
        id: background
        source: "artwork/multirange_selection_middle.png"
        width: sourceSize.width
        height: sourceSize.height
        anchors{
            top: parent.top
            left: leftBorder.right
            right: rightBorder.left
        }
        fillMode: Image.TileHorizontally
    }

    Image {
        id: rightBorder
        source: (isLast) ? "artwork/multirange_selection_right_last.png"
                         : "artwork/multirange_selection_right.png"
        width: sourceSize.width
        height: sourceSize.height
        anchors{
            top: parent.top
            right: parent.right
        }
        mirror: Utils.isRightToLeft()
    }
}
