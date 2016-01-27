import QtQuick 2.0


Rectangle{
    id: changeUsersRoot
    width: 20
    height : 20
    color: "white"
    border.width: 1
    border.color: "white"


    ListView {
        id: sesionView
        spacing: 2
        width: loginBox.width
        height:  42 * count
        model: sessionModel
        delegate:Rectangle{
            id: sessionItem
            height: 42
            radius: 5
            anchors.horizontalCenter: parent.horizontalCenter
            width:changeUsersRoot.width  - 15
            color: Qt.darker(root.color,1.4)
            border{
                color: "white"
                width: 1
            }

            Text {
                id: sessionToLoginIn
                text: name
                opacity: sessionItem.width > 0 ?1 : 0
                color: "white"
                anchors.fill: parent
                wrapMode: Text.WordWrap
                font.pixelSize: parent.height- 2
                font.bold: selectedSession === currentIndex  ?  true : false
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                Behavior on opacity {NumberAnimation{duration: 300}}
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: sessionItem.color = Qt.lighter(root.color,1.7)
                onExited: sessionItem.color = Qt.darker(root.color,1.4)
                onClicked:{
//                    console.log(currentIndex)
                    selectedSession = currentIndex
                    changeSession.visible = false
                }
            }

        }

    }
}
