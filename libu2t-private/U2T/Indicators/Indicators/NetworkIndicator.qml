import QtQuick 2.4
import U2T.Components 1.0
Rectangle{
    width: 20
    height: connectionView.height *  connectionView.count
    color: "#3e3e3e"
    property string image: theIcon.source
    ListView {
        id: connectionView
        width: parent.width
        height: 50 * count
        clip: true
        model: appletProxyModel
        delegate: Rectangle {
            height: 50
            width:  connectionView.width
            color: u2tSettings.averageBgColor
            radius: 5
            border{
                width: 1
                color: "white"
            }
            Image {
                id: theIcon
                width: 48
                height: width
                source:{
                    if (Signal >= 75){
                        "image://theme/nm-signal-100"
                    }else if (Signal <=75 && Signal >=50 ){
                        "image://theme/nm-signal-75"
                    }else if (Signal <=50 && Signal >=25 ){
                        "image://theme/nm-signal-50"
                    }else if (Signal <=25 && Signal >=10 ){
                        "image://theme/nm-signal-25"
                    }else if (Signal <10){
                        "image://theme/nm-signal-00"
                    }

                }
            }
            Text {
                id: name
//                anchors.centerIn: parent
                color: "white"
//                width: parent.width
//                wrapMode: Text.WordWrap
                anchors.left: theIcon.right
                anchors.verticalCenter: parent.verticalCenter
                text: ItemUniqueName

            }
        }

    }
}
