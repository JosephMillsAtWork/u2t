import QtQuick 1.0
import Unity2d 1.0
import "../../common"
import "../../common/units.js" as Units
import "../../common/utils.js" as Utils
import "../"
Renderer {
    needHeader: true
    currentItem: flow.currentItem
    /* FIXME: should be defined as a property of Renderer */
    property int contentHeight: Units.tvPx(540)

    ListView {
        id: flow

        property real margin: Units.tvPx(90)
        property real itemWidth: Units.tvPx(210)

        property int duration: 120

        anchors.fill: parent
        anchors.topMargin: Units.tvPx(140)
        anchors.bottomMargin: Units.tvPx(60)
        /* Make sure the first and last items are offsetted by margin */
        anchors.leftMargin: margin
        anchors.rightMargin: margin
        cacheBuffer: margin*2
        focus: true
        orientation: ListView.Horizontal
        spacing: Units.tvPx(80)
        highlightMoveSpeed: -1
        highlightMoveDuration: 230
        highlightRangeMode: ListView.ApplyRange
        preferredHighlightBegin: margin + itemWidth
        preferredHighlightEnd: width - margin - itemWidth
        snapMode: ListView.SnapToItem
        model: category_model

        delegate: AbstractButton {
            id: button

            property string uri: column_0
            property string iconHint: column_1
            property string categoryIndex: column_2
            property string mimetype: column_3
            property string name: column_4
            property string comment: column_5
            property string dndUri: column_6

            width: flow.itemWidth
            height: flow.height

            property variant segments: [-flow.itemWidth, 0.0, flow.width-flow.itemWidth, flow.width-flow.itemWidth+flow.itemWidth]
            property real absoluteX: button.x-flow.contentX

            property real angle
            angle: Utils.segmentsLinearInterpolation(segments, [63.0, 0.0, 0.0, -63.0], absoluteX)
            property real origin
            origin: Utils.segmentsLinearInterpolation(segments, [width, width, 0.0, 0.0], absoluteX)
            //Behavior on angle {SmoothedAnimation {durshadowation: flow.duration; velocity: -1}}
            transform: Rotation { origin.x: button.origin; origin.y: height/2; axis { x: 0; y: 1; z: 0 } angle: button.angle}

            scale: Utils.segmentsLinearInterpolation(segments, [0.8, 1.0, 1.0, 0.8], absoluteX)
            //Behavior on scale {SmoothedAnimation {duration: flow.duration; velocity: -1}}

            onClicked: dash.activateUriWithLens(lens, categoryId, uri, mimetype)

            Item {
                id: iconImage

                anchors.top: parent.top
                anchors.topMargin: Units.tvPx(-10)
                height: Units.tvPx(225)
                anchors.left: parent.left
                anchors.right: parent.right
                Item {
                    width: parent.width
                    height: parent.height
//                    anchors.centerIn

                    Image {
                        //anchors.verticalCenter: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: Units.tvPx(350)
                        width: Units.tvPx(380)
                        height: Units.tvPx(120)
                        source: "artwork/coverflow_shadow.png"
                        fillMode: Image.Center
                    }

                    Image {
                        source: "artwork/selection_glow.png"
                        anchors.fill: image
//                        height: Units.tvPx(350)
                        anchors.margins: Units.tvPx(-45)
                        opacity: button.activeFocus ? 1.0 : 0.0
                        Behavior on opacity {NumberAnimation {duration: 200; easing.type: Easing.OutQuad}}
                    }

                    Rectangle {
                        id: outline
                        anchors.fill: parent
                        anchors.margins: Units.tvPx(-2)
                        color: "#00000000"
                        smooth: true
                        border.width: Units.tvPx(1)
                        border.color: "transparent"
                        radius: Units.tvPx(2)
                    }

                    Image {
                        id: image

                        anchors.centerIn: parent
                        anchors.top: parent.top
                        anchors.topMargin: Units.tvPx(120)
                        width: Units.tvPx(250)
                        height: Units.tvPx(400)
                        fillMode: Image.Stretch
                        clip: true
                        source:if(status == Image.Error ){
                               "image://icons/"+iconHint;
                               }else if(status !== Image.Error){
                               iconHint;
}

                        sourceSize.width: width
                        sourceSize.height: height
                        smooth: true
                        asynchronous: true
                        opacity: status == Image.Ready ? 1.0 : 0.0
                        Behavior on opacity {NumberAnimation {duration: 200; easing.type: Easing.InOutQuad}}
                    }

                    Rectangle {
                        id: txtrectangle
                        anchors.fill: image.Center
                        anchors.top: parent.top
                        anchors.topMargin: Units.tvPx(250)
                        opacity: button.state == "hovered" || button.state == "selected-hovered" ? 0.4 : 0.0
                        Behavior on opacity { NumberAnimation { duration: 100 } }
                    }

                    TextMultiLine {
                        id: label
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        anchors.top: txtrectangle.bottom
//                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        anchors.left: parent.left
                        anchors.topMargin: Units.tvPx(80)

                        text: name
                        opacity: Utils.segmentsLinearInterpolation(segments, [0.0, 1.0, 1.0, 0.0], absoluteX)
                        //Behavior on opacity {SmoothedAnimation {duration: flow.duration; velocity: -1}}
                        color: "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        fontSize: "small"
                        style: Text.Raised
                        styleColor: "#1e1e1e"
                    }
                }
            }
        }
    }
}
