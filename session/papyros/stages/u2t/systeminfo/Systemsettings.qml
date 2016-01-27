import QtQuick 1.0
import "../dash"
import "../common"
import "../common/units.js" as Units
import "../common/utils.js" as Utils
FocusScope{    
    Rectangle {
        color: "transparent"
        width: parent.width
        height: parent.height
//        BorderImage {
//            id: name
//            source: "../dash/artwork/search_background.png"
//            width: parent.width - 25
//            height: parent.height
//            border.left: 25; border.top: 25
//            border.right: 25; border.bottom: 25
//        }

        Grid   {
            id:picturegrid
            anchors{
                top: parent.top
                topMargin: parent.height / 7
                left:parent.left
                leftMargin: parent.width / 7
            }
            spacing: parent.width / 15
            rows: 3
            columns: 5
            width: parent.height

            SettingsMangerParser {
                id:app
                icon: "Systemsetting_images/appernices-actve.png"
                desktopFile: "gnome-background-panel.desktop"
                KeyNavigation.right: remoter
                KeyNavigation.left: screensettings
                KeyNavigation.down: ubone
                KeyNavigation.up: printinger
                focus: true
                Text{
                    text:"Apperanence"
                    color: "white"
                    font.pixelSize: 24
                    anchors{
                        horizontalCenter:  app.horizontalCenter
                        baseline: app.bottom
                    }
                }
            }

            SettingsMangerParser {
                icon: "Systemsetting_images/keyboard-active.png"
                id:remoter
                desktopFile: "gnome-keyboard-panel.desktop"
                KeyNavigation.left: app
                KeyNavigation.right:lang
                KeyNavigation.down:adddrive
                KeyNavigation.up: usb
                Text {
                    text:"Keyboard"
                    font.pixelSize:28
                    color:"white"
                    anchors{
                        horizontalCenter: remoter.horizontalCenter
                        baseline: remoter.bottom
                    }
                }
            }

            SettingsMangerParser {
                icon: "Systemsetting_images/wrench-active.png"
                id:lang
                desktopFile:"language-selector.desktop"
                KeyNavigation.left: remoter
                KeyNavigation.right: online
                KeyNavigation.down:bluetooth
                KeyNavigation.up: sound
                Text {
                    text:"Language"
                    font.pixelSize:28
                    color:"white"
                    anchors{
                        horizontalCenter: lang.horizontalCenter
                        baseline: lang.bottom
                    }
                }

            }

            SettingsMangerParser {
                icon: "Systemsetting_images/configs-active.png"
                id:online
                desktopFile:"gnome-online-accounts-panel.desktop"
                KeyNavigation.left: lang
                KeyNavigation.right: screensettings
                KeyNavigation.down:network
                KeyNavigation.up: details
                Text {
                    text:"Online\n Accounts"
                    font.pixelSize:28
                    color:"white"
                    anchors{
                        horizontalCenter: oneline.horizontalCenter
                        baseline: online.bottom
                    }
                }
            }

            SettingsMangerParser {
                icon: "../launcher/artwork/icons/tvpicker-active.png"
                id:screensettings
                desktopFile: "gnome-screen-panel.desktop" //"ubuntu-tv-testcard.desktop"
                KeyNavigation.left: online
                KeyNavigation.right: app
                KeyNavigation.down:power
                KeyNavigation.up: user
                Text {
                    text:"Screen"
                    font.pixelSize:28
                    color:"white"
                    anchors{
                        horizontalCenter: screensettings.horizontalCenter
                        baseline: screensettings.bottom
                    }
                }
            }

            SettingsMangerParser {
                icon:"Systemsetting_images/ubuntuone-active.png"
                id:ubone
                desktopFile: "ubuntuone-installer.desktop"
                KeyNavigation.left: power
                KeyNavigation.right: adddrive
                KeyNavigation.down:printinger
                KeyNavigation.up: app
                Text {
                    text:"Ubuntu\n One"
                    font.pixelSize:28
                    color:"white"
                    anchors{
                        horizontalCenter: ubone.horizontalCenter
                        baseline: ubone.bottom
                    }
                }
            }

            SettingsMangerParser {
                icon:"Systemsetting_images/additinaldriver-active.png"
                id:adddrive
                desktopFile: "jockey-gtk.desktop"
                KeyNavigation.left: ubone
                KeyNavigation.right: bluetooth
                KeyNavigation.down:usb
                KeyNavigation.up: remoter
                Text {
                    text:"Additnal\n Drivers"
                    font.pixelSize:28
                    color:"white"
                    anchors{
                        horizontalCenter: adddrive.horizontalCenter
                        baseline: adddrive.bottom
                    }
                }
            }

            SettingsMangerParser {
                icon:"Systemsetting_images/bluetooth-active.png"
                id:bluetooth
                desktopFile: "bluetooth-wizard.desktop"
                KeyNavigation.left: adddrive
                KeyNavigation.right: network
                KeyNavigation.down:sound
                KeyNavigation.up: lang
                Text {
                    text:"Bluetooth"
                    font.pixelSize:28
                    color:"white"
                    anchors{
                        horizontalCenter: bluetooth.horizontalCenter
                        baseline: bluetooth.bottom
                    }
                }
            }

            SettingsMangerParser {
                icon:"Systemsetting_images/remote_layout-active.png"
                id:network
                desktopFile: "gnome-network-panel.desktop"
                KeyNavigation.left: bluetooth
                KeyNavigation.right: power
                KeyNavigation.down:details
                KeyNavigation.up: online
                Text {
                    text:"Network"
                    font.pixelSize:28
                    color:"white"
                    anchors{
                        horizontalCenter: network.horizontalCenter
                        baseline: network.bottom
                    }
                }
            }

            SettingsMangerParser {
                icon:"Systemsetting_images/batt-active.png"
                id:power
                desktopFile: "gnome-power-panel.desktop"
                KeyNavigation.left: network
                KeyNavigation.right: ubone
                KeyNavigation.down:user
                KeyNavigation.up: screensettings
                Text {
                    text:"Power"
                    font.pixelSize:28
                    color:"white"
                    anchors{
                        horizontalCenter: power.horizontalCenter
                        baseline: power.bottom
                    }
                }
            }

            SettingsMangerParser {
                icon:"Systemsetting_images/printer-active.png"
                id: printinger
                desktopFile: "gnome-printers-panel.desktop"
                KeyNavigation.left: user
                KeyNavigation.right: usb
                KeyNavigation.down:app
                KeyNavigation.up:  ubone
                Text {
                    text:"Printing"
                    font.pixelSize:28
                    color:"white"
                    anchors{
                        horizontalCenter: printinger.horizontalCenter
                        baseline: printinger.bottom
                    }
                }
            }

            SettingsMangerParser {
                icon: "Systemsetting_images/removable--media.png"
                id:usb
                desktopFile: "gnome-info-panel.desktop"
                KeyNavigation.left: printinger
                KeyNavigation.right: sound
                KeyNavigation.down:  remoter
                KeyNavigation.up: adddrive
                Text {
                    text:"Usb"
                    font.pixelSize:28
                    color:"white"
                    anchors{
                        horizontalCenter: usb.horizontalCenter
                        baseline: usb.bottom
                    }
                }
            }

            SettingsMangerParser {
                icon:"Systemsetting_images/sound-active.png"
                id:sound
                desktopFile: "gnome-sound-panel.desktop"
                KeyNavigation.left: usb
                KeyNavigation.right: details
                KeyNavigation.down:lang
                KeyNavigation.up: bluetooth
                Text {
                    text:"Sound"
                    font.pixelSize:28
                    color:"white"
                    anchors{
                        horizontalCenter: sound.horizontalCenter
                        baseline:  sound.bottom
                    }
                }
            }

            SettingsMangerParser {
                icon:"Systemsetting_images/Detials-active.png"
                id:details
                desktopFile: "gnome-info-panel.desktop"
                KeyNavigation.left: sound
                KeyNavigation.right: user
                KeyNavigation.down:online
                KeyNavigation.up: network
                Text {
                    text:"Details"
                    font.pixelSize:28
                    color:"white"
                    anchors{
                        horizontalCenter: details.horizontalCenter
                        baseline: details.bottom
                    }
                }
            }

            SettingsMangerParser {
                icon:"Systemsetting_images/user-active.png"
                id:user
                desktopFile: "gnome-user-accounts-panel.desktop"
                KeyNavigation.left: details
                KeyNavigation.right: printinger
                KeyNavigation.down:screensettings
                KeyNavigation.up: power
                Text {
                    text:"Users"
                    font.pixelSize:28
                    color:"white"
                    anchors{
                        horizontalCenter: user.horizontalCenter
                        baseline: parent.bottom
                    }
                }
            }
        }
    }
    Text {
        anchors{
            top: parent.top
            topMargin: parent.height / 62
            left: parent.left
            leftMargin: parent.width / 3.33
        }
        font.pixelSize: 64
        color: "white" //Utils.warmGrey
        text: u2d.tr("TV Settings")
    }
}
