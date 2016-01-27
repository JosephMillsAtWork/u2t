// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.0
import Unity2d 1.0
import QtMultimediaKit 1.1
import "../../dash/"
import "../../common"

Rectangle{
    property bool mirror: false
    property double musicPlayerOpacity: outsideCircleMusic.opacity
    property int musicPlayerRotation: outsideCircleMusic.rotation
    property int bottomPixelSize: bottomText.font.pixelSize
    property string bottomtext: bottomText.text
    property double bottomTextOpacity: bottomText.opacity
    property color bottomTextColor: bottomText.color
    property int topPixelSize: topText.font.pixelSize
    property string toptext: topText.text
    property double topTextOpacity: topText.opacity
    property color topTextColor:  topText.color

    id: box
    width: parent.width / .7
    height: parent.height / .6
    color: "transparent"
    scale: dash2dConfiguration.fullScreen === true ? .5 : 1
    anchors{
        centerIn:  content.Center
        //        right: parent.right
//        rightMargin: launcher2dConfiguration.launcherLocation === "left" ? parent.width / 4.2 : parent.width / -4.2
//        top: parent.top
//        topMargin: parent.height / -4
    }

    Image {
        source:"BackgroundAlpha_images/purpletopleft.png"
        id:purpletopleft
        x:toptext === "" ? 603 : 700 ; y:310
        Behavior on x {NumberAnimation{from: 700; to: 603;loops: Animation.Infinite ; duration:11200;easing.type:Easing.OutExpo}}
        width: toptext === "" ? 329 : 100
        Behavior on width {NumberAnimation{from: 100; to: 329;loops:Animation.Infinite;  duration:11200;easing.type:Easing.OutExpo}}
        height:356
        opacity: 0

    }
    Rectangle{
        id:purpletopleftRec
        gradient:  Gradient {
            GradientStop { position: 0; color: Qt.darker(unity2dConfiguration.averageBgColor , 1.5)}
            GradientStop { position: .7; color: Qt.darker(unity2dConfiguration.averageBgColor , 1.5)}
            GradientStop { position: 0.8; color:"#00000000"}
            GradientStop { position: 1; color: "#00000000"}
        }
        opacity: toptext === "" ? 1 : .51
        Behavior on opacity {NumberAnimation{from:1 ;to: .51;loops: Animation.Infinite;  duration:18200; easing.type: Easing.OutExpo}}
        width: purpletopleft.width;height: purpletopleft.width;radius:  180; rotation: 300
        anchors{centerIn:purpletopleft;}}

    Image {
        source:"BackgroundAlpha_images/redleft.png"
        id:redleft
        x:toptext === "" ? 695 : 700 ; y:481
        Behavior on x {NumberAnimation{from: 750; to: 695;loops: Animation.Infinite ; duration:18200;easing.type:Easing.OutExpo}}
        width:87
        height: toptext === "" ? 124 : 100
        Behavior on height {NumberAnimation{from: 50; to: 124;loops:Animation.Infinite;  duration:18200;easing.type:Easing.OutExpo}}
        opacity: 0
    }
    Rectangle{
        id:redleftRec
        gradient:  Gradient {
            GradientStop { position: 0; color: Qt.darker(unity2dConfiguration.averageBgColor ,1.2)}
            GradientStop { position: 0.8; color: Qt.darker(unity2dConfiguration.averageBgColor ,1.3)}
            GradientStop { position: 0.9; color:"#01000000"}
            GradientStop { position: 1; color: "#00000000"}
        }
        opacity: toptext === ""  ? .92 : .52
        Behavior on opacity {NumberAnimation{from:1 ;to: .51;loops: Animation.Infinite;  duration:18200; easing.type: Easing.OutExpo}}
        width: redleft.height;height: redleft.height;radius:  180; rotation: 280
        anchors{centerIn:redleft;}}
    ///
    Image {
        source:"BackgroundAlpha_images/yellowbottomright.png"
        id:yellowbottomright
        x: 1011  ; y: toptext === "" ? 604 : 2
        Behavior on y {NumberAnimation{from: 664; to: 599;loops: Animation.Infinite ; duration:20200;easing.type:Easing.OutExpo}}
        width:242

        height:toptext === "" ? 253 : 200
        Behavior on height {NumberAnimation{from: 80; to: 253;loops:Animation.Infinite;  duration:20200;easing.type:Easing.OutExpo}}

        opacity: 0
    }
    Rectangle{
        id:yellowbottomrightRec
        gradient:  Gradient {
            GradientStop { position: 0; color: Qt.darker(unity2dConfiguration.averageBgColor ,2.3)}
            GradientStop { position: 0.5; color: Qt.darker(unity2dConfiguration.averageBgColor ,1.4)}
            GradientStop { position: 0.9; color:"#00000000"}
            GradientStop { position: 1; color: "#00000000"}
        }
        opacity: toptext === "" ? .99 : 52
        Behavior on opacity {NumberAnimation{from:1 ;to: .51;loops: Animation.Infinite;  duration:20200; easing.type: Easing.OutExpo}}

        width: yellowbottomright.height;height: yellowbottomright.height;radius:  180; rotation: 132
        anchors{centerIn:yellowbottomright;}}

    Image {
        source:"BackgroundAlpha_images/brownbottomleft.png"
        id:brownbottomleft
        x:toptext === "" ? 713 : 600 ; y:670
        Behavior on x {NumberAnimation{from: 700; to: 713;loops: Animation.Infinite ; duration:16200;easing.type:Easing.OutExpo}}
        width:209
        height:toptext === ""  ? 200 : 100
        Behavior on height {NumberAnimation{from: 100; to: 200;loops:Animation.Infinite;  duration:16200;easing.type:Easing.OutExpo}}

        opacity: 0
    }
    Rectangle{
        id:brownbottomleftRec
        gradient:  Gradient {
            GradientStop { position: 0; color: Qt.darker(unity2dConfiguration.averageBgColor ,2.3)}
            GradientStop { position: 0.5; color: Qt.darker(unity2dConfiguration.averageBgColor ,1.4)}
            GradientStop { position: 0.7; color:"#00000000"}
            GradientStop { position: 1; color: "#00000000"}
        }
        opacity: toptext === ""  ? .92 : .52
        Behavior on opacity {NumberAnimation{from:1 ;to: .51;loops: Animation.Infinite;  duration:16200; easing.type: Easing.OutExpo}}

        width: brownbottomleft.height;height: brownbottomleft.height;radius:  180; rotation: 227
        anchors{centerIn:brownbottomleft;}}

    Image {
        source:"BackgroundAlpha_images/green.png"
        id:green
        x:toptext === ""  ? 696: 500 ; y:623
        Behavior on x {NumberAnimation{from: 700; to: 695;loops: Animation.Infinite ; duration:14200;easing.type:Easing.OutExpo}}

        width:127
        height: toptext === "" ? 155 : 55
        Behavior on height {NumberAnimation{from: 100; to: 155;loops:Animation.Infinite;  duration:14200;easing.type:Easing.OutExpo}}

        opacity: 0
    }
    Rectangle{
        id:greenRec
        gradient:  Gradient {
            GradientStop { position: 0; color: Qt.darker(unity2dConfiguration.averageBgColor ,4)}
            GradientStop { position: 0.5; color: Qt.darker(unity2dConfiguration.averageBgColor ,3.7)}
            GradientStop { position: 0.96; color:"#00000000"}
            GradientStop { position: 1; color: "#00000000"}
        }
        opacity: toptext === ""  ? 1 : .52
        Behavior on opacity {NumberAnimation{from:1 ;to: .51;loops: Animation.Infinite;  duration:14200; easing.type: Easing.OutExpo}}

        width: green.height;height: green.height;radius:  180; rotation: 236
        anchors{centerIn:green;}}

    Image {
        id:red2
        source:"BackgroundAlpha_images/red2.png"
        x:837 ; y:toptext === ""  ? 776 : 800 //776
        Behavior on y {NumberAnimation{from: 675; to:776;loops: Animation.Infinite ; duration:17200;easing.type:Easing.OutExpo}}

        width:toptext === ""  ? 124 : 100
        Behavior on width {NumberAnimation{from: 0; to: 124;loops:Animation.Infinite;  duration:17200;easing.type:Easing.OutExpo}}

        height:89
        opacity: 0
    }
    Rectangle{
        id:red2Rec
        gradient:  Gradient {
            GradientStop { position: 0; color: Qt.darker(unity2dConfiguration.averageBgColor ,1.4)}
            GradientStop { position: 0.5; color: Qt.darker(unity2dConfiguration.averageBgColor ,1)}
            GradientStop { position: 0.96; color:"#00000000"}
            GradientStop { position: 1; color: "#00000000"}
        }
        opacity: toptext === ""  ? 1 : .52
        Behavior on opacity {NumberAnimation{from:1 ;to: .51;loops: Animation.Infinite;  duration:17200; easing.type: Easing.OutExpo}}

        width: red2.width;height: red2.width;radius:  180; rotation: 197
        anchors{centerIn:red2;}}

    Image {
        source:"BackgroundAlpha_images/orangeleft.png"
        id:orangeleft
        x:toptext === ""  ? 720: 600 ; y:toptext === ""  ? 554: 660
        Behavior on y {NumberAnimation{from: 553; to: 554;loops: Animation.Infinite ; duration:21200;easing.type:Easing.OutExpo}}
        Behavior on x {NumberAnimation{from:760;to:710;duration:11200 ;loops: Animation.Infinite; easing.type: Easing.OutExpo}}
        width:47
        height: toptext === "" ? 81: 33
        Behavior on height {NumberAnimation{from: 0; to: 81;loops:Animation.Infinite;  duration:21200;easing.type:Easing.OutExpo}}
        opacity: 0
    }
    Rectangle{
        id:orangeleftRec
        gradient:  Gradient {
            GradientStop { position: 0; color: Qt.darker(unity2dConfiguration.averageBgColor ,3.4)}
            GradientStop { position: 0.5; color: Qt.darker(unity2dConfiguration.averageBgColor ,3.3)}
            GradientStop { position: 0.8; color: Qt.darker(unity2dConfiguration.averageBgColor ,3.2)}
            GradientStop { position: 1; color: "#00000000"}
        }
        Behavior on opacity {NumberAnimation{from:0 ;to: .61;loops: Animation.Infinite;  duration:21200; easing.type: Easing.OutExpo}}

        opacity: toptext === ""  ? .99 : .52
        width: orangeleft.height;height: orangeleft.height;radius:  180; rotation: 270
        anchors{centerIn:orangeleft;}}

    Image {
        source:"BackgroundAlpha_images/bluetopleft.png"
        id:bluetopleft
        x:toptext === ""  ? 720 : 500 ; y:toptext === ""  ? 335 : 300
        Behavior on x {NumberAnimation{from: 790; to: 720;loops: Animation.Infinite ; duration:19650;easing.type:Easing.OutExpo}}
        Behavior on y {NumberAnimation{from: 440; to: 335;loops: Animation.Infinite ; duration:19650;easing.type:Easing.OutExpo}}
        width:toptext === ""  ? 196 : 100
        Behavior on width {NumberAnimation{from: 50; to: 196;loops:Animation.Infinite;  duration:19650;easing.type:Easing.OutExpo}}
        height: toptext === ""  ? 189 : 100
        Behavior on height {NumberAnimation{from: 0; to: 189;loops:Animation.Infinite;  duration:19650;easing.type:Easing.OutExpo}}
        opacity: 0
    }
    Rectangle{
        gradient:  Gradient {
            GradientStop { position: 0; color: Qt.darker(unity2dConfiguration.averageBgColor , 1.8)}
            GradientStop { position: 0.7; color:"#00000000"}
            GradientStop { position: 1; color: "#00000000"}
        }

        opacity: toptext === "" ? 1 : .52
        Behavior on opacity {NumberAnimation{from:.1 ;to: .71;loops: Animation.Infinite;  duration:19650; easing.type: Easing.OutExpo}}
        width: bluetopleft.width;height: bluetopleft.width;radius:180 ; rotation:320
        anchors{centerIn: bluetopleft;}}



    Image {
        source:"BackgroundAlpha_images/yellow.png"
        id:yellow
        x: toptext === ""  ? 718 : 700
        Behavior on x {NumberAnimation{from: 740; to: 718;loops: Animation.Infinite ; duration:31700;easing.type:Easing.OutExpo}}
        Behavior on y {NumberAnimation{from: 620; to: 624;loops: Animation.Infinite ; duration:31700;easing.type:Easing.OutExpo}}
        y:toptext === ""  ? 624 :600
        width:toptext === ""  ? 42 : 40
        height:toptext === ""  ?  49 : 40
        Behavior on height {NumberAnimation{from: 0; to: 49;loops:Animation.Infinite;  duration:31700;easing.type:Easing.OutExpo}}

        opacity: 0
    }
    Rectangle{
        id:yellowRec
        gradient:  Gradient {
            GradientStop { position: 0; color: Qt.darker(unity2dConfiguration.averageBgColor ,1.7)}
            GradientStop { position: 0.5; color: Qt.darker(unity2dConfiguration.averageBgColor ,1.4)}
            GradientStop { position: 0.8; color: Qt.darker(unity2dConfiguration.averageBgColor ,1)}
            GradientStop { position: 1; color: "#00000000"}
        }
        Behavior on opacity {NumberAnimation{from:1 ;to: .51;loops: Animation.Infinite;  duration:31700; easing.type: Easing.OutExpo}}

        opacity: toptext === "" ? 1 : .52
        width: yellow.height + 5 ;height: yellow.height + 5 ;radius:  180; rotation: 260
        anchors{centerIn:yellow;}}



    Image {
        source:"BackgroundAlpha_images/purple2.png"
        id:purple2
        x:toptext === ""  ? 1132 : 1000 ; y:toptext === ""  ? 672 : 600
        Behavior on x {NumberAnimation{from: 1120; to: 1132;loops: Animation.Infinite ; duration:33200;easing.type:Easing.OutExpo}}
        Behavior on y {NumberAnimation{from: 697; to: 672;loops: Animation.Infinite ; duration:33200;easing.type:Easing.OutExpo}}

        width:44
        height: toptext === ""  ? 54 : 10
        Behavior on height {NumberAnimation{from: 0; to:54;loops:Animation.Infinite;  duration:33200;easing.type:Easing.OutExpo}}

        opacity: 0
    }
    Rectangle{
        id:purple2Rec
        gradient:  Gradient {
            GradientStop { position: 0; color: Qt.darker(unity2dConfiguration.averageBgColor, 2.4)}
            GradientStop { position: 0.8; color: Qt.darker(unity2dConfiguration.averageBgColor ,2.3)}
            GradientStop { position: 1; color: "#00000000"}
        }
        opacity: toptext === "" ? .92 : .52
        Behavior on opacity {NumberAnimation{from: .1 ;to: .71;loops: Animation.Infinite;  duration:33200; easing.type: Easing.OutExpo}}

        width: purple2.height ;height: purple2.height  ;radius:  180; rotation: 117
        anchors{centerIn:purple2;}}



    Image {
        source:"BackgroundAlpha_images/bluetopright.png"
        id:bluetopright
        x:toptext === ""  ? 1037 : 1000 ; y:363
        Behavior on x {NumberAnimation{from: 1000; to: 1037;loops: Animation.Infinite ; duration:26200;easing.type:Easing.OutExpo}}

        width:toptext === ""  ? 164 : 100
        Behavior on width {NumberAnimation{from: 20; to: 164;loops:Animation.Infinite;  duration:26200;easing.type:Easing.OutExpo}}

        height:167
        opacity: 0
    }
    Rectangle{
        id:bluetoprightRec
        gradient:  Gradient {
            GradientStop { position: 0; color: Qt.darker(unity2dConfiguration.averageBgColor, 1.4)}
            GradientStop { position: .6; color: Qt.darker(unity2dConfiguration.averageBgColor ,1.3)}
            GradientStop { position: .7; color: "#00000000"}
        }
        opacity: toptext === "" ? .92 : .52
        Behavior on opacity {NumberAnimation{from:.1 ;to: .91;loops: Animation.Infinite;  duration:26200; easing.type: Easing.OutExpo}}

        width: bluetopright.width + 15;height: bluetopright.width + 15;radius:  180; rotation: 45
        anchors{centerIn:bluetopright;}}

    Image {
        source:"BackgroundAlpha_images/greentopright.png"
        id:greentopright
        x:toptext === ""  ? 1140 : 1000 ; y:486
        Behavior on x {NumberAnimation{from: 1120; to: 1140;loops: Animation.Infinite ; duration:11200;easing.type:Easing.OutExpo}}

        width:toptext === ""  ? 87 : 80
        Behavior on width {NumberAnimation{from: 20; to: 87;loops:Animation.Infinite;  duration:24200;easing.type:Easing.OutExpo}}
        height: toptext === ""  ? 124 : 80
        Behavior on height {NumberAnimation{from: 40; to: 124;loops:Animation.Infinite;  duration:24200;easing.type:Easing.OutExpo}}

        opacity: 0
    }
    Rectangle{
        id:greentoprightRec
        gradient:  Gradient {
            GradientStop { position: 0; color: Qt.darker(unity2dConfiguration.averageBgColor, 2.4)}
            GradientStop { position: .7; color: Qt.darker(unity2dConfiguration.averageBgColor ,2.3)}
            GradientStop { position: .8; color: "#00000000"}
        }
        opacity: toptext === "" ? 1 : .52
        Behavior on opacity {NumberAnimation{from:.1 ;to: .71;loops: Animation.Infinite;  duration:24200; easing.type: Easing.OutExpo}}

        width: greentopright.height + 12;height: greentopright.height + 12 ;radius:  180; rotation: 75
        anchors{centerIn:greentopright;}}


    Image {
        source:"BackgroundAlpha_images/redtopright.png"
        id:redtopright
        x: toptext === ""  ? 1163 : 1000 ; y:545
        Behavior on x {NumberAnimation{from: 1160; to: 1163;loops: Animation.Infinite ; duration:11200;easing.type:Easing.OutExpo}}

        width:toptext === ""  ? 54: 40
        Behavior on width {NumberAnimation{from: 10; to: 54;loops:Animation.Infinite;  duration:11200;easing.type:Easing.OutExpo}}
        height: toptext === ""  ? 91 : 20
        Behavior on height {NumberAnimation{from: 10; to: 91;loops:Animation.Infinite;  duration:11200;easing.type:Easing.OutExpo}}

        opacity: 0

    }
    Rectangle{
        id:redtoprightRec
        gradient:  Gradient {
            GradientStop { position: 0; color: Qt.darker(unity2dConfiguration.averageBgColor, 1.4)}
            GradientStop { position: .7; color: Qt.darker(unity2dConfiguration.averageBgColor ,1.3)}
            GradientStop { position: .9; color: "#00000000"}
        }
        opacity: toptext === "" ? .92 : .52
        Behavior on opacity {NumberAnimation{from: .10 ;to: 1;loops: Animation.Infinite;  duration:11200; easing.type: Easing.OutExpo}}

        width: redtopright.height + 5;height: redtopright.height + 5 ;radius:  180; rotation: 97
        anchors{centerIn:redtopright;}}


    Image {
        source:"BackgroundAlpha_images/bluebottom.png"
        id:bluebottom
        x: toptext === ""  ? 935 : 900 ; y:toptext === ""  ? 764 : 765
        Behavior on y {NumberAnimation{from: 700; to: 734;loops: Animation.Infinite ; duration:14700;easing.type:Easing.OutExpo}}
        Behavior on x {NumberAnimation{from: 920; to: 935;loops: Animation.Infinite ; duration:14700;easing.type:Easing.OutExpo}}

        width: toptext === ""  ? 165 : 100
        Behavior on width {NumberAnimation{from: 100; to:165;loops:Animation.Infinite;  duration:14700;easing.type:Easing.OutExpo}}

        height:toptext === "" ? 118 : 119
        Behavior on height {NumberAnimation{from: 100; to:165;loops:Animation.Infinite;  duration:14700;easing.type:Easing.OutExpo}}

        opacity: 0
    }
    Rectangle{
        id:bluebottomRec
        gradient:  Gradient {
            GradientStop { position: 0; color: Qt.darker(unity2dConfiguration.averageBgColor, 3.4)}
            GradientStop { position: .7; color: Qt.darker(unity2dConfiguration.averageBgColor ,3.3)}
            GradientStop { position: .9; color: "#00000000"}
        }
        opacity: toptext === "" ? 1 : .52
        Behavior on opacity {NumberAnimation{from:.51;to: .81;loops: Animation.Infinite;  duration:14700; easing.type: Easing.OutExpo}}

        width: bluebottom.width ;height: bluebottom.width ;radius:  180; rotation: 166
        anchors{centerIn:bluebottom;}}


    Image {
        source:"BackgroundAlpha_images/orangebottom___1.png"
        id:orangebottom___1
        x:toptext === ""  ? 988 : 700 ; y:toptext === ""  ?  763 : 762
        Behavior on x {NumberAnimation{from: 980; to: 988;loops: Animation.Infinite ; duration:16760;easing.type:Easing.OutExpo}}
        Behavior on y {NumberAnimation{from: 766; to: 743;loops: Animation.Infinite ; duration:16760;easing.type:Easing.OutExpo}}

        width: toptext === ""  ? 115 : 90
        Behavior on width {NumberAnimation{from: 50; to: 115;loops:Animation.Infinite;  duration:16760;easing.type:Easing.OutExpo}}

        height:toptext === ""  ?  90 : 50
        Behavior on height {NumberAnimation{from: 10; to: 90;loops:Animation.Infinite;  duration:16760;easing.type:Easing.OutExpo}}

        opacity: 0
    }
    Rectangle{
        id:orangebottom___1Rec
        gradient:  Gradient {
            GradientStop { position: 0; color: Qt.darker(unity2dConfiguration.averageBgColor, 1.4)}
            GradientStop { position: .7; color: Qt.darker(unity2dConfiguration.averageBgColor ,1.3)}
            GradientStop { position: .9; color: "#00000000"}
        }
        opacity: toptext === "" ? 1 : .52
        Behavior on opacity {NumberAnimation{from:.1 ;to: .71;loops: Animation.Infinite;  duration:16760; easing.type: Easing.OutExpo}}

        width: orangebottom___1.width + 3 ;height: orangebottom___1.width  ;radius:  180; rotation: 146
        anchors{centerIn:orangebottom___1;}}


    Image {
        source:"BackgroundAlpha_images/orangetop.png"
        id:orangetop
        x:toptext === ""  ? 817 : 800 ; y:toptext === ""  ?  272 : 222
        Behavior on x {NumberAnimation{from: 815; to: 817;loops: Animation.Infinite ; duration:17280;easing.type:Easing.OutExpo}}
        Behavior on y {NumberAnimation{from: 400; to: 272;loops: Animation.Infinite ; duration:17280;easing.type:Easing.OutExpo}}

        width: toptext === ""  ? 239 : 200
        Behavior on width {NumberAnimation{from: 100; to: 239;loops:Animation.Infinite;  duration:17280;easing.type:Easing.OutExpo}}

        height: toptext === ""  ?  164 : 155
        Behavior on height {NumberAnimation{from: 100; to: 165;loops:Animation.Infinite;  duration:17280;easing.type:Easing.OutExpo}}
        opacity: 0
    }
    Rectangle{
        id:orangetopRec
        gradient:  Gradient {
            GradientStop { position: 0; color: Qt.darker(unity2dConfiguration.averageBgColor, 1.1)}
            GradientStop { position: .7; color: Qt.darker(unity2dConfiguration.averageBgColor ,1.2)}
            GradientStop { position: .9; color: "#00000000"}
        }
        opacity: toptext === "" ? .5 : .65
        Behavior on opacity {NumberAnimation{from:1 ;to: .51;loops: Animation.Infinite;  duration:17280; easing.type: Easing.OutExpo}}

        width: orangetop.width ;height: orangetop.width ;radius:  180; rotation:10
        anchors{top: orangetop.top; horizontalCenter: orangetop.horizontalCenter;
        }}

    Rectangle{
        id: darker
        color: "#46000000"
        opacity: .88
        radius: 360
        smooth: true
        width: parent.height / 3.27 //2.8
        height: parent.height / 3.27 //2.8
        x: parent.width / 2.42
        y: parent.height / 3
    }
    Rectangle  {
        id:outsideCircle
        radius: 360
        color: "#66000000"
        smooth: true
        anchors{
            fill: darker
            margins: 2
        }
    }
    Rectangle  {
        id:outsideCircle1
        radius: 360
        color: "#72000000"
        smooth: true
        anchors{
            fill: outsideCircle
            margins: 2
        }
    }

    Rectangle  {
        id:outsideCircleMusic
        radius: 360
        gradient:  Gradient {
            GradientStop { position: .1; color: Qt.darker(unity2dConfiguration.averageBgColor, 1.1)}
            GradientStop { position: .14; color: "#33000000"}
            GradientStop { position: .3; color: "#23000000"}
            GradientStop { position: .4; color: "#13000000"}
            GradientStop { position: .5; color: "#03000000"}
            GradientStop { position: .6; color: "#13000000"}
            GradientStop { position: .7; color: "#23000000"}
            GradientStop { position: .96; color: "#33000000"}
            GradientStop { position: .97; color: Qt.darker(unity2dConfiguration.averageBgColor ,1.2)}
            GradientStop { position: 1; color: Qt.darker(unity2dConfiguration.averageBgColor, 1.1)}

        }
        rotation: parent.musicPlayerRotation
        smooth: true
        opacity:parent.musicPlayerOpacity
        anchors{
            fill: outsideCircle1
            margins: 2
        }

}
//    fix wraping issue
    Text {
        id: topText
        text:parent.toptext
        opacity: parent.topTextOpacity
        Behavior on opacity {NumberAnimation{duration: 1200; easing.type: Easing.OutQuad}}
//        wrapMode: Text.wrapMode
        color:parent.topTextColor
        font.pixelSize: 32
        anchors.centerIn: outsideCircleMusic
        width:outsideCircleMusic.width
        height:34
    }
    Text {
        id:bottomText
        text: parent.bottomtext
        Behavior on text{NumberAnimation { duration: 600; easing.type: Easing.OutQuad }}
        opacity: parent.bottomTextOpacity
        Behavior on opacity {NumberAnimation{duration: 1200; easing.type: Easing.OutQuad}}
        color: parent.bottomTextColor
        anchors.centerIn: outsideCircleMusic
//        x:842 ; y:603
        width:264
        height:120
    }
}

