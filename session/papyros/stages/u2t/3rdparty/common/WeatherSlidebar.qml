import QtQuick 1.0
import "../sidebar"
import "../common"
import "../common/units.js" as Units
import "../WeatherWindow.qml" as Weather
SidebarView {
    id: root
    height: column.height + spacing * 2
    firstItem: differentcits

    property variant video: null

    Column {
        id: column
        spacing: parent.spacing

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: spacing

        Item {
            height: title.paintedHeight + Units.tvPx(37)
            width: Units.tvPx(470)
            anchors.horizontalCenter: parent.horizontalCenter

        }

        ExpandingDropDown {
            id: differentcits
            width: Units.tvPx(470)
            anchors.horizontalCenter: parent.horizontalCenter
            container: videoSidebar.container
            spacing: parent.spacing
            label: "cityList"
            WeatherListView{
                 id: listView
                 anchors { top: banner.bottom; bottom: parent.bottom; left: parent.left; right: parent.right }

                 scrollbar: false
                 focus: true
                 model: cityList

                 delegate: Item {
                     id: delegateItem
                     width: listView.width
                     height: thistext.height + 8
                     Image {
                         anchors.fill: parent;
                         source:  "common/artwork/" + (delegateItem.ListView.isCurrentItem ? "MenuItemFO.png" : "MenuItemNF.png");
                     }
                     Text {
                         id: thistext
                         anchors.verticalCenter: parent.verticalCenter
                         color: "white"
                         text: name
                     }
                     MouseArea {
                         anchors.fill: parent;
                         hoverEnabled: true
                         onEntered:
                             delegateItem.ListView.view.currentIndex = index
                         onClicked:
                             showCast(name)
                     }
                     Keys.onEnterPressed: {
                         showCast(name)
                         event.accepted = true
                     }
                 }
             }

            model: ListModel {
                id: cityList
                ListElement { name: "Amsterdam" }
                ListElement { name: "Atlanta" }
                ListElement { name: "Bangalore" }
                ListElement { name: "Bangkok" }
                ListElement { name: "Barcelona" }
                ListElement { name: "Beijing" }
                ListElement { name: "Berlin" }
                ListElement { name: "Bogota" }
                ListElement { name: "Boston" }
                ListElement { name: "Cape Town" }
                ListElement { name: "Casablanca" }
                ListElement { name: "Durban" }
                ListElement { name: "Helsinki" }
                ListElement { name: "Juneau" }
                ListElement { name: "Landshut" }
                ListElement { name: "Las Vegas" }
                ListElement { name: "Lhasa" }
                ListElement { name: "Lima" }
                ListElement { name: "London" }
                ListElement { name: "Manila" }
                ListElement { name: "Munich" }
                ListElement { name: "Moscow" }
                ListElement { name: "New York" }
                ListElement { name: "Nuuk" }
                ListElement { name: "Paris" }
                ListElement { name: "Rome" }
                ListElement { name: "San Francisco" }
                ListElement { name: "Seoul" }
                ListElement { name: "Sydney" }
                ListElement { name: "Tokyo" }
                ListElement { name: "Ulm" }
                ListElement { name: "Untermarchtal" }
            }
            selectedIndex: 1
        }

        Rectangle {
            width: Units.tvPx(500)
            height: Units.tvPx(2)
            color: "white"
            opacity: 0.25
        }


        SidebarScrollingComponent {
            id: info
            container: videoSidebar.container
            spacing: parent.spacing
            height: movieInfoHeader.height + movieInfo.height
            width: Units.tvPx(470)
            anchors.horizontalCenter: parent.horizontalCenter
            KeyNavigation.up: subtitles

            TextCustom {
                id: movieInfoHeader
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                color: "white"
                fontSize: "small"
                font.weight: Font.DemiBold
                text: u2d.tr("Movie info")
            }

            TextCustom {
                id: movieInfo
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: movieInfoHeader.bottom
                anchors.topMargin: Units.tvPx(30)
                wrapMode: Text.Wrap
                color: "white"
                fontSize: "small"
                property string baseText: u2d.tr('%1<br><br><b>Director:</b> %2<br><br><b>Cast:</b> %3')
                text: (player.nfo.video) ? baseText.arg((player.nfo.video.plot) ? player.nfo.video.plot : "")
                                           .arg((player.nfo.video.director) ? player.nfo.video.director : "")
                                           .arg(player.nfo.getActors().join(", ")) : ""

            }
        }
    }
}
