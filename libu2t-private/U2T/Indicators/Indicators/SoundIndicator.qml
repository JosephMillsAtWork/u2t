import QtQuick 2.3
import QtQuick.Controls 1.4
Rectangle{
    id: ind
    width : 20
    height:  20
    color: "#3e3e3e"
    property string image
    Image {
        id: theIcon
        source: image
        MouseArea{
        anchors.fill: theIcon
        onDoubleClicked: sound.mute
        }
    }
    Slider{
        width: parent.width - theIcon.width -10
        height: theIcon.height - 5
        anchors.left: theIcon.right
        anchors.verticalCenter: theIcon.verticalAlignment
        value: sound.master
        maximumValue: 150
        minimumValue: 0
        stepSize: 5
        onValueChanged: sound.master = value

    }
}


