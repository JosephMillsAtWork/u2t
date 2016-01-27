import QtQuick 2.0
import U2T.Menu 1.0
import "launcher"
Rectangle {
    color: u2tSettings.averageBgColor
    width: parent.width
    height: parent.height
    signal bfbClicked();

    LauncherItem {
        iconHint: "qrc:/artwork/user-trash.png"
        name: "trash"
        width: 64
        height: 64
        anchors.bottom: parent.bottom
        onClicked: {
        }
    }


    LauncherItem {
        id: bfb
        iconHint: "qrc:/artwork/distributor-logo-debian.png"
        name:"Open Dash"
        width: 58
        height: 58
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: {
            bfbClicked()
        }
    }

    // fav apps
    ListView{
        id: favAppsView
        height: 60 * launcherModel.count
        width: parent.width
        spacing: 2
        anchors.top: bfb.bottom
        anchors.topMargin: 2
        anchors.horizontalCenter: parent.horizontalCenter
        model: launcherModel
        delegate: LauncherItem {
            iconHint: "image://theme/" + dF.icon
            name: dF.name
            width: 58
            height: 58
            onClicked: {
            }

            DesktopEntry{
                id: dF
                filePath: {
                    "/usr/share/applications/" +tx
                }
            }
        }
    }
    ListView {
        id: deviceView
        width: parent.width
        height: parent.height
        model: storageModel
        anchors.top: favAppsView.bottom
        anchors.topMargin: 2
        delegate: LauncherItem {
            iconHint:  "image://theme/drive-harddisk"
            name: hdName
            visible: mounted ? false : true
            width: mounted ? 0:58
            height:mounted ? 0: 58
            onClicked: {
            }
        }
    }


    // BUG for some reason it can come up as text here
    // but not in a funciton ?

    Text{
        id: placeHolder
        opacity: 0
        text: {
            var fApps = u2tSettings.favoriteApps
            var t  = u2tSettings.favoriteApps
            var ro = t.toString()
            ro
        }
        Component.onCompleted: {
            racer.start()
        }
    }
    // er
    Timer{
        id: racer
        interval: 200
        repeat: false
        running: false
        onTriggered: {
            // make the favs model
            var ro = placeHolder.text
            var y = ro.split(",")
//            console.log(ro)
            for (var i = 0 ; i < y.length ; i++){
                launcherModel.append({"tx" : y[i]})
            }
        }

    }
    ListModel{id: launcherModel}
    ListModel{id: openApps }

}

