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
import "../common"
import "../common/units.js" as Units

FocusScope {
    width: row.width

    property alias leftIndicator: wifi
    property variant focusedIndicator: system

    Row {
        id: row
        spacing: Units.tvPx(11)
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right

//        DashVolumeIndicator {
//            id: volume
//            focus: true
//            anchors.verticalCenter: parent.verticalCenter

//            KeyNavigation.right: wifi

//            onActiveFocusChanged: if (activeFocus) focusedIndicator = volume
//        }

        DashWifiIndicator {
            id: wifi
            focus: true
            anchors.verticalCenter: parent.verticalCenter

            KeyNavigation.left: search_entry
            KeyNavigation.right: time
            onActiveFocusChanged: if (activeFocus) focusedIndicator = wifi
        }

        Rectangle {
            id: time
            focus: true
            width: Units.tvPx(130)
            height: Units.tvPx(80)
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"
            KeyNavigation.right: system
            KeyNavigation.left: wifi
            CurrentTimeIndicator {
                id: curtime
                anchors.centerIn: parent
            }PannelIndicaorparser{
            anchors.fill: curtime
            icon:""
            desktopFile: "indicator-datetime-preferences.desktop"
          }
        }
        DashSystemIndicator {
            id: system
            source: "artwork/cog.png"
            focusedSource: "artwork/cog_orange.png"
            focus: true
            anchors.verticalCenter: parent.verticalCenter
            KeyNavigation.left: time
            onActiveFocusChanged: if (activeFocus) focusedIndicator = system
        }
    }
}
