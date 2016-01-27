import QtQuick 1.0
import Unity2d 1.0
import "../../common"
import "../../common/utils.js" as Utils
import "../../dash/"
VideoPreview {
    id: preview
    buttons: buttons
    Rectangle{
        id: root
        width: parent.width
        height: parent.height
        color:"transparent"

        Rectangle {
            id: mainBackground
            width: if (unity2dConfiguration.formFactor === "tv" )
                       parent.width / 1.38
                   else
                       parent.width / 1.2
            height: parent.height / 1.2
            border.color: "#55FFFFFF"
            border.width: 1
            gradient: Gradient {
                GradientStop { position: 0; color: "#42FFFFFF"}
                GradientStop { position: 0.5; color: "#66808080"}
                GradientStop { position: 1; color: "#42FFFFFF"}

            }
            anchors{
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
            Row{
                id:mainRow
                width: parent.width / 1.20
                height:  parent.height
                spacing: parent.width / 15
                anchors{
                    left: parent.left
                    leftMargin: recLeft.width / 20
                    top: parent.top
                    topMargin: parent.height / 20
                }
                Rectangle{
                    id: recLeft
                    width: mainBackground.width / 2.3
                    height: mainBackground.height / 1.1
                    opacity: .77
                    border.color: "#55FFFFFF"
                    border.width: 1
                    gradient: Gradient {
                        GradientStop { position: 0; color: "#42FFFFFF"}
                        GradientStop { position: 0.5; color: "#66808080"}
                        GradientStop { position: 1; color: "#42FFFFFF"}

                    }
                    Image {
                        id: desktopScreenshot
                        width: recLeft.width
                        height: recLeft.height / 1.4
                        smooth: true
                        source: uri.substring(uri.lastIndexOf("file://")+7)
                        scale: if (status === Image.Ready)
                                   1
                               else
                                   0
                        Behavior on scale{NumberAnimation{from: 0;to: 1;duration: 1200;easing.type:Easing.OutQuint }}
                        anchors{
                            verticalCenter: parent.verticalCenter
                        }
                    }
                }

                Rectangle{
                    id: recRight
                    width: mainBackground.width / 2.3
                    height: mainBackground.height / 1.1
                    opacity: .77
                    border.color: "#55FFFFFF"
                    border.width: 1
                    gradient: Gradient {
                        GradientStop { position: 0; color: "#42FFFFFF"}
                        GradientStop { position: 0.5; color: "#66808080"}
                        GradientStop { position: 1; color: "#42FFFFFF"}

                    }
                    Text{
                        id:mainName
                        font.pixelSize: parent.width / 12
                        color: "white"
                        text: Utils.removeExt(name)
                        width: parent.width
                        wrapMode: Text.WordWrap
                    }Text{
                        text: "<b>Format:</b> \t" + mimeType.substring(mimeType.lastIndexOf("/")+1)
                        color: "white"
                        anchors{
                        top: mainName.bottom

                        }
                    }
                }
            }
        }
    }
}
