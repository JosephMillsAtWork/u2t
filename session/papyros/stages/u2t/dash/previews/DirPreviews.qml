import QtQuick 1.0
import Unity2d 1.0
import Qt.labs.folderlistmodel 1.0
import "../../common"
import "../../common/units.js" as Units
import "../../common/utils.js" as Utils
import "../../common/jsonpath.js" as JSONParser
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
                        source: "image://icons/" + iconHint
                        sourceSize.width: width
                        sourceSize.height: height
                        //                        onStatusChanged: if (status == Image.Error) source = "image://icons/unknown"
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

                    Text {
                        id: mainName
                        color: "white"
                        height: defaultAppImg.height
                        anchors{
                            right: parent.right
                            top: parent.top
                            left: defaultAppImg.right
                        }
                    }
                    Marquee {
                        id:formateName
                        anchors.fill: nameOfItem
                        padding: 2
                        color: "transparent"
                        opacity: .95
                        textColor: "white"
                        fontSize: parent.width / 12
                        text: name
                    }

                    Rectangle{
                        id:folderViewBackground
                        anchors.top: formateName.bottom
                        width: recRight.width
                        height: recRight.height / 1.13
                        gradient: Gradient {
                            GradientStop { position: 0; color: "#77000000"}
                            GradientStop { position: 0.9; color: "#66808080"}
                            GradientStop { position: 1; color: "#77000000"}
                        }
                        ListView{
                            spacing: 7
                            width: recRight.width
                            height: folderViewBackground.height - 5
                            focus: true
                            clip: true
                            contentHeight: folderViewBackground.height
                            anchors{
                                topMargin: 5
                                top: folderViewBackground.top
                                left: folderViewBackground.left
                                leftMargin: 10
                            }
                            Component {
                                id: fileDelegate
                               PreviewButton{
                                    id: openButton
                                    text: fileName
                                    width: recRight.width - 20
                                    onClicked:{
                                        dash.activateUriWithLens(itemLensId, uri, mimeType)
                                        dash.hidePreview()
                                        shellManager.dashActive = false
                                    }
                            }
                            }
                            FolderListModel{
                                id: folderModel
                                showDirs: true
                                sortReversed: false
                                nameFilters: ["*"]
                                folder: uri.substring(uri.lastIndexOf("file://")+7)
                            }
                            model: folderModel
                            delegate: fileDelegate
                        }

                    }
                }
            }
        }
    }
}
