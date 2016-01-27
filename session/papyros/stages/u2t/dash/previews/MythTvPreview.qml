import QtQuick 1.0
import "../../common"
import "../../common/units.js" as Units
import "../../common/utils.js" as Utils
import "../../dash"
import "Mythtv"

VideoPreview{
    id: mainWinder
    Rectangle{
        id: rootTangle
        width: parent.width;
        height:  parent.height;
        color:"transparent"
        Image{
            id:fanartaroo
            width: parent.width;
            height: parent.height
            source:encodeURI((dash2dConfiguration.mythipBackend)+"/Content/GetVideoArtwork?Id="+nfo.video.id+"&Type=fanart")
            opacity: status === Image.Ready ? 1 : 0
            Behavior on opacity {NumberAnimation{duration: 900; easing.type: Easing.OutQuint}}
            anchors{
                left: parent.left
                top: parent.top
            }
        }
        TextCustom {
            id: title
            anchors.left: parent.left
            anchors.top: parent.top
            fontSize: if (dash2dConfiguration.fullScreen !== true)
                          "small"
                          else
                          "xx-large"
            smooth: true
            color: "white"
        }
        Marquee {
            id:marqueeText
            width: parent.width
            color: "transparent"
            opacity: .95
            textColor: "white"
            fontSize: 64
            text:name
            padding: 2
            anchors{
                top: title.top
                left: parent.left
            }
        }
        RatingStars {
            id: rating
            rating: (nfo.video) ? nfo.video.UserRating * 0.5 : 0.0
            spacing: Units.tvPx(42)
            starIconSize: if (unity2dConfiguration.formFactor === "tv" )
                              32
                          else if (unity2dConfiguration.formFactor === "desktop")
                              32
            scale: if(unity2dConfiguration.formFactor === false)
                       .30
            else
                       1
            anchors{
                right: parent.right
                rightMargin: rootTangle.width / 3.66
                top: parent.top
                topMargin: parent.height / 6
            }
        }

        Image {
            id: previewImage
            width: parent.width / 4
            height: parent.height / 1.8
            source: coverart
            anchors{
                top: parent.top
                topMargin: parent.height/ 6.2
                left: parent.left
                leftMargin: parent.width / 6
            }
        }

        Image{
            id: previewImage1
            visible: if (nfo.video.ContentType === "MOVIE")
                         false
                     else
                         true
            width: parent.width / 1.94
            height: parent.height / 9
            smooth: true
            source:  encodeURI((dash2dConfiguration.mythipBackend)+"/Content/GetVideoArtwork?Id="+nfo.video.id+"&Type=banner")
            anchors{
                bottom: parent.bottom
                bottomMargin: parent.height / 8
                left: parent.left
                leftMargin: parent.width / 20
            }
        }

        GlowButton {
              id: buttonPlay
              text: u2d.tr("Play")
              focus: true
              KeyNavigation.up: buttonIngh4
              KeyNavigation.down: buttonIngh
              onClicked:{
                  dash.activateUriWithLens(itemLensId, uri, mimeType)
                  dash.hidePreview()
                  shellManager.dashActive = false
              }
              height: parent.height / 12
              width: parent.width / 4
              anchors{
                  bottom: parent.bottom
                  bottomMargin: parent.height / 8
                  right: parent.right
                  rightMargin: parent.width / 20
              }
          }
        Plot{
            id:plotLoader
            visible: false
        }

        Director{
            id:dirElement
            visible: false
        }

        Studio{
            id:studioLoader
            visible: false
        }

        Rated{
            id:ratedLoader
            visible: false
        }
        GlowButton {
            id: buttonIngh
            KeyNavigation.up: buttonPlay
            KeyNavigation.down: buttonIngh1
            width:rootTangle.width / 3
            height: rootTangle.height / 11
            text: u2d.tr("Plot")
            focus: true
            anchors{
                top: parent.top
                topMargin: rootTangle.height / 4
                right:parent.right
                rightMargin: rootTangle.width / 6
            }
            onClicked: {
                plotLoader.visible = true;
                fanartaroo.opacity = .44
                title.visible = false
                marqueeText.visible = false
                rating.visible  = false
                previewImage.visible  = false
                previewImage1.visible  = false
                buttonIngh.visible  = false;
                buttonIngh1.visible  = false;
                buttonIngh3.visible  = false;
                buttonIngh4.visible  = false;
                buttonPlay.visible  = false;
            }
        }
        GlowButton {
            id: buttonIngh1
            anchors{
                top: buttonIngh.bottom
                topMargin: Units.tvPx(10)
                right: buttonIngh.right
            }
            width:rootTangle.width / 3
            height: rootTangle.height / 11
            text:u2d.tr("Director")
            KeyNavigation.down: buttonIngh3
            KeyNavigation.up: buttonIngh
            onClicked: {
                dirElement.visible = true

                fanartaroo.opacity = .44
                title.visible = false
                marqueeText.visible = false
                rating.visible  = false
                previewImage.visible  = false
                previewImage1.visible  = false

                buttonIngh.visible  = false;
                buttonIngh1.visible  = false;
                buttonIngh3.visible  = false;
                buttonIngh4.visible  = false;
                buttonPlay.visible  = false;
            }
        }

        GlowButton {
            id: buttonIngh3
            anchors{
                top: buttonIngh1.bottom
                topMargin: Units.tvPx(10)
                right: buttonIngh1.right
            }
            KeyNavigation.down: buttonIngh4
            KeyNavigation.up: buttonIngh1
            width:rootTangle.width / 3
            height: rootTangle.height / 11
            text: u2d.tr("Studio")
            onClicked: {
                studioLoader.visible = true;

                fanartaroo.opacity = .44
                title.visible = false
                marqueeText.visible = false
                rating.visible  = false
                previewImage.visible  = false
                previewImage1.visible  = false

                buttonIngh.visible  = false;
                buttonIngh1.visible  = false;
                buttonIngh3.visible  = false;
                buttonIngh4.visible  = false;
                buttonPlay.visible  = false;            }
        }

        GlowButton {
            id: buttonIngh4
            anchors{
                top: buttonIngh3.bottom
                topMargin: Units.tvPx(10)
                right:buttonIngh3.right
            }
            KeyNavigation.up: buttonIngh3
            KeyNavigation.down:buttonPlay
            width:rootTangle.width / 3
            height: rootTangle.height / 11
            text: u2d.tr("Rated")
            onClicked: {
                ratedLoader.visible = true;

                fanartaroo.opacity = .44
                title.visible = false
                marqueeText.visible = false
                rating.visible  = false
                previewImage.visible  = false
                previewImage1.visible  = false

                buttonIngh.visible  = false;
                buttonIngh1.visible  = false;
                buttonIngh3.visible  = false;
                buttonIngh4.visible  = false;
                buttonPlay.visible  = false;
            }
        }
    }
}
