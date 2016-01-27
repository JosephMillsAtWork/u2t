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
import QtQuick 1.1
import "common/utils.js" as Utils
Loader {
    id: dashLoader
    source: "dash/Dash.qml"
    x: if (launcher2dConfiguration.launcherLocation === "left")
           launcherLoader.width
       else if (launcher2dConfiguration.launcherLocation === "right" && dash2dConfiguration.fullScreen === true)
          0
       else if (launcher2dConfiguration.launcherLocation === "right" && dash2dConfiguration.fullScreen === false)
         parent.width - launcherLoader.width - dashLoader.width
    else
    (parent != undefined ? parent.width - width - launcherLoader.width : 0)
    onLoaded: item.focus = true
    Behavior on onLoaded { NumberAnimation{duration: 200 ; easing.type: Easing.OutQuad}}
    opacity: item.active ? 1.0 : 0.0
    focus: item.active
    Behavior on opacity {
        NumberAnimation { duration: 200; easing.type: Easing.OutQuad } }
    Binding {
        target: dashLoader.item
        property: "fullscreenWidth"
        value: if (unity2dConfiguration.formFactor === "tablet")
                   shell.height - launcherLoader.height
               else if (launcher2dConfiguration.launcherLocation === "right")
                   shell.width + launcherLoader.width
               else
                    shell.width - launcherLoader.width
    }
}
