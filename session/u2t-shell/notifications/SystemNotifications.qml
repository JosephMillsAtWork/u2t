
import QtQuick 2.0

QtObject {
    property int soundVolume: sound.master
    property real batteryLevel: upower.primaryDevice
            ? upower.primaryDevice.percentage : 0

    onSoundVolumeChanged: notifications.add(soundNotification.createObject())

    property int lastLevel: 100

    onBatteryLevelChanged: {
        print("Battery level changed!")
        if (batteryLevel <= 30 && batteryLevel < lastLevel - 5) {
            lastLevel = batteryLevel
            notifications.add(batteryNotification.createObject())
        }

        if (batteryLevel > lastLevel) {
            lastLevel += 5
        }
    }

    Component {
        id: soundNotification

        SystemNotification {
            notificationId: -1
            iconName: sound.iconName
            percent: sound.master/100
        }
    }

    Component {
        id: batteryNotification

        SystemNotification {
            notificationId: -2
            iconName: upower.deviceIcon(upower.primaryDevice)
            summary: batteryLevel < 10 ? "Critically low battery!"
                                       : "Low battery!"
            body: upower.deviceSummary(upower.primaryDevice)

            duration: 5000
        }
    }
}
