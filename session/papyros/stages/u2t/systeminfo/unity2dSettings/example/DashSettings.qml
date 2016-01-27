// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import Unity2d 1.0
import "../component" as Comp
import "../../../dash/"
import "../../../common/"
import "settingsPage/dash"

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

    }//background rect
    Column{
        id: dashSettingsColoumn
        spacing: parent.height / 28
        anchors{
            left: mainBackground.left
            top: mainBackground.top
            topMargin: mainBackground.height / 30

        }
        //Formfactor

        Rectangle{
            id:formFactorRec
            width: mainBackground.width
            height: mainBackground.height / 8
            border.color: "#55FFFFFF"
            border.width: 1
            gradient: Gradient {
                GradientStop { position: 0; color: "#12000000"}
                GradientStop { position: 0.5; color: "#44808080"}
                GradientStop { position: 1; color: "#12000000"}

            }
            x: status === Rectangle.Ready ? 0 : 1
            Behavior on x {NumberAnimation{from: 1300; to: 0 ;duration:700 ;easing.type: Easing.OutQuint}}
            MouseArea{
                anchors.fill: formFactorRec
                onClicked:{
                    console.log("formfactor-settings-clicked")
                    dashSettingsColoumn.visible = false

                    formFactorToMain.visible = true
                    formFactorMain.visible = true
                    leftArrowFormfactor.visible = true
                    rightArrowFormfactor.visible = true

                    dashViewMain.visible = false
                    leftArrowDashView.visible = false
                    rightArrowDashView.visible = false

                    shellOpenGLMain.visible = false
                    leftArrowOpenGL.visible = false
                    rightArrowOpenGL.visible = false

                    stickyEdgeMain.visible = false
                    leftArrowStickyEdge.visible = false
                    rightArrowStickyEdge.visible = false

                    dashFullScreenMain.visible = false
                    leftArrowDashFullScreen.visible = false
                    rightArrowDashFullScreen.visible = false
                }
            }
            Text {
                id: formFactorText
                color: "white"
                font.pixelSize: formFactorRec.height / 4
                text: u2d.tr("Use Interface For:")
                anchors{
                    left: formFactorRec.left
                    leftMargin: formFactorRec.width / 20
                    verticalCenter: formFactorRec.verticalCenter
                }
            }    Rectangle{
                id: formFactorButtonRec
                height: formFactorRec.height - 3
                width: formFactorRec.height - 3
                radius: 0
                border.color: "#55FFFFFF"
                border.width: 1
                gradient: Gradient {
                    GradientStop { position: 0; color: "#12000000"}
                    GradientStop { position: 0.5; color: "#44808080"}
                    GradientStop { position: 1; color: "#12000000"}
                }
                anchors{
                    right: parent.right
                    rightMargin: parent.width / 20
                    verticalCenter: formFactorRec.verticalCenter
                }
                Image{
                    id: formFactorButton
                    source: if (unity2dConfiguration.formFactor === "tv")
                                "../component/gfx/formFactorTV.png"
                            else if (unity2dConfiguration.formFactor === "desktop")
                                "../component/gfx/formFactorDesktop.png"
                            else if (unity2dConfiguration.formFactor === "tablet")
                                "../component/gfx/formFactorTablet.png"
                    anchors{
                        fill: formFactorButtonRec
                        margins: 10
                    }
                }
            }
        }

        // backgroundColor
        Rectangle{
            id:backgroundColorRec
            width: mainBackground.width
            height: mainBackground.height / 8
            border.color: "#55FFFFFF"
            border.width: 1
            gradient: Gradient {
                GradientStop { position: 0; color: "#12000000"}
                GradientStop { position: 0.5; color: "#44808080"}
                GradientStop { position: 1; color: "#12000000"}
            }
            x: status === Rectangle.Ready ? 0 : 1
            Behavior on x {NumberAnimation{from: 1300; to: 0 ;duration:  1000 ;easing.type: Easing.OutQuint}}
                MouseArea{
                    id: backgroundColorButtonRecMouseArea
                    anchors.fill:backgroundColorRec
                    onClicked:{
                        avgBgColorMain.visible = true
                        leftArrowavgBgColor.visible = true
                        rightArrowavgBgColor.visible = true
                        formFactorToMain.visible = true
                        dashSettingsColoumn.visible = false

                        formFactorMain.visible = false
                        leftArrowFormfactor.visible = false
                        rightArrowFormfactor.visible = false


                        dashViewMain.visible = false
                        leftArrowDashView.visible = false
                        rightArrowDashView.visible = false

                        shellOpenGLMain.visible = false
                        leftArrowOpenGL.visible = false
                        rightArrowOpenGL.visible = false

                        stickyEdgeMain.visible = false
                        leftArrowStickyEdge.visible = false
                        rightArrowStickyEdge.visible = false

                        dashFullScreenMain.visible = false
                        leftArrowDashFullScreen.visible = false
                        rightArrowDashFullScreen.visible = false
                    }

                Text {
                    id: backgroundColorText
                    color: "white"
                    font.pixelSize: backgroundColorRec.height / 4
                    text: u2d.tr("Average Background Color:")
                    anchors{
                        left: backgroundColorButtonRecMouseArea.left
                        leftMargin:backgroundColorButtonRecMouseArea.width / 20
                        verticalCenter: backgroundColorButtonRecMouseArea.verticalCenter
                    }
                }
                Rectangle{
                    id: backgroundColorButtonRec
                    height: backgroundColorRec.height - 3
                    width: backgroundColorRec.height - 3
                    radius: 0
                    border.color: "#55FFFFFF"
                    border.width: 1
                    gradient: Gradient {
                        GradientStop { position: 0; color: "#12000000"}
                        GradientStop { position: 0.5; color: "#44808080"}
                        GradientStop { position: 1; color: "#12000000"}
                    }
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 20
                        verticalCenter: backgroundColorRec.verticalCenter
                    }
                    Rectangle{
                        id: backgroundColorButton
                        color: (unity2dConfiguration.averageBgColor)
                        anchors{
                            fill:backgroundColorButtonRec
                            margins: 10
                        }
                    }
                }
            }
        }

        // DashView
        Rectangle{
            id:dashViewRec
            width: mainBackground.width
            height: mainBackground.height / 8
            radius: 0
            border.color: "#55FFFFFF"
            border.width: 1
            gradient: Gradient {
                GradientStop { position: 0; color: "#12000000"}
                GradientStop { position: 0.5; color: "#44808080"}
                GradientStop { position: 1; color: "#12000000"}
            }
            x: status === Rectangle.Ready ? 0 : 1
            Behavior on x {NumberAnimation{from: 1300; to: 0 ;duration:  1300 ;easing.type: Easing.OutQuint}}
            MouseArea{
                anchors.fill: dashViewRec
                onClicked: {
                    console.log("dashview-settings-clicked")
                    dashSettingsColoumn.visible = false

                    formFactorToMain.visible = true
                    formFactorMain.visible = false
                    leftArrowFormfactor.visible = false
                    rightArrowFormfactor.visible = false


                    dashViewMain.visible = true
                    leftArrowDashView.visible = true
                    rightArrowDashView.visible = true

                    shellOpenGLMain.visible = false
                    leftArrowOpenGL.visible = false
                    rightArrowOpenGL.visible = false

                    stickyEdgeMain.visible = false
                    leftArrowStickyEdge.visible = false
                    rightArrowStickyEdge.visible = false

                    dashFullScreenMain.visible = false
                    leftArrowDashFullScreen.visible = false
                    rightArrowDashFullScreen.visible = false
                }
            }
            Text {
                id: dashViewText
                color: "white"
                font.pixelSize: dashViewRec.height / 4
                text: u2d.tr("Dash View:")
                anchors{
                    left: dashViewRec.left
                    leftMargin: dashViewRec.width / 20
                    verticalCenter: dashViewRec.verticalCenter
                }
            }    Rectangle{
                id: dashViewButtonRec
                height: dashViewRec.height - 3
                width: dashViewRec.height - 3
                radius: 0
                border.color: "#55FFFFFF"
                border.width: 1
                gradient: Gradient {
                    GradientStop { position: 0; color: "#12000000"}
                    GradientStop { position: 0.5; color: "#44808080"}
                    GradientStop { position: 1; color: "#12000000"}
                }
                anchors{
                    right: parent.right
                    rightMargin: parent.width / 20
                    verticalCenter: dashViewRec.verticalCenter
                }
                Image{
                    id: dashViewButton
                    source: if (dash2dConfiguration.dashView === "coverflow")
                                "../component/gfx/coverflowButton.png"
                            else if (dash2dConfiguration.dashView === "tile-vertical")
                                "../component/gfx/gridview.png"
                            else if (dash2dConfiguration.dashView === "tile-horizontal")
                                "../component/gfx/verticalButton.png"
                    anchors{
                        fill: dashViewButtonRec
                        margins: 10
                    }
                }MouseArea{
                    anchors.fill:dashViewButton
                    onClicked: console.log("formfactor-clicked")
                }
            }
        }


        // fullScreen
        Rectangle{
            id:fullScreenRec
            width: mainBackground.width
            height: mainBackground.height / 8
            radius: 0
            border.color: "#55FFFFFF"
            border.width: 1
            gradient: Gradient {
                GradientStop { position: 0; color: "#12000000"}
                GradientStop { position: 0.5; color: "#44808080"}
                GradientStop { position: 1; color: "#12000000"}
            }
            x: status === Rectangle.Ready ? 0 : 1
            Behavior on x {NumberAnimation{from: 1300; to: 0 ;duration:  1600 ;easing.type: Easing.OutQuint}}
            Text {
                id: fullScreenText
                color: "white"
                font.pixelSize: fullScreenRec.height / 4
                text: u2d.tr("Use Full Screen For Dash:")
                anchors{
                    left: fullScreenRec.left
                    leftMargin: fullScreenRec.width / 20
                    verticalCenter: fullScreenRec.verticalCenter
                }
            }    Image{
                id: fullScreenButtonRec
                source: "../../../artwork/tick_box.png"
                anchors{
                    right: parent.right
                    rightMargin: parent.width / 12.5
                    verticalCenter: fullScreenRec.verticalCenter
                }
                Image{
                    id:fullScreenButton
                    visible: if (dash2dConfiguration.fullScreen === true)
                                 true
                             else
                                 false
                    source: "../../../artwork/tick.png"
                    scale: 1.5
                    smooth: true
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 12.5
                        verticalCenter: fullScreenRec.verticalCente
                    }
                }MouseArea{
                    anchors.fill: fullScreenButton
                    onClicked: if (dash2dConfiguration.fullScreen === true)
                                   dash2dConfiguration.fullScreen = false
                               else if (dash2dConfiguration.fullScreen === false)
                                   dash2dConfiguration.fullScreen = true
                }
            }
        }

        // musicHint
        Rectangle{
            id:musicHintRec
            width: mainBackground.width
            height: mainBackground.height / 8
            radius: 0
            border.color: "#55FFFFFF"
            border.width: 1
            gradient: Gradient {
                GradientStop { position: 0; color: "#12000000"}
                GradientStop { position: 0.5; color: "#44808080"}
                GradientStop { position: 1; color: "#12000000"}
            }
            x: status === Rectangle.Ready ? 0 : 1
            Behavior on x {NumberAnimation{from: 1300; to: 0 ;duration:  1600 ;easing.type: Easing.OutQuint}}
            Text {
                id: musicHintText
                color: "white"
                font.pixelSize: musicHintRec.height / 4
                text: u2d.tr("Turn on Music Hinting:")
                anchors{
                    left: musicHintRec.left
                    leftMargin: musicHintRec.width / 20
                    verticalCenter: musicHintRec.verticalCenter
                }
            }    Image{
                id: musicHintButtonRec
                source: "../../../artwork/tick_box.png"
                anchors{
                    right: parent.right
                    rightMargin: parent.width / 12.5
                    verticalCenter: musicHintRec.verticalCenter
                }
                Image{
                    id:musicHintButton
                    visible: if (dash2dConfiguration.musicHint === true)
                                 true
                             else
                                 false
                    source: "../../../artwork/tick.png"
                    scale: 1.5
                    smooth: true
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 12.5
                        verticalCenter: musicHintRec.verticalCente
                    }
                }MouseArea{
                    anchors.fill: musicHintButton
                    onClicked: if (dash2dConfiguration.musicHint === true)
                                   dash2dConfiguration.musicHint = false
                               else if (dash2dConfiguration.musicHint === false)
                                   dash2dConfiguration.musicHint = true
                }
            }
        }











        // mythIpBackend
        Rectangle{
            id:mythIpBackendRec
            width: mainBackground.width
            height: mainBackground.height / 8
            radius: 0
            border.color: "#55FFFFFF"
            border.width: 1
            gradient: Gradient {
                GradientStop { position: 0; color: "#12000000"}
                GradientStop { position: 0.5; color: "#44808080"}
                GradientStop { position: 1; color: "#12000000"}
            }
            x: status === Rectangle.Ready ? 0 : 1
            Behavior on x {NumberAnimation{from: 1300; to: 0 ;duration:  1900 ;easing.type: Easing.OutQuint}}
        }
        Text {
            id: mythIpBackendText
            color: "white"
            font.pixelSize: mythIpBackendRec.height / 4
            text: u2d.tr("MythTV Backend Address:")
            anchors{
                left: mythIpBackendRec.left
                leftMargin: mythIpBackendRec.width / 20
                verticalCenter: mythIpBackendRec.verticalCenter
            }
        }
        Rectangle{
            id: mythIpBackendButtonRec
            height: mythIpBackendRec.height / 3
            width: mythIpBackendRec.width / 4
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
                verticalCenter: mythIpBackendRec.verticalCenter
            }
            TextInput{
                id: mythIpBackendButton

                height: mythIpBackendButtonRec.height / 1.4
                color:"white"
                text: (dash2dConfiguration.mythipBackend)
                onAccepted:{
                    dash2dConfiguration.mythipBackend = mythIpBackendButton.text
                    mythIpBackendButton.focus = false

                }
                    anchors{
                    bottom: mythIpBackendButtonRec.bottom
                    horizontalCenter: mythIpBackendButtonRec.horizontalCenter

                }
            }

        }





    }//Column

    Image {
        visible: false
        id: formFactorToMain
        source: "../../../artwork/cross.png"
        anchors{
            top:parent.top
            left:  parent.left
            leftMargin: parent.width / 4
        }

        MouseArea{
            anchors.fill: formFactorToMain
            onClicked:{
                dashSettingsColoumn.visible =  true
                formFactorToMain.visible =  false


                formFactorMain.visible =  false
                leftArrowFormfactor.visible =  false
                rightArrowFormfactor.visible =  false

                dashViewMain.visible = false;
                leftArrowDashView.visible = false
                rightArrowDashView.visible = false

                shellOpenGLMain.visible = false
                leftArrowOpenGL.visible = false
                rightArrowOpenGL.visible = false

                stickyEdgeMain.visible = false
                leftArrowStickyEdge.visible = false
                rightArrowStickyEdge.visible = false

                dashFullScreenMain.visible = false
                leftArrowDashFullScreen.visible = false
                rightArrowDashFullScreen.visible = false

                avgBgColorMain.visible = false;
                leftArrowavgBgColor.visible = false
                rightArrowavgBgColor.visible = false

            }
        }
    }


    ////////////////////////////////////////
    //          Starting Dialogs
    ///////////////////////////////////////
    Rectangle {
        id:rootView
        width: parent.width
        height: parent.height
        color: "transparent"

        //       Form Factor
        //Rectangle{
        //    id:formFactorToTheRight
        //    width: parent.height / 6
        //    height: parent.height / 4
        //    visible: true //false
        //    radius: 0
        //    border.color: "#55FFFFFF"
        //    border.width: 1
        //    gradient: Gradient {
        //        GradientStop { position: 0; color: "#12000000"}
        //        GradientStop { position: 0.5; color: "#44808080"}
        //        GradientStop { position: 1; color: "#12000000"}
        //    }
        //    anchors{
        //bottom: rightArrowFormfactor.top
        //verticalCenter: rightArrowFormfactor.verticalCenter
        //right: parent.right
        //rightMargin: 27
        //    }
        //        Text {
        //            id: totheright
        //            text: u2d.tr("   Next:\nDash View")
        //            color: "white"
        //            visible: false
        //anchors{
        //horizontalCenter: formFactorToTheRight.horizontalCenter
        //verticalCenter: formFactorToTheRight.verticalCenter
        //}
        //        }
        //}
        Image {
            visible: false
            id: rightArrowFormfactor
            source: "../../../artwork/right_arrow_timeline.png"
            width: 64
            height: 64
            x: parent.width / 1.15
            y: parent.height / 2.69
            MouseArea{
                hoverEnabled: true
                anchors.fill:rightArrowFormfactor
                onClicked:{
                    formFactorMain.visible = false
                    leftArrowFormfactor.visible = false
                    rightArrowFormfactor.visible = false

                    dashViewMain.visible = true
                    leftArrowDashView.visible = true
                    rightArrowDashView.visible = true

                    shellOpenGLMain.visible = false
                    leftArrowOpenGL.visible = false
                    rightArrowOpenGL.visible = false

                    stickyEdgeMain.visible = false
                    leftArrowStickyEdge.visible = false
                    rightArrowStickyEdge.visible = false

                    dashFullScreenMain.visible = false
                    leftArrowDashFullScreen.visible = false
                    rightArrowDashFullScreen.visible = false

                    avgBgColorMain.visible = false;
                    leftArrowavgBgColor.visible = false
                    rightArrowavgBgColor.visible = false
                }

            }//MouseArea
        }//Image

        ShellFormFactorSettings{
            visible: false
            id:formFactorMain
            scale: 1.32
            width: parent.width
            height: parent.height
            x: parent.width / 2.11
            y: parent.height / 3.66
            Image {
                id: leftArrowFormfactor
                source: "../../../artwork/left_arrow_timeline.png"
                width: 48
                height: 48
                anchors{
                    top: formFactorMain.top
                    topMargin: formFactorMain.height / 4.99
                    right: formFactorMain.left
                }

                MouseArea{
                    anchors.fill: leftArrowFormfactor
                    onClicked:{
                        formFactorMain.visible = false
                        leftArrowFormfactor.visible = false
                        rightArrowFormfactor.visible = false

                        dashViewMain.visible = false;
                        leftArrowDashView.visible = false
                        rightArrowDashView.visible = false

                        shellOpenGLMain.visible = false
                        leftArrowOpenGL.visible = false
                        rightArrowOpenGL.visible = false

                        stickyEdgeMain.visible = false
                        leftArrowStickyEdge.visible = false
                        rightArrowStickyEdge.visible = false

                        dashFullScreenMain.visible = false
                        leftArrowDashFullScreen.visible = false
                        rightArrowDashFullScreen.visible = false

                        avgBgColorMain.visible = true
                        leftArrowavgBgColor.visible = true
                        rightArrowavgBgColor.visible = true
                    }

                }//MouseArea
            }//Image
        }//ShellFormFactorSettings

        // dash View start
        Image {
            id: rightArrowDashView
            visible: false

            source: "../../../artwork/right_arrow_timeline.png"
            width: 64
            height: 64
            x: parent.width / 1.15
            y: parent.height / 2.69

            MouseArea{
                anchors.fill: rightArrowDashView
                onClicked:{
                    formFactorMain.visible = false
                    leftArrowFormfactor.visible = false
                    rightArrowFormfactor.visible = false

                    dashViewMain.visible = false
                    leftArrowDashView.visible = false
                    rightArrowDashView.visible = false

                    shellOpenGLMain.visible = true
                    leftArrowOpenGL.visible = true
                    rightArrowOpenGL.visible = true

                    stickyEdgeMain.visible = false
                    leftArrowStickyEdge.visible = false
                    rightArrowStickyEdge.visible = false

                    dashFullScreenMain.visible = false;
                    leftArrowDashFullScreen.visible = false
                    rightArrowDashFullScreen.visible = false

                    avgBgColorMain.visible = false;
                    leftArrowavgBgColor.visible = false
                    rightArrowavgBgColor.visible = false
                }

            }//Mouse
        }//Image
        DashViewSettings{
            id:dashViewMain
            visible: false
            scale: 1.32
            width: parent.width
            height: parent.height
            x: parent.width / 2.11
            y: parent.height / 3.66
            Image {
                id: leftArrowDashView
                source: "../../../artwork/left_arrow_timeline.png"
                width: 48
                height: 48
                anchors{
                    top: dashViewMain.top
                    topMargin: dashViewMain.height / 4.99
                    right: dashViewMain.left
                }
                MouseArea{
                    anchors.fill: leftArrowDashView
                    onClicked:{
                        formFactorMain.visible = true
                        leftArrowFormfactor.visible = true
                        rightArrowFormfactor.visible = true

                        dashViewMain.visible = false
                        leftArrowDashView.visible = false
                        rightArrowDashView.visible = false

                        shellOpenGLMain.visible = false
                        leftArrowOpenGL.visible = false
                        rightArrowOpenGL.visible = false

                        stickyEdgeMain.visible = false
                        leftArrowStickyEdge.visible = false
                        rightArrowStickyEdge.visible = false

                        dashFullScreenMain.visible = false;
                        leftArrowDashFullScreen.visible = false
                        rightArrowDashFullScreen.visible = false

                        avgBgColorMain.visible = false;
                        leftArrowavgBgColor.visible = false
                        rightArrowavgBgColor.visible = false
                    }

                }//Mouse

            }//Image
        }//DashViewSettings


        //openGL
        Image {
            visible: false

            id: rightArrowOpenGL
            source: "../../../artwork/right_arrow_timeline.png"
            width: 64
            height: 64
            x: parent.width / 1.15
            y: parent.height / 2.69

            MouseArea{
                anchors.fill: rightArrowOpenGL
                onClicked:{
                    formFactorMain.visible = false
                    leftArrowFormfactor.visible = false
                    rightArrowFormfactor.visible = false

                    dashViewMain.visible = false;
                    leftArrowDashView.visible = false
                    rightArrowDashView.visible = false

                    shellOpenGLMain.visible = false
                    leftArrowOpenGL.visible = false
                    rightArrowOpenGL.visible = false

                    stickyEdgeMain.visible = true
                    leftArrowStickyEdge.visible = true
                    rightArrowStickyEdge.visible = true

                    dashFullScreenMain.visible = false;
                    leftArrowDashFullScreen.visible = false
                    rightArrowDashFullScreen.visible = false

                    avgBgColorMain.visible = false;
                    leftArrowavgBgColor.visible = false
                    rightArrowavgBgColor.visible = false
                }

            }//MouseArea
        }//Image

        ShellOpenGLSettings{
            id:shellOpenGLMain
            visible: false
            scale: 1.32
            width: parent.width
            height: parent.height
            x: parent.width / 2.11
            y: parent.height / 3.666
            Image {
                id: leftArrowOpenGL
                source: "../../../artwork/left_arrow_timeline.png"
                width: 48
                height: 48
                anchors{
                    top: shellOpenGLMain.top
                    topMargin: shellOpenGLMain.height / 4.99
                    right: shellOpenGLMain.left
                }
                MouseArea{

                    anchors.fill: leftArrowOpenGL
                    onClicked:{
                        formFactorMain.visible = false
                        leftArrowFormfactor.visible = false
                        rightArrowFormfactor.visible = false

                        dashViewMain.visible = true
                        leftArrowDashView.visible = true
                        rightArrowDashView.visible = true

                        shellOpenGLMain.visible = false
                        leftArrowOpenGL.visible = false
                        rightArrowOpenGL.visible = false

                        stickyEdgeMain.visible = false
                        leftArrowStickyEdge.visible = false
                        rightArrowStickyEdge.visible = false

                        dashFullScreenMain.visible = false;
                        leftArrowDashFullScreen.visible = false
                        rightArrowDashFullScreen.visible = false

                        avgBgColorMain.visible = false;
                        leftArrowavgBgColor.visible = false
                        rightArrowavgBgColor.visible = false
                    }

                }//MouseArea
            }//Image
        }//ShellOpenGLSettings



        //            Sticky Edge
        Image {
            visible: false

            id: rightArrowStickyEdge
            source: "../../../artwork/right_arrow_timeline.png"
            width: 64
            height: 64
            x: parent.width / 1.15
            y: parent.height / 2.69

            MouseArea{
                anchors.fill: rightArrowStickyEdge
                onClicked:{
                    formFactorMain.visible = false
                    leftArrowFormfactor.visible = false
                    rightArrowFormfactor.visible = false

                    dashViewMain.visible = false
                    leftArrowDashView.visible = false
                    rightArrowDashView.visible = false

                    shellOpenGLMain.visible = false
                    leftArrowOpenGL.visible = false
                    rightArrowOpenGL.visible = false

                    stickyEdgeMain.visible = false
                    leftArrowStickyEdge.visible = false
                    rightArrowStickyEdge.visible = false

                    dashFullScreenMain.visible = true
                    leftArrowDashFullScreen.visible = true
                    rightArrowDashFullScreen.visible = true

                    avgBgColorMain.visible = false;
                    leftArrowavgBgColor.visible = false
                    rightArrowavgBgColor.visible = false
                }
            }//MouseArea
        }//Image

        ShellStickySettings{
            id:stickyEdgeMain
            visible: false
            scale: 1.32
            width: parent.width
            height: parent.height
            x: parent.width / 2.11
            y: parent.height / 3.66
            Image {
                id: leftArrowStickyEdge
                source: "../../../artwork/left_arrow_timeline.png"
                width: 48
                height: 48
                anchors{
                    top: stickyEdgeMain.top
                    topMargin: stickyEdgeMain.height / 4.99
                    right: stickyEdgeMain.left
                }
                MouseArea{
                    anchors.fill: leftArrowStickyEdge
                    onClicked:{
                        formFactorMain.visible = false
                        leftArrowFormfactor.visible = false
                        rightArrowFormfactor.visible = false

                        dashViewMain.visible = false
                        leftArrowDashView.visible = false
                        rightArrowDashView.visible = false

                        shellOpenGLMain.visible = true
                        leftArrowOpenGL.visible = true
                        rightArrowOpenGL.visible = true

                        stickyEdgeMain.visible = false
                        leftArrowStickyEdge.visible = false
                        rightArrowStickyEdge.visible = false

                        dashFullScreenMain.visible = false
                        leftArrowDashFullScreen.visible = false
                        rightArrowDashFullScreen.visible = false

                        avgBgColorMain.visible = false;
                        leftArrowavgBgColor.visible = false
                        rightArrowavgBgColor.visible = false
                    }

                }//MouseArea
            }//Image
        }// ShellStickySettings

        //dash Full Screen
        Image {
            visible: false
            id: rightArrowDashFullScreen
            source: "../../../artwork/right_arrow_timeline.png"
            width: 64
            height: 64
            x: parent.width / 1.15
            y: parent.height / 2.69
            MouseArea{
                anchors.fill: rightArrowDashFullScreen
                onClicked:{
                    formFactorMain.visible = false
                    leftArrowFormfactor.visible = false
                    rightArrowFormfactor.visible = false

                    dashViewMain.visible = false;
                    leftArrowDashView.visible = false
                    rightArrowDashView.visible = false

                    shellOpenGLMain.visible = false
                    leftArrowOpenGL.visible = false
                    rightArrowOpenGL.visible = false

                    stickyEdgeMain.visible = false
                    leftArrowStickyEdge.visible = false
                    rightArrowStickyEdge.visible = false

                    dashFullScreenMain.visible = false;
                    leftArrowDashFullScreen.visible = false
                    rightArrowDashFullScreen.visible = false

                    avgBgColorMain.visible = true
                    leftArrowavgBgColor.visible = true
                    rightArrowavgBgColor.visible = true
                }
            }//MouseArea
        } //Image
        DashFullScreenSettings{
            id:dashFullScreenMain
            visible: false
            scale: 1.32
            width: parent.width
            height: parent.height
            x: parent.width / 2.11
            y: parent.height / 3.66
            Image {
                id: leftArrowDashFullScreen
                source: "../../../artwork/left_arrow_timeline.png"
                width: 48
                height: 48
                anchors{
                    top: dashFullScreenMain.top
                    topMargin: dashFullScreenMain.height / 4.99
                    right: dashFullScreenMain.left
                }
                MouseArea{
                    anchors.fill: leftArrowDashFullScreen
                    onClicked:{
                        formFactorMain.visible = false
                        leftArrowFormfactor.visible = false
                        rightArrowFormfactor.visible = false

                        dashViewMain.visible = false;
                        leftArrowDashView.visible = false
                        rightArrowDashView.visible = false

                        shellOpenGLMain.visible = false
                        leftArrowOpenGL.visible = false
                        rightArrowOpenGL.visible = false

                        stickyEdgeMain.visible = true
                        leftArrowStickyEdge.visible = true
                        rightArrowStickyEdge.visible = true


                        dashFullScreenMain.visible = false;
                        leftArrowDashFullScreen.visible = false
                        rightArrowDashFullScreen.visible = false

                        avgBgColorMain.visible = false;
                        leftArrowavgBgColor.visible = false
                        rightArrowavgBgColor.visible = false
                    }
                }//MouseArea
            } //Image
        } //DashFullScreenSettings




        // Avg Background
        Image {
            visible: false
            id: rightArrowavgBgColor
            source: "../../../artwork/right_arrow_timeline.png"
            width: 64
            height: 64
            x: parent.width / 1.15
            y: parent.height / 2.69
            MouseArea{
                anchors.fill: rightArrowavgBgColor
                onClicked:{
                    formFactorMain.visible = true
                    leftArrowFormfactor.visible = true
                    rightArrowFormfactor.visible = true

                    dashViewMain.visible = false;
                    leftArrowDashView.visible = false
                    rightArrowDashView.visible = false

                    shellOpenGLMain.visible = false
                    leftArrowOpenGL.visible = false
                    rightArrowOpenGL.visible = false

                    stickyEdgeMain.visible = false
                    leftArrowStickyEdge.visible = false
                    rightArrowStickyEdge.visible = false

                    dashFullScreenMain.visible = false;
                    leftArrowDashFullScreen.visible = false
                    rightArrowDashFullScreen.visible = false

                    avgBgColorMain.visible = false;
                    leftArrowavgBgColor.visible = false
                    rightArrowavgBgColor.visible = false

                }
            }//MouseArea
        } //Image
        ShellAvgBackground{
            id:avgBgColorMain
            visible: false
            scale: 1.32
            width: parent.width
            height: parent.height
            x: parent.width / 2.11
            y: parent.height / 3.66
            Image {
                id: leftArrowavgBgColor
                source: "../../../artwork/left_arrow_timeline.png"
                width: 48
                height: 48
                anchors{
                    top: avgBgColorMain.top
                    topMargin: avgBgColorMain.height / 4.99
                    right: avgBgColorMain.left
                }
                MouseArea{
                    anchors.fill: leftArrowavgBgColor
                    onClicked:{
                        formFactorMain.visible = false
                        leftArrowFormfactor.visible = false
                        rightArrowFormfactor.visible = false

                        dashViewMain.visible = false;
                        leftArrowDashView.visible = false
                        rightArrowDashView.visible = false

                        shellOpenGLMain.visible = false
                        leftArrowOpenGL.visible = false
                        rightArrowOpenGL.visible = false

                        stickyEdgeMain.visible = false
                        leftArrowStickyEdge.visible = false
                        rightArrowStickyEdge.visible = false


                        dashFullScreenMain.visible = true
                        leftArrowDashFullScreen.visible = true
                        rightArrowDashFullScreen.visible = true

                        avgBgColorMain.visible = false;
                        leftArrowavgBgColor.visible = false
                        rightArrowavgBgColor.visible = false
                    }
                }//MouseArea
            } //Image
        } //avgBackGround
    }//Roottange
}//focusscope

