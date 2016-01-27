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

Indicator {
    activable: true

    Keys.onPressed: {
        if (active) {
            // eat the events the indicators bar usually processes
            if (event.key == Qt.Key_Up || event.key == Qt.Key_Down || event.key == Qt.Key_Left || event.key == Qt.Key_Right) {
                event.accepted = true
            }
            if (event.key == Qt.Key_Up) {
                shell.volume = Math.min(shell.volume + 0.05, 1)
            } else if (event.key == Qt.Key_Down) {
                shell.volume = Math.max(shell.volume - 0.05, 0)
            }
        }
    }

    Keys.onReleased: {
        if (active) {
            // eat the events the indicators bar usually processes
            if (event.key == Qt.Key_Up || event.key == Qt.Key_Down || event.key == Qt.Key_Left || event.key == Qt.Key_Right) {
                event.accepted = true
            }
        }
    }
}
