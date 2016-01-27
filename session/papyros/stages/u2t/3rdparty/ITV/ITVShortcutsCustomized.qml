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
import Unity2d 1.0
import "../../common"
import "../../common/utils.js" as Utils
import "../../common/units.js" as Units
import "../../dash/"

Item {
    anchors.fill: parent

    Grid {
        id: buttons
        anchors.fill: parent
        spacing: 70
        columns: 4
        rows: 2
        anchors.verticalCenter: parent.verticalCenter
        ItvButton {
            scale: 2.0
            icon: "artwork/icons/watchseries.png"
            onClicked: activateLens("watchseries.lens")
        }

        ItvButton {
            scale: 2.0
            icon: "artwork/icons/youtube-active.png"
            onClicked: activateLens("youtube.lens")
        }

        ItvButton {
            scale: 2.0
            icon: "artwork/icons/hulu-active.png"
            onClicked:  activateNokiaMaps()   //activateLens("maps")
        }

        ItvButton {
            scale: 2.0
            icon: "artwork/icons/project_free_tv-active.png"
            onClicked: activateWeather()
        }
        ItvButton {
            scale: 2.0
            icon: "artwork/icons/project_free_tv-active.png"
            onClicked: activateSystemsettings()
        }
        ItvButton {
            scale: 2.0
            icon: "artwork/icons/project_free_tv-active.png"
            onClicked: activateQtvviewer()
        }
        ItvButton {
            scale: 2.0
            icon: "artwork/icons/project_free_tv-active.png"
            onClicked: activateVideffect()
        }
    }

    FocusPath {
        item: buttons
        columns: buttons.columns
    }
}
