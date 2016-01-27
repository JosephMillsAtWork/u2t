import QtQuick 2.3
Rectangle{
    id: ind
    width : 20
    height:  20
    color: "#3e3e3e"
    property string image
    Image {
        id: theIcon
        source: image
    }
    Text {
        anchors.right: parent.right
        color: "white"
        text:{
            if( hardware.primaryBattery.chargePercent === 100 ){
                "Fully Charged"
            }else if (hardware.primaryBattery.chargePercent < 100)
            hardware.primaryBattery.chargePercent + "% " +
            hardware.primaryBattery.timeToFull
        }
    }
}
