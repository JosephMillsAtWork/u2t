import QtQuick 2.4
import QtQuick.Controls 1.4
import U2T.Components 1.0
Image{
    id: indRoot
    property string text
    default property alias object: comp.children
    property bool shown: false
    property string image
//    property url iconSource: "icon://" + image
    property string tooltip
    source: image
    width: 22
    height: 22
    MouseArea{
        anchors.fill: parent
        onClicked :{
            if(shown ===false ){
                shown = true
            }else if(shown === true ){
                shown = false
            }
        }
        Item{
            id:comp
            visible: shown
            anchors.top: parent.bottom
//            anchors.right: parent.left
        }
    }
}
