import QtQuick 1.0
import "../common/units.js" as Units
Systemdropdown {
    activable: true
    Keys.onPressed: {
        if (active) {
            if (event.key === Qt.Key_Up || event.key === Qt.Key_Down || event.key === Qt.Key_Left || event.key === Qt.Key_Right) {
                event.accepted = true
            }
        }
    }
    Keys.onReleased: {
        if (active) {
            // eat the events the indicators bar usually processes
            if (event.key === Qt.Key_Up || event.key === Qt.Key_Down || event.key === Qt.Key_Left || event.key === Qt.Key_Right) {
                event.accepted = true
            }
        }
    }
}
