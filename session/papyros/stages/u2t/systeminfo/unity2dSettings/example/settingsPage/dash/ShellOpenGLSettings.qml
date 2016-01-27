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
            id: openGLName
            height: 28
            color: "white"
            font.pixelSize: openGL.height / 12
            text: "Use Open GL"
            anchors{
                horizontalCenter: openGL.horizontalCenter
                top:openGL.top
            }
        }
        Rectangle {
            id: openGL
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

            smooth: true
            border.color: "#34FFFFFF"
            border.width: 1
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#10FFFFFF"; }
                GradientStop { position: 1.0; color: "#20dd4814"; }
                GradientStop { position: 1.0; color: "#25000000"; }

            }
            Text{
                id:openGLDescription
                text: u2d.tr("Use OpenGL viewport. Chooose whether or not to render the graphics into an OpenGL viewport. When set to false, the raster engine is used.")
                font.pixelSize: parent.height / 19
                color: "white"
                width: openGL.width - 12
                height: openGL.height
                wrapMode: Text.WordWrap
                anchors{
                    top:openGL.top
                    topMargin: openGL.height / 10
                    left:openGL.left
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
                bottomMargin: openGLDescription.height / 1.11
                left:parent.left
                leftMargin: openGLDescription.width / 8.33 //13.33
            }
            Rectangle {
                id: openGLYESRec
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
                    id:openGLYESMouse
                    anchors.fill: openGLYESRec
                    onClicked: unity2dConfiguration.useOpengl = "true"
                }Text{
                    text: u2d.tr("Yes")
                    color:"white"
                    opacity: if ((unity2dConfiguration.useOpengl) === true)
                                 1
                             else
                                 .28
                    anchors{
                        verticalCenter: openGLYESMouse.verticalCenter
                        horizontalCenter: openGLYESMouse.horizontalCenter
                    }
                }


            } //Rectangle

            Rectangle {
                id: openGLNORec
                width: parent.width / 2.99
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
                    id:openGLNOMouse
                    anchors.fill: openGLNORec
                    onClicked: unity2dConfiguration.useOpengl = "false"
                }Text{
                    text: u2d.tr("No")
                    color:"white"
                    opacity: if ((unity2dConfiguration.useOpengl) === false)
                                 1
                             else
                                 .28
                    anchors{
                        verticalCenter: openGLNOMouse.verticalCenter
                        horizontalCenter: openGLNOMouse.horizontalCenter
                    }
                }
            } //Rectangle
        }//Row
    }//rootangle
}//scope

