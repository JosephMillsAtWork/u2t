import QtQuick 1.0
import "../../../common"
import "../"
import "../../../common/utils.js" as Utils

Item{
    id:plotmain
    VideoPreview{
    }
    Item {
        id: startingtxt
        height: rootTangle.height
        width: rootTangle.width
        BorderImage {
            id : bordersreal
            source: "../../../dash/artwork/search_background_clear.png"
            width: parent.width / 1.5; height: parent.height / 4
            anchors.centerIn: startingtxt
            border.left: 25; border.top: 25
            border.right: 25; border.bottom: 25
        }

        ListView{
            id: textinfo
            model: ratingmodel
            anchors{
                top: bordersreal.top
                topMargin: bordersreal.height / 2.8
                left: bordersreal.left
                leftMargin: bordersreal.width / 2.8
            }
            delegate: Text{
                color: "white"
                font.pixelSize: rootTangle.width / 40
                text: u2d.tr("Studio")+ "\n" + studio
            }
        }

        XmlListModel {
            id:ratingmodel
            source: (dash2dConfiguration.mythipBackend)+"/Video/GetVideoByFileName?FileName="+Utils.mythFileName(uri)
            query: "/VideoMetadataInfo"
            XmlRole { name: "studio"; query: "Studio/string()" }

        }

        GlowButton{
            id: buttonBack
            focus: true
            width:  startingtxt.width / 6
            height: startingtxt.height / 12
            text: u2d.tr("Back")
            anchors{
                top: parent.top
                topMargin: startingtxt.height / 1.6
                left: parent.left
                leftMargin: startingtxt.width / 2.5
            }
            onClicked:{
                loaderlo4.visible = true;
                studioLoader.visible = false

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
            id:loaderlo4
            visible: false
            source: "../VideoPreview.qml"
        }
    }
}
