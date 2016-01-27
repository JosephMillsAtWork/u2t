import QtQuick 1.1
import Unity2d 1.0
import "../common"
import "filters/sidebar"
import "filters"
import "../common/units.js" as Units

SidebarView {
    id: lensSidebar
    height: column.height + spacing * 25
    property variant lens: null

    Column {
        id: column
        spacing: lensSidebar.spacing

        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
            topMargin: spacing
            bottomMargin: spacing
}
        Item {
            anchors{
                left: parent.left
                right: parent.right
                leftMargin: Units.tvPx(10)
            }
                height: title.paintedHeight + Units.tvPx(35)
            TextCustom {
                id: title
                anchors {
                    fill: parent
                    bottomMargin: Units.tvPx(20)
                }
                    color: "white"
                fontSize: "large"
                font.weight: Font.DemiBold
                verticalAlignment: Text.AlignBottom
                text: "Filter Lens"
            }
        }

        ListView {
            id: filters
            anchors{
                left: parent.left
                right: parent.right
            }
           height: childrenRect.height
            focus: true
            onActiveFocusChanged: {
                // Reset the focus to the first component
                if (!activeFocus) {
                    currentIndex = 0
                }
            }

            model: lens.filters
            delegate: SidebarFilterLoader {
                width: ListView.view.width
                lens: filterPane.lens
                filterModel: filter
                isFirst: index == 0
                container: lensSidebar.container
                containerYOffset: column.y + filters.y + y
                spacing: lensSidebar.spacing
            }
        }
    }
}
