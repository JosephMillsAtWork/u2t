import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Dialogs 1.2

import U2T.Menu 1.0
import U2T.GSettings 1.0
import U2T.Hardware 1.0
import U2T.Sound 1.0
import U2T.System 1.0
import U2T.Notifications 1.0
import U2T.Networking 1.0

import GreenIsland 1.0 as GreenIsland
import "WindowManager.js" as WindowManagement


import org.kde.kcoreaddons 1.0
import org.kde.solid 1.0

Item {
    id: root
    anchors.fill: parent
//    color: "#00000000"
    property string now
    property var activeWindow: null
    readonly property int activeWindowIndex: WindowManagement.getActiveWindowIndex()
    readonly property var windowList: WindowManagement.windowList
//    property string something
    Loader {
        id: loader
        anchors.fill: parent
        asynchronous: true
        Component.onCompleted: {
            var component = Qt.createComponent(Qt.resolvedUrl("main.qml"),
                                               Component.Asynchronous)
            loader.sourceComponent = component
        }
    }

    //////////////////////////////////////////
    ////
    /// SINGLETONS
    ///
    /////////////////////////////////////////



    Connections {
        id: compositor
        target: GreenIsland.Compositor
        onWindowMapped: {
            // A window was mapped
            WindowManagement.windowMapped(window);
        }
        onWindowUnmapped: {
            // A window was unmapped
            WindowManagement.windowUnmapped(window);
        }
        onWindowDestroyed: {
            // A window was unmapped
            WindowManagement.windowDestroyed(id);
        }
        onSurfaceMapped: {
            // A surface was mapped
            WindowManagement.surfaceMapped(surface);
        }

    }


    GreenIsland.FpsCounter { id: fpsCounter }
//    GreenIsland.Compositor{id: compositor}
    /////////////////////////////////////////////
    // Extra Process Runner
    ////////////////////////////////////////////
    QQmlProcess{ id: appRunner ;startDetached: true }

    //////////////////////////////////
    // mlite (Desktop File Reader)
    /////////////////////////////////
    DesktopEntry { id: dFile }

    ////////////////////////////////////
    // Notifacations
    ///////////////////////////////////
    NotificationServer{id: notifyServer }

    ////////////////////////////////////
    // Networking
    ///////////////////////////////////
    EnabledConnections {id: enabledConnections }
    AvailableDevices {id: availableDevices }
    NetworkModel { id: connectionModel }
    AppletProxyModel { id: appletProxyModel;  sourceModel: connectionModel }


    ////////////////////////////////
    // KDE SOILD Framework
    ////////////////////////////////
    Devices { id: allDevices }
    Devices { id: diskVolShares; query: "IS StorageVolume" }

    ////////////////////////////////////
    // SOUND and battery
    ////////////////////////////////////
    HardwareEngine { id: hardware }

    Sound {
        id: sound
        property string iconName: sound.muted || sound.master == 0 ? "av/volume_off" : sound.master <= 33 ? "av/volume_mute" : sound.master >= 67 ? "av/volume_up" : "av/volume_down"
        property int notificationId: 0
        onMasterChanged: {
            soundTimer.restart()
        }
        // The master volume often has random or duplicate change signals, so this helps to
        // smooth out the signals into only real changes
        Timer {
            id: soundTimer
            interval: 10
            onTriggered: {
                if (sound.master !== volume && volume !== -1) {
                    sound.notificationId = notifyServer.notify("Sound", sound.notificationId,
                                                               "icon://" + sound.iconName, "Volume changed", "", [], {}, 0,
                                                               sound.master).id
                }
                volume = sound.master
            }
            property int volume: -1
        }
    }

    ////////////////////////////////
    //       KeyBoard
    ///////////////////////////////
    KeyEventFilter { id: keyEventFilter }

    /////////////////////////////////
    // Icons and Cursor
    ///////////////////////////////
    IconHelper{id:iconHelper}

    ///////////////
    //  NOW
    //////////////////
    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: now = new Date()
    }

}

