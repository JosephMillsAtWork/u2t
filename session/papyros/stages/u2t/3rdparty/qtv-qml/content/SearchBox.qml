import Qt 4.7

FocusScope {
    id: focusScope
    width: 250; height: textInput.height + 10
    property alias text: textInput.text
    signal returnPressed();

    Text {
        id: typeSomething
        verticalAlignment: Text.AlignLeft
        text: u2d.tr("Search The TV Data Base")
        anchors{
            right: parent.right
             rightMargin: 8
             left: parent.left
             verticalCenter: parent.verticalCenter
        }
             color: "#44FFFFFF"
        font.pixelSize: 28
        font.italic: true
    }

    MouseArea {
        anchors.fill: parent
        onClicked: { focusScope.focus = true; textInput.openSoftwareInputPanel(); }
    }

    TextInput {
        id: textInput
        smooth: true
        anchors { left: parent.left; right: clear.left; rightMargin: 8; verticalCenter: parent.verticalCenter }
        focus: true
        selectByMouse: true
        font.pixelSize: 28
        font.bold: true
        color: "#FFFFFF"

        Keys.onPressed: {
            if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return)
                returnPressed();
        }
    }

    Image {
        id: clear
        height: parent.height
        width: height
        smooth: true
        fillMode: Image.PreserveAspectFit
        anchors { right: parent.right; rightMargin: 8; verticalCenter: parent.verticalCenter }
        source: "pics/clear.png"
        opacity: 0

        MouseArea {
            anchors.fill: parent
            onClicked: { textInput.text = ''; focusScope.focus = true; textInput.openSoftwareInputPanel(); }
        }
    }

    states: State {
        name: "hasText"; when: textInput.text != ''
        PropertyChanges { target: typeSomething; opacity: 0 }
        PropertyChanges { target: clear; opacity: 1 }
    }

    transitions: [
        Transition {
            from: ""; to: "hasText"
            NumberAnimation { exclude: typeSomething; properties: "opacity" }
        },
        Transition {
            from: "hasText"; to: ""
            NumberAnimation { properties: "opacity" }
        }
    ]
}
