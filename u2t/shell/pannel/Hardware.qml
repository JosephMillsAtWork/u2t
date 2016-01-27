import QtQuick 2.0
Item {
    Column {
        Repeater {
            model: hardware.storageDevices
            delegate:

                Rectangle{
                Text {
                    text: modelData.name
                    visible: !modelData.ignored
                }
                Image {
                    source: {
                        if (modelData.iconName.indexOf("harddisk") !== -1) {
                            return Qt.resolvedUrl("images/harddisk.svg")
                        } else if (modelData.iconName.indexOf("usb") !== -1) {
                            return "icon://device/usb"
                        } else {
                            return Qt.resolvedUrl("images/harddisk.svg")
                        }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            //                        Qt.openUrlExternally(modelData.filePath)
                            //                        indicator.close()
                        }
                    }
                }
            }
        }
    }


}
