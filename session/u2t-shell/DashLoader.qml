import QtQuick 2.0
import U2T.Menu 1.0
import QtQuick.Controls 1.2
Rectangle {
    width: 100
    height: 62
    color: "transparent"
    opacity: .9
    property bool shown: false
    onShownChanged: {
        if(shown === false){
             dashLoader.source = "dash/Dash.qml"
        }
    }

    // Open and Close Settings
    Rectangle{
        id: settingsRunner
        width: 32
        height: width
        color: "blue"
        radius: 20
        visible: shown  === true ? true : false
        anchors.right: parent.right
        MouseArea{
            anchors.fill:parent
            onClicked: {
                var g = dashLoader.source
                var e = g.toString()
                var t = e.substring(e.lastIndexOf("/")+1)
                if(t === "Dash.qml"){
                    dashLoader.source = "dash/U2tSettings.qml"
                }else{
                    dashLoader.source = "dash/Dash.qml"
                }
            }
        }
    }
    Loader{
        id: dashLoader
        width:  parent.width
        height: parent.height - bottomBar.height
        source: "dash/Dash.qml"
        anchors.top: parent.top
    }
    Rectangle{
        id: bottomBar
        width: parent.width
        height: pannel.height
        color: "#92000000"
        anchors.bottom: parent.bottom
    }
}
