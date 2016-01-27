import QtQuick 1.0
import Unity2d 1.0
//import QtWebKit 1.0
import "../../../dash"
import "../../../common"
import "../../../indicators"
import "../../../common/utils.js" as Utils
//import "../../qmlvideofx/qml/qmlvideofx/"
//import Qt.labs.folderlistmodel 1.0
//import Qt.labs.particles 1.0



Rectangle {
    id:root
    width: parent.width
    height: parent.height
    color: "transparent"
    x: status === Rectangle.Ready ? 0 : 1
    Behavior on x {NumberAnimation{from: 1300; to: 0 ;duration: 1900 ;easing.type: Easing.OutQuint}}
    Image {
        id: mainBackground
        width: if (unity2dConfiguration.formFactor === "tv" )
                   parent.width / 1.38
               else
                   parent.width / 1.35
        height: parent.height
        smooth: true

        source:{
            var filename = lightDmConfiguration.background
            if(filename === "/usr/share/backgrounds/warty-final-ubuntu.png")
                filename = "../component/gfx/workaroundWarty.jpg"
            return filename
        }
        anchors{
            left: parent.left
            leftMargin: parent.width / 3.98
        }
    }
    Rectangle{
        id: hideMeRec
        width: if (unity2dConfiguration.formFactor === "tv" )
                   parent.width / 1.38
               else
                   parent.width / 1.35
        height: parent.height
        anchors{
            left: parent.left
            leftMargin: parent.width / 3.98
        }
        color: "transparent"
        Grid{
            id: dotsGrid
            visible: if (lightDmConfiguration.drawGrid === true)
                         true
                     else
                         false
            columns: 22
            rows: 15
            width: if (unity2dConfiguration.formFactor === "tv" )
                       parent.width / 1.38
                   else
                       parent.width / 1.40
            height: parent.height
            spacing: parent.width / 26
            anchors{
                left:parent.left
                leftMargin: parent.width / 44
                top: parent.top
                topMargin: parent.height / 33

            }
            Repeater { model: 330
                Image {
                    id: dotToRepeate
                    source: "../component/gfx/oneDot.png"
                    smooth: true
                    opacity: .22
                }
            }
        }
        Rectangle{
            id:topBar
            color: lightDmConfiguration.backgroundColor
            width: parent.width
            height: parent.height / 24
            opacity: .66
            anchors{
                top: parent.top
                left: parent.left
                //            leftMargin: parent.width / 3.98
            }
            Text {
                id: userName
                height:topBar.height
                text: u2d.tr("  username")
                color:"white"
                anchors{
                    left:parent.left
                    top:parent.top
                    topMargin: topBar.height / 3.66
                }
            }
            Row{
                id:iconRow
                height: if(dash2dConfiguration.fullScreen === false)
                            userName.height - 5
                        else
                            userName.height
                width: parent.width / 4.6
                spacing: parent.height / 3
                anchors{
                    right:parent.right
                    rightMargin: if(dash2dConfiguration.fullScreen === false)
                                     parent.height * 1.2
                                 else
                                     0
                    top:parent.top
                    topMargin: userName.height / 3.66
                }

                Image {
                    id:uniAcessimg
                    source: "/usr/share/unity-greeter/a11y.svg"
                }Image {
                    id: keyboardImg
                    width: parent.height * 1.1
                    source: "/usr/share/icons/gnome/scalable/devices/input-keyboard-symbolic.svg"
                }Text{
                    color:"white"
                    text: "en"
                }
                Image{
                    width: parent.height * 1
                    smooth: true
                    source: "/usr/share/icons/gnome/scalable/status/network-wireless-signal-excellent-symbolic.svg"
                }
                TextCustom {
                    Timer {interval: 1000;running: true;repeat: true;onTriggered: parent.setTime()}
                    fontSize: "ex-small";color: "white";smooth: true;
                    Component.onCompleted: setTime()
                    function setTime(){text = Qt.formatTime(new Date(), "hh:mm")}
                }
                Image{
                    source: "/usr/share/icons/gnome/scalable/actions/system-shutdown-symbolic.svg"
                }
            }//iconRow
        }//topBar

        Rectangle{
            id:signInAreaRec
            width: parent.width / 3.3
            height: parent.height / 4.6
            color: lightDmConfiguration.backgroundColor
            radius: 10
            opacity: .55
            border.color: "#34FFFFFF"
            border.width: 1
            anchors{
                left:parent.left
                leftMargin: parent.width / 16.8
                top:parent.top
                topMargin: parent.height / 2.22
            }
        }
        Rectangle{
            id:signInIconRec
            color:"transparent"
            width: signInAreaRec.width / 8
            height: signInAreaRec.width / 8
            anchors{
                left:parent.left
                leftMargin: parent.width / 3.22
                top:parent.top
                topMargin: parent.height / 2.14
            }
            Image {
                id: signInIcon
                source: lightDmConfiguration.backgroundLogo
                smooth: true
                scale: 1
                Behavior on scale{
                    NumberAnimation{
                        from: .22
                        to: 1
                        loops:mainBackground.visible === true ? 1 : NumberAnimation.Infinite
                        duration: 1500
                        easing.type: Easing.OutBounce
                    }
                }
                anchors.fill: signInIconRec
            }
        }
        Text{
            id:userNameSignin
            text: u2d.tr("Users Name")
            color: "white"
            font.pixelSize: parent.width / 40
            anchors{
                left:parent.left
                leftMargin: parent.width / 14.8
                top:parent.top
                topMargin: parent.height / 2.11
            }
        }

        Image {
            id: passwordBox
            source: "../../../common/artwork/search_background.png"
            width: parent.width / 3.66
            height: parent.height / 13.6
            anchors{
                top:parent.top
                topMargin: parent.height / 1.77
                left:parent.left
                leftMargin: parent.width / 13.8
            }
        }Text {
            id: passwordText
            text: u2d.tr("Password")
            color:"white"
            opacity: .55
            font.pixelSize: parent.width / 34
            anchors{
                left: passwordBox.left
                leftMargin: passwordBox.width / 33
                bottom: passwordBox.bottom
            }
        }


        Text {
            id: guestText
            text: u2d.tr("Guest Session")
            color:"white"
            opacity: .88
            font.pixelSize: parent.width / 34
            anchors{
                top:parent.top
                topMargin: parent.height / 1.44
                left:parent.left
                leftMargin: parent.width / 13.8
            }
        }
        Image {
            id: bottomIcon
            source: lightDmConfiguration.logo
            smooth: true
            scale: 1
            Behavior on scale{
                NumberAnimation{
                    from: .22
                    to: 1
                    loops: mainBackground.visible === true ? 1 : NumberAnimation.Infinite
                    duration: 1500
                    easing.type: Easing.OutBounce
                }
            }
            anchors{
                top:parent.top
                topMargin: parent.height / 1.11
                left:parent.left
                leftMargin: parent.width / 55
            }
        }
    }//mainbkg
    //****************************
    //    Start right Menu
    //****************************
   Rectangle{
       id:hideSideBar
       height: parent.height // 1.46
       width: parent.width // 14.46
       color: "transparent"
       x:1
       Behavior on x{NumberAnimation{from:parent.width;to: 1 ; duration: 400; easing.type: Easing.OutQuad }}

    Rectangle{
        id:backroundForLauncher
        height: parent.height / 1.46
        width: parent.width / 14.46
        color: (lightDmConfiguration.backgroundColor)
        opacity: .66
        anchors{
            right: parent.right
            rightMargin: if (unity2dConfiguration.formFactor === "tv")
                             parent.width /  91.38
                         else
                             parent.width / 91.38
            verticalCenter:  parent.verticalCenter
        }

    }
    Rectangle{
        id:backgroundImgSlider
        visible: false
        Behavior on visible{NumberAnimation{duration:1200;easing.type: Easing.OutQuint}}
        opacity:status === Rectangle.Ready ? 1:0
        Behavior on opacity {NumberAnimation{from: 0 ;to: 1; duration:1200 }}
        height: parent.height / 8
        width: parent.height / 2
        radius: 8
        border.color: "#55FFFFFF"
        border.width: 1
        gradient: Gradient {
            GradientStop { position: 0; color: "#88000000"}
            GradientStop { position: 0.5; color: "#44808080"}
            GradientStop { position: 1; color: "#88000000"}
        }
        anchors{
            right: parent.right
            top: parent.top
            topMargin: parent.height / 6
        }
        Text{
            id:backgroundImgTxt
            text:u2d.tr("  Change Background")
            color: "white"
            smooth: true
            anchors{
                verticalCenter: backgroundImgSlider.verticalCenter
                left:  backgroundImgSlider.left

            }
        }
    }
    Rectangle{
        id: backgroundImgButtonRec
        height: parent.height / 8 //6.5
        width: parent.height / 8 //6.5
        radius: 0
        border.color: "#55FFFFFF"
        border.width: 1
        gradient: Gradient {
            GradientStop { position: 0; color: "#12000000"}
            GradientStop { position: 0.5; color: "#44808080"}
            GradientStop { position: 1; color: "#12000000"}
        }
        x: parent.width / 1.08
        anchors{
            top: parent.top
            topMargin: parent.height / 6
        }MouseArea{
            anchors.fill: backgroundImgButtonRec
            hoverEnabled: true
            onEntered: {
                backgroundImgSlider.visible = true
                dotsGrid.visible = false
                topBar.visible = false
                signInAreaRec.visible = false
                signInIconRec.visible = false
                signInIcon.visible = false
                userNameSignin.visible = false
                passwordBox.visible = false
                passwordText.visible = false
                guestText.visible = false
                bottomIcon.visible = false
            }
            onExited:{
                backgroundImgSlider.visible = false
                dotsGrid.visible = true
                topBar.visible = true
                signInAreaRec.visible = true
                signInIconRec.visible = true
                signInIcon.visible = true
                userNameSignin.visible = true
                passwordBox.visible = true
                passwordText.visible = true
                guestText.visible = true
                bottomIcon.visible = true
            }
            onClicked: {
                backgroundHelpBkg.scale = 1
                backgroundHelpBkg.opacity = 1

                hideSideBar.visible = false
                mainBackground.visible = false
                hideMeRec.visible = false
                backToMenu.visible = true
            }
        }
        Image{
            id: backgroundImgButton
            source:{
                var filename = lightDmConfiguration.background
                if(filename === "/usr/share/backgrounds/warty-final-ubuntu.png"){
                    filename = "../component/gfx/workaroundWarty.jpg"
                    return filename
                }
                else if (lightDmConfiguration.background !== "/usr/share/backgrounds/warty-final-ubuntu.png")
                    (lightDmConfiguration.background)
            }
            anchors{
                fill:backgroundImgButtonRec
                margins: 10
            }

        }

    }








    Rectangle{
        id:dotsImgSlider
        visible: false
        Behavior on visible{NumberAnimation{duration:1200;easing.type: Easing.OutQuint}}
        opacity:status === Rectangle.Ready ? 1:0
        Behavior on opacity {NumberAnimation{from: 0 ;to: 1; duration:1200 }}
        height: parent.height / 8
        width: parent.height / 2
        radius: 8
        border.color: "#55FFFFFF"
        border.width: 1
        gradient: Gradient {
            GradientStop { position: 0; color: "#88000000"}
            GradientStop { position: 0.5; color: "#44808080"}
            GradientStop { position: 1; color: "#88000000"}
        }
        anchors{
            right: parent.right
            top: parent.top
            topMargin: parent.height / 3.30
        }
        Text{
            id:dotsImgTxt
            text:u2d.tr("  Remove The Dots")
            color: "white"
            smooth: true
            anchors{
                verticalCenter: dotsImgSlider.verticalCenter
                left:  dotsImgSlider.left

            }
        }
    }
    Rectangle{
        id: dotsImgButtonRec
        height: parent.height / 8 //6.5
        width: parent.height / 8 //6.5
        radius: 0
        border.color: "#55FFFFFF"
        border.width: 1
        gradient: Gradient {
            GradientStop { position: 0; color: "#12000000"}
            GradientStop { position: 0.5; color: "#44808080"}
            GradientStop { position: 1; color: "#12000000"}
        }
        x: parent.width / 1.08
        anchors{
            top: parent.top
            topMargin: parent.height / 3.30
        }MouseArea{
            anchors.fill: dotsImgButtonRec
            hoverEnabled: true
            onEntered: {
                dotsImgSlider.visible = true
                mainBackground.visible = false
                topBar.visible = false
                signInAreaRec.visible = false
                signInIconRec.visible = false
                signInIcon.visible = false
                userNameSignin.visible = false
                passwordBox.visible = false
                passwordText.visible = false
                guestText.visible = false
                bottomIcon.visible = false
                if (lightDmConfiguration.drawGrid === false)
                    dotsGrid.visible = false
                else
                    dotsGrid.visible = true

            }

            onExited:{
                dotsImgSlider.visible = false
                topBar.visible = true
                signInAreaRec.visible = true
                signInIconRec.visible = true
                signInIcon.visible = true
                userNameSignin.visible = true
                passwordBox.visible = true
                passwordText.visible = true
                guestText.visible = true
                bottomIcon.visible = true
                if (backToMenu.visible === false)
                    mainBackground.visible = true
                else
                    mainBackground.visible = false

                if (lightDmConfiguration.drawGrid === true)
                    dotsGrid.visible = true
                else
                    dotsGrid.visible = false

            }
            onClicked: {
                dotsHelpBkg.scale = 1
                dotsHelpBkg.opacity = 1
                hideSideBar.visible = false

                mainBackground.visible = false
                hideMeRec.visible = false
                backToMenu.visible = true
            }
        }
        Image{
            id: dotsImgButton
            source: "../../../dash/artwork/emblem-system-symbolic.png"
            smooth: true
            anchors{
                fill:dotsImgButtonRec
                margins: 10
            }

        }
    }
    ///////////////////
    Rectangle{
        id:colorImgSlider
        visible: false
        Behavior on visible{NumberAnimation{duration:1200;easing.type: Easing.OutQuint}}
        opacity:status === Rectangle.Ready ? 1:0
        Behavior on opacity {NumberAnimation{from: 0 ;to: 1; duration:1200 }}
        height: parent.height / 8
        width: parent.height / 2
        radius: 8
        border.color: "#55FFFFFF"
        border.width: 1
        gradient: Gradient {
            GradientStop { position: 0; color: "#88000000"}
            GradientStop { position: 0.5; color: "#44808080"}
            GradientStop { position: 1; color: "#88000000"}
        }
        anchors{
            right: parent.right
            top: parent.top
            topMargin: parent.height / 2.30
        }
        Text{
            id:colorImgTxt
            text:u2d.tr("  Change Colors")
            color: "white"
            smooth: true
            anchors{
                verticalCenter: colorImgSlider.verticalCenter
                left:  colorImgSlider.left

            }
        }
    }
    Rectangle{
        id: colorImgButtonRec
        height: parent.height / 8 //6.5
        width: parent.height / 8 //6.5
        radius: 0
        border.color: "#55FFFFFF"
        border.width: 1
        gradient: Gradient {
            GradientStop { position: 0; color: "#12000000"}
            GradientStop { position: 0.5; color: "#44808080"}
            GradientStop { position: 1; color: "#12000000"}
        }
        x: parent.width / 1.08
        anchors{
            top: parent.top
            topMargin: parent.height / 2.30
        }MouseArea{
            anchors.fill: colorImgButtonRec
            hoverEnabled: true
            onEntered: {
                colorImgSlider.visible = true
                mainBackground.visible = false
                topBar.visible = true
                signInAreaRec.visible = true
                signInIconRec.visible = false
                signInIcon.visible = false
                userNameSignin.visible = false
                passwordBox.visible = false
                passwordText.visible = false
                guestText.visible = false
                bottomIcon.visible = false
                dotsGrid.visible = false


            }

            onExited:{
                colorImgSlider.visible = false
                topBar.visible = true
                signInAreaRec.visible = true
                signInIconRec.visible = true
                signInIcon.visible = true
                userNameSignin.visible = true
                passwordBox.visible = true
                passwordText.visible = true
                guestText.visible = true
                bottomIcon.visible = true
                if (backToMenu.visible === false)
                    mainBackground.visible = true
                else
                    mainBackground.visible = false

                if (lightDmConfiguration.drawGrid === true)
                    dotsGrid.visible = true
                else
                    dotsGrid.visible = false

            }
            onClicked: {
                colorsHelpBkg.scale = 1
                colorsHelpBkg.opacity = 1
                hideSideBar.visible = false

                mainBackground.visible = false
                hideMeRec.visible = false
                backToMenu.visible = true
            }
        }
        Rectangle{
            id: colorImgButton
            color: (lightDmConfiguration.backgroundColor)
            anchors{
                fill:colorImgButtonRec
                margins: 10
            }
        }
    }





    //////////////////////////////////////////////

    Rectangle{
        id:iconsImgSlider
        visible: false
        Behavior on visible{NumberAnimation{duration:1200;easing.type: Easing.OutQuint}}
        opacity:status === Rectangle.Ready ? 1:0
        Behavior on opacity {NumberAnimation{from: 0 ;to: 1; duration:1200 }}
        height: parent.height / 8
        width: parent.height / 2
        radius: 8
        border.color: "#55FFFFFF"
        border.width: 1
        gradient: Gradient {
            GradientStop { position: 0; color: "#88000000"}
            GradientStop { position: 0.5; color: "#44808080"}
            GradientStop { position: 1; color: "#88000000"}
        }
        anchors{
            right: parent.right
            top: parent.top
            topMargin: parent.height / 1.76
        }
        Text{
            id:iconsImgTxt
            text:u2d.tr("  Change Icons")
            color: "white"
            smooth: true
            anchors{
                verticalCenter: iconsImgSlider.verticalCenter
                left:  iconsImgSlider.left

            }
        }
    }
    Rectangle{
        id: iconsImgButtonRec
        height: parent.height / 8 //6.5
        width: parent.height / 8 //6.5
        radius: 0
        border.color: "#55FFFFFF"
        border.width: 1
        gradient: Gradient {
            GradientStop { position: 0; color: "#12000000"}
            GradientStop { position: 0.5; color: "#44808080"}
            GradientStop { position: 1; color: "#12000000"}
        }
        x: parent.width / 1.08
        anchors{
            top: parent.top
            topMargin: parent.height / 1.76
        }MouseArea{
            anchors.fill: iconsImgButtonRec
            hoverEnabled: true
            onEntered: {
                iconsImgSlider.visible = true
                mainBackground.visible = false
                topBar.visible = false
                signInAreaRec.visible = false
                signInIconRec.visible = true
                signInIcon.visible = true
                signInIconRec.scale = 1
                signInIcon.scale = 1
                userNameSignin.visible = false
                passwordBox.visible = false
                passwordText.visible = false
                guestText.visible = false
                bottomIcon.visible = true
                bottomIcon.scale = true
                dotsGrid.visible = false


            }
            onExited:{
                iconsImgSlider.visible = false
                topBar.visible = true
                signInAreaRec.visible = true
                signInIconRec.visible = true
                signInIcon.visible = true
                signInIcon.scale = 1
                userNameSignin.visible = true
                passwordBox.visible = true
                passwordText.visible = true
                guestText.visible = true
                bottomIcon.visible = true
                bottomIcon.scale = 1

                if (backToMenu.visible === false)
                    mainBackground.visible = true
                else
                    mainBackground.visible = false

                if (lightDmConfiguration.drawGrid === true)
                    dotsGrid.visible = true
                else
                    dotsGrid.visible = false

            }
            onClicked: {
                iconsHelpBkg.scale = 1
                iconsHelpBkg.opacity = 1
                hideSideBar.visible = false

                mainBackground.visible = false
                hideMeRec.visible = false
                backToMenu.visible = true
            }
        }
        Image{
            id: iconsImgButton
            source: lightDmConfiguration.backgroundLogo
            smooth: true
            anchors{
                fill:iconsImgButtonRec
                margins: 10
            }
        }
    }
    //////////////////////////////


    Rectangle{
        id:uvaImgSlider
        visible: false
        Behavior on visible{NumberAnimation{duration:1200;easing.type: Easing.OutQuint}}
        opacity:status === Rectangle.Ready ? 1:0
        Behavior on opacity {NumberAnimation{from: 0 ;to: 1; duration:1200 }}
        height: parent.height / 8
        width: parent.height / 2
        radius: 8
        border.color: "#55FFFFFF"
        border.width: 1
        gradient: Gradient {
            GradientStop { position: 0; color: "#88000000"}
            GradientStop { position: 0.5; color: "#44808080"}
            GradientStop { position: 1; color: "#88000000"}
        }
        anchors{
            right: parent.right
            top: parent.top
            topMargin: parent.height / 1.42
        }
        Text{
            id:uvaImgTxt
            text:u2d.tr("  Universal Access")
            color: "white"
            smooth: true
            anchors{
                verticalCenter: uvaImgSlider.verticalCenter
                left:  uvaImgSlider.left

            }
        }
    }
    Rectangle{
        id: uvaImgButtonRec
        height: parent.height / 8 //6.5
        width: parent.height / 8 //6.5
        radius: 0
        border.color: "#55FFFFFF"
        border.width: 1
        gradient: Gradient {
            GradientStop { position: 0; color: "#12000000"}
            GradientStop { position: 0.5; color: "#44808080"}
            GradientStop { position: 1; color: "#12000000"}
        }
        x: parent.width / 1.08
        anchors{
            top: parent.top
            topMargin: parent.height / 1.42
        }MouseArea{
            anchors.fill: uvaImgButtonRec
            hoverEnabled: true
            onEntered: {
                uvaImgSlider.visible = true
            }
            onExited:{
                uvaImgSlider.visible = false
                topBar.visible = true
                signInAreaRec.visible = true
                signInIconRec.visible = true
                signInIcon.visible = true
                userNameSignin.visible = true
                passwordBox.visible = true
                passwordText.visible = true
                guestText.visible = true
                bottomIcon.visible = true
                if (backToMenu.visible === false)
                    mainBackground.visible = true
                else
                    mainBackground.visible = false

                if (lightDmConfiguration.drawGrid === true)
                    dotsGrid.visible = true
                else
                    dotsGrid.visible = false

            }
            onClicked: {
                universalAHelpBkg.scale = 1
                universalAHelpBkg.opacity = 1
                hideSideBar.visible = false
                mainBackground.visible = false
                hideMeRec.visible = false
                backToMenu.visible = true
            }
        }
        Image{
            id: uvaImgButton
            source: "/usr/share/unity-greeter/a11y.svg"
            smooth: true
            anchors{
                fill:uvaImgButtonRec
                margins: 10
            }
        }
    }
}//hideSideBar

    //**************************
    //    Start Back to main Menu
    //***************************
    Image {
        visible: false
        id: backToMenu
        source: "../../../artwork/cross.png"
        anchors{
            left: parent.left
            leftMargin: parent.width / 3.98
            top: parent.top
        }
    }MouseArea{
        width: backToMenu.width
        height: backToMenu.height
        anchors.fill: backToMenu
        onClicked:{
            backToMenu.visible = false
            mainBackground.visible = true
            hideMeRec.visible = true
            hideSideBar.x = 1
            hideSideBar.visible = true
            dotsHelpBkg.opacity = 0
            backgroundHelpBkg.opacity = 0
            colorsHelpBkg.opacity = 0
            iconsHelpBkg.opacity = 0
            universalAHelpBkg.opacity = 0
        }
    }



    //    **************************
    //          Start Options
    //    **************************

    //Change the Background
    Rectangle {
        id: backgroundHelpBkg
        width: if (unity2dConfiguration.formFactor === "tv" )
                   parent.width / 1.38
               else
                   parent.width / 1.35
        height: parent.height
        border.color: "#49000000"
        border.width: 20
        radius: 0
        gradient: Gradient {
            GradientStop { position: 1; color: "#99000000"}
            GradientStop { position: 0; color: "#88000000"}

        }
        anchors{
            left: parent.left
            leftMargin: parent.width / 3.98
        }
        scale: 0
        Behavior on scale {NumberAnimation{from: 0;to: .88; duration: 900;easing.type: Easing.OutCirc}}
//        Particles {
//            y: 0
//            width: parent.width / 1.4
//            opacity: .22
//            height: parent.height
//            source: "../component/gfx/oneDot.png"
//            lifeSpan: 15700
//            count: 200
//            angle: 90
//            angleDeviation: 36
//            velocity: 30
//            velocityDeviation: 10
//            ParticleMotionWander {
//                xvariance: 30
//                pace: 1000
//            }
//        }
//        Particles {
//            opacity: .22
//            width: 1
//            height: 1
//            source: "../component/gfx/oneDot.png"
//            lifeSpan: 3500
//            count: 250
//            angle: 270
//            angleDeviation: 45
//            velocity: 50
//            velocityDeviation: 30
//            anchors{
//                top:parent.top
//                left: parent.left
//            }
//            ParticleMotionGravity {
//                yattractor: 1000
//                xattractor: 20
//                acceleration: 25
//            }
//        }
//        Particles {
//            opacity: .22
//            width: 1
//            height: 1
//            source: "../component/gfx/oneDot.png"
//            lifeSpan: 3500
//            count: 250
//            angle: 270
//            angleDeviation: 45
//            velocity: 50
//            velocityDeviation: 30
//            anchors{
//                top:parent.top
//                left: parent.left
//                leftMargin: parent.width / 2
//            }
//            ParticleMotionGravity {
//                yattractor: 1000
//                xattractor: 20
//                acceleration: 25
//            }
//        }
//        Particles {
//            opacity: .22
//            width: 1
//            height: 1
//            source: "../component/gfx/oneDot.png"
//            lifeSpan: 3500
//            count: 250
//            angle: 270
//            angleDeviation: 45
//            velocity: 50
//            velocityDeviation: 30
//            anchors{
//                top:parent.top
//                right: parent.right
//            }
//            ParticleMotionGravity {
//                yattractor: 1000
//                xattractor: 20
//                acceleration: 25
//            }
//        }

        Text {
            id:backgroundHelpDesription
            text: u2d.tr("Change the image that LightDm is using for a background. This Can either be a file on your computer \n\n"
                         + "\t \t example:  /home/user/Pictures/background.png \n\n"
                         + "Or If one Likes they may enter a color.\n\n"
                         + "\t \t example: #772953")
            wrapMode: Text.WordWrap
            width: backgroundHelpBkg.width / 1.2
            height: backgroundHelpBkg.height / 1.2
            smooth: true
            font.pixelSize: parent.width / 44
            color: "white"
            anchors{
                horizontalCenter: backgroundHelpBkg.horizontalCenter
                top: backgroundHelpBkg.top
                topMargin: backgroundHelpBkg.height /5
            }
        }
        Text {
            text: u2d.tr("Change The Background")
            color: "white"
            font.pixelSize: parent.width / 33
            anchors{
                bottom: backgroundHelpDesription.top
                bottomMargin: 30
                horizontalCenter: backgroundHelpDesription.horizontalCenter
            }
        }
        Rectangle{
            id: backgroundHelpOptionButtonRec
            height: parent.height / 12
            width: parent.width / 1.2
            radius: 0
            border.color: "#55FFFFFF"
            border.width: 0
            gradient: Gradient {
                GradientStop { position: 0; color: "#66FFFFFF"}
                GradientStop { position: 0.8; color: "#44808080"}
                GradientStop { position: 1; color: "#66808080"}
            }
            anchors{
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: parent.height / 4
            }
            MouseArea{
                anchors.fill: backgroundHelpOptionButtonRec
                hoverEnabled: true
                onEntered: backgroundHelpOptionButtonRec.border.width = 7
                onExited: backgroundHelpOptionButtonRec.border.width = 0
            }
            TextInput{
                id: backgroundHelpOptionButton
                height: backgroundHelpOptionButtonRec.height / 1.4
                color:"white"
                font.pixelSize: parent.height / 2
                smooth: true
                text: (lightDmConfiguration.background)
                onAccepted:{
                    lightDmConfiguration.background = backgroundHelpOptionButton.text
                    backgroundHelpOptionButton.focus = false

                }
                anchors{
                    bottom: backgroundHelpOptionButtonRec.bottom
                    horizontalCenter: parent.horizontalCenter
                }
            }
        }//optionsBox
        GlowButton{
            text: "Set To Default"
            height: parent.height / 12
            width: parent.width / 2
            onClicked: lightDmConfiguration.background = "/usr/share/backgrounds/warty-final-ubuntu.png"
            anchors{
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: parent.height / 10
            }
        }
    }//backgroundHelpDesription




    Rectangle {
        id: dotsHelpBkg
        width: if (unity2dConfiguration.formFactor === "tv" )
                   parent.width / 1.38
               else
                   parent.width / 1.35
        height: parent.height
        border.color: "#49000000"
        border.width: 20
        radius: 0
        gradient: Gradient {
            GradientStop { position: 1; color: "#99000000"}
            GradientStop { position: 0; color: "#88000000"}

        }
        anchors{
            left: parent.left
            leftMargin: parent.width / 3.98
        }
        scale: 0
        Behavior on scale {NumberAnimation{from: 0;to: .88; duration: 900;easing.type: Easing.OutCirc}}
        Text {
            id:dotsHelpDesription
            text: u2d.tr("Would You Like to remove the Dots ?")
            wrapMode: Text.WordWrap
            width: dotsHelpBkg.width / 1.2
            height: dotsHelpBkg.height / 1.2
            smooth: true
            font.pixelSize: parent.width / 44
            color: "white"
            anchors{
                horizontalCenter: dotsHelpBkg.horizontalCenter
                top: dotsHelpBkg.top
                topMargin: dotsHelpBkg.height /5
            }
        }Text {
            text: u2d.tr("Remove the Grid Dots")
            color: "white"
            font.pixelSize: parent.width / 33
            anchors{
                bottom: dotsHelpDesription.top
                bottomMargin: 30
                horizontalCenter: dotsHelpDesription.horizontalCenter
            }
        }
        Column {
            height: parent.height
            width: parent.width
            spacing: parent.width / 80
            anchors{
                left: parent.left
                leftMargin:  parent.width / 4
                top: parent.top
                topMargin: parent.height / 2
            }
            GlowButton{
                text: u2d.tr("Yes")
                height: parent.height / 12
                width: parent.width / 2
                onClicked: lightDmConfiguration.drawGrid = false

            }
            GlowButton{
                text: u2d.tr("No")
                height: parent.height / 12
                width: parent.width / 2
                onClicked: lightDmConfiguration.drawGrid = true


            }
            GlowButton{
                text: "Set To Default"
                height: parent.height / 12
                width: parent.width / 2
                onClicked: lightDmConfiguration.drawGrid = true

            }
        }//Row
    }//dotsHelpDesription


    //Change the colors
    Rectangle {
        id: colorsHelpBkg
        width: if (unity2dConfiguration.formFactor === "tv" )
                   parent.width / 1.38
               else
                   parent.width / 1.35
        height: parent.height
        border.color: "#49000000"
        border.width: 20
        radius: 0
        gradient: Gradient {
            GradientStop { position: 1; color: "#99000000"}
            GradientStop { position: 0; color: "#88000000"}

        }
        anchors{
            left: parent.left
            leftMargin: parent.width / 3.98
        }
        scale: 0
        Behavior on scale {NumberAnimation{from: 0;to: .88; duration: 900;easing.type: Easing.OutCirc}}
        Text {
            id:colorsHelpDesription
            text: u2d.tr("Change the color that LightDm use's for a sign in box and top panel.\n\n"
                         + "\t \t example: #772953 \n \n "
                         + "Imporant this is set before wallpaper is seen. \n \n"
                         + "Right Now your current Color is")
            wrapMode: Text.WordWrap
            width: colorsHelpBkg.width / 1.2
            height: colorsHelpBkg.height / 1.2
            smooth: true
            font.pixelSize: parent.width / 44
            color: "white"
            anchors{
                horizontalCenter: colorsHelpBkg.horizontalCenter
                top: colorsHelpBkg.top
                topMargin: colorsHelpBkg.height /5
            }
        }
        Text {
            text: u2d.tr("Change The Color")
            color: "white"
            font.pixelSize: parent.width / 33
            anchors{
                bottom: colorsHelpDesription.top
                bottomMargin: 30
                horizontalCenter: colorsHelpDesription.horizontalCenter
            }
        }
        Rectangle{
            id: currentColorImgButton
            height: parent.height / 9
            width: parent.width / 3
            color: "transparent"
            border.color:  "#55FFFFFF"
            border.width: 1
            anchors{
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: parent.height / 2.88
            }
        }
        Rectangle{
            id: currentColorImg
            color: lightDmConfiguration.backgroundColor
            anchors{
                fill:currentColorImgButton
                margins: 10
            }
        }
        Rectangle{
            id: colorsHelpOptionButtonRec
            height: parent.height / 12
            width: parent.width / 1.2
            radius: 0
            border.color: "#55FFFFFF"
            border.width: 0
            gradient: Gradient {
                GradientStop { position: 0; color: "#66FFFFFF"}
                GradientStop { position: 0.8; color: "#44808080"}
                GradientStop { position: 1; color: "#66808080"}
            }
            anchors{
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: parent.height / 4
            }
            MouseArea{
                anchors.fill: colorsHelpOptionButtonRec
                hoverEnabled: true
                onEntered: colorsHelpOptionButtonRec.border.width = 7
                onExited: colorsHelpOptionButtonRec.border.width = 0
            }
            TextInput{
                id: colorsHelpOptionButton
                height: colorsHelpOptionButtonRec.height / 1.4
                color:"white"
                font.pixelSize: parent.height / 2
                smooth: true
                text: (lightDmConfiguration.backgroundColor)
                onAccepted:{
                    lightDmConfiguration.backgroundColor = colorsHelpOptionButton.text
                    colorsHelpOptionButton.focus = false

                }
                anchors{
                    bottom: colorsHelpOptionButtonRec.bottom
                    horizontalCenter: parent.horizontalCenter
                }
            }
        }//optionsBox
        GlowButton{
            text: "Set To Default"
            height: parent.height / 12
            width: parent.width / 2
            onClicked: lightDmConfiguration.backgroundColor = "#2C001E"
            anchors{
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: parent.height / 10
            }
        }
    }//colorsHelpDesription

    //Change the icons
    Rectangle {
        id: iconsHelpBkg
        width: if (unity2dConfiguration.formFactor === "tv" )
                   parent.width / 1.38
               else
                   parent.width / 1.35
        height: parent.height
        border.color: "#49000000"
        border.width: 20
        radius: 0
        gradient: Gradient {
            GradientStop { position: 1; color: "#99000000"}
            GradientStop { position: 0; color: "#88000000"}

        }
        anchors{
            left: parent.left
            leftMargin: parent.width / 3.98
        }
        scale: 0
        Behavior on scale {NumberAnimation{from: 0;to: .88; duration: 900;easing.type: Easing.OutCirc}}
        Text {
            id:iconsHelpDesription
            text: u2d.tr("Change the image that LightDm is using for its two icons.\n\n"
                         + "\t \t example:  /home/user/Pictures/icons.png \n\n")
            wrapMode: Text.WordWrap
            width: iconsHelpBkg.width / 1.2
            height: iconsHelpBkg.height / 1.2
            smooth: true
            font.pixelSize: parent.width / 44
            color: "white"
            anchors{
                horizontalCenter: iconsHelpBkg.horizontalCenter
                top: iconsHelpBkg.top
                topMargin: iconsHelpBkg.height /5
            }
        }
        Text {
            text: u2d.tr("Change The Icons")
            color: "white"
            font.pixelSize: parent.width / 33
            anchors{
                bottom: iconsHelpDesription.top
                bottomMargin: 30
                horizontalCenter: iconsHelpDesription.horizontalCenter
            }
        }


        Text{
            text: u2d.tr("Sign In Icon:   ")
            color:"white"
            font.pixelSize: parent.width / 44
            anchors{
                left: parent.left
                leftMargin: parent.width / 50
                bottom: parent.bottom
                bottomMargin: parent.height / 1.75
            }
        }
        Rectangle{
            id: iconsSignHelpOptionButtonRec
            height: parent.height / 12
            width: parent.width / 1.6
            radius: 0
            border.color: "#55FFFFFF"
            border.width: 0
            gradient: Gradient {
                GradientStop { position: 0; color: "#66FFFFFF"}
                GradientStop { position: 0.8; color: "#44808080"}
                GradientStop { position: 1; color: "#66808080"}
            }
            anchors{
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: parent.height / 1.8
            }
            MouseArea{
                anchors.fill: iconsSignHelpOptionButtonRec
                hoverEnabled: true
                onEntered: iconsSignHelpOptionButtonRec.border.width = 7
                onExited: iconsSignHelpOptionButtonRec.border.width = 0
            }
            TextInput{
                id: iconsSignHelpOptionButton
                height: iconsSignHelpOptionButtonRec.height / 1.4
                color:"white"
                font.pixelSize: parent.height / 2
                smooth: true
                text: (lightDmConfiguration.backgroundLogo)
                onAccepted:{
                    lightDmConfiguration.backgroundLogo = iconsSignHelpOptionButton.text
                    iconsSignHelpOptionButton.focus = false

                }
                anchors{
                    bottom: iconsSignHelpOptionButtonRec.bottom
                    horizontalCenter: parent.horizontalCenter
                }
            }
        }//optionsBox
        GlowButton{

            text: "Set To Default"
            height: parent.height / 12
            width: parent.width / 2
            onClicked: lightDmConfiguration.backgroundLogo = "/usr/share/unity-greeter/cof.png"
            anchors{
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: parent.height / 2.2
            }
        }

        Text{
            text: u2d.tr("Bottom Icon:   ")
            color:"white"
            font.pixelSize: parent.width / 44
            anchors{
                left: parent.left
                leftMargin:  parent.width / 50
                bottom: parent.bottom
                bottomMargin: parent.height / 4
            }
        }
        Rectangle{
            id: iconsHelpOptionButtonRec
            height: parent.height / 12
            width: parent.width / 1.6
            radius: 0
            border.color: "#55FFFFFF"
            border.width: 0
            gradient: Gradient {
                GradientStop { position: 0; color: "#66FFFFFF"}
                GradientStop { position: 0.8; color: "#44808080"}
                GradientStop { position: 1; color: "#66808080"}
            }
            anchors{
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: parent.height / 4.49
            }
            MouseArea{
                anchors.fill: iconsHelpOptionButtonRec
                hoverEnabled: true
                onEntered: iconsHelpOptionButtonRec.border.width = 7
                onExited: iconsHelpOptionButtonRec.border.width = 0
            }
            TextInput{
                id: iconsHelpOptionButton
                height: iconsHelpOptionButtonRec.height / 1.4
                color:"white"
                font.pixelSize: parent.height / 2
                smooth: true
                text: (lightDmConfiguration.logo)
                onAccepted:{
                    lightDmConfiguration.logo = iconsHelpOptionButton.text
                    iconsHelpOptionButton.focus = false

                }
                anchors{
                    bottom: iconsHelpOptionButtonRec.bottom
                    horizontalCenter: parent.horizontalCenter
                }
            }
        }//optionsBox
        GlowButton{
            text: "Set To Default"
            height: parent.height / 12
            width: parent.width / 2
            onClicked: lightDmConfiguration.Logo = "/usr/share/unity-greeter/logo.png"
            anchors{
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: parent.height / 9
            }
        }
    }//iconsHelpDesription
    ///////////////////////////////////////////////////////
    //Change the universalA
    Rectangle {
        id: universalAHelpBkg
        width: if (unity2dConfiguration.formFactor === "tv" )
                   parent.width / 1.38
               else
                   parent.width / 1.35
        height: parent.height
        border.color: "#49000000"
        border.width: 20
        radius: 0
        gradient: Gradient {
            GradientStop { position: 1; color: "#99000000"}
            GradientStop { position: 0; color: "#88000000"}

        }
        anchors{
            left: parent.left
            leftMargin: parent.width / 3.98
        }
        scale: 0
        Behavior on scale {NumberAnimation{from: 0;to: .88; duration: 900;easing.type: Easing.OutCirc}}
        Text{
            text: u2d.tr("Universal Access")
            color: "white"
            font.pixelSize: parent.height / 15
            anchors{
                left: parent.left
                leftMargin: parent.width / 50
                top: parent.top
                topMargin: parent.width / 60
            }
        }

        //universalAcc Options
        Column{
            id:mainuniversalAccColumn
            spacing: parent.height / 120
            width: parent.width / 1.022
            height: parent.height
            anchors{
                horizontalCenter: parent.horizontalCenter
                top: universalAHelpBkg.top
                topMargin: parent.height / 9

            }

            Rectangle{
                id:universalAccRec
                width: parent.width
                //                Behavior on width {NumberAnimation{from: 0; to: parent.width / 2.022 ;duration: 1200;easing.type: Easing.OutQuint}}
                height: parent.height / 8
                border.color: "#55FFFFFF"
                border.width: 1
                gradient: Gradient {
                    GradientStop { position: 0; color: "#42FFFFFF"}
                    GradientStop { position: 0.5; color: "#66808080"}
                    GradientStop { position: 1; color: "#42FFFFFF"}

                }
                MouseArea{
                    anchors.fill: universalAccRec
                    hoverEnabled: true
                    onEntered: {
                        onboardImg.opacity = 1
                        onboardImg.visible = true
                    }
                    onExited: {
                        onboardImg.opacity = 0
                        onboardImg.visible = false
                    }
                }
                Text {
                    font.pixelSize: 18
                    color: "white"
                    text: u2d.tr("Use On-Screen Keyboard:")
                    anchors{
                        verticalCenter: universalAccRec.verticalCenter
                        left: universalAccRec.left
                        leftMargin: universalAccRec.width / 20
                    }
                }
                Image{
                    id: universalAccIconButtonRec
                    source: "../../../artwork/tick_box.png"
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 12.5
                        verticalCenter: universalAccRec.verticalCenter
                    }
                    Image{
                        id:universalAccIconButton
                        visible: if(lightDmConfiguration.onscreenKeyboard === true)
                                     true
                                 else
                                     false
                        source: "../../../artwork/tick.png"
                        scale: 1.5
                        smooth: true
                        anchors{
                            right: parent.right
                            rightMargin: parent.width / 12.5
                            verticalCenter: universalAccIconButtonRec.verticalCenter
                        }
                    }MouseArea{
                        anchors.fill:universalAccIconButton
                        onClicked: if (lightDmConfiguration.onscreenKeyboard === true)
                                       lightDmConfiguration.onscreenKeyboard = false
                                   else if (lightDmConfiguration.onscreenKeyboard === false)
                                       lightDmConfiguration.onscreenKeyboard = true
                    }
                }
            }

            //////////////////////////////////////////////////////
            Rectangle{
                id:bangTheDrumsRec
                width: parent.width
                //                Behavior on width {NumberAnimation{from: 0; to: parent.width / 1.022 ;duration: 1300;easing.type: Easing.OutQuint}}
                height: parent.height / 8
                border.color: "#55FFFFFF"
                border.width: 1
                gradient: Gradient {
                    GradientStop { position: 0; color: "#42FFFFFF"}
                    GradientStop { position: 0.5; color: "#66808080"}
                    GradientStop { position: 1; color: "#42FFFFFF"}

                }
                MouseArea{
                    anchors.fill: bangTheDrumsRec
                    hoverEnabled: true
                    onEntered: {
                        drumsTxtBottom.opacity  = 1
                        drumsTxtBottom.visible = true
                    }
                    onExited: {
                        drumsTxtBottom.opacity = 0
                        drumsTxtBottom.visible = false
                    }
                }
                Text {
                    font.pixelSize: 18
                    color: "white"
                    text: u2d.tr("Play The Drums ?:")
                    anchors{
                        verticalCenter: bangTheDrumsRec.verticalCenter
                        left: bangTheDrumsRec.left
                        leftMargin: bangTheDrumsRec.width / 20
                    }
                }
                Image{
                    id: bangTheDrumsIconButtonRec
                    source: "../../../artwork/tick_box.png"
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 12.5
                        verticalCenter: bangTheDrumsRec.verticalCenter
                    }
                    Image{
                        id:bangTheDrumsIconButton
                        source: "../../../artwork/tick.png"
                        visible: if(lightDmConfiguration.playReadySound === true)
                                     true
                                 else
                                     false
                        scale: 1.5
                        smooth: true
                        anchors{
                            right: parent.right
                            rightMargin: parent.width / 12.5
                            verticalCenter: bangTheDrumsIconButtonRec.verticalCenter
                        }
                    }MouseArea{
                        anchors.fill:bangTheDrumsIconButton
                        onClicked: if (lightDmConfiguration.playReadySound === true)
                                       lightDmConfiguration.playReadySound = false
                                   else if (lightDmConfiguration.playReadySound === false)
                                       lightDmConfiguration.playReadySound = true
                    }
                }
            }

            //////////////////////////////////////////////////////////////
            Rectangle{
                id:screenReaderRec
                width: parent.width
                //                Behavior on width {NumberAnimation{from: 0; to: parent.width /1.022 ;duration: 1400;easing.type: Easing.OutQuint}}
                height: parent.height / 8
                border.color: "#55FFFFFF"
                border.width: 1
                gradient: Gradient {
                    GradientStop { position: 0; color: "#42FFFFFF"}
                    GradientStop { position: 0.5; color: "#66808080"}
                    GradientStop { position: 1; color: "#42FFFFFF"}

                }
                MouseArea{
                    anchors.fill: screenReaderRec
                    hoverEnabled: true
                    onEntered:{
                        orcaTxtBottom.opacity = 1
                        orcaTxtBottom.visible = true
                    }
                    onExited: {
                        orcaTxtBottom.opacity = 0
                        orcaTxtBottom.visible = false
                    }
                }
                Text {
                    font.pixelSize: 18
                    color: "white"
                    text: u2d.tr("Use the Screen Reader ?")
                    anchors{
                        verticalCenter: screenReaderRec.verticalCenter
                        left: screenReaderRec.left
                        leftMargin: screenReaderRec.width / 20
                    }
                }
                Image{
                    id: screenReaderIconButtonRec
                    source: "../../../artwork/tick_box.png"
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 12.5
                        verticalCenter: screenReaderRec.verticalCenter
                    }
                    Image{
                        id:screenReaderIconButton
                        source: "../../../artwork/tick.png"
                        visible: if(lightDmConfiguration.screenReader === true)
                                     true
                                 else
                                     false
                        scale: 1.5
                        smooth: true
                        anchors{
                            right: parent.right
                            rightMargin: parent.width / 12.5
                            verticalCenter: screenReaderIconButtonRec.verticalCenter
                        }
                    }MouseArea{
                        anchors.fill:screenReaderIconButton
                        onClicked: if (lightDmConfiguration.screenReader === true)
                                       lightDmConfiguration.screenReader = false
                                   else if (lightDmConfiguration.screenReader === false)
                                       lightDmConfiguration.screenReader = true
                    }
                }
            }
            ////////////////////////////////////////////////////////////////////
            Rectangle{
                id:highContrastRec
                width: parent.width
                //                Behavior on width {NumberAnimation{from: 0; to:parent.width / 1.022;duration: 1400;easing.type: Easing.OutQuint}}
                height: parent.height / 8
                border.color: "#55FFFFFF"
                border.width: 1
                gradient: Gradient {
                    GradientStop { position: 0; color: "#42FFFFFF"}
                    GradientStop { position: 0.5; color: "#66808080"}
                    GradientStop { position: 1; color: "#42FFFFFF"}

                }
                MouseArea{
                    anchors.fill: highContrastRec
                    hoverEnabled: true
                    onEntered: {
                        highConTxtBottom.opacity = 1
                        highConTxtBottom.visible = true
                    }
                    onExited: {
                        highConTxtBottom.opacity = 0
                        highConTxtBottom.visible = false
                    }
                }
                Text {
                    font.pixelSize: 18
                    color: "white"
                    text: u2d.tr("Use High Contrast:")
                    anchors{
                        verticalCenter: highContrastRec.verticalCenter
                        left: highContrastRec.left
                        leftMargin: highContrastRec.width / 20
                    }
                }
                Image{
                    id: highContrastIconButtonRec
                    source: "../../../artwork/tick_box.png"
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 12.5
                        verticalCenter: highContrastRec.verticalCenter
                    }
                    Image{
                        id:highContrastIconButton
                        source: "../../../artwork/tick.png"
                        visible: if(lightDmConfiguration.highContrast === true)
                                     true
                                 else
                                     false
                        scale: 1.5
                        smooth: true
                        anchors{
                            right: parent.right
                            rightMargin: parent.width / 12.5
                            verticalCenter: highContrastIconButtonRec.verticalCenter
                        }
                    }MouseArea{
                        anchors.fill:highContrastIconButton
                        onClicked: if (lightDmConfiguration.highContrast === true)
                                       lightDmConfiguration.highContrast = false
                                   else if (lightDmConfiguration.highContrast === false)
                                       lightDmConfiguration.highContrast = true
                    }
                }
            }
        }//Colomn

        //helptxt@bottom
        Rectangle{
            id:bottomBrowserHelpRec
            width: parent.width / 1.022
            height: parent.height / 3.17
            border.color: "#55FFFFFF"
            border.width: 0
            gradient: Gradient {
                GradientStop { position: 0; color: "#77000000"}
                GradientStop { position: 0.9; color: "#66808080"}
                GradientStop { position: 1; color: "#77000000"}
            }
            anchors{
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin:parent.height / 28

            }
            Text{
                id:drumsTxtBottom
                opacity: 0
                Behavior on opacity {NumberAnimation{from: 0; to:.99 ;duration: 1200 ; easing.type: Easing.InSine }}
                visible: false
                color: "white"
                smooth: true
                font.pixelSize: dash2dConfiguration.fullScreen === true ? 22 : 14
                text:u2d.tr("Play the Drums ?  \n \n"
                            +"This turns the Drums that you hear at the START of lightdm, To either On or Off \n The default State that is shiped with Ubuntu is Turned On")
                anchors{
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
            }
            Image {
                id: onboardImg
                width: parent.width / 1.022
                height: parent.height // 3.17
                visible: false
                opacity: .66
                Behavior on opacity {NumberAnimation {from: 0 ;to: .66; duration: 1700; easing.type: Easing.InSine }  }
                source: "http://screenshots.ubuntu.com/screenshots/o/onboard/9048_large.png"
                anchors{
                    horizontalCenter: parent.horizontalCenter
                    top:parent.top
                }
            }
            Text{
                id:orcaTxtBottom
                opacity: 0
                Behavior on opacity {NumberAnimation{from: 0; to:.99 ;duration: 1200 ; easing.type: Easing.InSine }}
                visible: false
                color: "white"
                smooth: true
                font.pixelSize: dash2dConfiguration.fullScreen === true ? 22 : 14
                text:u2d.tr("\t \tTurn On Or Off The Screen Reader ?\n"
                            +" Orca is a free, open source, flexible, and extensible screen reader \n that provides access to the graphical desktop via user-customizable\n combinations of speech and\/or braille.")

                anchors{
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
            }

            Text{
                id:highConTxtBottom
                opacity: 0
                Behavior on opacity {NumberAnimation{from: 0; to:.99 ;duration: 1200 ; easing.type: Easing.InSine }}
                visible: false
                color: "white"
                smooth: true
                font.pixelSize: dash2dConfiguration.fullScreen === true ? 22 : 14
                text:u2d.tr("Turn On Or Off High Contrast")

                anchors{
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                    //top:parent.top
                }
           }
        }
    }//universalAHelpDesription
}//root
