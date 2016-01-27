import QtQuick 1.0
import Unity2d 1.0
import "../../common"
import "../../common/utils.js" as Utils
import "../"
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
                        source:iconHint.indexOf("http://") == 0 ? iconHint : "image://icons/" + (iconHint != "" ? iconHint : "unknown")
                        sourceSize.width: width
                        sourceSize.height: height
                        scale:status === Image.Ready ? 1 : 0
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
                        text: comment
                        width: parent.width
                        wrapMode: Text.WordWrap
                    }
                    Text{
                        id: formatName
                        text: u2d.tr("Format:   ") + mimeType.substring(mimeType.lastIndexOf("/")+1)
                        color: "white"
                        wrapMode: Text.WordWrap
                        width: parent.width
                        anchors{
                            top: mainName.bottom

                        }
                    }
                    Text{
                        id:nameName
                        text:{
                            var forLocalMusic = uri.substring(uri.indexOf(":")+1)
                            if (Utils.removeExt(uri.substring(uri.lastIndexOf("http://")+7)) === "grooveshark")
                                u2d.tr("Album:  ") + name
                            else if (Utils.removeExt(uri.substring(uri.lastIndexOf("http://")+7)) === "tinysong")
                                u2d.tr("Song:   ") + name
                            else if (mimeType.indexOf("taglib/") === 0 && forLocalMusic.substring(0,forLocalMusic.lastIndexOf(":")) === "file")
                                u2d.tr("Song:   ")+ name
                            else if (mimeType.indexOf("taglib/") === 0 && forLocalMusic.substring(0,forLocalMusic.lastIndexOf(":")) === "album")
                                u2d.tr("Album:  ")+ name
                        }
                        wrapMode: Text.WordWrap
                        width: parent.width
                        color: "white"
                        anchors{
                            top: formatName.bottom

                        }
                    }
                    Text{
                        id: sourceName
                        text: u2d.tr("Source:   ") + decodeURIComponent(uri.substring(uri.indexOf(":")+1))
                        color: "white"
                        width: parent.width
                        wrapMode: Text.WordWrap
                        anchors{
                            top: nameName.bottom

                        }
                    }

                    GlowButton{
                        id:  buttonPlayGlow
                        text: u2d.tr("Play")
                        width: recRight.width - 20
                        height: recRight.height / 10
                        x: 10
                        y: desktopScreenshot.status === Image.Ready ? recRight.height - height - 5 : 50
                        Behavior on y {NumberAnimation{duration: 1200; easing.type: Easing.OutBounce}}
                        onClicked: {
                            dash.activateUriWithLens(itemLensId, uri, mimeType)
                            dash.hidePreview()
                            shellManager.dashActive = false;
                        }

                    }
                }
            }
        }
    }
}


