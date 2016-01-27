import QtQuick 1.0
import Unity2d 1.0
import "../../common"
import "../../common/units.js" as Units
import "../../systeminfo"

FocusScope {
    Rectangle{
        id:roottangle
        width:parent.width
        height: parent.height
        color: "transparent"
        Item {
            id: toptext
            TextCustom {
                id: titleText
                anchors{
                    left: parent.left
                    leftMargin: roottangle.width / 3.30 //Units.tvPx(15)
                    top: parent.top
                    topMargin: roottangle.height / 10 // Units.tvPx(50)
                }
                text: u2d.tr("Ubuntu TV Extras")
                fontSize: "large"
            }
        }

        Grid {
            id: buttons
            spacing: 75
            columns: 4
            rows: 2
            anchors{
                top: parent.top
                topMargin: parent.height / 4
                left:parent.left
                leftMargin:  parent.width / 8

            }
            ItvButton {
                id:watchserie
                label:  u2d.tr("News")
                focus: true
                KeyNavigation.right: youtube
                KeyNavigation.left:weather
                KeyNavigation.down: sysset
                icon: "/usr/share/unity/lenses/news/news_blank.png"
                iconSourceSize.width: 128
                iconSourceSize.height: 128
                onClicked: activateLens("news.lens")
            }

            ItvButton {
                id:youtube
                label:  u2d.tr("YouTube")
                KeyNavigation.right: maps
                KeyNavigation.left: watchserie
                KeyNavigation.down: qtviewer
                icon: "../../launcher/artwork/icons/youtube-lens-active.png"
                onClicked: activateYoutube()
            }

            ItvButton {
                id:maps
                label:  u2d.tr("Maps")
                KeyNavigation.left:  youtube
                KeyNavigation.right: weather
                KeyNavigation.down: torrents
                icon: "../../launcher/artwork/icons/map-lens-active.png"
                onClicked:  activateNokiaMaps()   //activateLens("maps")
            }

            ItvButton {
                id: weather
                label:  u2d.tr("Unity 2d Settings")
                KeyNavigation.left: maps
                KeyNavigation.right: watchserie
                KeyNavigation.down: netflixs
                icon: "../../dash/artwork/unity-ubuntu.png"
                onClicked: activateDconfsettings()
                iconSourceSize.width: 128
                iconSourceSize.height: 128
            }
            ItvButton {
                id: sysset
                label:  u2d.tr("System Settings")
                KeyNavigation.left:netflixs
                KeyNavigation.right: qtviewer
                KeyNavigation.up: watchserie
                icon: "../../systeminfo/Systemsetting_images/wrench-active.png"
                onClicked: activateSystemsettings()
            }
            ItvButton {
                id:qtviewer
                label:  u2d.tr("Qt Viewer")
                KeyNavigation.right:torrents
                KeyNavigation.left: sysset
                KeyNavigation.up: youtube
                icon:"../../launcher/artwork/icons/iplayer-active.png"
                onClicked: activateQtvviewer()
            }

            ItvButton {
                id: torrents
                label:  u2d.tr("Torrents")
                KeyNavigation.right: netflixs
                KeyNavigation.left: qtviewer
                KeyNavigation.up: maps
                icon: "../../launcher/artwork/icons/torrent-lens-active.png"
                onClicked: activateLens("torrents.lens")
}
                SettingsMangerParser{
                id: netflixs
                KeyNavigation.up:weather
                KeyNavigation.left: torrents
                KeyNavigation.right: sysset
                icon: "/usr/share/netflix-desktop/NetflixIcon.png"
                iconSourceSize.width: 128
                iconSourceSize.height: 128
                desktopFile:  "netflix-desktop.desktop"

                }
            }
        }
    }
