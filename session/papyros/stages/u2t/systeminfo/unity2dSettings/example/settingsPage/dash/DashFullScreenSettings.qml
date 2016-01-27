import QtQuick 1.1
import Unity2d 1.0
import "../../../../../dash"
import "../../../../../common"
import "../../../../../systeminfo"

FocusScope{

    Rectangle {
        width: parent.width
        height: parent.height
        color: "transparent"

        Text{
            id: fullScreenName
            height: 28
            color: "white"
            font.pixelSize: fullScreen.height / 12
            text: u2d.tr("Full Screen Dash")
            anchors{
                horizontalCenter: fullScreen.horizontalCenter
                top:fullScreen.top
            }
        }
        Rectangle {
            id: fullScreen
            width: parent.width / 2.33
            height: parent.height / 2.22
            radius: 0
            opacity: status === Rectangle.Ready ? .88 : 0.0
            Behavior on opacity {
                NumberAnimation {
                    property: "opacity";
                    from: 0.0
                    to: .88
                    duration: 1100;
                    easing.type: Easing.InOutQuad
                }
            }
            border.color: "#34FFFFFF"
            border.width: 1
            smooth: true
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#10FFFFFF"; }
                GradientStop { position: 1.0; color: "#20dd4814"; }
                GradientStop { position: 1.0; color: "#25000000"; }

            }
            Text{
                id:fullScreenDescription
                text: u2d.tr("Describe if the dash should be fullscreen or not. If the dash is already running this setting is applied immediately, otherwise it is applied as soon as the dash is activated again.")
                font.pixelSize: parent.height / 19
                color: "white"
                width: fullScreen.width - 12
                height: fullScreen.height
                wrapMode: Text.WordWrap
                anchors{
                    top:fullScreen.top
                    topMargin: fullScreen.height / 10
                    left:fullScreen.left
                    leftMargin: 8
                }
            }
        }
        Row{
            height: parent.height / 2.33
            width: parent.width / 2.66
            spacing: parent.width / 12.66
            anchors{
                bottom: parent.bottom
                bottomMargin: fullScreenDescription.height / 1.11
                left:parent.left
                leftMargin: fullScreenDescription.width / 8.33 //13.33
            }
            Rectangle {
                id: fullScreenYESRec

                width: parent.width / 2.99 //.33
                height: parent.height / 2.33
                radius: 0
                border.color: "#55FFFFFF"
                border.width: 1
                gradient: Gradient {
                    GradientStop { position: 0; color: "#29FFFFFF"}
                    GradientStop { position: 0.5; color: "#10000000"}
                    GradientStop{position: 1; color: "#22FFFFFF"}
                }
                MouseArea{
                    id:fullScreenYesMouse
                anchors.fill: fullScreenYESRec
                onClicked: dash2dConfiguration.fullScreen = "true"

                }Text {
                    color: "white"
                    opacity: if ((dash2dConfiguration.fullScreen) === true)
                                 1
                             else
                                 .28
                    text: u2d.tr("Yes")
                    anchors{
                    verticalCenter: fullScreenYesMouse.verticalCenter
                    horizontalCenter: fullScreenYesMouse.horizontalCenter
                    }
                }


            } //Rectangle

            Rectangle {
                id: fullScreenNORec
                width: parent.width / 2.99
                height: parent.height / 2.33
                border.color: "#34FFFFFF"
                border.width: 1
                smooth: true
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#10FFFFFF"; }
                    GradientStop { position: 1.0; color: "#20dd4814"; }
                    GradientStop { position: 1.0; color: "#25000000"; }

                }
                MouseArea{
                    id:fullScreenNoMouse
                anchors.fill: fullScreenNORec
                onClicked: dash2dConfiguration.fullScreen = "false"
                }Text{
                    text: u2d.tr("No")
                    color:"white"
                    opacity: if ((dash2dConfiguration.fullScreen) === false)
                                 1
                             else
                                 .28
                    anchors{
                    verticalCenter: fullScreenNoMouse.verticalCenter
                    horizontalCenter: fullScreenNoMouse.horizontalCenter
                }
                }
            } //Rectangle
        }//Row
    }//rootangle
}//scope


