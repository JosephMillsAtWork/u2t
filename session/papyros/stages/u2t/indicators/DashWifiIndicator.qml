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
import "../common/units.js" as Units
import "../common/utils.js" as Utils
import Qt 4.7
import QtMobility.systeminfo 1.1

WifiIndicator {
    background.width: active ? Units.tvPx(354) : width
    background.height: active ? Units.tvPx(510) : height
    background.opacity: active ? 0.5 : activeFocus ? 0.2 : 0

    Item {
        id: wlan
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: background.top
        anchors.topMargin: Units.tvPx(80)
        anchors.bottom: background.bottom
        width: background.width
        visible: background.width != Units.tvPx(180)
        opacity: active ? 1 : 0
        clip: true
        Behavior on opacity { NumberAnimation {} }

        Text {
            id: signame
            color: "white"
            text: "Networking"
            x: 110
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 18; font.bold: true
        }

    }


    BorderImage {
        id: wifiBarOutline

        anchors.bottom: wlan.bottom
        anchors.bottomMargin: 10
        //        anchors.fill: wlan

        source: "artwork/wifi.sci"

        height: Units.tvPx(560)
        width: Units.tvPx(354)
    }

    BorderImage {
        id: wifiBarFiller
        source: "artwork/wifi_orange.sci"

        anchors.horizontalCenter: wifiBarOutline.horizontalCenter
        anchors.bottom: wifiBarOutline.bottom
        width: Units.tvPx(354)
        height: Units.tvPx(Math.round(560 + shell.volume * 202))
    }


    Item {
        id: wlan1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: background.top
        anchors.topMargin: Units.tvPx(80)
        anchors.bottom: background.bottom
        width: background.width
        visible: background.width != Units.tvPx(170)

        opacity: active ? 2 : 0

        NetworkInfo {
            id: wlaninfo
            mode: NetworkInfo.WlanMode;

            onStatusChanged: {
                monitorNameChanges: true
                monitorSignalStrengthChanges: true

            }
        }
        //||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        //        |Main Image
        BorderImage {
            id: ethnetpic
            source: "../artwork/search_background.png"
            anchors.top: parent.top
            anchors.topMargin: Units.tvPx(40)
            width: 354; height: 120
            border.left: 20; border.top: 20
            border.right: 20; border.bottom: 20
        }



        //        |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

        Column{
            anchors.top: parent.top
            anchors.topMargin: Units.tvPx(170)
            spacing: 2
            BorderImage {
                id: hiddenNet
                source: "../artwork/search_background.png"
                width: 354; height: 60
                border.left: 20; border.top: 20
                border.right: 20; border.bottom: 20
                PannelIndicaorparser{
                    id:hiddenNetbutt
                    anchors.fill: hiddenNet
                    icon: ""
                    desktopFile: "gnome-network-panel.desktop"
                }
                Text {
                    id:hiddennettxt
                    anchors{
                        verticalCenter: hiddenNetbutt.verticalCenter
                        left: hiddenNetbutt.left
                        leftMargin: Units.tvPx(10)
                    }
                    color: "white"
                    text: qsTr("Connect to a hidden Network")
                }
            }

            //correct
            BorderImage {
                id: vpnnet
                source: "../artwork/search_background.png"
                width: 354; height: 60
                border.left: 20; border.top: 20
                border.right: 20; border.bottom: 20
                PannelIndicaorparser{
                    id: vpnnetbutt
                    anchors.fill: vpnnet
                    icon: ""
                    desktopFile: "nm-connection-editor.desktop"
                }
                Text {
                    id:vpnnettxt
                    anchors{
                        verticalCenter: vpnnetbutt.verticalCenter
                        left: vpnnetbutt.left
                        leftMargin: Units.tvPx(10)
                    }
                    color: "white"
                    text: qsTr("VPN Connections")
                }

            }



            //Fixme
            BorderImage {
                id: conninfo
                source: "../artwork/search_background.png"

                width: 354; height: 60
                border.left: 20; border.top: 20
                border.right: 20; border.bottom: 20
                PannelIndicaorparser{
                    id:coninfobutt
                    anchors.fill: conninfo
                    icon: ""
                    desktopFile: "gnome-network-panel.desktop"
                }
                Text {
                    id:coninfottxt
                    anchors{
                        verticalCenter: coninfobutt.verticalCenter
                        left: coninfobutt.left
                        leftMargin: Units.tvPx(10)
                    }
                    color: "white"
                    text: qsTr("Connection Information")
                }

            }



            BorderImage {
                id: nettools
                source: "../artwork/search_background.png"
                width: 354; height: 60
                border.left: 20; border.top: 20
                border.right: 20; border.bottom: 20
                PannelIndicaorparser{
                    id:nettoolbutt
                    anchors.fill: nettools
                    icon: ""
                    desktopFile: "gnome-nettool.desktop"
                }
                Text {
                    id:nettooltxt
                    anchors{
                        verticalCenter: nettoolbutt.verticalCenter
                        left: nettoolbutt.left
                        leftMargin: Units.tvPx(10)
                    }
                    color: "white"
                    text: qsTr("Networking Tools")
                }

            }


            //        BorderImage {
            //            id: wirelesspic4
            //            source: "../artwork/search_background.png"

            //            width: 354; height: 60
            //            border.left: 20; border.top: 20
            //            border.right: 20; border.bottom: 20
            //            PannelIndicaorparser{
            //            id:hiddenNetbutt
            //                anchors.fill: hiddenNet
            //                icon: ""
            //                desktopFile: "gnome-network-panel.desktop"
            //            }
            //            Text {
            //                id:hiddennettxt
            //                anchors{
            //                verticalCenter: hiddenNetbutt.verticalCenter
            //                left: hiddenNet.left
            //                leftMargin: Units.tvPx(8)
            //                }
            //                color: "white"
            //                text: qsTr("Connect to a hidden Network")
            //            }

            //        }
        }
        //  |||||||||||||||||||||||||||||||||||||||||




        Text {
            id: etherne
            //anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: Units.tvPx(80)
            anchors.bottom: parent.bottom
            width: parent.width
            visible: parent.width != Units.tvPx(180)
            opacity: active ? 2 : 0

            NetworkInfo{
                id: ethstats
                mode: NetworkInfo.EthernetMode;

                onStatusChanged: {
                    monitorNameChanges: true
                    monitorStatusChanges: true

                }
            }
            Text {
                text: "Status:"+" "+ethstats.networkStatus
                color: "white"
                font.pointSize: 14; font.bold: true
                anchors.left: parent.left
                anchors.leftMargin: Units.tvPx(24)
                anchors.top: parent.top
                anchors.topMargin: Units.tvPx(-24)
            }
            Text {
                color: "white"
                font.pointSize: 14; font.bold: true
                anchors.left: parent.left
                anchors.leftMargin: Units.tvPx(24)
                anchors.top: parent.top
                anchors.topMargin: Units.tvPx(07)
                text: "Connected To:"+" "+ ethstats.networkName
            }
            Text {
                color: "white"
                font.pointSize: 14; font.bold: true
                anchors.left: parent.left
                anchors.leftMargin: Units.tvPx(24)
                anchors.top: parent.top
                anchors.topMargin: Units.tvPx(40)
                text: "Mac Address:"+""+ethstats.macAddress
            }

        }
    }
}
