// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
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
            id: formFactorsName
            height: 28
            color: "white"
            font.pixelSize: formFactor.height / 12
            text: "Form Factor"
            anchors{
                horizontalCenter: formFactor.horizontalCenter
                top:formFactor.top
            }
        }
        Rectangle {
            id: formFactor
            width: parent.width / 2.33
            height: parent.height / 2.22
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
                id:formFactorDescription
                text: u2d.tr("Customize the current apperarance of the Unity 2d dash layout. In the Future Unity 2d will adapt its shape and form to the device it is running on.")
                font.pixelSize: parent.height / 19
                color: "white"
                width: formFactor.width - 12
                height: formFactor.height
                wrapMode: Text.WordWrap
                anchors{
                    top:formFactor.top
                    topMargin: formFactor.height / 10
                    left:formFactor.left
                    leftMargin: 8
                }
            }
        }
        Row{
            height: parent.height / 2.33
            width: parent.width / 2.66
            spacing: formFactorDesktopRec.width / 5
            anchors{
                bottom: parent.bottom
                bottomMargin: formFactorDescription.height / 1.11
                left:parent.left
                leftMargin: formFactorDescription.width / 33.33
            }
            Rectangle {
                id: formFactorDesktopRec
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


                    Image {
                        id:formFactorDesktopImg
                        source: "../../../component/gfx/formFactorDesktop.png"
                        width: formFactorDesktopRec.width - 10
                        height: formFactorDesktopRec.height - 10
                        smooth: true
                        opacity: if ((unity2dConfiguration.formFactor) === "desktop")
                                     1
                        else
                                     .55
                        anchors{
                            verticalCenter: formFactorDesktopRec.verticalCenter
                            horizontalCenter: formFactorDesktopRec.horizontalCenter
                        }MouseArea{
                        anchors.fill: formFactorDesktopImg
                        onClicked: unity2dConfiguration.formFactor = "desktop"
                        }
                        Text{
                            color: "white"
                            text: u2d.tr("Desktop Mode")
                            anchors{
                                left:formFactorDesktopImg.left
                                leftMargin: formFactorDesktopImg.width / 8
                                top:formFactorDesktopImg.bottom
                            }
                        } //Text
                    } //Image
            } //Rectangle

            Rectangle {
                id: dashVertRec
                width: parent.width / 3.33
                height: parent.height / 2.33
                radius: 0
                border.color: "#55FFFFFF"
                border.width: 1
                gradient: Gradient {
                    GradientStop { position: 0; color: "#29FFFFFF"}
                    GradientStop { position: 0.5; color: "#10000000"}
                    GradientStop{position: 1; color: "#22FFFFFF"}
                }
                    Image {
                        id:dashVertImg
                        source: "../../../component/gfx/formFactorTV.png"
                        width: dashVertRec.width - 10
                        height: dashVertRec.height - 10
                        opacity: if ((unity2dConfiguration.formFactor) === "tv")
                                     1
                        else
                                     .26
                        anchors{
                            verticalCenter: dashVertRec.verticalCenter
                            horizontalCenter: dashVertRec.horizontalCenter
                        }MouseArea{
                        anchors.fill: dashVertImg
                        onClicked: unity2dConfiguration.formFactor = "tv"
                        }
                        Text{
                            color: "white"
                            text: u2d.tr("TV Mode")
                            anchors{
                                left:dashVertImg.left
                                leftMargin: dashVertImg.width / 8
                                top:dashVertImg.bottom

                            }
                        } //Text
                    } //Image
            } //Rectangle

            Rectangle {
                id: dashCoverRec
                width: parent.width / 3.33
                height: parent.height / 2.33
                radius: 0
                border.color: "#55FFFFFF"
                border.width: 1
                gradient: Gradient {
                    GradientStop { position: 0; color: "#29FFFFFF"}
                    GradientStop { position: 0.5; color: "#10000000"}
                    GradientStop{position: 1; color: "#22FFFFFF"}
                }
                    Image {

                        id:dashCoverImg
                        source: "../../../component/gfx/formFactorTablet.png"
                        width: dashCoverRec.width - 10
                        height: dashCoverRec.height - 10
                        opacity: if ((unity2dConfiguration.formFactor) === "tablet")
                                     1
                        else
                                     .26
                        anchors{
                            verticalCenter: dashCoverRec.verticalCenter
                            horizontalCenter: dashCoverRec.horizontalCenter

                        }MouseArea{
                        anchors.fill: dashCoverImg
                        onClicked: unity2dConfiguration.formFactor = "tablet"
                        }
                        Text{
                            color: "white"
                            text: u2d.tr("Tablet Mode")

                            anchors{
                                left:dashCoverImg.left
                                leftMargin: dashCoverImg.width / 12
                                top:dashCoverImg.bottom

                            }
                        } //Text
                    } //Image
            } //Rectangle
        }//Row
    }//rootangle
}//scope
