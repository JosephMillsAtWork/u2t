import QtQuick 1.0

Loader {
    property bool keepLoaded : true
    property url viewSource
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    width: parent.width
    x: status === Loader.Ready ? 0 : 1
    Behavior on x {
        NumberAnimation{from: 1300 ;to: 1 ; duration: 500}
    }

    function activationComplete() {
        if (typeof item.activationComplete != 'undefined') item.activationComplete();
    }

    function deactivationComplete() {
        if (typeof item.deactivationComplete != 'undefined') item.deactivationComplete();
        if (!keepLoaded)
            source = "";
    }

    function loadView() {
        if (status != Loader.Ready)
            source = viewSource;
    }
}
