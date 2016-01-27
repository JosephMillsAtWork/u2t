// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item{
    BorderImage {
        id: placetxt
        source: "../../../dash/artwork/search_background_clear.png"
        width: parent.width; height:parent.height
        border.left: 25; border.top: 25
        border.right: 25; border.bottom: 25
        Flickable{
            id: asdf
            anchors.fill: placetxt
            contentWidth: placetxt.width; contentHeight: placetxt.height
            flickableDirection: Flickable.VerticalFlick
            TextEdit {
                color: "white"
                font.pixelSize: 22
                text: serie.overview
                readOnly: true
                wrapMode: TextEdit.Wrap
                anchors{
                    left:parent.left + 7
                    right: parent.right -7
                    top:parent.top + 7
                    bottom: parent.bottom -7
                    fill: parent
                }
            }
            MouseArea{
                id:maintxtrightclick
                anchors.fill: placetxt
            }
        }
    }
}
