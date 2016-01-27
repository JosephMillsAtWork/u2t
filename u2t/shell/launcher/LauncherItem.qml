import QtQuick 2.0
import U2T.Menu 1.0

Rectangle {
    id: rootLauncherItem
    width: 64
    height: 64
    radius: 1
    color: u2tSettings.averageBgColor
    border{
        color: "#44FFFFFF"
        width: 1
    }
    property string iconHint
    signal clicked()
    property string  name


    Image {
        id: appIcon
        source: rootLauncherItem.iconHint
        width: parent.width
        height: parent.height
        onStatusChanged: {
            if(status === Image.Error ){
                source = "image://theme/unknown"
            }
        }
    }



    Rectangle{
        id: pip
        radius: 5
        width: parent.width * 3
        height: parent.height
        color: "#80000000"
        opacity: 0
        anchors.left: parent.right
        anchors.leftMargin: 14
        border{
            color: "white"
            width: 1
        }

        Text {
            anchors.fill: parent
            text: name
            width:  parent.width
            wrapMode:Text.WrapAnywhere
            clip: true
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

        }
    }

    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            if(dashLoader.shown === false){
                pip.opacity = 1
            }
        }
        onExited: {
            pip.opacity = 0
        }
        onClicked:rootLauncherItem.clicked()

    }
}
