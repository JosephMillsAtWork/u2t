/*
 * This file is part of unity-2d
 *
 * Copyright 2011 Canonical Ltd.
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
import "../common/utils.js" as Utils

FocusScope {
    id: lensBar

    /* declare width & spacing of icons as required for layout calculations */
    property int iconWidth: 24
    property int iconSpacing: 36

    property variant visibleLenses: SortFilterProxyModel {
        model: dash.lenses
        dynamicSortFilter: true

        filterRole: Lenses.RoleVisible
        filterRegExp: RegExp("^true$")
    }

    Rectangle {
        id: background
        anchors.fill: parent
        color: "#22000000"
    }

    /* LensBar contains a row of LensButtons */
    Row {
        id: lensContainer

        anchors.horizontalCenter: background.horizontalCenter
        anchors.top: background.top
        anchors.bottom: background.bottom

        focus: true
        onActiveFocusChanged: if (activeFocus) selectChild(currentIndex)

        Keys.onPressed: if (handleKeyPress(event.key)) event.accepted = true

        /* The Home lens is unfortunately not supplied by the "lenses" list
           This causes the keyboard navigation logic to be messy */
        property int currentIndex: 0

        function selectChild(index) {
            var child = lensContainer.childFromIndex(index)
            if (child != undefined) {
                child.focus = true
                currentIndex = index
                return true
            } else {
                return false
            }
        }

        function handleKeyPress(key) {
            switch (Utils.switchLeftRightKeys(key)) {
            case Qt.Key_Right:
                return selectChild(currentIndex+1)
            case Qt.Key_Left:
                return selectChild(currentIndex-1)
            }
        }

        function childFromIndex(index) {
            var indexInChildren = 0
            for(var i=0; i<children.length; i++) {
                if (children[i] !== repeater) {
                    if (indexInChildren === index) return children[i]
                    indexInChildren++
                }
            }
            return undefined
        }

        /* Now fetch all other lenses and display */
        Repeater{
            id: repeater
            model: visibleLenses
            delegate: LensButton {
                Accessible.name: u2d.tr(item.name)
                objectName: item.name

                /* Heuristic: if iconHint does not contain a '/' then it is an icon name */
                icon: {
                    if (item.id == "home.lens") {
                        return "artwork/lens-nav-home.svg"
                    }
                    item.iconHint.indexOf("/") == -1 ? "image://icons/" + item.iconHint : item.iconHint
                }
                active: {
                    /* we need this in order to activate the arrow when using a custom shortcuts file */
                    if (item.id == "home.lens" && shellManager.dashActiveLens == "") {
                        return true
                    }
                    return item.viewType == Lens.LensView
                }
                onClicked: {
                    if (item.id === "home.lens") {
                        dash.activateHome()
                    } else {
                        dash.activateLens(item.id)
                    }
                }
                iconWidth: lensBar.iconWidth
                iconSpacing: lensBar.iconSpacing
                width: iconWidth+iconSpacing
                height: lensContainer.height
            }
        }
    }


    Image {
        id: iconsForTvGuide
        source: "/usr/share/unity/5/lens-nav-video.svg"
        width: iconWidth
        height: width
        smooth: true
        rotation: 0
        opacity: .66
        scale: 1
        anchors{
            verticalCenter: lensContainer.verticalCenter
            right: iconsforsettings.left
            rightMargin: parent.width / 50
        }
        Behavior on scale{NumberAnimation{from: .75;to: 1;duration: 700;easing.type: Easing.InQuint}}
        Behavior on rotation{NumberAnimation{from: 0;to: 720;duration: 1200;}}

                PictureGlowButton{
                    anchors.fill: iconsForTvGuide
                    onClicked:{
                        activateEpg()
                        iconsForTvGuide.rotation = 360
                        iconsForTvGuide.scale = 0
                }
            }
        }

    Image {
        id: iconsforsettings
        source: "artwork/emblem-system-symbolic.png"
        width: iconWidth
        height: width
        smooth: true
        rotation: 0
        opacity: .66
        scale: 1
        anchors{
            verticalCenter: lensContainer.verticalCenter
            right: parent.right
            rightMargin: parent.width / 50
        }
        Behavior on scale{NumberAnimation{from: .75;to: 1;duration: 700;easing.type: Easing.InQuint}}
        Behavior on rotation{NumberAnimation{from: 0;to: 720;duration: 1200;}}

                PictureGlowButton{
                    anchors.fill: iconsforsettings
                    onClicked:{
                        activateDconfsettings()
                        iconsforsettings.rotation = 360
                        iconsforsettings.scale = 0
                }
            }
        }

}
