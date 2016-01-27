//import QtQuick 2.0
import U2T.Hardware 1.0
import QtQuick 2.3
Rectangle{
    id: ind
       width : 20
       height:  20
//    visible: hardware.batteries.length > 0
//    iconName: deviceChargeIcon(hardware.primaryBattery)
//    tooltip: deviceSummary(hardware.primaryBattery)
    color: {
        if (hardware.primaryBattery && hardware.primaryBattery.chargeState !== Battery.Charging) {
            if (hardware.primaryBattery.chargePercent < 10) {
                "red"
            } else if (hardware.primaryBattery.chargePercent < 15) {
                 "orange"
            } else if (hardware.primaryBattery.chargePercent < 20) {
                "yellow"
            }else{
            "blue"
            }
        }

//        return "transparent"
    }


    Image {
        id: name

        source: "image://theme/" + hardware.primaryBattery.iconName


    }
    Text {
        anchors.top: name.bottom
        text:{
            + "\n Icon Name: " + hardware.primaryBattery.iconName  // yBattery.iconName
            + "\n Serial " + hardware.primaryBattery.serial
            + "\n Charge Percent " + hardware.primaryBattery.chargePercent
            + "\n timeToFull " + hardware.primaryBattery.timeToFull
            +"USER \n" +   currentUser.fullName
            +"\nUser icon " + currentUser.faceIconUrl
            + sound.master
                    + "\n" + hardware.storageDevices.length

        }
    }

//    view: Column {

        // TODO: Re-enable once we have a brightness API
        // ListItem.Subtitled {
        //     text: "Screen Brightness"
        //     valueText: "25%"
        //     content: Slider {
        //         width: parent.width
        //         value: 0.25
        //         anchors.verticalCenter: parent.verticalCenter
        //         anchors.verticalCenterOffset: Units.dp(7)
        //     }
        //
        //     showDivider: true
        // }

//        Repeater {
//            model: hardware.batteries
//            delegate: ListItem.Subtitled {
//                iconSource: deviceIcon(modelData)
//                text: deviceTitle(modelData)
//                valueText: deviceSummary(modelData)
//                content: ProgressBar {
//                    value: chargePercent/100
//                    width: parent.width
//                    anchors.verticalCenter: parent.verticalCenter
//                }
//            }
//        }
//    }

    function deviceTitle(battery) {
        var product;
        if (isMouse(battery)) {
            product = battery.product
        } else if (battery.type === Battery.PrimaryBattery) {
            product = "Battery"
        } else if (battery.type === Battery.MonitorBattery) {
            product = "External monitor"
        } else if (battery.type === Battery.KeyboardBattery) {
           product= "Keyboard"
        } else {
            product = battery.product
        }
        return product
    }

//    function deviceIcon(battery) {
//        print("Battery type", battery.name, battery.type, battery.vendor, battery.product,
//                battery.iconName, battery.udi)

//        if (isMouse(battery)) {
//            return "icon://hardware/mouse"
//        } else if (battery.type == Battery.PrimaryBattery) {
//            return "icon://" + deviceChargeIcon(battery)
//        } else if (battery.type == Battery.MonitorBattery) {
//            return "icon://hardware/desktop_windows"
//        } else if (battery.type == Battery.KeyboardBattery) {
//            return "icon://hardware/keyboard"
//        } else if (battery.type == Battery.PhoneBattery) {
//            return "icon://hardware/smartphone"
//        } else {
//            return "icon://device/battery_std"
//        }
//    }

//    function isMouse(battery) {
//        return battery.type == Battery.MouseBattery ||
//                battery.type == Battery.KeyboardMouseBattery ||
//                battery.name.toLowerCase().indexOf("mouse") != -1 ||
//                battery.product.toLowerCase().indexOf("mouse") != -1
//    }

//    function deviceChargeIcon(device) {
//        if (!device)
//            return ""

//        var level = "full"

//        if (!device)
//            return "device/battery_unknown"

//        print(device.chargePercent)

//        if (device.chargePercent < 25)
//            level = "20"
//        else if (device.chargePercent < 35)
//            level = "30"
//        else if (device.chargePercent < 55)
//            level = "50"
//        else if (device.chargePercent < 65)
//            level = "60"
//        else if (device.chargePercent < 85)
//            level = "80"
//        else if (device.chargePercent < 95)
//            level = "90"

//        print(level, device.chargeState)

//        if (device.chargeState == Battery.Charging ||
//                device.chargeState == Battery.FullyCharged)
//            return "device/battery_charging_" + level
//        else
//            return "device/battery_" + level
//    }

//    function deviceSummary(device) {
//        if (!device)
//            return "";

//        var percent = device.chargePercent + "%"

//        print("Battery state", device.chargeState)

//        if (device.chargeState == Battery.Charging) {
//            return "%1 until full".arg(DateUtils.shortDuration(device.timeToFull * 1000, 'm'))
//        } else if (device.chargeState == Battery.Discharging && device.timeToEmpty != 0) {
//            return "%1 remaining".arg(DateUtils.shortDuration(device.timeToEmpty * 1000, 'm'))
//        } else if (device.chargeState == Battery.FullyCharged) {
//            return "Fully Charged"
//        } else {
//            return percent
//        }
//    }
}
