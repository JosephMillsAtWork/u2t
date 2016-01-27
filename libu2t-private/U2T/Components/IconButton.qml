import QtQuick 2.3

Image{
    width: 22
    height: 22
    source: image
    opacity: imageOpacity
    MouseArea{
        anchors.fill: parent
        onClicked:{
            clicked()
        }
    }
}
