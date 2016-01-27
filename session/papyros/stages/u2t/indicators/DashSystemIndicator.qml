import QtQuick 1.0
import "../common/units.js" as Units

SystemIndicator {
    //||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    // |                Bring buttons to life
    //||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    background.opacity: active ? 0.7 : activeFocus ? 0.0 : 0
    aboutthiscomp.opacity: active ? 0.7 : activeFocus ? 0.0 : 0
    ubuntuhelp.opacity: active ? 0.7 : activeFocus ? 0.0 : 0
    systemsettings.opacity: active ? 0.7 : activeFocus ? 0.0 : 0
    lock.opacity: active ? 0.7 : activeFocus ? 0.0 : 0
    user.opacity: active ? 0.7 : activeFocus ? 0.0 : 0
    logout.opacity: active ? 0.7 : activeFocus ? 0.0 : 0
    suspend.opacity: active ? 0.7 : activeFocus ? 0.0 : 0
    restart.opacity: active ? 0.7 : activeFocus ? 0.0 : 0
    switchoff.opacity: active ? 0.7 : activeFocus ? 0.0 : 0

    //    |     boarderimages

//    backgroundboarder.opacity:  active ? 0.7 : activeFocus ? 0.0 : 0
//    aboutthiscompboarder.opacity: active ? 0.7 : activeFocus ? 0.0 : 0
//    ubuntuhelpboarder.opacity: active ? 0.7 : activeFocus ? 0.0 : 0
//    systemsettingsboarder.opacity: active ? 0.7 : activeFocus ? 0.0 : 0
//    lockboarder.opacity: active ? 0.7 : activeFocus ? 0.0 : 0
//    userboarder.opacity: active ? 0.7 : activeFocus ? 0.0 : 0
//    logoutboarder.opacity: active ? 0.7 : activeFocus ? 0.0 : 0
//    suspendboarder.opacity: active ? 0.7 : activeFocus ? 0.0 : 0
//    restartboarder.opacity:  active ? 0.7 : activeFocus ? 0.0 : 0
//    switchofboarder.opacity: active ? 0.7 : activeFocus ? 0.0 : 0

    //|||^^^^^^^FIXME ADDIN all the glow and also the borders like this ?^^^^^^



    Item {
        id: systemBarClip
        anchors.horizontalCenter: parent.horizontalCenter
        //        anchors.top: background.top
        //        anchors.topMargin: Units.tvPx(80)
        anchors.bottom: background.bottom
        height: background.height
        width: background.width
        visible: background.width != Units.tvPx(80)
        opacity: active ? 1 : 0
        clip: true

        Behavior on opacity { NumberAnimation {} }

        BorderImage {
            id: systemBarOutline

            anchors.bottom: systemBarClip.bottom
            anchors.bottomMargin: 10
            anchors.horizontalCenter: systemBarClip.horizontalCenter

            source: "artwork/sys_bar.sci"

            height: Units.tvPx(260)
            width: Units.tvPx(254)
            opacity: active ? 1 : 0
        }

        BorderImage {
            id: systemBarFiller
            source: "artwork/sys_filler.sci"

            anchors.horizontalCenter: systemBarOutline.horizontalCenter
            anchors.bottom: systemBarOutline.bottom
            width: Units.tvPx(58)
            opacity: active ? 1 : 0
            height: Units.tvPx(Math.round(58 + shell.volume * 202))
        }
    }
}
