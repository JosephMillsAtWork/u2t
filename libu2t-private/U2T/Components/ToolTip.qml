import QtQuick 2.4
import U2T.Components 1.0

Popover {
    id: dropdown

    property alias text: tooltipLabel.text

    property MouseArea mouseArea

    overlayLayer: "tooltipOverlayLayer"
    globalMouseAreaEnabled: false

    width: tooltipLabel.paintedWidth + Units.dp(32)
    implicitHeight: Device.isMobile ? Units.dp(44) : Units.dp(40)

    backgroundColor: Qt.rgba(0.2, 0.2, 0.2, 0.9)

    Timer {
        id: timer

        interval: 1000
        onTriggered: open(mouseArea, 0, Units.dp(4))
    }

    Connections {
        target: mouseArea

        onReleased: {
            if(showing)
                close()
        }

        onPressAndHold: {
            if(text !== "" && !showing)
                open(mouseArea, 0, Units.dp(4))
        }

        onEntered: {
            if(text !== "" && !showing)
                timer.start()
        }

        onExited: {
            timer.stop()

            if(showing)
                close()
        }
    }

    Text {
        id: tooltipLabel
        color: "white"//Theme.dark.textColor
        anchors.centerIn: parent
    }
}
