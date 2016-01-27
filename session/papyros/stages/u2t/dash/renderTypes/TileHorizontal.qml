/*
 * This file is part of unity-2d
 *
 * Copyright 2011 Canonical Ltd.
 *
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
 * This File has be re-wrote By Joseph Mills <josephjamesmills@ubuntu.com>.
 */

import QtQuick 1.0
import Unity2d 1.0
import QtMultimediaKit 1.1
import "../../common"
import "../../common/units.js" as Units
import "../../common/utils.js" as Utils
import "../"

RendererGrid {
    cellWidth: Units.dtPx(280)
    cellHeight: Units.dtPx(75)
    minHorizontalSpacing: Units.dtPx(10)
    minVerticalSpacing: Units.dtPx(10)
    cellRenderer: Component {
        AbstractButton {
            id: button
            property string uri
            property string iconHint
            property string mimetype
            property string displayName
            property string comment
            property string dndUri
            Accessible.name: displayName
            Keys.onPressed: {
                if (event.key === Qt.Key_Return ){
                    activateUriWithLens(lens, uri, mimetype)
                }
            }
            MouseArea{
                anchors.fill: button
                acceptedButtons: Qt.RightButton
                onClicked: {
                    if (mouse.button === Qt.RightButton){
                        dash.showPreview(categoryId, uri, mimetype,displayName,comment,iconHint,dndUri,lens)
                    }
                }
            }
            DragItemWithUrl {
                anchors.fill: parent
                url: decodeURIComponent(dndUri)
                defaultAction: {
                    if (!url.indexOf("application://")) return Qt.CopyAction
                    else if (!url.indexOf("unity-install://")) return Qt.IgnoreAction
                    else return Qt.LinkAction
                }
                supportedActions: defaultAction
                delegate: Component {
                    Image {
                        source: icon.source
                        width: icon.width
                        height: icon.height
                        fillMode: icon.fillMode
                        sourceSize.width: width
                        sourceSize.height: height
                        asynchronous: true
                    }
                }
                onPressed: parent.pressed = true
                onReleased: {
                    parent.pressed = false
                    parent.clicked()
                }
                onDrop: parent.pressed = false
            }
            ButtonBackground {
                id: buttonBackground
                anchors.fill: parent
                anchors.margins: unity2dConfiguration.formFactor === "tv" ? 2 : 0
                state: button.state
            }
            MouseArea{
                anchors.fill: buttonBackground
                hoverEnabled: true
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
                onClicked:{
                    dash.activateUriWithLens(lens, uri, mimetype)
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

            Image {
                id: icon

                /* Heuristic: if iconHint does not contain a '/' then it is an icon name */
                source: iconHint != "" && iconHint.indexOf("/") == -1 ? "image://icons/" + iconHint : iconHint
                width: Units.dtPx(48)
                height: Units.dtPx(48)
                anchors{
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: Units.dtPx(15)
                }
                fillMode: Image.PreserveAspectFit
                sourceSize.width: width
                sourceSize.height: height
                asynchronous: true
                opacity: status == Image.Ready ? 1 : 0
                Behavior on opacity {NumberAnimation {duration: 200; easing.type: Easing.InOutQuad}}
            }

            Item {
                id: labels
                anchors{
                    top: icon.top
                    bottom: icon.bottom
                    left: icon.right
                    leftMargin: Units.dtPx(15)
                    right: parent.right
                    rightMargin: Units.dtPx(15)
                }

                TextCustom {
                    id: firstLine
                    text: displayName
                    color: button.state == "pressed" ? "#5e5e5e" : "#ffffff"
                    elide: Text.ElideMiddle
                    fontSize: "small"
                    anchors{
                        left: parent.left
                        right: parent.right
                        top: parent.top
                    }
                    height: paintedHeight
                }

                Text {
                    id: secondLine
                    text: comment
                    color: button.state == "pressed" ? "#888888" : "#cccccc"
                    font.pixelSize:  unity2dConfiguration.formFactor === "tv" ? 18 : 12
                    anchors{
                        left: parent.left
                        right: parent.right
                        top: firstLine.bottom
                        bottom: parent.bottom
                    }
                    clip: true
                    wrapMode: Text.Wrap
                    verticalAlignment: Text.AlignTop
                }
            }
        }
    }
}
