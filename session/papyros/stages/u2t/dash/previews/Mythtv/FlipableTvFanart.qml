import QtQuick 1.0
import "../../" //dash
import "../../../common/units.js" as Units
import "../" //previews

Flipable{
    id: container
    property alias image: frontImage.source
    property bool fliped: true
    property int xAxis: 0
    property int yAxis: 0
    property int angle: 0
    front: PreviewImageBox {
        id: frontImage
        smooth: true
        width: 550
        height:700
        showBackgroundImage: false ;
        showBlackBoundary: true ;
        clip: true
    }
    back: PreviewImageBox {
        id: backImage
        smooth: true
        clip: true
        width: frontImage.width
        height: frontImage.height
        color: "transparent" ;
       // anchors.centerIn: frontImage.Center
        showBackgroundImage: false ;
        showBlackBoundary: true ;
        state: "back"
        source: encodeURI((dash2dConfiguration.mythipBackend)+"/Content/GetVideoArtwork?Id="+nfo.video.id+"&Type=coverart")
    }
    MouseArea{
        anchors.fill: container;
        onClicked: container.fliped = !container.fliped
    }
    transform: Rotation{
        id: rotation; origin.x: container.width / 2 ; origin.y: container.height / 2
        axis.x: container.xAxis; axis.y: container.yAxis; axis.z: 0
    }
    states: State {
        name: "back"; when: container.fliped
        PropertyChanges { target: rotation;angle:container.angle }
    }
    transitions: Transition {
        ParallelAnimation{
            NumberAnimation{ target: rotation;property:"angle";duration: 800 }
            SequentialAnimation{
                NumberAnimation{ target: container;property: "scale"; to: .80; duration: 800 }
                NumberAnimation{ target: container;property: "scale"; to: 1.0; duration: 800}
            }
        }
    }
}
