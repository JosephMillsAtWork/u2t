/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * This file has been re-wrote by Joseph Mills <josephjamesmills@gmail.com>
*/

import QtQuick 1.0
import Unity2d 1.0
import QtMultimediaKit 1.1
import "../../common"
import "../../common/units.js" as Units
import "../../common/utils.js" as Utils
import  "../"
Renderer {
    needHeader: true
    currentItem: flow.currentItem
    /* FIXME: file bug joseph ....should be defined as a property of Renderer */
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
//                property string categoryIndex: column_2
                property string mimetype: column_3
                property string displayName: column_4
                property string comment: column_5
                property string dndUri: column_6
                Accessible.name: displayName
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
                Keys.onPressed: {
                    if (event.key === Qt.Key_Return ){
                        dash.activateUriWithLens(lens, uri, mimetype)
                    }
                }
                MouseArea{
                    anchors.fill: button
                    acceptedButtons:Qt.LeftButton | Qt.RightButton
                    hoverEnabled: true

                    onClicked: {
                        if (mouse.button === Qt.LeftButton){
                            dash.activateUriWithLens(lens, uri, mimetype)
                        }else if (mouse.button === Qt.RightButton){
                            dash.showPreview(categoryId, uri, mimetype,displayName,comment,iconHint,lens)
                        }
                    }
                    onEntered: {
                        if (mimetype.indexOf("taglib/") === 0 && dash2dConfiguration.musicHint === true){
                            musicPlayPlay.source = decodeURIComponent(uri.substring(uri.lastIndexOf(":")+3))
                            musicPlayPlay.play()
                            playplayRec.opacity = 1
                            button.state = "hovered"
                        }
                        else if (Utils.removeExt(uri.substring(uri.lastIndexOf("http://")+7)) === "grooveshark" && dash2dConfiguration.musicHint === true){
                            musicPlayPlay.source = decodeURIComponent(uri.substring(uri.lastIndexOf("http://")))
                            musicPlayPlay.play()
                            playplayRec.opacity = 1
                            button.state = "hovered"
                        }
                        else if (Utils.removeExt(uri.substring(uri.lastIndexOf("http://")+7)) === "tinysong" && dash2dConfiguration.musicHint === true){
                            musicPlayPlay.source = encodeURI(uri.substring(uri.lastIndexOf("http://")))
                            musicPlayPlay.play()
                            playplayRec.opacity = 1
                            button.state = "hovered"
                        }
                        else {
                            button.state = "hovered"
                        }
                    }
                    onExited:{
                        musicPlayPlay.pause()
                        button.state = ""
                    }
                }

                ButtonBackground {
                    anchors.fill: unity2dConfiguration.formFactor === "tv" ? image : parent
                    anchors.margins: unity2dConfiguration.formFactor === "tv" ? -14 : -10
                    state: button.state
                }
                Image {
                    id: image
                    width: unity2dConfiguration.formFactor === "tv" ? Units.tvPx(250) : Units.dtPx(100)
                    height:unity2dConfiguration.formFactor === "tv" ? Units.tvPx(300) : Units.dtPx(120)
                    fillMode: Image.Stretch
                    clip: true
                    anchors{
                        centerIn: parent
                        top: parent.top
                        topMargin: unity2dConfiguration.formFactor === "tv" ? Units.tvPx(120) : Units.dtPx(50)
                    }
                    source: iconHint != "" && iconHint.indexOf("/") == -1 ? "image://icons/" + iconHint : iconHint
                    sourceSize.width: width
                    sourceSize.height: height
                    smooth: true
                    asynchronous: true
                    scale: status == Image.Ready ? 1 : 0
                    Behavior on scale { NumberAnimation {property: "scale";from: .8;to:1;duration: 1200;easing.type: Easing.OutBounce}}
                    opacity: status == Image.Ready ? 1.0 : 0.0
                    Behavior on opacity { NumberAnimation {from: .8;to: 1;duration: 1000;easing.type: Easing.OutElastic}}
                }



                Text {
//                    property variant segments: [-flow.itemWidth, 0.0, flow.width-flow.itemWidth, flow.width-flow.itemWidth+flow.itemWidth]
//                    property real absoluteX: label.x-flow.contentX
                    id: label
                    smooth: true
                    text: displayName
                    width: image.width
                    font.pixelSize:  unity2dConfiguration.formFactor === "tv" ? 22 : 12
                    wrapMode: Text.WrapAnywhere
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    style: unity2dConfiguration.formfactor === "tv" ? Text.RichText : Text.Normal
                    styleColor: "#1e1e1e"
                    anchors{
                        bottom: parent.bottom
                        bottomMargin: unity2dConfiguration.formFactor === "tv" ? 0 : 10
                        right: parent.right
                        left: parent.left
                    }

                    Image {
                        visible: unity2dConfiguration.formFactor === "tv" ? true : false
                        height: parent.height
                        source: "../artwork/coverflow_shadow.png"
                        anchors{
                            horizontalCenter: parent.horizontalCenter
                            bottom: parent.bottom
                        }
                    }
                    Rectangle {
                        id: playplayRec
                        color: "transparent"
                        opacity: 0
                        width: 20
                        height: 20
                        Audio {
                            id: musicPlayPlay
                            source: ""
                            playing: false
                        }
                    }
                }
            }
        }
    }
