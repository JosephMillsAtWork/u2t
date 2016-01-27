import Qt 4.7
import "content"
import "../../dash"
Rectangle {
    id: page
    width:  parent.width; height: parent.height
    color: "transparent"
    property string currentSearchString: ""
    Component.onCompleted: { searchBar.focus = true }
    SearchBar {
        id: searchBar
        width: parent.width
        focus: true
        height:80
        anchors{
            top: parent.top
            topMargin: 25
       }
      onSearch: {
         currentSearchString = text;
            feedModel.newSearch(text);
     }
    }
    ListView {
        id: listView
        width: parent.width -10
        anchors.top: searchBar.bottom; anchors.topMargin: 5
        anchors.bottom: parent.bottom
        clip: true
        spacing: 10
        model: SeriesModel {
            id: feedModel;
            source: ''
            onStatusChanged: {
                if (status == XmlListModel.Loading){
                    progresDialog.text = "Searching '" + currentSearchString + "'";
                    page.state = 'Loading';
                } else {
                    page.state = '';
                }
            }
        }
        delegate: SeriesDelegate {
            onClicked:  {
                serieDelegate.loadDetails(seriesid, name, overview, banner);
                page.state = 'Serie';
            }
        }
    }
    SerieDelegate {
        id: serieDelegate
        opacity: 0.0
        anchors.fill: parent

                Behavior on x { NumberAnimation { from: listView.currentItem.x; to: 0; duration: 1000 }}
                Behavior on height { NumberAnimation { from: listView.currentItem.height; to: page.height; duration: 1000 }}
    }


    ProgresDialog {
        id: progresDialog;
        visible: false;
        anchors {horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter}
    }

    states: [
        State {
            name: "Serie"
            PropertyChanges {
                target: serieDelegate
                opacity: 1.0
            }

            PropertyChanges {
                target: listView
                opacity: 0.0
            }
            AnchorChanges {
                target: searchBar
                //anchors.top: parent.bottom
                anchors.bottom: parent.top
            }
        },
        State {
            name: "Loading"
            PropertyChanges {
                target: progresDialog
                visible: true
            }
        }
    ]

    transitions: [
        Transition {
            PropertyAnimation { properties: "opacity"; duration: 300}
            AnchorAnimation { duration: 300 }
        }
    ]
}
