import QtQuick 1.1
import Unity2d 1.0
import "../component" as Comp
import "../../../dash"
import "../../../common"
import "../../../common/utils.js" as Utils
import "../../../common/units.js" as Units
import "settingsPage"
import "../../../dash/filters/sidebar/"
FocusScope{
Rectangle {
    id: roottangle
    width: parent.width
    height: parent.height
    color: "transparent"
    anchors{
        right: parent.right
        left: parent.left
        top: parent.top
        bottom: parent.bottom
    }

    Rectangle {
        id: mainBackground
        width: if (unity2dConfiguration.formFactor === "tv" )
                   parent.width / 1.38
               else
                   parent.width / 1.35
        height: parent.height
        border.color: "#09FFFFFF"
        border.width: 2
        radius: 0
        gradient: Gradient {
            GradientStop { position: 1; color: "#02000000"}
            GradientStop { position: 0; color: "#02FFFFFF"}

        }anchors{
            left: parent.left
            leftMargin: parent.width / 3.98
        }

    }
    //This is the starting grid
    Grid{
        id: mainGridpage
        width: mainBackground.width
        height: parent.height - 60
        columns: 2
        rows: 2
        spacing: mainBackground.width / 10
        anchors{
            left: mainBackground.left
            leftMargin: mainBackground.width / 6
            top: mainBackground.top
            topMargin: mainBackground.height / 30

        }
        Rectangle{
            id:powerbkRec
            width: mainBackground.width / 4
            height: mainBackground.width / 4
            border.color: "#55FFFFFF"
            border.width: 1
            gradient: Gradient {
                GradientStop { position: 0; color: "#12000000"}
                GradientStop { position: 0.5; color: "#44808080"}
                GradientStop { position: 1; color: "#12000000"}
            }MouseArea{
                id: powerbkRecMouse
                width: powerbkRec.width
                height: powerbkRec.height
                anchors.fill: powerbkRec
                onClicked:{
                    mainGridpage.visible = false
                    mainPowerColumn.visible = true
                    backtomain.visible = true
                }
                Image{
                    id: powerbkRecImg
                    source: "../component/gfx/gnome-power-manager-symbolic.png"
                    width: powerbkRecMouse.width / 2
                    height: powerbkRecMouse.width / 2
                    smooth: true
                    anchors{
                        verticalCenter: powerbkRecMouse.verticalCenter
                        horizontalCenter: powerbkRecMouse.horizontalCenter
                    }
                    Text {
                        text: u2d.tr("Power Settings") ;
                        color: "white";
                        font.pixelSize: powerbkRec.height / 10;
                        anchors{
                            horizontalCenter: powerbkRecImg.horizontalCenter
                            top: powerbkRecImg.top
                            topMargin: powerbkRecImg.height / -2
                        }
                    }
                }
            }
        }
        Rectangle{
            id:timebkRec
            width: mainBackground.width / 4
            height: mainBackground.width / 4
            border.color: "#55FFFFFF"
            border.width: 1
            gradient: Gradient {
                GradientStop { position: 0; color: "#12000000"}
                GradientStop { position: 0.5; color: "#44808080"}
                GradientStop { position: 1; color: "#12000000"}
            }MouseArea{
                id: timebkRecMouse
                width: timebkRec.width
                height: timebkRec.height
                anchors.fill: timebkRec
                onClicked:{
                    mainGridpage.visible = false
                    mainTimeColumn.visible = true
                    backtomain.visible = true
                }
                Image{
                    id: timebkRecImg
                    source: "../component/gfx/preferences-system-time-symbolic.png"
                    width: timebkRecMouse.width / 2
                    height: timebkRecMouse.width / 2
                    smooth: true
                    anchors{
                        verticalCenter: timebkRecMouse.verticalCenter
                        horizontalCenter: timebkRecMouse.horizontalCenter
                    }
                    Text {
                        text: u2d.tr("Time Settings") ;
                        color: "white";
                        font.pixelSize: timebkRec.height / 10;
                        anchors{
                            horizontalCenter: timebkRecImg.horizontalCenter
                            top: timebkRecImg.top
                            topMargin: timebkRecImg.height / -2

                        }
                    }
                }
            }
        }
        Rectangle{
            id:soundbkRec
            width: mainBackground.width / 4
            height: mainBackground.width / 4
            border.color: "#55FFFFFF"
            border.width: 1
            gradient: Gradient {
                GradientStop { position: 0; color: "#12000000"}
                GradientStop { position: 0.5; color: "#44808080"}
                GradientStop { position: 1; color: "#12000000"}
            }MouseArea{
                id: soundbkRecMouse
                width: soundbkRec.width
                height: soundbkRec.height
                anchors.fill: soundbkRec
                onClicked:{
                    backtomain.visible = true
                    mainGridpage.visible = false
                    mainSoundColumn.visible = true
                }
                Image{
                    id:soundbkRecImg
                    source: "../component/gfx/audio-volume.png"
                    width: soundbkRecMouse.width / 2
                    height: soundbkRecMouse.width / 2
                    smooth: true
                    anchors{
                        verticalCenter: soundbkRecMouse.verticalCenter
                        horizontalCenter: soundbkRecMouse.horizontalCenter
                    }
                    Text {
                        text: u2d.tr("Sound Settings") ;
                        color: "white";
                        font.pixelSize: soundbkRec.height / 10;
                        anchors{
                            horizontalCenter: soundbkRecImg.horizontalCenter;
                            top: soundbkRecImg.top
                            topMargin: soundbkRecImg.height / -2
                        }
                    }
                }
            }
        }
        Rectangle{
            id:bluetoothbkRec
            width: mainBackground.width / 4
            height: mainBackground.width / 4
            border.color: "#55FFFFFF"
            border.width: 1
            gradient: Gradient {
                GradientStop { position: 0; color: "#12000000"}
                GradientStop { position: 0.5; color: "#44808080"}
                GradientStop { position: 1; color: "#12000000"}
            }MouseArea{
                id: bluetoothbkRecMouse
                width: bluetoothbkRec.width
                height: bluetoothbkRec.height
                anchors.fill: bluetoothbkRec
                onClicked:{
                    backtomain.visible = true
                    mainGridpage.visible = false
                    mainBluetoothColumn.visible = true
                }
                Image{
                    id: bluetoothbkRecImg
                    source: "../component/gfx/bluetooth-symbolic.png"
                    width: bluetoothbkRecMouse.width / 2
                    height: bluetoothbkRecMouse.width / 2
                    smooth: true
                    anchors{
                        verticalCenter: bluetoothbkRecMouse.verticalCenter
                        horizontalCenter: bluetoothbkRecMouse.horizontalCenter
                    }
                    Text {
                        text: u2d.tr("BlueTooth Settings") ;
                        color: "white";
                        font.pixelSize: bluetoothbkRec.height / 10;
                        anchors{
                            horizontalCenter: bluetoothbkRecImg.horizontalCenter
                            top: bluetoothbkRecImg.top
                            topMargin: bluetoothbkRecImg.height / -2

                        }
                    }
                }
            }
        }

    }

    //         Power Options
    Column{
        visible: false
        id:mainPowerColumn
        spacing: 5
        width: mainBackground.width
        height: parent.height - 60
        anchors{
            left: mainBackground.left
            top: mainBackground.top
            topMargin: mainBackground.height / 15

        }
        Rectangle{
            id:appletsRec
            width: mainBackground.width
            height: mainBackground.height / 8
            border.color: "#55FFFFFF"
            border.width: 1
            gradient: Gradient {
                GradientStop { position: 0; color: "#12000000"}
                GradientStop { position: 0.5; color: "#44808080"}
                GradientStop { position: 1; color: "#12000000"}

            }
            Text {
                font.pixelSize: 18
                color: "white"
                text: u2d.tr("Power Icon Policy:  (\"present\", \"charge\", and \"never\")")
                anchors{
                    verticalCenter: appletsRec.verticalCenter
                    left: appletsRec.left
                    leftMargin: appletsRec.width / 20
                }
            }
            Rectangle{
                id: appletsButtonRec
                height: appletsRec.height / 3
                width: appletsRec.width / 4
                radius: 0
                border.color: "#55FFFFFF"
                border.width: 0
                gradient: Gradient {
                    GradientStop { position: 0; color: "#12000000"}
                    GradientStop { position: 0.5; color: "#44808080"}
                    GradientStop { position: 1; color: "#12000000"}
                }
                anchors{
                    right: parent.right
                    rightMargin: parent.width / 20
                    verticalCenter: appletsRec.verticalCenter
                }
                TextInput{
                    id: appletsButton

                    height: appletsButtonRec.height / 1.4
                    color:"white"
                    text:  (indicatorPower.iconPolicy)
                    onAccepted:{
                        indicatorPower.iconPolicy = appletsButton.text
                        appletsButton.focus = false

                    }
                    anchors{
                        bottom: appletsButtonRec.bottom
                        horizontalCenter: appletsButtonRec.horizontalCenter

                    }
                }

            }
        }
        Rectangle{
            id:powerIconRec
            width: mainBackground.width
            height: mainBackground.height / 8
            border.color: "#55FFFFFF"
            border.width: 1
            gradient: Gradient {
                GradientStop { position: 0; color: "#12000000"}
                GradientStop { position: 0.5; color: "#44808080"}
                GradientStop { position: 1; color: "#12000000"}

            }
            Text {
                font.pixelSize: 18
                color: "white"
                text: u2d.tr("Show Time By Icon:")
                anchors{
                    verticalCenter: powerIconRec.verticalCenter
                    left: powerIconRec.left
                    leftMargin: powerIconRec.width / 20
                }
            }
            Image{
                id: powerIconButtonRec
                source: "../../../artwork/tick_box.png"
                anchors{
                    right: parent.right
                    rightMargin: parent.width / 12.5
                    verticalCenter: powerIconRec.verticalCenter
                }
                Image{
                    id:powerIconButton
                    visible: if (indicatorPower.showTime === true)
                                 true
                             else
                                 false
                    source: "../../../artwork/tick.png"
                    scale: 1.5
                    smooth: true
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 12.5
                        verticalCenter: powerIconRec.verticalCenter
                    }
                }MouseArea{
                    anchors.fill:powerIconButton
                    onClicked: if (indicatorPower.showTime === true)
                                   indicatorPower.showTime = false
                               else if (indicatorPower.showTime === false)
                                   indicatorPower.showTime = true
                }
            }
        }
    }


    //Bluetooth Options
    Column{
        visible: false
        id:mainBluetoothColumn
        spacing: 5
        width: mainBackground.width
        height: parent.height - 60
        anchors{
            left: mainBackground.left
            top: mainBackground.top
            topMargin: mainBackground.height / 15

        }

        Rectangle{
            id:bluetoothRec
            width: mainBackground.width
            height: mainBackground.height / 8
            border.color: "#55FFFFFF"
            border.width: 1
            gradient: Gradient {
                GradientStop { position: 0; color: "#12000000"}
                GradientStop { position: 0.5; color: "#44808080"}
                GradientStop { position: 1; color: "#12000000"}

            }
            Text {
                font.pixelSize: 18
                color: "white"
                text: u2d.tr("Show Bluetooth:")
                anchors{
                    verticalCenter: bluetoothRec.verticalCenter
                    left: bluetoothRec.left
                    leftMargin: bluetoothRec.width / 20
                }
            }
            Image{
                id: bluetoothIconButtonRec
                source: "../../../artwork/tick_box.png"
                anchors{
                    right: parent.right
                    rightMargin: parent.width / 12.5
                    verticalCenter: bluetoothRec.verticalCenter
                }
                Image{
                    id:bluetoothIconButton
                    visible: if (indicatorBluetooth.visible === true)
                                 true
                             else
                                 false
                    source: "../../../artwork/tick.png"
                    scale: 1.5
                    smooth: true
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 12.5
                        verticalCenter: bluetoothRec.verticalCenter
                    }
                }MouseArea{
                    anchors.fill:bluetoothIconButton
                    onClicked: if (indicatorBluetooth.visible === true)
                                   indicatorBluetooth.visible = false
                               else if (indicatorBluetooth.visible === false)
                                   indicatorBluetooth.visible = true
                }
            }
        }
    }


    //    Sound Options
    Column{
        visible: false
        id:mainSoundColumn
        spacing: 5
        width: mainBackground.width
        height: parent.height - 60
        anchors{
            left: mainBackground.left
            top: mainBackground.top
            topMargin: mainBackground.height / 15

        }

        Rectangle{
            id:soundVisableRec
            width: mainBackground.width
            height: mainBackground.height / 8
            border.color: "#55FFFFFF"
            border.width: 1
            gradient: Gradient {
                GradientStop { position: 0; color: "#12000000"}
                GradientStop { position: 0.5; color: "#44808080"}
                GradientStop { position: 1; color: "#12000000"}

            }
            Text {
                font.pixelSize: 18
                color: "white"
                text: u2d.tr("Show Sound Icon:")
                anchors{
                    verticalCenter: soundVisableRec.verticalCenter
                    left: soundVisableRec.left
                    leftMargin: soundVisableRec.width / 20
                }
            }
            Image{
                id: soundIconButtonRec
                source: "../../../artwork/tick_box.png"
                anchors{
                    right: parent.right
                    rightMargin: parent.width / 12.5
                    verticalCenter: soundVisableRec.verticalCenter
                }
                Image{
                    id:soundIconButton
                    visible: if (indicatorSound.visible === true)
                                 true
                             else
                                 false
                    source: "../../../artwork/tick.png"
                    scale: 1.5
                    smooth: true
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 12.5
                        verticalCenter: soundVisableRec.verticalCenter
                    }
                }MouseArea{
                    anchors.fill:soundIconButton
                    onClicked: if (indicatorSound.visible === true)
                                   indicatorSound.visible = false
                               else if (indicatorSound.visible === false)
                                   indicatorSound.visible = true
                }
            }
        }


        Rectangle{
            id:soundOsdRec
            width: mainBackground.width
            height: mainBackground.height / 8
            border.color: "#55FFFFFF"
            border.width: 1
            gradient: Gradient {
                GradientStop { position: 0; color: "#12000000"}
                GradientStop { position: 0.5; color: "#44808080"}
                GradientStop { position: 1; color: "#12000000"}

            }
            Text {
                font.pixelSize: 18
                color: "white"
                text: u2d.tr("Show Sound Notifactions:")
                anchors{
                    verticalCenter: soundOsdRec.verticalCenter
                    left: soundOsdRec.left
                    leftMargin: soundOsdRec.width / 20
                }
            }
            Image{
                id: soundOsdIconButtonRec
                source: "../../../artwork/tick_box.png"
                anchors{
                    right: parent.right
                    rightMargin: parent.width / 12.5
                    verticalCenter: soundOsdRec.verticalCenter
                }
                Image{
                    id:soundOsdIconButton
                    visible: if (indicatorSound.showNotifyOsdOnScroll === true)
                                 true
                             else
                                 false
                    source: "../../../artwork/tick.png"
                    scale: 1.5
                    smooth: true
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 12.5
                        verticalCenter: soundOsdRec.verticalCenter
                    }
                }MouseArea{
                    anchors.fill:soundOsdIconButton
                    onClicked: if (indicatorSound.showNotifyOsdOnScroll === true)
                                   indicatorSound.showNotifyOsdOnScroll = false
                               else if (indicatorSound.showNotifyOsdOnScroll === false)
                                   indicatorSound.showNotifyOsdOnScroll = true
                }
            }
        }
        Rectangle{
            id:soundMuteRec
            width: mainBackground.width
            height: mainBackground.height / 8
            border.color: "#55FFFFFF"
            border.width: 1
            gradient: Gradient {
                GradientStop { position: 0; color: "#12000000"}
                GradientStop { position: 0.5; color: "#44808080"}
                GradientStop { position: 1; color: "#12000000"}

            }
            Text {
                font.pixelSize: 18
                color: "white"
                text: u2d.tr("Global Mute:")
                anchors{
                    verticalCenter: soundMuteRec.verticalCenter
                    left: soundMuteRec.left
                    leftMargin: soundMuteRec.width / 20
                }
            }
            Image{
                id: soundMuteIconButtonRec
                source: "../../../artwork/tick_box.png"
                anchors{
                    right: parent.right
                    rightMargin: parent.width / 12.5
                    verticalCenter: soundMuteRec.verticalCenter
                }
                Image{
                    id:soundMuteIconButton
                    visible: if (indicatorSound.globalMute === true)
                                 true
                             else
                                 false
                    source: "../../../artwork/tick.png"
                    scale: 1.5
                    smooth: true
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 12.5
                        verticalCenter: soundMuteRec.verticalCenter
                    }
                }MouseArea{
                    anchors.fill:soundMuteIconButton
                    onClicked: if (indicatorSound.globalMute === true)
                                   indicatorSound.globalMute = false
                               else if (indicatorSound.globalMute === false)
                                   indicatorSound.globalMute = true
                }
            }
        }
    }


    //       Time Options
    Column{
        visible: false
        id:mainTimeColumn
        spacing: 5
        width: mainBackground.width
        height: parent.height - 60
        anchors{
            left: mainBackground.left
            top: mainBackground.top
            topMargin: mainBackground.height / 15

        }
        Rectangle{
            id:timeVisableRec
            width: mainBackground.width
            height: mainBackground.height / 10
            border.color: "#55FFFFFF"
            border.width: 1
            gradient: Gradient {
                GradientStop { position: 0; color: "#12000000"}
                GradientStop { position: 0.5; color: "#44808080"}
                GradientStop { position: 1; color: "#12000000"}

            }
            Text {
                font.pixelSize: 18
                color: "white"
                text: u2d.tr("Show Time:")
                anchors{
                    verticalCenter: timeVisableRec.verticalCenter
                    left: timeVisableRec.left
                    leftMargin: timeVisableRec.width / 20
                }
            }
            Image{
                id: timeVisableIconButtonRec
                source: "../../../artwork/tick_box.png"
                anchors{
                    right: parent.right
                    rightMargin: parent.width / 12.5
                    verticalCenter: timeVisableRec.verticalCenter
                }
                Image{
                    id:timeVisableIconButton
                    visible: if (indicatorTime.showClock === true)
                                 true
                             else
                                 false
                    source: "../../../artwork/tick.png"
                    scale: 1.5
                    smooth: true
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 12.5
                        verticalCenter: timeVisableRec.verticalCenter
                    }
                }MouseArea{
                    anchors.fill:timeVisableIconButton
                    onClicked: if (indicatorTime.showClock === true)
                                   indicatorTime.showClock = false
                               else if (indicatorTime.showClock === false)
                                   indicatorTime.showClock = true
                }
            }
        }

        Rectangle{
            id:timeShowDateRec
            width: mainBackground.width
            height: mainBackground.height / 10
            border.color: "#55FFFFFF"
            border.width: 1
            gradient: Gradient {
                GradientStop { position: 0; color: "#12000000"}
                GradientStop { position: 0.5; color: "#44808080"}
                GradientStop { position: 1; color: "#12000000"}

            }
            Text {
                font.pixelSize: 18
                color: "white"
                text: u2d.tr("Show Date:")
                anchors{
                    verticalCenter: timeShowDateRec.verticalCenter
                    left: timeShowDateRec.left
                    leftMargin: timeShowDateRec.width / 20
                }
            }
            Image{
                id: timeShowDateIconButtonRec
                source: "../../../artwork/tick_box.png"
                anchors{
                    right: parent.right
                    rightMargin: parent.width / 12.5
                    verticalCenter: timeShowDateRec.verticalCenter
                }
                Image{
                    id:timeShowDateIconButton
                    visible: if (indicatorTime.showDate === true)
                                 true
                             else
                                 false
                    source: "../../../artwork/tick.png"
                    scale: 1.5
                    smooth: true
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 12.5
                        verticalCenter: timeShowDateRec.verticalCenter
                    }
                }MouseArea{
                    anchors.fill:timeShowDateIconButton
                    onClicked: if (indicatorTime.showDate === true)
                                   indicatorTime.showDate = false
                               else if (indicatorTime.showDate === false)
                                   indicatorTime.showDate = true
                }
            }
        }

        Rectangle{
            id:timeShowDayRec
            width: mainBackground.width
            height: mainBackground.height / 10
            border.color: "#55FFFFFF"
            border.width: 1
            gradient: Gradient {
                GradientStop { position: 0; color: "#12000000"}
                GradientStop { position: 0.5; color: "#44808080"}
                GradientStop { position: 1; color: "#12000000"}

            }
            Text {
                font.pixelSize: 18
                color: "white"
                text: u2d.tr("Show Day:")
                anchors{
                    verticalCenter: timeShowDayRec.verticalCenter
                    left: timeShowDayRec.left
                    leftMargin: timeShowDayRec.width / 20
                }
            }
            Image{
                id: timeShowDayIconButtonRec
                source: "../../../artwork/tick_box.png"
                anchors{
                    right: parent.right
                    rightMargin: parent.width / 12.5
                    verticalCenter: timeShowDayRec.verticalCenter
                }
                Image{
                    id:timeShowDayIconButton
                    visible: if (indicatorTime.showDay === true)
                                 true
                             else
                                 false
                    source: "../../../artwork/tick.png"
                    scale: 1.5
                    smooth: true
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 12.5
                        verticalCenter: timeShowDayRec.verticalCenter
                    }
                }MouseArea{
                    anchors.fill:timeShowDayIconButton
                    onClicked: if (indicatorTime.showDay === true)
                                   indicatorTime.showDay = false
                               else if (indicatorTime.showDay === false)
                                   indicatorTime.showDay = true
                }
            }
        }

        Rectangle{
            id:timeShowEventsRec
            width: mainBackground.width
            height: mainBackground.height / 10
            border.color: "#55FFFFFF"
            border.width: 1
            gradient: Gradient {
                GradientStop { position: 0; color: "#12000000"}
                GradientStop { position: 0.5; color: "#44808080"}
                GradientStop { position: 1; color: "#12000000"}

            }
            Text {
                font.pixelSize: 18
                color: "white"
                text: u2d.tr("Show Events:")
                anchors{
                    verticalCenter: timeShowEventsRec.verticalCenter
                    left: timeShowEventsRec.left
                    leftMargin: timeShowEventsRec.width / 20
                }
            }
            Image{
                id: timeShowEventsIconButtonRec
                source: "../../../artwork/tick_box.png"
                anchors{
                    right: parent.right
                    rightMargin: parent.width / 12.5
                    verticalCenter: timeShowEventsRec.verticalCenter
                }
                Image{
                    id:timeShowEventsIconButton
                    visible: if (indicatorTime.showEvents === true)
                                 true
                             else
                                 false
                    source: "../../../artwork/tick.png"
                    scale: 1.5
                    smooth: true
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 12.5
                        verticalCenter: timeShowEventsRec.verticalCenter
                    }
                }MouseArea{
                    anchors.fill:timeShowEventsIconButton
                    onClicked: if (indicatorTime.showEvents === true)
                                   indicatorTime.showEvents = false
                               else if (indicatorTime.showEvents === false)
                                   indicatorTime.showEvents = true
                }
            }
        }

        Rectangle{
            id:timeShowLocationsRec
            width: mainBackground.width
            height: mainBackground.height / 10
            border.color: "#55FFFFFF"
            border.width: 1
            gradient: Gradient {
                GradientStop { position: 0; color: "#12000000"}
                GradientStop { position: 0.5; color: "#44808080"}
                GradientStop { position: 1; color: "#12000000"}

            }
            Text {
                font.pixelSize: 18
                color: "white"
                text: u2d.tr("Show Locations:")
                anchors{
                    verticalCenter: timeShowLocationsRec.verticalCenter
                    left: timeShowLocationsRec.left
                    leftMargin: timeShowLocationsRec.width / 20
                }
            }
            Image{
                id: timeShowLocationsIconButtonRec
                source: "../../../artwork/tick_box.png"
                anchors{
                    right: parent.right
                    rightMargin: parent.width / 12.5
                    verticalCenter: timeShowLocationsRec.verticalCenter
                }
                Image{
                    id:timeShowLocationsIconButton
                    visible: if (indicatorTime.showLocations === true)
                                 true
                             else
                                 false
                    source: "../../../artwork/tick.png"
                    scale: 1.5
                    smooth: true
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 12.5
                        verticalCenter: timeShowLocationsRec.verticalCenter
                    }
                }MouseArea{
                    anchors.fill:timeShowLocationsIconButton
                    onClicked: if (indicatorTime.showLocations === true)
                                   indicatorTime.showLocations = false
                               else if (indicatorTime.showLocations === false)
                                   indicatorTime.showLocations = true
                }
            }
        }

        Rectangle{
            id:timeShowSecondsRec
            width: mainBackground.width
            height: mainBackground.height / 10
            border.color: "#55FFFFFF"
            border.width: 1
            gradient: Gradient {
                GradientStop { position: 0; color: "#12000000"}
                GradientStop { position: 0.5; color: "#44808080"}
                GradientStop { position: 1; color: "#12000000"}

            }
            Text {
                font.pixelSize: 18
                color: "white"
                text: u2d.tr("Show Seconds:")
                anchors{
                    verticalCenter: timeShowSecondsRec.verticalCenter
                    left: timeShowSecondsRec.left
                    leftMargin: timeShowSecondsRec.width / 20
                }
            }
            Image{
                id: timeShowSecondsIconButtonRec
                source: "../../../artwork/tick_box.png"
                anchors{
                    right: parent.right
                    rightMargin: parent.width / 12.5
                    verticalCenter: timeShowSecondsRec.verticalCenter
                }
                Image{
                    id:timeShowSecondsIconButton
                    visible: if (indicatorTime.showSeconds === true)
                                 true
                             else
                                 false
                    source: "../../../artwork/tick.png"
                    scale: 1.5
                    smooth: true
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 12.5
                        verticalCenter: timeShowSecondsRec.verticalCenter
                    }
                }MouseArea{
                    anchors.fill:timeShowSecondsIconButton
                    onClicked: if (indicatorTime.showSeconds === true)
                                   indicatorTime.showSeconds = false
                               else if (indicatorTime.showSeconds === false)
                                   indicatorTime.showSeconds = true
                }
            }
        }


        Rectangle{
            id:timeShowWeekNumbersRec
            width: mainBackground.width
            height: mainBackground.height / 10
            border.color: "#55FFFFFF"
            border.width: 1
            gradient: Gradient {
                GradientStop { position: 0; color: "#12000000"}
                GradientStop { position: 0.5; color: "#44808080"}
                GradientStop { position: 1; color: "#12000000"}

            }
            Text {
                font.pixelSize: 18
                color: "white"
                text: u2d.tr("Show Week Numbers in Calender:")
                anchors{
                    verticalCenter: timeShowWeekNumbersRec.verticalCenter
                    left: timeShowWeekNumbersRec.left
                    leftMargin: timeShowWeekNumbersRec.width / 20
                }
            }
            Image{
                id: timeShowWeekNumbersIconButtonRec
                source: "../../../artwork/tick_box.png"
                anchors{
                    right: parent.right
                    rightMargin: parent.width / 12.5
                    verticalCenter: timeShowWeekNumbersRec.verticalCenter
                }
                Image{
                    id:timeShowWeekNumbersIconButton
                    visible: if (indicatorTime.showWeekNumbers === true)
                                 true
                             else
                                 false
                    source: "../../../artwork/tick.png"
                    scale: 1.5
                    smooth: true
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 12.5
                        verticalCenter: timeShowWeekNumbersRec.verticalCenter
                    }
                }MouseArea{
                    anchors.fill:timeShowWeekNumbersIconButton
                    onClicked: if (indicatorTime.showWeekNumbers === true)
                                   indicatorTime.showWeekNumbers = false
                               else if (indicatorTime.showWeekNumbers === false)
                                   indicatorTime.showWeekNumbers = true
                }
            }
        }






//        Rectangle{
//            id : mainDropDown
//            width: 470
//            height: 700
//            radius: 25
//            color: "transparent"
//            anchors{
//                top:parent.top
//                verticalCenter: parent.verticalCenter
//            }
//            Column{
//                width: 470
//                height: 700
//                id:colInside
//                anchors.fill: mainDropDown
//                spacing: 10
//                Rectangle{
//                    id: mainrec
//                    width:  colInside.width
//                    height: colInside.height / 4
//                    color:"black"
//                    radius: 25

//                    MouseArea{
//                    id:showMeNow
//                    anchors.fill: mainrec
//                    width: mainrec.width
//                    height: mainrec.height
//                    onClicked:{
//                        if (mainRec1.opacity === 1 && mainRec2.opacity === 1 && mainRec3.opacity === 1 && mainDropDown.color === "green" ){
//                            mainRec1.height = 0
//                            mainRec2.height = 0
//                            mainRec3.height = 0
//                            mainDropDown.color = "transparent"
//                        }
//                        else //if (mainRec1.visible === false && mainRec2.visible === false && mainRec3.visible === false && mainDropDown.color === "transparent" ){
//                        {
//                            mainRec1.height = colInside.height / 4
//                            mainRec2.height = colInside.height / 4
//                            mainRec3.height = colInside.height / 4
//                            mainDropDown.color = "green"
//                                }
//                               }
//                    }
//                    Text{
//                        text: (indicatorTime.timeFormat);
//                        color: "white"
//                        anchors{
//                            horizontalCenter: mainrec.horizontalCenter;
//                            verticalCenter: mainrec.verticalCenter
//                        }
//                    }
//                }
//                Rectangle{
//                    id: mainRec1
////                    visible: false
//                    width:  colInside.width
//                    height: colInside.height / 4
//                    color:"black"
//                    radius: 25
//                    Text{
//                        text: if (indicatorTime.timeFormat === "24-hour")
//                                  u2d.tr("Local (Default)")
//                        else
//                                  u2d.tr("24 Hour")
//                        color: "white"
//                        anchors{
//                            horizontalCenter: mainRec1.horizontalCenter;
//                            verticalCenter: mainRec1.verticalCenter
//                        }
//                    }
//                }Rectangle{
//                    id: mainRec2
////                    visible: false
//                    width:  colInside.width
//                    height: colInside.height / 4
//                    color:"black"
//                    radius: 25
//                    Text{
//                        text: if (indicatorTime.timeFormat === "custom")
//                                  u2d.tr("Local (Default)")
//                        else
//                                  u2d.tr("Custom")
//                        color: "white"
//                        anchors{
//                            horizontalCenter: mainRec2.horizontalCenter;
//                            verticalCenter: mainRec2.verticalCenter
//                        }
//                    }
//                }Rectangle{
//                    id: mainRec3
////                    visible: false
//                    width:  colInside.width
//                    height: colInside.height / 4
//                    color:"black"
//                    radius: 25
//                    Text{
//                        text: if (indicatorTime.timeFormat === "12-hour")
//                        u2d.tr("Local (Default)")
//                        else
//                        u2d.tr("12-Hour")
//                        color: "white"
//                        anchors{
//                            horizontalCenter: mainRec3.horizontalCenter;
//                            verticalCenter: mainRec3.verticalCenter
//                        }
//                    }
//                }

//        ExpandingDropDown {
//            id: languages
//            width: Units.tvPx(470)
//            anchors.horizontalCenter: parent.horizontalCenter
//            spacing: parent.spacing
//            first: true
//            focus: true
//            label: "Languages"
//            model: ListModel {
//                id:hourModel
//                ListElement { label: "12-Hour" }
//                ListElement { label: "24-hour" }
//                ListElement { label: "Local" }
//            }MouseArea{
//            anchors.fill: hourModel
//            onAcceptedButtonsChanged: indicatorTime.timeFormat = hourModel.lablel
//            }
//        }
            }//col
    Image {
        visible: false
        id: backtomain
        source: "../../../artwork/cross.png"
        anchors{
            top:parent.top
            left:  parent.left
            leftMargin: parent.width / 4
        }

        MouseArea{
            anchors.fill: backtomain
            onClicked: {
            backtomain.visible = false
            mainTimeColumn.visible = false
                mainSoundColumn.visible = false
                mainPowerColumn.visible =  false
                mainBluetoothColumn.visible = false
            mainGridpage.visible = true

            }

//            TextInput{
//                id: mythIpBackendButton

//                height: mythIpBackendButtonRec.height / 1.4
//                color:"white"
//                text: (dash2dConfiguration.mythipBackend)
//                onAccepted:{
//                    dash2dConfiguration.mythipBackend = mythIpBackendButton.text
//                    mythIpBackendButton.focus = false

//                }
//                    anchors{
//                    bottom: mythIpBackendButtonRec.bottom
//                    horizontalCenter: mythIpBackendButtonRec.horizontalCenter

//                }
//            }

        }
    }
}//main
}
