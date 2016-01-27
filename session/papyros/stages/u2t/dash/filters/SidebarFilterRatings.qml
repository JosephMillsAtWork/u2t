import QtQuick 1.0
import "../../common"
import "sidebar"
import "../../common/units.js" as Units
import "../previews"
SidebarFilter {
    id: filter
    ExpandingDropDown {
        id: dropDown
        width: Units.tvPx(470)
        anchors.horizontalCenter: parent.horizontalCenter
        container: parent.container
        containerYOffset: parent.containerYOffset
        spacing: parent.spacing
        minItems: 6
        focus: true
        selectedIndex: filterModel.rating
        label: modelData.name
        model: 6
        delegate:
            Item {
            id: item
            anchors{
                left: parent.left
                right: parent.right
            }
            // FIXME this somehow results in a binding loop sometimes
            height: dropDown.itemHeight
            property int rating: index

            TextCustom {
                anchors.centerIn: parent
                text: "All"
                color: "white"
                fontSize: "small"
                visible: item.rating == 0
            }

            Row {
                anchors.centerIn: parent
                visible: item.rating > 0

                Repeater {
                    model: 5
                    Star {
                        fill: item.rating > index ? 1.0 : 0.0
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                enabled: dropDown.state == "expanded"
                onClicked: { dropDown.selectedIndex = index; dropDown.close() }
            }
        }

        onSelectedItemChanged: {
            if (selectedItem) {
                filterModel.rating = selectedItem.rating
            }
        }
    }
}
