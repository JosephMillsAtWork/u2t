/*
 * This file is part of unity-2d
 *
 * Copyright 2010-2011 Canonical Ltd.
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
 * This File has be re-wrote By Joseph Mills <josephjamesmills@ubuntu.com>
 */

import QtQuick 1.1
import Unity2d 1.0
import QtMultimediaKit 1.1
import "../../common"
import "../../common/units.js" as Units
import "../../common/utils.js" as Utils
import "../"
import  "../../3rdparty/BackgroundSwitcher/"

RendererGrid {
    cellWidth: Units.dtPx(100)
    cellHeight: Units.dtPx(112)
    minHorizontalSpacing: Units.dtPx(42)
    minVerticalSpacing: Units.dtPx(20)
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
            DragItemWithUrl {
                anchors.fill: parent
                url: decodeURIComponent(dndUri)
                defaultAction: {
                    if (!url.indexOf("application://"))
                        return Qt.CopyAction
                    else if (!url.indexOf("unity-install://"))
                        return Qt.IgnoreAction
                    else
                        return Qt.LinkAction
                }
                supportedActions: defaultAction
                delegate: Component{
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
                onPressed:{
                    parent.pressed = true
                    buttonBackground.visible = false
                }
                onReleased: {
                    buttonBackground.visible   = false
                    parent.pressed = false
                    parent.clicked()
                }
                onDrop: parent.pressed = false
                }

            ButtonBackground {
                id: buttonBackground
                state: button.state
                anchors{
                    fill:  unity2dConfiguration.formFactor === "tv" ? icon : parent
                    margins:  unity2dConfiguration.formFactor === "tv" ? -2 : 0
                }
            }
            MouseArea{
                anchors.fill: buttonBackground
                hoverEnabled: true
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onEntered: {
                    if (mimetype.indexOf("taglib/") === 0 && dash2dConfiguration.musicHint === true){
                        musicPlayPlay.source = decodeURIComponent(uri.substring(uri.lastIndexOf(":")+3))
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
                    if (mouse.button === Qt.RightButton){
                        dash.showPreview(categoryId, uri, mimetype,displayName,comment,iconHint,dndUri,lens)
                        console.log(iconHint)
                    }
                    else if (mouse.button === Qt.LeftButton)
                    dash.activateUriWithLens(lens, uri, mimetype)

                }
            }
            Image {
                id: icon
                source: iconHint.indexOf("http://") == 0 ? iconHint : "image://icons/" + (iconHint != "" ? iconHint : "unknown")
                onStatusChanged: if (status == Image.Error) source = "image://icons/unknown"
                width: Units.dtPx(64)
                height: Units.dtPx(64)
                anchors{
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    topMargin: Units.dtPx(4)
                }
                fillMode: Image.PreserveAspectFit
                sourceSize.width: width
                sourceSize.height: height
                asynchronous: true
                opacity: status == Image.Ready ? 1 : 0
                Behavior on opacity {NumberAnimation {duration: 200; easing.type: Easing.OutQuad}}
            }

            TextCustom {
                id: label
                text:  displayName
                color: "white"
                width: parent.width
                font.pixelSize:  unity2dConfiguration.formFactor === "tv" ? 18 : 12
//                state: ( parent.state == "selected" || parent.state == "hovered" ) ? "expanded" : ""
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                anchors{
                    top: icon.bottom
                    topMargin: 10

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
        } //renderButton
    } //Component
} //RendererGrid
