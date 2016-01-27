/*
 * Papyros Shell - The desktop shell for Papyros following Material Design
 * Copyright (C) 2015 Michael Spencer
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.2
import QtQuick.Window 2.0
import Material 0.1
import org.kde.kcoreaddons 1.0 as KCoreAddons
import "desktop"
View {
    id: shell
    state: "default"
    states: [
        State {
            name: "locked"

            PropertyChanges {
                target: keyboardListener
                enabled: false
            }
        },

        State {
            name: "exposed"
        },

        State {
            name: "switcher"
        }
    ]

    backgroundColor: Qt.rgba(0.2, 0.2, 0.2, 1)
    property string logs: "Shell running\n"
    readonly property bool hasErrors: stage.status == Loader.Error
    property alias windowManager: desktop.windowManager
    property list<Action>keybindings: [
        Action {
            name: "Kill session"
            shortcut: "Ctrl+Alt+Backspace"
            onTriggered: Compositor.abortSession();
        },

        Action {
            id: lockAction
            name: "Lock your " + Device.name
            shortcut: "Alt+L"
            onTriggered: lockScreen();
        },

        Action {
            name: "Developer tools"
            shortcut: "Ctrl+Alt+D"
            onTriggered: toggleDeveloperTools()
        }
    ]

    property alias screenInfo: __screenInfo
    signal superPressed()
//    onStateChanged: {
//        powerDialog.close()
//    }

    function log(message) {
        logs = logs + message + '\n'
    }

    function toggleState(state) {
        if (shell.state === state)
            shell.state = "default"
        else
            shell.state = state
    }

    function toggleDeveloperTools() {
        toggleState("developer")
    }

    function lockScreen() {
        shell.state = "locked"
    }

    function showPowerDialog() {
        print("Showing power dialog!")
        if (SessionManager.canSuspend || SessionManager.canHibernate ||
                SessionManager.canPowerOff) {
            powerDialog.open()
        }
    }

    Desktop {
        id: desktop
        clip: true
    }


    Loader {
        id: stage
        anchors.fill: parent
        Component.onCompleted: {
            var component = Qt.createComponent(Qt.resolvedUrl("u2t.qml"),
                    Component.Asynchronous)
            loader.sourceComponent = component
        }
    }

    // This catches mouse clicks outside of the active popup menu and closes the popup menu
    MouseArea {
        id: popupWindowOverlay
        anchors.fill: parent
        visible: desktop.windowManager.activeWindow !== undefined &&
                desktop.windowManager.activeWindow.popupChild !== null
        enabled: visible
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
        onPressed: {
            var point = popupWindowOverlay.mapToItem(desktop.windowManager.activeWindow.popupChild,
                    mouse.x, mouse.y)
            console.log(point)
            if (!desktop.windowManager.activeWindow.popupChild.contains(point)) {
                mouse.accepted = true
                desktop.windowManager.activeWindow.popupChild.close(destroy)
            } else {
                mouse.accepted = false
            }
        }
    }

    QtObject {
        id: __screenInfo
        readonly property string name: _greenisland_output.name
        readonly property int number: _greenisland_output.number
        readonly property bool primary: _greenisland_output.primary
    }
}
