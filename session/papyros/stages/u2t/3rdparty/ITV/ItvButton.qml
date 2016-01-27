import QtQuick 1.0
import Unity2d 1.0
import "../../common"
import  "../../dash/artwork"
import "../../dash"
//import "../../common/units.js" as units

AbstractButton {
    id: button
    property alias icon: icon.source
    property alias label: label.text
    property alias iconSourceSize: icon.sourceSize
    width: 160
    height: 172

    ItvButtonBackground {
        state: button.state
        anchors{
            fill: icon
        margins: 0
    }
        }

    Image {
        id: icon
        width: sourceSize.width
        height: sourceSize.height
        fillMode: Image.PreserveAspectFit
        asynchronous: true
        opacity: status == Image.Ready ? 1 : 0
        Behavior on opacity {
            NumberAnimation {
                duration: 200;
                easing.type: Easing.InOutQuad
            }
        }
        anchors{
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 5
        }
    }

    Text{
        id: label
        color: "#ffffff"
        anchors{
            top: icon.bottom
            horizontalCenter: icon.horizontalCenter
        }
    }
}
