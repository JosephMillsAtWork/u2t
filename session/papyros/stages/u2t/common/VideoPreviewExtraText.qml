import QtQuick 1.1
import "../common"
import "../common/units.js" as Units
import "../dash"
import "../dash/previews"


Item {
    id: startingtxt
    height: Units.tvPx(1200)
    width: Units.tvPx(501)
    BorderImage {
        id : bordersreal
        source: "../dash/artwork/search_background_clear.png"
        width: 530; height: 550
        anchors.centerIn: borders
        border.left: 25; border.top: 25
        border.right: 25; border.bottom: 25
        opacity: 1
    }
    BorderImage {
        id : borders
        source: "../artwork/search_background.png"
        width: 530; height: 550
        anchors.centerIn: txtbackground
        border.left: 25; border.top: 25
        border.right: 25; border.bottom: 25
        //   opacity: .72
    }

    PreviewImageBox {
        id: txtbackground
        anchors.top: parent.top
        anchors.topMargin: Units.tvPx(200)
        anchors.left: parent.left
        anchors.leftMargin: Units.tvPx(530)
        //        property variant height
        width: Units.tvPx(499)
        height:Units.tvPx(520)
        color: "Transparent"
        opacity: .95
        clip: true

    }
}
