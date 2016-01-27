import QtQuick 2.3
import QtQuick.Controls 1.2
Column {
    width: parent.width
    height: parent.height
    // averageBgColor
    Rectangle{
        height: 40
        width: parent.width - 20
        color: u2tSettings.averageBgColor
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            color: "white"
            text: qsTr("Average Background Color %1").arg(u2tSettings.averageBgColor)
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                colorDialog.open()
            }
        }
    }

    //favorite-apps
    Rectangle{
        height: 40 * 2
        width: parent.width - 20
        color: "transparent"
//        radius: 5
//        border{ width:1 ;color: "white" }
        anchors.horizontalCenter: parent.horizontalCenter
        Column{
            width: parent.width
            height: parent.height
            spacing: 1
            Text {
                color: "white"
                text: qsTr("Fav Applicaitons")
            }
            Text{
                color: "white"
                width: parent.width
                text:{
                   var fin = ""
                   var fL = u2tSettings.favoriteApps
                   var fLS = fL.toString()
                   var fLA = fLS.split(",")

                    for (var i = 0 ; i < fLA.length; i++){
                        var er = fLA[i]
                        fin += er.replace(".desktop" ," ")
                    }
                    fin


                }
            }
            ComboBox{
                model: allDesktopFiles
                width: parent.width
//                onCurrentIndexChanged:
//                    console.log("add this " + currentText)
            }
        }

    }



    // FORM Factor




    //favorite-apps
    Rectangle{
        height: 40 * 2
        width: parent.width - 20
        color: "transparent"
//        radius: 5
//        border{ width:1 ;color: "white" }
        anchors.horizontalCenter: parent.horizontalCenter
        Column{
            width: parent.width
            height: parent.height
            spacing: 1
            Text {
                color: "white"
                text: qsTr("Form Factor")
            }
            Text{
                color: "white"
                width: parent.width
                text:{
                    "Current Form Factor " + u2tSettings.formFactor
                }
            }
            ComboBox{
                model: formFactorModel
                width: parent.width
                onCurrentIndexChanged: u2tSettings.formFactor = currentText
            }
        }

    }




    // background
    Rectangle{
        height: 40
        width: parent.width - 20
        color: u2tSettings.averageBgColor
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            color: "white"
            text: qsTr("Background %1").arg(u2tSettings.background)
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                fileDialog.open()
            }
        }
    }






}



