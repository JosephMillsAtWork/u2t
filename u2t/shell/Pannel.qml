import QtQuick 2.0
import QtQuick.Window 2.0
//import org.kde.plasma.networkmanagement 0.2
import QtQuick.Controls 1.4
import org.kde.plasma.networkmanagement 0.2 as PlasmaNM
import "pannel"
Rectangle {
    width: Screen.width
    height: Screen.height / 20
    color: "#80000000"

    Row{
        id: pannelIconRows
        height: parent.height
        width: nmApp.width * 4
        anchors.right: parent.right
        Image {
            height: parent.height
            width: height
            id: nmApp
            source: "image://theme/nm-signal-100"
        }
        Image {
            id: battIndicatorndicator
            height: parent.height
            width: height
            source: "image://theme/" +hardware.primaryBattery.iconName
        }
        Image {
            id: soundIndicator
            height: parent.height
            width: height
            source: "image://theme/audio-volume-high-panel"
        }
        Image {
            id: personOInd
            source: "image://theme/avatar-default"
            height: parent.height
            width: height
        }

    }





//    property bool predictableWirelessPassword: !Uuid && Type == PlasmaNM.Enums.Wireless &&
//                                               (SecurityType == PlasmaNM.Enums.StaticWep || SecurityType == PlasmaNM.Enums.WpaPsk ||
//                                                SecurityType == PlasmaNM.Enums.Wpa2Psk)
//    property bool showSpeed: ConnectionState == PlasmaNM.Enums.Activated &&
//                             (Type == PlasmaNM.Enums.Wimax ||
//                              Type == PlasmaNM.Enums.Wired ||
//                              Type == PlasmaNM.Enums.Wireless ||
//                              Type == PlasmaNM.Enums.Gsm ||
//                              Type == PlasmaNM.Enums.Cdma)






//    Text {
//    color: "white"
//    anchors.horizontalCenter: parent.horizontalCenter
////    text: networkShares.devices[0]
//    text: "NFS url: " + networkShares.device( networkShares.devices[0], "StorageVolume" ).fsType


//    }


//    Battery{
//        anchors.horizontalCenter: parent.horizontalCenter
//        width: parent.width / 2
//        height: shell.height
//    }






//    Text {
//        id: name
//        text:
//    }


//    // SOLID
//    Rectangle{
//        width: parent.width / 2
//        height: shell.height
//        color: "black"
//        anchors.horizontalCenter: parent.horizontalCenter
//        anchors.top: parent.bottom
//        ListView {
//            id: deviceView
//            width: parent.width
//            height: parent.height
//            model: devicesModel
//            delegate: Rectangle {
//                height: deviceView.height / 12
//                width: deviceView.width
//                color: u2tSettings.averageBgColor
//                radius: 5
//                border{
//                    width: 1
//                    color: "white"
//                }
//                Text {
//                    anchors.horizontalCenter: parent.horizontalCenter
//                    color: "white"
//                    text: devicePath
//                          + "\nFiles System Type: " + filesystem
//                          + "\nSize: " + formatSizeUnits(size)
////                    +"\n desc: " + description
//                }

//            }
//        }
//    }






//NETWORK MANAGER
//    Rectangle{visible: false
//        width: parent.width / 2
//        height: parent.height * 4
//        color: "black"
//        anchors.horizontalCenter: parent.horizontalCenter
//        anchors.top: parent.bottom
//    ListView {
//        id: connectionView
//        width: parent.width
//        height: parent.height * 4
//        model: appletProxyModel
//        delegate: Rectangle {
//            height: connectionView.height
//            width: connectionView.width
//            color: u2tSettings.averageBgColor
//            radius: 5
//            border{
//                width: 1
//                color: "white"
//            }
//            Image {
//                width: 48
//                height: width
//                source:{
//                    if (Signal >= 75){
//                    "image://theme/nm-signal-100"
//                    }else if (Signal <=75 && Signal >=50 ){
//                    "image://theme/nm-signal-75"
//                    }else if (Signal <=50 && Signal >=25 ){
//                        "image://theme/nm-signal-50"
//                    }else if (Signal <=25 && Signal >=10 ){
//                        "image://theme/nm-signal-25"
//                    }else if (Signal <10){
//                        "image://theme/nm-signal-00"
//                    }

//                }
//            }
//                Text {
//                    id: name
//                    anchors.centerIn: parent
//                    color: "white"
//                    width: parent.width
//                    wrapMode: Text.WordWrap
//                    text:

//                        "Item Uniq Name : "+  ItemUniqueName
//                        +"\nConnection State " + ConnectionState
//                        + "\nDevice Name " + DeviceName
//                        + "\nConnection Path " + ConnectionPath
//                        + "\nConnection Icon " + ConnectionIcon
//                        + "\nName : " + Name
//                        + "\nDevice Name " + DeviceName
//                        + "\nDevice path " + DevicePath
//                        + "\nDevice State " +DeviceState
//                        + "\nDuplicate " + Duplicate
//                        + "\nItemType " + ItemType
//                        + "\nLastUsed " + LastUsed
//                        + "\nLastUsedDateOnly " + LastUsedDateOnly
//                        + "\nNsp: " + Nsp
//                        + "\nSection: " + Section
//                        + "\nSignal: " + Signal
//                        + "\nSlave: " + Slave
//                        + "\nSsid: " + Ssid


//                        +"\nSpecificPath "+ SpecificPath
//                        +"\nSecurityType " +SecurityType
//                        +"\nSecurityTypeString " +SecurityTypeString
//                        +"\nTimeStamp "+ TimeStamp
//                        +"\nType " + Type
//                        +"\nUni " + Uni
//                        +"\nUuid " + Uuid
//                        +"\nVpnState " +VpnState
//                        +"\nConnectionDetails  " + ConnectionDetails




////+ "\n" +themeList



//                    //                     +"\n " + ConnectionDetails[4] //ConnectionDetails

//                }
//    }

//    }
//}
}
