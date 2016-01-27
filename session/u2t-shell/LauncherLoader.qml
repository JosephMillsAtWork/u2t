import QtQuick 2.0
import U2T.Menu 1.0
import "launcher"
Rectangle {
    color: u2tSettings.averageBgColor
    width: parent.width
    height: parent.height
    signal bfbClicked();

    LauncherItem {
        iconHint: "../artwork/user-trash.png"
        name: "trash"
        width: 64
        height: 64
        anchors.bottom: parent.bottom
        onClicked: {
        }
    }


    LauncherItem {
        id: bfb
        iconHint: "../artwork/distributor-logo-debian.png"
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
            isShortCut: true
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
        height:60 * mountCount
        property int mountCount: 0
        onCountChanged: {
            for (var i = 0 ; i < count; i++ ){
                var sto = storageModel.get(i).mounted
                if (sto === false ){
                     mountCount = mountCount + i;
                }
            }
        }

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
    ListView {
        id: openView
        width: parent.width
        height: 60 * count
        onAddChanged: { height = 60 * count ; console.log("THE COUNT CHANGED JPOSEPH ")}
        model: openApps
        anchors.top: deviceView.bottom
        anchors.topMargin: 2
        delegate: LauncherItem {
            iconHint:  "image://theme/" + icon
            name:  model.name   //appId + "\n" + desktopFile + "\n "+ actions
            width: 58
            height: 58
            onClicked: {
            }
        }

        remove: Transition {
            ParallelAnimation {
                NumberAnimation { property: "opacity"; to: 0; duration: 250 }
            }
        }

        removeDisplaced: Transition {
            SequentialAnimation {
                PauseAnimation { duration: 250 }
            }
        }

        move: Transition {
            SequentialAnimation {
                PauseAnimation { duration: 250 }
            }
        }

        moveDisplaced: Transition {
            SequentialAnimation {
                PauseAnimation { duration: 250 }
            }
        }

        add: Transition {
            ParallelAnimation {
                NumberAnimation {property:  "scale"; from: 0 ; to: 1;  duration:800 ; easing.type: Easing.OutQuart}
                NumberAnimation {property:  "opacity";from: 0 ; to: 1;  duration:800 }
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
        interval: 100
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
//    ListModel{id: openApps }

}

