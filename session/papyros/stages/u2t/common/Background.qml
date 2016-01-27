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
import Unity2d 1.0
import Effects 1.0
import "utils.js" as Utils

Item {
    id: background
    property bool active: false
    property bool fullscreen: false
    property int bottomBorderThickness
    property int rightBorderThickness
    property bool activeTriggerHelper: true
    property bool reallyActive: active && activeTriggerHelper
    property variant view: undefined

    function trigger()
    {
        activeTriggerHelper = false
        activeTriggerHelper = true
    }

    // This is here to workaround https://bugs.launchpad.net/unity-2d/+bug/968215
    // caused by https://bugreports.qt-project.org/browse/QTBUG-25037
    Rectangle {
    anchors.fill: parent
    color: "transparent"
    }

    /* Avoid redraw at rendering */
    effect: CacheEffect {}

    Item {
        anchors.fill: parent
        anchors.bottomMargin: bottomBorderThickness
        anchors.rightMargin: rightBorderThickness
        clip: true

//        /* Extra Item seemingly unnecessary but actually useful to avoid a
//           redrawing bug that happens when applying an effect on a clipped item.
//           In this particular case, doing the Colorize on the clipped child item
//           would prevent proper repainting when maximizing then unmaximizing the
//           dash.
//        */
//        effect: ColorizeEffect {
//            color: unity2dConfiguration.averageBgColor
//            saturation: 0.2
//        }
        Rectangle{
        anchors.fill: parent
        color: "#10000000"
        }
        Image {
            id: blurredBackground
            effect: Blur {blurRadius: 12}

            /* 'source' needs to be set when this becomes visible, that is when active
               becomes true, so that a screenshot of the desktop is taken at that point.
               See http://doc.qt.nokia.com/4.7-snapshot/qml-image.html#cache-prop
            */

            /* Use an image of the root window which essentially is a
               capture of the entire screen */
            source: reallyActive ? "image://window/root" : ""
            cache: false

            fillMode: Image.PreserveAspectCrop

            /* Place the screenshot of the desktop background on top of the desktop background,
               no matter where the DeclarativeView or the parent object are placed.
            */
            property variant origin: parent.mapFromItem(null, background.view != undefined ? -background.view.globalPosition.x : -declarativeView.globalPosition.x,
                                                              background.view != undefined ? -background.view.globalPosition.y : -declarativeView.globalPosition.y)
            x: origin.x
            y: origin.y
        }

        Image {
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: "../artwork/background_sheen.png"
            opacity: 0.5
        }
    }

    BorderImage {
        id: border
        /* Define properties of border here */
        property int bottomThickness: 39
        property int rightThickness: 37
        anchors.fill: parent
        source: desktop.isCompositingManagerRunning ? "artwork/desktop_dash_background.sci" : "artwork/desktop_dash_background_no_transparency.sci"
        mirror: launcher2dConfiguration.launcherLocation === "right" ? true : false
    }

    states: [
            State {
                name: "normal"
                when: !fullscreen
                PropertyChanges {
                    target: background
                    bottomBorderThickness: border.bottomThickness
                    rightBorderThickness: border.rightThickness
                }
                PropertyChanges {
                    target: border
                    visible: true
                }
            },
            State {
                name: "fullscreen"
                when: fullscreen
                PropertyChanges {
                    target: background
                    bottomBorderThickness: 0
                    rightBorderThickness: 0
                }
                PropertyChanges {
                    target: border
                    visible: false
                }
            }
        ]
}
