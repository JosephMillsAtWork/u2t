import QtQuick 1.0

Item {
    id: background
    property string state
    opacity: ( state == "selected" || state == "pressed"
              || state == "hovered" ) ? 1.0 : 0.0
    Behavior on opacity {NumberAnimation {duration: 300}}

    Rectangle {
        /* FIXME: */
        anchors.fill: parent
        anchors.bottomMargin: 0
        anchors.rightMargin: 0
        color: background.state == "pressed" ? "#ffffffff" : "#00000000"

        Image {
            fillMode: Image.Stretch
            anchors.fill: parent
            source: "../../artwork/selection_glow.png"
            smooth: true
        }
    }
}
