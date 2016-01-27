import Qt 4.7

Rectangle {
    id: searchBar
    height: 70
    color: "transparent"
    width: parent.width - 100
    signal search(string text);
    BorderImage {
        id: searchbar
        source: "../../../dash/artwork/search_background.png"
        width: parent.width - 100 ; height: 70
        border.left: 25; border.top: 25
        border.right: 25; border.bottom: 25
  }
    Image {
        id: magGlass
        source: "../../../dash/artwork/search_icon.png"
        anchors{
            left: searchbar.left
            leftMargin: 12
            verticalCenter:searchbar.verticalCenter
        }
    }
    SearchBox{
        id: searchBox
        state: 'Show'
        height: parent.height - 5
        focus: parent.focus
        anchors{
            left: magGlass.right
            leftMargin: 15
            right: parent.right
            rightMargin: 5
        }
        onReturnPressed: {
            if (searchBox.text !== '') {
                searchBar.search(searchBox.text);
                searchBox.text = ""
            }
        }

        states: [
            State {
                name: "Hide"
                PropertyChanges {
                    target: searchBox
                    opacity: 0.0
                }
            },
            State {
                name: "Show"
                PropertyChanges {
                    target: searchBox
                    opacity: 1.0
                }
            }
        ]
    }


}
