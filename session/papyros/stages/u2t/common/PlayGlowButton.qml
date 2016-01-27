import QtQuick 1.0
import "utils.js" as Utils
import "units.js" as Units

AbstractButton {
    id: button

    //        property alias text: textBox.text

      height: Units.tvPx(100)
      width: Units.tvPx(100)

    Image {
        id: playButton
        source: "../common/artwork/arrow.png"
        Behavior on opacity { NumberAnimation { duration: state == "hovered" || state == "selected-hovered" ? 100 : 250 } }
    }

    Rectangle {
        id: border
        anchors.fill: parent
        color: "transparent"
        border.color: "white"
        border.width: 3
        radius: Units.tvPx(16)

        Behavior on opacity { NumberAnimation { duration: 250 } }
    }


    // Note that the glow when selected is outside the item
    BorderImage {
        id: glow
        anchors.fill: parent
        anchors.margins: Units.tvPx(-19)
        anchors.topMargin: Units.tvPx(-18)
        anchors.rightMargin: Units.tvPx(-20)

        source: "artwork/button_glow.sci"
        Behavior on opacity { NumberAnimation { duration: 250 } }
    }

    states: [
        State {
            name: "default"
            PropertyChanges { target: glow; opacity: 0.0 }
            PropertyChanges { target: border; opacity: 0.5 }
            PropertyChanges { target: background; opacity: 0.2 }
        },
        State {
            name: "selected"
            PropertyChanges { target: glow; opacity: 1.0 }
            PropertyChanges { target: border; opacity: 0.0 }
            PropertyChanges { target: background; opacity: 0.05 }

        },
        State {
            name: "hovered"
            PropertyChanges { target: glow; opacity: 0.0 }
            PropertyChanges { target: border; opacity: 0.5 }
            PropertyChanges { target: background; opacity: 0.4 }
        },
        State {
            name: "selected-hovered"
            PropertyChanges { target: glow; opacity: 1.0 }
            PropertyChanges { target: border; opacity: 0.0 }
            PropertyChanges { target: background; opacity: 0.4 }
        }
    ]
}

