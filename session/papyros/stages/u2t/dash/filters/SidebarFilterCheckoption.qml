import QtQuick 1.0
import "../../common"
import "sidebar"
import "../../common/units.js" as Units

SidebarFilter {
    id: filter

    ExpandingDropDown {
        id: dropDown
        width: Units.tvPx(470)
        anchors.horizontalCenter: parent.horizontalCenter
        container: parent.container
        containerYOffset: parent.containerYOffset
        spacing: parent.spacing
        focus: true
        label: modelData.name
        model: modelData.options
        selectedIndex: modelData.filtering ? modelData.options.activeIndex : 0
        delegate:
            Item {
            property variant option: item
            anchors.left: parent.left; anchors.right: parent.right
            height: itemHeight
            TextCustom {
                text: item.name
                anchors.fill: parent
                color: "white"
                fontSize: "small"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                MouseArea {
                    anchors.fill: parent
                    enabled: dropDown.state == "expanded"
                    onClicked: { dropDown.selectedIndex = index; dropDown.close() }
                }
            }
        }

        onSelectedItemChanged: if (selectedItem) selectedItem.option.active = true
    }
}
