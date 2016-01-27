// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import Unity2d 1.0
import "../../../../../dash"
import "../../../../../common"

FocusScope{

    Rectangle {
        width: parent.width
        height: parent.height
        color: "transparent"

        Text{
            id: avgBgColorsName
            height: 28
            color: "white"
            font.pixelSize: avgBgColor.height / 12
            text: "Average background color"
            anchors{
                horizontalCenter: avgBgColor.horizontalCenter
                top:avgBgColor.top
            }
        }
        Rectangle {
            id: avgBgColor
            width: parent.width / 2.33
            height: parent.height / 1.51
            radius: 0
            opacity: status === Rectangle.Ready ? .88 : 0.0
            Behavior on opacity {NumberAnimation {property: "opacity";from: 0.0;to: 1 ;duration: 1100;easing.type: Easing.InOutQuad}}
            border.color: "#34FFFFFF"
            border.width: 1
            smooth: true
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#10FFFFFF"; }
                GradientStop { position: 1.0; color: "#20dd4814"; }
                GradientStop { position: 1.0; color: "#25000000"; }

            }

            Text{
                id:avgBgColorDescription
                text: u2d.tr("Change the average color derived from the currently set desktop-wallpaper.")
                font.pixelSize: parent.height / 19
                color: "white"
                width: avgBgColor.width - 12
                height: avgBgColor.height
                wrapMode: Text.WordWrap
                anchors{
                    top:avgBgColor.top
                    topMargin: avgBgColor.height / 10
                    left:avgBgColor.left
                    leftMargin: 8
                }
            }
        }

        Grid{
            id: colorBackgroundLayers
            columns: 5
            rows: 3
            spacing: avgBgColorDescription.width / 38
            width: parent.width / 1.93
            height: parent.width / 1.93
            anchors{
                top: parent.top
                topMargin: avgBgColorDescription.width / 4.98
                left:parent.left
                leftMargin: avgBgColorDescription.width / 33.33
            }
            Repeater {
                model:15;
                Rectangle {
                    id: avgBgColorRec
                    width: parent.width / 7.11
                    height: parent.width / 7.11
                    radius: 0
                    border.color: "#35FFFFFF"
                    border.width: 5
                    gradient: Gradient {
                        GradientStop { position: 0; color: "#29FFFFFF"}
                        GradientStop { position: 0.5; color: "#10000000"}
                        GradientStop{position: 1; color: "#22FFFFFF"}
                    }
                }
            }//Repeater
        }//Grid
        Grid {
            columns: 5
            rows: 3
            width: parent.width / 1.93
            height: parent.width / 1.93
            anchors{
            fill: colorBackgroundLayers
            }
            spacing: colorBackgroundLayers.spacing
            Rectangle { color:unity2dConfiguration.averageBgColor; width: parent.width / 7.11; height: parent.width / 7.11 }

            Rectangle { id: green; color: "#00FF00"; width: parent.width / 7.11; height: parent.width / 7.11
            MouseArea{anchors.fill: green; onClicked: unity2dConfiguration.averageBgColor = green.color }}

            Rectangle { id: blue; color:"#0000FF"; width: parent.width / 7.11; height: parent.width / 7.11
            MouseArea{anchors.fill: blue; onClicked: unity2dConfiguration.averageBgColor = blue.color }}

            Rectangle { id: red; color:"#FF0000"; width: parent.width / 7.11; height:parent.width / 7.11
            MouseArea{anchors.fill: red; onClicked: unity2dConfiguration.averageBgColor = red.color }}

            Rectangle { id: orange; color: "#FF7F00"; width: parent.width / 7.11; height: parent.width / 7.11
            MouseArea{anchors.fill: orange; onClicked: unity2dConfiguration.averageBgColor = orange.color }}

            Rectangle { id: yellow; color: "#FFFF00"; width: parent.width / 7.11; height: parent.width / 7.11
            MouseArea{anchors.fill: yellow; onClicked: unity2dConfiguration.averageBgColor = yellow.color }}

            Rectangle { id: teal; color: "#008080"; width: parent.width / 7.11; height: parent.width / 7.11
            MouseArea{anchors.fill: teal; onClicked: unity2dConfiguration.averageBgColor =  teal.color }}

            Rectangle { id: black; color: "#000000"; width: parent.width / 7.11; height: parent.width / 7.11
            MouseArea{anchors.fill: black; onClicked: unity2dConfiguration.averageBgColor = black.color }}

            Rectangle { id: bone; color: "#E3DAC9"; width: parent.width / 7.11; height:parent.width / 7.11
            MouseArea{anchors.fill: bone; onClicked: unity2dConfiguration.averageBgColor = bone.color }}

            Rectangle { id: white; color: "#FFFFFF"; width: parent.width / 7.11; height: parent.width / 7.11
            MouseArea{anchors.fill: white; onClicked: unity2dConfiguration.averageBgColor = white.color }}

            Rectangle { id: brown; color: "#964B00"; width: parent.width / 7.11; height: parent.width / 7.11
            MouseArea{anchors.fill: brown; onClicked: unity2dConfiguration.averageBgColor = brown.color }}

            Rectangle { id: purple; color: "#A020F0"; width: parent.width / 7.11; height: parent.width / 7.11
            MouseArea{anchors.fill: purple; onClicked: unity2dConfiguration.averageBgColor = purple.color }}

            Rectangle { id: grey; color: "#BEBEBE"; width: parent.width / 7.11; height: parent.width / 7.11
            MouseArea{anchors.fill: grey; onClicked: unity2dConfiguration.averageBgColor = grey.color }}

            Rectangle { id: magenta; color: "#CC00CC"; width: parent.width / 7.11; height: parent.width / 7.11
            MouseArea{anchors.fill: magenta; onClicked: unity2dConfiguration.averageBgColor = magenta.color }}

            Rectangle { id: turquoise; color: "#00CED1"; width: parent.width / 7.11; height:parent.width / 7.11
            MouseArea{anchors.fill: turquoise; onClicked: unity2dConfiguration.averageBgColor = turquoise.color }}

            Rectangle { id: indigo; color: "#6F00FF"; width: parent.width / 7.11; height: parent.width / 7.11
            MouseArea{anchors.fill: indigo; onClicked: unity2dConfiguration.averageBgColor = indigo.color }}
        }
    }//rootangle
}//scope

