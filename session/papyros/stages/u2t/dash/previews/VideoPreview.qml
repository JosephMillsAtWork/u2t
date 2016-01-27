import QtQuick 1.0
import "../../common"
FocusScope {
    id: preview
    property string uri
    property variant dndUri
    property variant itemLensId
    property int category
    property variant nfo
    property variant buttons
    property string name
    property string iconHint
    property string comment
    property string lens: dashLoader.item.lenses
    nfo: VideoInfo {
        uri: preview.uri
    }
    MouseArea {
        anchors.fill: parent
    }
}
