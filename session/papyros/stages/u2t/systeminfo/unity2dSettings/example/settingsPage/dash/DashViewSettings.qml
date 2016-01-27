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
            id: dashViewName
            opacity: 1
            height: 28
            color: "white"
            font.pixelSize: dashViewMode.height / 12
            text: "Dash View"
            anchors{
                horizontalCenter: dashViewMode.horizontalCenter
                top:dashViewMode.top
            }
        }
        Rectangle {
            id: dashViewMode
            width: parent.width / 2.33
            height: parent.height / 2.22
            border.color: "#34FFFFFF"
            border.width: 1
            smooth: true
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#10FFFFFF"; }
                GradientStop { position: 1.0; color: "#20dd4814"; }
                GradientStop { position: 1.0; color: "#25000000"; }

            }
            opacity: status === Rectangle.Ready ? .88 : 0.0
            Behavior on opacity {
                NumberAnimation {
                    property: "opacity";
                    from: 0.0
                    to: .98
                    duration: 1100;
                    easing.type: Easing.InOutQuad
                }
            }


            Text{
                id:dashViewDescription
                text:u2d.tr("Customize the current apperarance of the Unity 2d dash layout. The default state is is tile vertical. If you would like to set the Unity 2d dash layout Back to default")
                font.pixelSize: parent.height / 19
                color: "white"
                width: dashViewMode.width - 12
                height: dashViewMode.height
                wrapMode: Text.WordWrap
                anchors{
                    top:dashViewMode.top
                    topMargin: 40
                    left:dashViewMode.left
                    leftMargin: 8
                }
            }
           }
            Row{
                height: parent.height / 2.33
                width: parent.width / 2.66
                spacing: dashViewDescription.width / 12.33
                anchors{
                    bottom: parent.bottom
                    bottomMargin: dashViewDescription.height / 1.11
                    left:parent.left
                    leftMargin: dashViewDescription.width / 33.33
                }

                Rectangle {
                    id: dashViewRec
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
                            id:dashViewImg
                            source: "../../../component/gfx/gridview.png"
                            width: dashViewRec.width - 10
                            height: dashViewRec.height - 10
                            opacity: if ((dash2dConfiguration.dashView) === "tile-vertical")
                                         1
                            else
                                         .26
                            anchors{
                                verticalCenter: dashViewRec.verticalCenter
                                horizontalCenter: dashViewRec.horizontalCenter
                            } MouseArea {
                                anchors.fill: dashViewImg
                                onClicked: dash2dConfiguration.dashView = "tile-vertical"
                                }
                            Text{
                                color: "white"
                                text: u2d.tr("Tile Horizontal")
                                anchors{
                                    left:dashViewImg.left
                                    leftMargin: dashViewImg.width / 8
                                    top:dashViewImg.bottom
                                }
                            } //Text
                        } //Image
//                    } //SettingManagerParser
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
                            source: "../../../component/gfx/verticalButton.png"
                            width: dashVertRec.width - 10
                            height: dashVertRec.height - 10
                            opacity: if ((dash2dConfiguration.dashView) === "tile-horizontal")
                                         1
                            else
                                         .26
                            anchors{
                                verticalCenter: dashVertRec.verticalCenter
                                horizontalCenter: dashVertRec.horizontalCenter
                            }AbstractButton{
                            anchors.fill: dashVertImg
                            onClicked: dash2dConfiguration.dashView = "tile-horizontal"
                            }
                            Text{
                                color: "white"
                                text: u2d.tr("Tile Vertical")
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
                            source: "../../../component/gfx/coverflowButton.png"
                            width: dashCoverRec.width - 10
                            height: dashCoverRec.height - 10
                            opacity: if ((dash2dConfiguration.dashView) === "coverflow")
                                                                     1
                                                        else
                                                                     .26
                            anchors{
                                verticalCenter: dashCoverRec.verticalCenter
                                horizontalCenter: dashCoverRec.horizontalCenter
                            }MouseArea{
                                anchors.fill: dashCoverImg
                                onClicked: dash2dConfiguration.dashView = "coverflow"
                            }
                            Text{
                                color: "white"
                                text: u2d.tr("CoverFlow  \(TV\)")
                                anchors{
                                    left:dashCoverImg.left
                                    leftMargin: dashCoverImg.width / 12
                                    top:dashCoverImg.bottom

                                }
                            } //Text
                        } //Image
                } //Rectangle
            }//Row
        }//roottangle
    }//focusScope
