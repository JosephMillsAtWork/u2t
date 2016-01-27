import QtQuick 2.0
import U2T.Menu 1.0
import QtQuick.Controls 1.2
Rectangle {
    width: 100
    height: 62
    color: u2tSettings.averageBgColor
    opacity: .88
    property bool shown: false
    TextField {
        id: searchBox
        width: parent.width -( settingsRunner.width*2)
        placeholderText: qsTr("Search...")
        anchors.top: parent.top
        anchors.topMargin: 5
    }
    GridView{
        id: aView
        cellWidth: parent.width / 3
        cellHeight: 70
        width: parent.width
        height: parent.height - bottomBar.height
        clip: true
        anchors.top:searchBox.bottom
        anchors.topMargin: 6
        model: SortFilterProxyModel{
            id: proxyModel
            source: allApps
            sortCaseSensitivity: Qt.CaseInsensitive
            filterString: "*" + searchBox.text + "*"
            filterSyntax: SortFilterProxyModel.Wildcard
            filterCaseSensitivity: Qt.CaseInsensitive
        }
        // FIX me Make many different views
        delegate: gridView
    }


    Component{
      id: gridView
        GridComponent {
    }
    }







}
