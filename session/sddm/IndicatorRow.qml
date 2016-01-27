import QtQuick 2.3
import U2T.GSettings 1.0
        // ScreenReader
Image{
    width: 22
    height: 22
    source: image
    // anchors.verticalCenter: parent.verticalCenter
    opacity: imageOpacity
    // source: "image://theme/access"
    MouseArea{
        anchors.fill: parent
        onClicked:{
            clicked()
        }
    }
}
