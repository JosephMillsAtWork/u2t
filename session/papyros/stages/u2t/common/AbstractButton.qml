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

import QtQuick 2.0
FocusScope {
    property bool enabled: true
    property bool pressed: false
    property alias mouseOver: mouse_area.containsMouse
    signal clicked
    Accessible.role: Accessible.PushButton
    MouseArea {
        id: mouse_area
        enabled: parent.enabled
        hoverEnabled: parent.enabled
        anchors.fill: parent
        onClicked:{
            parent.clicked()
        }
        }

    state: {
        if (activeFocus && mouse_area.containsMouse)
            return "selected-hovered"
        else if(pressed || mouse_area.pressed)
            return "pressed"
        else if(activeFocus)
            return "selected"
        else if(mouse_area.containsMouse)
            return "hovered"
        else
            return "default"
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Return && !event.modifiers) {
            clicked()
            event.accepted = true;
        }
    }
}
