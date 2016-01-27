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
import "../common/utils.js" as Utils
import "../common/units.js" as Units
import "../launcher"
import "../dash"
FocusScope {
    id: indicator
    property string activeComponent
    signal itemClicked1(string id)

    //    onActiveFocusChanged: if (!activeFocus) systemsettingsLens.focus = true
    //||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    //||                        Propertys
    //||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    //|             background
    property alias background: backgroundRectangle
    property alias backgroundboarder: backgroundRectangleBorder


    //    |         Menu Buttons

    property alias aboutthiscomp: abouthiscomputerRectangle
    property alias ubuntuhelp: ubuntuhelpRectangle
    property alias systemsettings: systemsettingsRectangle
    property alias lock: lockRectangle
    property alias user: userRectangle
    property alias logout: logoutRectangle
    property alias suspend: suspendRectangle
    property alias restart: restartRectangle
    property alias switchoff: switchoffRectangle

    //    |             Borders

    property alias aboutthiscompboarder: abouthiscomputerRectangleBorder
    property alias ubuntuhelpboarder: ubuntuhelpRectangleBorder
    property alias systemsettingsboarder: systemsettingsRectangleBorder
    property alias lockboarder: lockRectangleBorder
    property alias userboarder: userRectangleBorder
    property alias logoutboarder: logoutRectangleBorder
    property alias suspendboarder: suspendRectangleBorder
    property alias restartboarder: restartRectangleBorder
    property alias switchofboarder: switchoffRectangleBorder


    //  |   Random

    property bool ownBackground: true
    property bool active: false
    property bool activable: false
    property alias source: icon.source
    property alias focusedSource: focusedIcon.source

    width: icon.width
    height: icon.height

    onActiveFocusChanged: if (active && !activeFocus) active = false

    //    |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    //                                              Roottangle
    //   ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    Rectangle {
        id: backgroundRectangle
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(120)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-330)
        height: Units.tvPx(720)
        width: Units.tvPx(420)
        color: Utils.darkAubergine
        opacity: parent.activeFocus && ownBackground ? 0 :0
        radius: Units.tvPx(10)
        //        anchors.horizontalCenter: parent.horizontalCenter

        Behavior on opacity { NumberAnimation {} }
        Behavior on width { NumberAnimation {} }
        Behavior on height { NumberAnimation {} }
    }

    MouseArea {
        anchors.fill: background
        enabled: active
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        enabled: activable
        hoverEnabled: true
        onClicked: if (activable) { indicator.forceActiveFocus(); active = !active }
    }

    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(300)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-880)
        radius: Units.tvPx(10)
        opacity: !active && mouseArea.containsMouse ? 0.0 : 0
        Behavior on opacity { NumberAnimation { duration: 100 } }
    }

    //white boarder line

    Rectangle {
        id: backgroundRectangleBorder
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(300)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-880)
        width: background.width + border.width
        height: background.height + border.width
        color: "transparent"
        opacity: parent.activeFocus && ownBackground ? 0.0 : 0
        radius: background.radius + border.width

        anchors.centerIn: backgroundRectangle

        border.color: "white"
        border.width: Units.tvPx(3)

        Behavior on opacity { NumberAnimation {} }
    }


    //||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    //              1                            About this computer                                           ||
    //||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    Rectangle {
        id: abouthiscomputerRectangle
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(140)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-319)
        height: Units.tvPx(50)
        width: Units.tvPx(400)
        color: Utils.darkAubergine
        opacity: parent.activeFocus && ownBackground ? 0 :0
        radius: Units.tvPx(10)
        Behavior on opacity { NumberAnimation {} }
        Behavior on width { NumberAnimation {} }
        Behavior on height { NumberAnimation {} }
        Text {
            //            anchors.centerIn: parent.Center
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: Units.tvPx(8)
            font.pixelSize: 24
            color: "white"
            text: qsTr("About This Computer")
        }

        PannelIndicaorparser{
            enabled: active
            anchors.fill: abouthiscomputerRectangle
            icon:""
            desktopFile: "gnome-info-panel.desktop"
        }
    }


    MouseArea {
        id: aboutmouseArea
        anchors.fill: parent
        enabled: activable
        hoverEnabled: true
        onClicked: if (activable) { indicator.forceActiveFocus(); active = !active }
    }

    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(300)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-880)
        radius: Units.tvPx(10)
        opacity: !active && aboutmouseArea.containsMouse ? 0.0 : 0
        Behavior on opacity { NumberAnimation { duration: 100 } }
    }

    Rectangle {
        id: abouthiscomputerRectangleBorder
        width: abouthiscomputerRectangle.width + border.width
        height: abouthiscomputerRectangle.height + border.width
        color: "transparent"
        opacity: parent.activeFocus && ownBackground ? 0.0 : 0
        radius: abouthiscomputerRectangle.radius + border.width

        anchors.centerIn: abouthiscomputerRectangle

        border.color: "white"
        border.width: Units.tvPx(.5)

        Behavior on opacity { NumberAnimation {} }
    }
    //||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    //        2                                Ubuntu Help                                           ||
    //||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    Rectangle {
        id: ubuntuhelpRectangle
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(200)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-319)
        height: Units.tvPx(50)
        width: Units.tvPx(400)
        color: Utils.darkAubergine
        opacity: parent.activeFocus && ownBackground ? 0 :0
        radius: Units.tvPx(10)
        Behavior on opacity { NumberAnimation {} }
        Behavior on width { NumberAnimation {} }
        Behavior on height { NumberAnimation {} }
        Text {
            //            anchors.centerIn: parent.Center
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: Units.tvPx(8)
            font.pixelSize: 24
            color: "white"
            text: qsTr("Ubuntu Help")
        }


        PannelIndicaorparser{
            enabled: active
            anchors.fill: ubuntuhelpRectangle
            icon:""
            desktopFile: "yelp.desktop"
        }
    }

    MouseArea {
        id: ubuntuhelpmouseArea
        anchors.fill: parent
        enabled: activable
        hoverEnabled: true
        onClicked: if (activable) { indicator.forceActiveFocus(); active = !active }
    }

    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(300)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-880)
        radius: Units.tvPx(10)
        opacity: !active && ubuntuhelpmouseArea.containsMouse ? 0.0 : 0
        Behavior on opacity { NumberAnimation { duration: 100 } }
    }

    Rectangle {
        id: ubuntuhelpRectangleBorder
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(300)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-880)
        width: ubuntuhelpRectangle.width + border.width
        height: ubuntuhelpRectangle.height + border.width
        color: "transparent"
        opacity: parent.activeFocus && ownBackground ? 0.0 : 0
        radius: ubuntuhelpRectangle.radius + border.width

        anchors.centerIn: ubuntuhelpRectangle

        border.color: "white"
        border.width: Units.tvPx(.5)

        Behavior on opacity { NumberAnimation {} }
    }

    //||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    //  3                                        System Setting                                                   ||
    //||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

    Rectangle {
        id: systemsettingsRectangle
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(260)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-319)
        height: Units.tvPx(75)
        width: Units.tvPx(400)
        color: Utils.darkAubergine
        opacity: parent.activeFocus && ownBackground ? 0 :0
        radius: Units.tvPx(10)
        Behavior on opacity { NumberAnimation {} }
        Behavior on width { NumberAnimation {} }
        Behavior on height { NumberAnimation {} }
        PictureGlowButton{
            enabled: active
            anchors.fill: systemsettingsRectangle
            onClicked: dash.activateSystemsettings()
            Text {
                id:systxt
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: Units.tvPx(8)
                font.pixelSize: 24
                color: "white"
                text: qsTr("System Settings . . ..")
            }
        }
    }

    MouseArea {
        id: systemmouseArea
        anchors.fill: parent
        enabled: activable
        hoverEnabled: true
        onClicked: if (activable) { indicator.forceActiveFocus(); active = !active }
    }

    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(300)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-880)
        radius: Units.tvPx(10)
        opacity: !active && systemmouseArea.containsMouse ? 0.0 : 0
        Behavior on opacity { NumberAnimation { duration: 100 } }
    }

    Rectangle {
        id: systemsettingsRectangleBorder
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(300)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-880)
        width: systemsettingsRectangle.width + border.width
        height: systemsettingsRectangle.height + border.width
        color: "transparent"
        opacity: parent.activeFocus && ownBackground ? 0.0 : 0
        radius: systemsettingsRectangle.radius + border.width

        anchors.centerIn: systemsettingsRectangle

        border.color: "white"
        border.width: Units.tvPx(.5)

        Behavior on opacity { NumberAnimation {} }
    }
    //||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    //4                                          Lock                                           ||
    //||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    Rectangle {
        id: lockRectangle
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(350)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-319)
        height: Units.tvPx(50)
        width: Units.tvPx(400)
        color: Utils.darkAubergine
        opacity: parent.activeFocus && ownBackground ? 0 :0
        radius: Units.tvPx(10)
        Behavior on opacity { NumberAnimation {} }
        Behavior on width { NumberAnimation {} }
        Behavior on height { NumberAnimation {} }
        Text {
            //            anchors.centerIn: parent.Center
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: Units.tvPx(8)
            font.pixelSize: 24
            color: "white"
            text: qsTr("Lock")
        }

        PannelIndicaorparser{
            enabled: active
            anchors.fill: lockRectangle
            desktopFile:  'indicator-session-lock-screen.desktop'
            icon:""
        }
    }
    MouseArea {
        id: lockmouseArea
        anchors.fill: parent
        enabled: activable
        hoverEnabled: true
        onClicked: if (activable) { indicator.forceActiveFocus(); active = !active }
    }

    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(300)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-880)
        radius: Units.tvPx(10)
        opacity: !active && lockmouseArea.containsMouse ? 0.0 : 0
        Behavior on opacity { NumberAnimation { duration: 100 } }
    }

    Rectangle {
        id: lockRectangleBorder
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(300)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-880)
        width: lockRectangle.width + border.width
        height: lockRectangle.height + border.width
        color: "transparent"
        opacity: parent.activeFocus && ownBackground ? 0.0 : 0
        radius: lockRectangle.radius + border.width

        anchors.centerIn: lockRectangle

        border.color: "white"
        border.width: Units.tvPx(.5)

        Behavior on opacity { NumberAnimation {} }
    }

    //||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    //     5          User                                    ||
    //||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    Rectangle {
        id: userRectangle
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(410)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-319)
        height: Units.tvPx(175)
        width: Units.tvPx(400)
        color: Utils.darkAubergine
        opacity: parent.activeFocus && ownBackground ? 0 :0
        radius: Units.tvPx(10)
        Behavior on opacity { NumberAnimation {} }
        Behavior on width { NumberAnimation {} }
        Behavior on height { NumberAnimation {} }

        Image {
            id: userid
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: Units.tvPx(8)
            source: "../artwork/faces/astronaut.jpg"
        }
        Text {
            //            anchors.centerIn: parent.Center
            anchors.verticalCenter: userid.verticalCenter
            anchors.left: userid.right
            anchors.leftMargin: Units.tvPx(18)
            font.pixelSize: 24
            color: "white"
            text: qsTr("Joseph's Tv")
        }

        PannelIndicaorparser{
            enabled: active
            anchors.fill: userRectangle
            icon:""
            desktopFile: "gnome-user-accounts-panel.desktop"
        }
    }

    MouseArea {
        id: usermouseArea
        anchors.fill: parent
        enabled: activable
        hoverEnabled: true
        onClicked: if (activable) { indicator.forceActiveFocus(); active = !active }
    }

    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(300)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-880)
        radius: Units.tvPx(10)
        opacity: !active && usermouseArea.containsMouse ? 0.0 : 0
        Behavior on opacity { NumberAnimation { duration: 100 } }
    }

    Rectangle {
        id: userRectangleBorder
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(300)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-880)
        width: userRectangle.width + border.width
        height: userRectangle.height + border.width
        color: "transparent"
        opacity: parent.activeFocus && ownBackground ? 0.0 : 0
        radius: userRectangle.radius + border.width

        anchors.centerIn: userRectangle

        border.color: "white"
        border.width: Units.tvPx(.5)

        Behavior on opacity { NumberAnimation {} }
    }

    //||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    //   6                               Logout                                           ||
    //||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    Rectangle {
        id: logoutRectangle
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(600)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-319)
        height: Units.tvPx(50)
        width: Units.tvPx(400)
        color: Utils.darkAubergine
        opacity: parent.activeFocus && ownBackground ? 0 :0
        radius: Units.tvPx(10)
        Behavior on opacity { NumberAnimation {} }
        Behavior on width { NumberAnimation {} }
        Behavior on height { NumberAnimation {} }
        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: Units.tvPx(8)
            font.pixelSize: 24
            color: "white"
            text: qsTr("Logout")
        }

        PannelIndicaorparser{
            enabled: active
            anchors.fill: logoutRectangle
            icon:""
            desktopFile:"indicator-session-logout.desktop"
        }
    }

    MouseArea {
        id: logoutmouseArea
        anchors.fill: parent
        enabled: activable
        hoverEnabled: true
        onClicked: if (activable) { indicator.forceActiveFocus(); active = !active }
    }

    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(300)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-880)
        radius: Units.tvPx(10)
        opacity: !active && logoutmouseArea.containsMouse ? 0.0 : 0
        Behavior on opacity { NumberAnimation { duration: 100 } }
    }

    Rectangle {
        id: logoutRectangleBorder
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(300)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-880)
        width: logoutRectangle.width + border.width
        height: logoutRectangle.height + border.width
        color: "transparent"
        opacity: parent.activeFocus && ownBackground ? 0.0 : 0
        radius: logoutRectangle.radius + border.width

        anchors.centerIn: logoutRectangle

        border.color: "white"
        border.width: Units.tvPx(.5)

        Behavior on opacity { NumberAnimation {} }
    }

    //||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    // 7                                         Suspend                                           ||
    //||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    Rectangle {
        id: suspendRectangle
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(660)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-319)
        height: Units.tvPx(50)
        width: Units.tvPx(400)
        color: Utils.darkAubergine
        opacity: parent.activeFocus && ownBackground ? 0 :0
        radius: Units.tvPx(10)
        Behavior on opacity { NumberAnimation {} }
        Behavior on width { NumberAnimation {} }
        Behavior on height { NumberAnimation {} }
        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: Units.tvPx(8)
            font.pixelSize: 24
            color: "white"
            text: qsTr("Suspend")
        }

        PannelIndicaorparser{
            enabled: active
            anchors.fill: suspendRectangle
            icon: ""
            desktopFile:"indicator-session-lock-screen.desktop"
        }
    }


    MouseArea {
        id: suspendmouseArea
        anchors.fill: parent
        enabled: activable
        hoverEnabled: true
        onClicked: if (activable) { indicator.forceActiveFocus(); active = !active }
    }

    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(300)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-880)
        radius: Units.tvPx(10)
        opacity: !active && suspendmouseArea.containsMouse ? 0.0 : 0
        Behavior on opacity { NumberAnimation { duration: 100 } }
    }

    Rectangle {
        id: suspendRectangleBorder
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(300)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-880)
        width: suspendRectangle.width + border.width
        height: suspendRectangle.height + border.width
        color: "transparent"
        opacity: parent.activeFocus && ownBackground ? 0.0 : 0
        radius: suspendRectangle.radius + border.width

        anchors.centerIn: suspendRectangle

        border.color: "white"
        border.width: Units.tvPx(.5)

        Behavior on opacity { NumberAnimation {} }
    }


    //||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    //8                                         Restart                                         ||
    //||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    Rectangle {
        id: restartRectangle
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(720)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-319)
        height: Units.tvPx(50)
        width: Units.tvPx(400)
        color: Utils.darkAubergine
        opacity: parent.activeFocus && ownBackground ? 0 :0
        radius: Units.tvPx(10)
        Behavior on opacity { NumberAnimation {} }
        Behavior on width { NumberAnimation {} }
        Behavior on height { NumberAnimation {} }
        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: Units.tvPx(8)
            font.pixelSize: 24
            color: "white"
            text: qsTr("Restart")
        }

        PannelIndicaorparser{
            enabled: active
            anchors.fill:restartRectangle
            icon:""
            desktopFile: "indicator-session-restart.desktop"
        }
    }


    MouseArea {
        id: restartmouseArea
        anchors.fill: parent
        enabled: activable
        hoverEnabled: true
        onClicked: if (activable) { indicator.forceActiveFocus(); active = !active }
    }

    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(300)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-880)
        radius: Units.tvPx(10)
        opacity: !active && restartmouseArea.containsMouse ? 0.0 : 0
        Behavior on opacity { NumberAnimation { duration: 100 } }
    }

    Rectangle {
        id: restartRectangleBorder
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(300)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-880)
        width: restartRectangle.width + border.width
        height: restartRectangle.height + border.width
        color: "transparent"
        opacity: parent.activeFocus && ownBackground ? 0.0 : 0
        radius: restartRectangle.radius + border.width

        anchors.centerIn: restartRectangle

        border.color: "white"
        border.width: Units.tvPx(.5)

        Behavior on opacity { NumberAnimation {} }
    }

    //||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||\
    //|                 END                                              |
    //||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||


    //||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    //9                                          Switch Off                                           ||
    //||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    Rectangle {
        id: switchoffRectangle
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(780)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-319)
        height: Units.tvPx(50)
        width: Units.tvPx(400)
        color: Utils.darkAubergine
        opacity: parent.activeFocus && ownBackground ? 0 :0
        radius: Units.tvPx(10)
        Behavior on opacity { NumberAnimation {} }
        Behavior on width { NumberAnimation {} }
        Behavior on height { NumberAnimation {} }
        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: Units.tvPx(8)
            font.pixelSize: 24
            color: "white"
            text: qsTr("Switch Off")
        }

        PannelIndicaorparser{
            enabled: active
            anchors.fill: switchoffRectangle
            icon:""
            desktopFile: "indicator-session-shutdown.desktop"
        }
    }

    MouseArea {
        id: switchoffmouseArea
        anchors.fill: parent
        enabled: activable
        hoverEnabled: true
        onClicked: if (activable) { indicator.forceActiveFocus(); active = !active }
    }

    Rectangle {

        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(300)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-880)
        radius: Units.tvPx(10)
        opacity: !active && switchoffmouseArea.containsMouse ? 0.0 : 0
        Behavior on opacity { NumberAnimation { duration: 100 } }
    }

    Rectangle {
        id: switchoffRectangleBorder
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(300)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(-880)
        width: switchoffRectangle.width + border.width
        height: switchoffRectangle.height + border.width
        color: "transparent"
        opacity: parent.activeFocus && ownBackground ? 0.0 : 0
        radius: switchoffRectangle.radius + border.width

        anchors.centerIn: switchoffRectangle

        border.color: "white"
        border.width: Units.tvPx(.5)

        Behavior on opacity { NumberAnimation {} }
    }


    //||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||\
    //|                 END                                              |
    //||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||


    //top image

    Image {
        id: focusedIcon
        opacity: 1 - icon.opacity

        smooth: true
    }

    Image {
        id: icon
        focus: true
        opacity: activeFocus ? 0 : 1
        Behavior on opacity { NumberAnimation { } }

        width: Units.tvPx(sourceSize.width)
        height: Units.tvPx(sourceSize.height)
        smooth: true

        Keys.onPressed: {
            if (!event.isAutoRepeat)
            {
                if (event.key == Qt.Key_Return ||
                        event.key == Qt.Key_Enter ||
                        (event.key == Qt.Key_Escape && active))
                {
                    event.accepted = true
                    if (activable) {
                        active = !active
                    }
                }
            }
        }
    }
}
