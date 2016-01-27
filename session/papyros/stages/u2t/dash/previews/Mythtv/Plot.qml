import QtQuick 1.0
import "../../../common"
import "../../../dash"
import "../"
import "../../../common/utils.js" as Utils


Rectangle{
        id:  plotmain
        Item {
        id: startingtxt
        height: rootTangle.height
        width: rootTangle.width
        BorderImage {
            id : bordersreal
            source: "../../../dash/artwork/search_background_clear.png"
            width: startingtxt.width / 1.1 ; height: startingtxt.height / 1.1
            anchors.centerIn: startingtxt
            border.left: 25; border.top: 25
            border.right: 25; border.bottom: 25

        }
        Text{
            id: textinfo
            wrapMode: Text.WordWrap
            color: "white"
            font.pixelSize: rootTangle.width / 40
            property string baseText:"%1"
            text: baseText.arg((nfo.video.Description) ? nfo.video.Description : "")
            width: bordersreal.width / 1.02
            anchors{
            top: bordersreal.top
            topMargin: startingtxt.height / 20
            left: bordersreal.left
            leftMargin: startingtxt.width / 50
            }

        }

            GlowButton{
            id: buttonBack
            focus: true
            text: "Back"
            width: bordersreal.width / 1.01
            anchors{
                bottom: parent.bottom
                left: parent.left
                leftMargin: startingtxt.width / 20
            }
            onClicked:{
                loaderto.visible = true;
                plotLoader.visible = false;

                buttonIngh.visible  = true
                buttonIngh1.visible  = true
                buttonIngh3.visible  = true
                buttonIngh4.visible  = true
                buttonPlay.visible  = true

                fanartaroo.opacity = 1
                title.visible = true
                marqueeText.visible = true
                rating.visible  = true
                previewImage.visible  = true
                previewImage1.visible  = true
            }
        }

            Loader{
                id:loaderto
                visible: false
                source: "../VideoPreview.qml"
            }
        }
    }
