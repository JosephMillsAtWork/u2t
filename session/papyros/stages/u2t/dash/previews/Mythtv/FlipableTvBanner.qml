import QtQuick 1.0
import "../../../dash"
import "../../../common/units.js" as Units
import "../../previews"

Flipable{
    id: container
    property alias image: frontImage.source
    property bool fliped: true
    property int xAxis: 0
    property int yAxis: 0
    property int angle: 0
    width: Units.tvPx(487);height: Units.tvPx(125)

    front: PreviewImageBox {
        id: frontImage
        smooth: true
        width: Units.tvPx(487);height: Units.tvPx(125)
        anchors.top: parent.top
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
        anchors.centerIn: frontImage.Center
        color: "transparent" ;
        showBackgroundImage: false ;
        showBlackBoundary: false ;
        source:
            if(status === previewImage1.Error )
               Utils.removeExt(uri) + ((nfo.isMovie) ? "fanart.jpg" : ".jpg");
            else
                encodeURI((dash2dConfiguration.mythipBackend)+"/Content/GetVideoArtwork?Id="+nfo.video.id+"&Type=screenshot")

    }
    state: "front"
    MouseArea{anchors.fill: container; onClicked: container.fliped = !container.fliped }
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
            NumberAnimation{ target: rotation;property:"angle";duration: 600 }
            SequentialAnimation{
                NumberAnimation{ target: container;property: "scale"; to: .44; duration: 700 }
                NumberAnimation{ target: container;property: "scale"; to: 1.0; duration: 500}
            }
        }
    }
}
