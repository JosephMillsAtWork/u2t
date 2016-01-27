import QtQuick 1.0

DropShadowEffect {
    property int overflow: 20

    anchors.centerIn: sourceItem
    width: sourceItem.width + overflow
    height: sourceItem.height + overflow
    color: "#DD4814" // Ubuntu Orange
    blur: 3
    opacity: sourceItem.opacity
}
