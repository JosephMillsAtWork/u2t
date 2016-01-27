// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../../common/utils.js" as Utils
Rectangle {
    id: root
    width: parent.width
    height: parent.height
    color: "#EAEAEA"
    Text {
        id: newspaperId
        width:root.width
        height: root.height / 8
        color: "#3a3030"
        text: name.substring(name.lastIndexOf("\ -")+2)
        font.pointSize: 52
        font.family: "URW Chancery L"
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WrapAnywhere
        smooth: true
        y: root.height / 20
    }
    Rectangle{
        id:topSpep1
        width: root.width - 20
        height: 2
        color: "black"
        x: 10
        anchors{
            top: newspaperId.bottom
            topMargin: 12
        }
    }
    Text {
        id: date
        text: Utils.now.toDateString()
        font.pointSize: 12
        width:root.width
        height: 12
        color: "#3a3030"
        anchors{
            top:topSpep1.bottom
            topMargin: 5
            left: topSpep1.left
            leftMargin: 10
        }
    }
    Rectangle{
        id:topSpep2
        width: root.width - 20
        height: 5
        color: "black"
        x: 10
        anchors{
            top: date.bottom
            topMargin: 12
        }
    }
    Text {
        id: price
        text: "Free"
        font.bold: true
        font.italic: true
        font.pointSize: 12
        width: 100
        color: "#3a3030"
        x: root.width - width
        anchors{
            bottom:topSpep2.top
            bottomMargin: 4
        }
    }
    Text {
        id: subject
        text: name.substring(0,name.lastIndexOf("-"))
        font.pointSize: root.height / 22
        font.family: "Impact"
        width: root.width
        wrapMode: Text.WordWrap
        height: 40
        horizontalAlignment: Text.AlignHCenter
        anchors{
            top: price.bottom
            topMargin: root.height / 25
        }
    }
    Rectangle{
        id: imageBackground
        width: root.width / 2
        height: root.height / 2
        color: "#44000000"
        anchors{
            top: subject.bottom
            topMargin:  root.height/ 11
            horizontalCenter: subject.horizontalCenter
        }
    }
    Image {
        id: mainImage
        source: iconHint
        smooth: true
        sourceSize.height: imageBackground.height
        sourceSize.width: imageBackground.width
        anchors.fill: imageBackground
    }
    Text {
        id: source
        font.bold: true
        color: "#3a3030"
        text: u2d.tr("source: ")
        horizontalAlignment: Text.AlignHCenter
        y: root.height - 20
        x: 20
    }
    Text{
        id:link
        text: uri.substring(uri.lastIndexOf("&url=")+5)
        color: "#3a3030"
        anchors{
            left: source.right
            bottom: source.bottom
        }
    }
    MouseArea{
        anchors.fill: link
        hoverEnabled: true
        onEntered:{
            link.font.underline = true
            link.color = "blue"
        }
        onExited:{
            link.color = "#3a3030"
            link.font.underline = false
        }
        onClicked:{
            shellManager.dashActive = false
            dash.activateUriWithLens(itemLensId, uri, mimeType)
            dash.hidePreview()
        }
    }
}
