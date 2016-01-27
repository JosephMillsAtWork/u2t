// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import Unity2d 1.0
import "../systeminfo/"
import  "utils.js" as Utils

FocusScope{
Rectangle {
    id: background
    width: parent.width / 1.23
    height: parent.height / 3
    radius: 45
    border.color: "#59000000"
    border.width: 3
    smooth: true
    gradient: Gradient {
        GradientStop { position: 0.0; color: "#79000000"; }
             GradientStop { position: 1.0; color: "#29000000"; }
         }
    anchors{
    verticalCenter: parent.verticalCenter
    horizontalCenter: parent.horizontalCenter
    }
}
Row{
anchors.verticalCenter:  background.verticalCenter
anchors.horizontalCenter: background.horizontalCenter
    SettingsMangerParser {
        icon: "../systeminfo/Systemsetting_images/configs-active.png"
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
        icon: "../systeminfo/Systemsetting_images/configs-active.png"
        id:online1
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
                baseline: online1.bottom
            }
        }
    }
    SettingsMangerParser {
        icon: "../systeminfo/Systemsetting_images/configs-active.png"
        id:online2
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
                horizontalCenter: oneline2.horizontalCenter
                baseline: online2.bottom
            }
        }
    }
}
}

