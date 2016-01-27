import QtQuick 1.0
import QtWebKit 1.0
import "../../common"
import"../../systeminfo"


Rectangle {
    id: webBrowser
    property string urlString : dash2dConfiguration.mythipBackend.substring(0,dash2dConfiguration.mythipBackend.lastIndexOf(":")) + "/mythweb/tv/list"
    width: parent.width; height: parent.height
    color: "#343434"
    FlicableWebView {
        id: webView
        url: webBrowser.urlString
        onProgressChanged: header.urlChanged = false
        anchors {
            top: headerSpace.bottom;
            left: parent.left;
            right: parent.right;
            bottom: parent.bottom
        }
    }

    Item {
        id: headerSpace;
        width: parent.width;
        height: 0
    }

//    SettingsMangerParser {
//        visible: false
//        icon: "/usr/share/pixmaps/mythtv.png"
//        id:mythfrontend
//        x: 900
//        smooth: true
//        desktopFile: "mythtv.desktop"
//    }
    BrowserScrollbars {
        scrollArea: webView; width: 8
        anchors { right: parent.right; top: header.bottom; bottom: parent.bottom }
    }

    BrowserScrollbars{
        scrollArea: webView; height: 8; orientation: Qt.Horizontal
        anchors { right: parent.right; rightMargin: 8; left: parent.left; bottom: parent.bottom }
    }


//    Row{
//        id:testbutton
//        PictureGlowButton{
//            id:drendering
//            text: "testing 1"
//            onClicked: declarativeView.activeLens = activateQtvviewer
//        }
//        PictureGlowButton{
//            id:fanart
//            text: "Testing 2"
//            onClicked: declarativeView.activeLens = activateVideffect
//        }
//        PictureGlowButton{
//            id:showmythbuttons
//            text: "Luanch Myth"
//            onClicked: mythfrontend.visible = "" ? mythfrontend.visible = "" : mythfrontend.visible = true
//        }
    }
    //    Header {
    //        id: header
    //        editUrl: webBrowser.urlString
    //        width: headerSpace.width; height: headerSpace.height
    //    }


//}
