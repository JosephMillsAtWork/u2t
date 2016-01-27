import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 1.4

Window {
    width: Screen.width / 2
    height: Screen.height / 2
    color: "#C7c7c7"
    visible:  false
    Loader{
        anchors.fill: parent
        sourceComponent: systemSettingsMain

    }
    Component{
        id: systemSettingsMain
        SystemSettingsMain{
    }
    }



}

