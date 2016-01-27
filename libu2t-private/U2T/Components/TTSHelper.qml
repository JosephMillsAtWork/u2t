import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
Rectangle{
    id: ttsHelperRoot
    property string text
    default property alias view: comp.children
    color: "transparent"
    Layout.alignment: Qt.AlignHCenter
    Text {
        id: tx
        Layout.alignment: Qt.AlignVCenter
        text: qsTr(ttsHelperRoot.text)
    }
    Item{
        id:comp
        width:  parent.width /1.2
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
    }
}

