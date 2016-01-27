/*
 * This file is part of unity-2d
 *
 * Copyright 2012 Canonical Ltd.
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

Item {
    // true if the behaviour wants the target to be shown, false otherwise
    property bool shown

    // The target the behavior will be deciding if has to be shown or not
    property variant target

    // Whether the target has been shown by an external reason
    property bool forcedVisible: false

    // Whether the target has been hidden by an external reason
    property bool forcedHidden: false

    // The id that triggered the last forcedVisible change
    property variant forcedVisibleChangeId
}
