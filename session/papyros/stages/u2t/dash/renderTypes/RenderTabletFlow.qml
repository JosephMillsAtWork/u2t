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
    property int contentHeight: Units.tvPx(420)

    ListView {
        id: flow
        property real margin: Units.tvPx(90)
        property real itemWidth: Units.tvPx(210)
        property int duration: 120
        anchors{
            fill: parent
            top:parent.top
            leftMargin: margin
            rightMargin: margin
        }
        cacheBuffer: margin*2
        focus: true
        orientation: ListView.Horizontal
        spacing: Units.tvPx(80)
        highlightMoveSpeed: -1
        highlightMoveDuration: 1300
        highlightRangeMode: ListView.ApplyRange
        preferredHighlightBegin: margin + itemWidth
        preferredHighlightEnd: width - margin - itemWidth
        snapMode: ListView.SnapToItem
        model: category_model

        delegate:AbstractButton {
            id: button
            property string uri: column_0
            property string iconHint: column_1
            property string categoryIndex: column_2
            property string mimetype: column_3
            property string name: column_4
            property string comment: column_5
            property string dndUri: column_6
            property variant segments: [-flow.itemWidth, 0.0, flow.width-flow.itemWidth, flow.width-flow.itemWidth+flow.itemWidth]
            property real absoluteX: button.x-flow.contentX
            property real angle
            property real origin

            angle: Utils.segmentsLinearInterpolation(segments, [63.0, 0.0, 0.0, -63.0], absoluteX)
            origin: Utils.segmentsLinearInterpolation(segments, [width, width, 0.0, 0.0], absoluteX)
            width: flow.itemWidth
            height: flow.height
            transform: Rotation {
                origin.x: button.origin;
                origin.y: height/2;
                axis { x: 0;
                    y: 1;
                    z: 0
                }
                angle: button.angle
            }
            scale: Utils.segmentsLinearInterpolation(segments, [0.8, 1.0, 1.0, 0.8], absoluteX)
            onClicked: dash.activateUriWithLens(lens, categoryId, uri, mimetype)

            BorderImage{
                source: "artwork/selection_glow.png"
                border.left: 45; border.top: 45
                border.right: 45; border.bottom: 45
                height:iconImage.height -60
                width: iconImage.width + 85
                anchors{
                    horizontalCenter: iconImage.horizontalCenter
                    verticalCenter: iconImage.verticalCenter
                }
                opacity: button.activeFocus ? 1.0 : 0.0
                Behavior on opacity {
                    NumberAnimation {
                        duration: 200;
                        easing.type: Easing.OutQuad
                    }
                }
            }

            Item {
                id: iconImage
                height: parent.height +1
                width: parent.width +1
                anchors{
                    top: parent.top
                    topMargin: Units.tvPx(-10)
                    left: parent.left
                    right: parent.right
                }
            }
            Image {
                id: image
                width: Units.tvPx(250)
                height: Units.tvPx(300)
                fillMode: Image.Stretch
                clip: true
                anchors{
                    centerIn: parent
                    top: parent.top
                    topMargin: Units.tvPx(120)
                }
                source:iconHint != "" && iconHint.indexOf("/") == -1 ? "image://icons/" + iconHint : iconHint
                sourceSize.width: width
                sourceSize.height: height
                smooth: true
                asynchronous: true
                scale: status == Image.Ready ? 1 : 0
                Behavior on scale {
                    NumberAnimation {
                        property: "scale";
                        from: .8
                        to:1
                        duration: 1200;
                        easing.type: Easing.OutBounce
                    }
                }
                opacity: status == Image.Ready ? 1.0 : 0.0
                Behavior on opacity {
                    NumberAnimation {
                        from: .8
                        to: 1
                        duration: 1000;
                        easing.type: Easing.OutElastic
                    }
                }
            }

            Rectangle {
                anchors.fill: iconImage
                opacity: button.state == "hovered" || button.state == "selected-hovered" ? 0.4 : 0.0
                Behavior on opacity { NumberAnimation { duration: 100 } }
            }

            TextMultiLine {
                property variant segments: [-flow.itemWidth, 0.0, flow.width-flow.itemWidth, flow.width-flow.itemWidth+flow.itemWidth]
                property real absoluteX: label.x-flow.contentX

                id: label
                text: name
                width: parent.width
                wrapMode: Text.WrapAnywhere
                color: "#ffffff"
                horizontalAlignment: Text.AlignHCenter
                fontSize: "small"
                style: Text.RichText
                styleColor: "#1e1e1e"
                anchors{
                    bottom: parent.bottom
                    right: parent.right
                    left: parent.left
                }

                Image {
                    height: parent.height
                    source: "artwork/coverflow_shadow.png"
                    anchors{
                        horizontalCenter: parent.horizontalCenter
                        bottom: parent.bottom
                    }
                }
            }
        }

    }
}
