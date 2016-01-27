import QtQuick 2.4
QtObject {
    id: notification

    property int notificationId

    property string summary
    property string body
    property real percent
    property string iconName
    property string iconSource: "image://theme/" + iconName

    property alias timer: __timer
    property alias duration: __timer.interval

    Timer {
        id: __timer

        running: true
        interval: 2000
        onTriggered: notifications.remove(notification)
    }
}

