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
import "../common/units.js" as Units
AbstractCategoryHeader {
    id: categoryHeader
    height: visible ? Units.tvPx(80) : 0
    Accessible.name: "%1 %2".arg(title.text).arg(label.text)
    Rectangle {
        id: selectableArea
        anchors{
            left: parent.left
            right: parent.right
            top: title.top
            bottom: title.bottom
            bottomMargin: -4
        }
        opacity: categoryHeader.state == "hovered" || categoryHeader.state == "selected-hovered" ? 0.4 : 0.0
        Behavior on opacity { NumberAnimation { duration: 100 } }
    }

    Image {
        id: icon
        anchors{
            bottom: title.bottom
            bottomMargin: Units.tvPx(2)
            left: parent.left
            leftMargin: Units.tvPx(-5)
        }
        source: "../common/artwork/category_arrow.png"
        opacity: uncollapsed ? 1.0 : 0.0
        Behavior on opacity {NumberAnimation { duration: 100 }}

    }
    TextCustom {
        id: title
        text: categoryHeader.label
        fontSize: "large"
        anchors{
            bottom: parent.bottom
            left: icon.right
            leftMargin: Units.tvPx(3)
        }
    }

    TextCustom {
        id: count
        text: "(%1)".arg(parent.count)
        fontSize: "large"
        anchors{
            baseline: title.baseline
            left: title.right
            leftMargin: Units.tvPx(25)
        }
        opacity: 0.3
    }
}
