import QtQuick 1.1
import "../"
Rectangle {
//    width: parent.width
//    height: parent.height
    color:"black"

Text {
        font.pixelSize:  22
        color: "white"
        width: parent.width
        wrapMode: Text.WordWrap
        text: "mimeType:  " + mimeType + "\n"
              + "name:   " +name + "\n"
              + "uri:   " + uri + "\n"
              + "category Aka Row that the lens is in:    " +  category + "\n"
              + "comment:   " +  comment + "\n"
              + "iconHint:   " +  iconHint + "\n"
              + "dashloader lenes ID:  " +  dashLoader.item.lenses + "\n"
              + "LensName:   " +  shellManager.dashActiveLens + "\n"
              + "DashShell:   " + shellManager.dashShell + "\n"
              + "LastFocused Window Id:   " + shellManager.lastFocusedWindow + "\n"
              + "Currant Page:   " + dashLoader.item.currentPage + "\n"
              + "dndUri:   " + dndUri + "\n"
              + "Item LensID: " +  itemLensId


    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    }
}
