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

FocusScope {
    property alias scrollbar: scrollbar
    property alias model: list.model
    property alias bodyDelegate: list.bodyDelegate
    property alias headerDelegate: list.headerDelegate
    ListViewWithHeaders {
        id: list
        focus: true
        anchors{
            fill: parent

//            rightMargin: 15
    }
    }
    AbstractScrollbar {
        id: scrollbar
        width: 4
        anchors{
            top: parent.top
            topMargin: 15
            bottom: parent.bottom
            bottomMargin: 10
            right: list.right
            rightMargin: unity2dConfiguration.formFactor === "tv" ? 20 : 10
        }

        targetFlickable: list.flickable
        /* The glow around the slider is 5 pixels wide on the left and right sides
           and 10 pixels tall on the top and bottom sides. */
        sliderAnchors.rightMargin: -5
        sliderAnchors.leftMargin: -5
        sliderAnchors.topMargin: -10
        sliderAnchors.bottomMargin: -10
        sliderSmooth: false
        sliderSource: "../common/artwork/scrollbar.sci"
        /* Hide the scrollbar if there is less than a page of results */
        opacity: targetFlickable.visibleArea.heightRatio < 1.0 ? 1.0 : 0.0
        Behavior on opacity {NumberAnimation {duration: 100}}
    }
}
