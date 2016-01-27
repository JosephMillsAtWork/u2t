import QtQuick 2.0
import "../common"
import "../../../launcher"
import "../common/utils.js" as Utils
import Papyros.Components 0.1
import Papyros.Desktop 0.1
import Papyros.Indicators 0.1
Rectangle {
    color: baseSchema.averageBgColor
    width: parent.width
    height: parent.height

    //bfb
    Rectangle{
        id: bfb
        width: 64
        height: 64
        anchors.horizontalCenter: parent.horizontalCenter
    }

    // fav apps
    ListView{
        id: favAppsView
        height: parent.height
        width: parent.width
        spacing: 2
        anchors.top: bfb.bottom
        anchors.topMargin: 2
        anchors.horizontalCenter: parent.horizontalCenter
        model: launcherModel
        delegate: IconTile {
            width: 64
            height: width
            AppIcon{
                showColor: false
                iconName: dF.iconName
                hasIcon: dF.hasIcon
                name: dF && dF.name !== "" ? dF.name : "foo"
                width: 58
                height: 58
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked:{

                    dF.launch([])
                }
            }
            DesktopFile{
                id: dF
                appId:{
                    var cutDe = tx.substring(0,tx.lastIndexOf(".desktop"))
                    "/usr/share/applications/" + cutDe
                }
            }
        }

    }

    // BUG for some reason it can come up as text here
    // but not in a funciton ?

    Text{
        id: placeHolder
        opacity: 0
        text: {
            var fApps = baseSchema.favoriteApps
            var t  = baseSchema.favoriteApps
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
        interval: 1200
        repeat: false
        running: false
        onTriggered: {
            // make the favs model
            var ro = placeHolder.text
            var y = ro.split(",")
            console.log(ro)
            for (var i = 0 ; i < y.length ; i++){
                launcherModel.append({"tx" : y[i]})
            }
        }

    }






    ListModel{id: launcherModel}
    ListModel{id: openApps }
}
