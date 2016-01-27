import QtQuick 1.0
import "../../common"
import "../../common/utils.js" as Utils

FocusScope {
    id: filterLoader
    property variant lens
    property variant filterModel
    property variant container
    property variant containerYOffset
    property int spacing
    property bool isFirst
    height: childrenRect.height + spacing

    Loader {
        id: filterView
        focus: true
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
        }
        source: "Sidebar" + Utils.convertToCamelCase(filterModel.rendererName) + ".qml"
        onStatusChanged: {
            if (status == Loader.Error) {
                console.log("Failed to load filter renderer", filterModel.rendererName)
            }
        }

        Binding { target: filterView.item; property: "lens"; value: filterLoader.lens }
        Binding { target: filterView.item; property: "filterModel"; value: filterLoader.filterModel }
        Binding { target: filterView.item; property: "container"; value: filterLoader.container }
        Binding { target: filterView.item; property: "containerYOffset"; value: filterLoader.containerYOffset }
        Binding { target: filterView.item; property: "spacing"; value: filterLoader.spacing }
        onLoaded: item.focus = true
    }
}
