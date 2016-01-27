import QtQuick 1.0
//import Unity2d 1.0
import "../../common"
//import "../../dash/Dash.qml"
FocusScope{
    Text{
        text: "Unity 2d Extra's"
        font.pixelSize: 48
        font.family: "ubuntu"
        color:"white"
        style: Sunken
        anchors{
            top: parent.top
            topMargin: 50
            left:parent.left
            leftMargin:  50
        }
    }
    Grid{
        rows: 2
        width: parent.width
        height: parent.height
        spacing: 20
        anchors{
            top: parent.top
            topMargin: 200
            left: parent.left
            leftMargin: parent.width / 25
//            right: parent.right
//            right.Margin:nt.right
        }

        Image{
            id:movies1
            source: "../../launcher/artwork/icons/music-lens-active.png"
            width: 128
            height: 128
            opacity: status = Image.Ready ? 1 : 0
            Behavior on opacity{
                        NumberAnimation {
                            target: movies1
                            properties:"rotation"
                            from: 0
                            to: 1
                            duration: 22200;
                            easing.type: Easing.InOutBounce
                        }
                    }



        }PictureGlowButton{
            id: movies2
            text: "movie"
            anchors.fill: movies1
        }MouseArea{
            id:mousemovies
            anchors.fill: movies2
            onClicked: activateVideffect()        }



        Image{
            id:options1
            width: 128
            height: 128
            source: "../../launcher/artwork/icons/find_more_apps-active.png"
        }PictureGlowButton{
            id: options2
            text: "options"
            anchors.fill: options1
        }MouseArea{
            anchors.fill: options2
          onClicked: activateSystemsettings()
        }

        Image{
            id:browser1
            width: 128
            height: 128
            source:  "../../launcher/artwork/icons/find_internet_apps-active.png"
        }PictureGlowButton{
            id: browser2
            text: "browser"
            anchors.fill: browser1
        }MouseArea{
            anchors.fill: browser2
        onClicked: activateMythweb()
        }

        Image{
            id:pics1
            width: 128
            height: 128
            source: "../../launcher/artwork/icons/photo-lens-active.png"
        }PictureGlowButton{
            id: pics2
            text: "Pictures"
            anchors.fill: pics1
        }MouseArea{
            anchors.fill: pics2
        }

        Image{
            id:weather1
            width:128
            height: 128
            source:"/usr/share/icons/gnome/scalable/status/weather-few-clouds-symbolic.svg"
        }PictureGlowButton{
            id: weather2
            text: "Weather"
            anchors.fill: weather1
        }MouseArea{
            anchors.fill: weather2
        onClicked: activateWeather()
        }

        Image{
            id:maps1
            width: 128
            height: 128
        }PictureGlowButton{
            id: maps2
            text: "Maps"
            anchors.fill: maps1
        }MouseArea{
            anchors.fill: maps2
        onClicked:activateQtvviewer()
            /*activateNokiaMaps()*/
        }
    }
}
