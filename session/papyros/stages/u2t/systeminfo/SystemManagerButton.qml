
import QtQuick 1.0
import "../common"

PictureGlowButton {
    id: button
    width:icon.width;height: icon.height
    property alias icon: icon.source
    property alias iconSourceSize: icon.sourceSize

    Image {
        id: icon
        width: sourceSize.width
        height: sourceSize.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        fillMode: Image.PreserveAspectFit

        asynchronous: true
        opacity: status == Image.Ready ? 1 : 0
        Behavior on opacity {NumberAnimation {duration: 200; easing.type: Easing.InOutQuad}}
    }
}
