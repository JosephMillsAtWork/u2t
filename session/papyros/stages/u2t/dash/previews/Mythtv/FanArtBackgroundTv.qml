import QtQuick 1.0
import "../../../dash"
import "../../../common"
import "../../../common/units.js" as Units
import "../../../common/utils.js" as Utils
import "../../previews"

Rectangle{
    width: parent.width
    height: parent.height
    anchors{
        left: parent.left
        top: parent.top

    }

    Image{
        id:minusone
        source:encodeURI((dash2dConfiguration.mythipBackend)+"/Content/GetVideoArtwork?Id="+nfo.video.id+"&Type=coverart")
        width: parent.width
        height: parent.height
        smooth: true
        anchors{
            left: parent.left
            top: parent.top
        }
    }
    Image {
        id: one
       opacity: 0
        width: parent.width;
        height: parent.height
        smooth: true

        anchors{
            left: parent.left
            top: parent.top
        }
        source: encodeURI((dash2dConfiguration.mythipBackend)+"/Content/GetVideoArtwork?Id="+nfo.video.id+"&Type=screenshot")
    }
    Image {
        id: two
        opacity: 0
        width: parent.width
        height: parent.height
        smooth: true
        anchors{
            left: parent.left
            top: parent.top
        }
        source: encodeURI((dash2dConfiguration.mythipBackend)+"/Content/GetVideoArtwork?Id="+nfo.video.id+"&Type=banner")

    }

    Image {
        id: three
        width: parent.width;
        height: parent.height
        smooth: true
        opacity: 0
        anchors{
            left: parent.left
            top: parent.top
        }
        source: encodeURI((dash2dConfiguration.mythipBackend)+"/Content/GetVideoArtwork?Id="+nfo.video.id+"&Type=fanart")

    }
    Item {
        Timer {
            interval: 3000
            running: true
            repeat: true
            onTriggered: changeBackground()
            function changeBackground(){
                var i = 1
                if(i === 1) {
                    one.opacity=1
                    two.opacity=0
                    three.opacity=0
                    minusone.opacity = 0
                }
                if(i === 2) {
                    two.opacity=1
                    one.opacity=0
                    three.opacity=0
                    minusone.opacity = 0
                }
                if(i === 3) {
                    one.opacity=0
                    two.opacity=0
                    three.opacity=1
                    minusone.opacity = 0
                }
                i++;
                if(i > 3)
                    i = 1;
                else
                    i = i;
            }
        }
    }

}
