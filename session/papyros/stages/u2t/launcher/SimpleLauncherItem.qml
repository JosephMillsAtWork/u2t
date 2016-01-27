import QtQuick 2.0
import "../common"
import "../common/units.js" as Units
//re-write this file to be way more dynamic
AbstractButton {
    id: simpleLauncherItem
    property string icon
    property bool active
    property string activePath: "artwork/icons/%1-active.png"
    property string inactivePath: "artwork/icons/%1-deactive.png"
    property string focusedPath: "artwork/icons/%1-focus.png"
    property bool enabled: false
    anchors.left: parent.left
    anchors.right: parent.right
    height: width

    Image {
        source: inactivePath.arg(icon)
        anchors.fill: parent
        anchors.margins: Units.tvPx(-9)
        smooth: true
    }

    Image {
        id: activeIcon
        source: activePath.arg(icon)
        anchors.fill: parent
        anchors.margins: Units.tvPx(-9)
        opacity: simpleLauncherItem.state == "active" ? 1.0 : 0.0
        smooth: true
        Behavior on opacity {
            NumberAnimation {
                property: rotation
                from: .66
                to:1
                duration: 1250
            }
        }
    }

    Image {
        id: focusedIcon
        source: focusedPath.arg(icon)
        anchors.fill: parent
        anchors.margins: Units.tvPx(-9)
        opacity: simpleLauncherItem.state == "selected" ? 1.0 : 0.0
        smooth: true
        Behavior on opacity { NumberAnimation { duration: 250 } }
    }

    states: [
        State {
            name: "default"
            PropertyChanges { target: activeIcon; opacity: active ? 1.0 : 0.0 }
            PropertyChanges { target: focusedIcon; opacity: 0.0 }
        },
        State {
            name: "selected"
            PropertyChanges { target: activeIcon; opacity: 0.0 }
            PropertyChanges { target: focusedIcon; opacity: 1.0 }
        },
        State {
            name: "hovered"
            PropertyChanges { target: activeIcon; opacity: enabled ? 1.0 : 0.0 }
            PropertyChanges { target: focusedIcon; opacity: 0.0 }
        },
        State {
            name: "hovered-selected"
            PropertyChanges { target: activeIcon; opacity: 0.0 }
            PropertyChanges { target: focusedIcon; opacity: enabled ? 1.0 : 0.0 }
        }
    ]
}
