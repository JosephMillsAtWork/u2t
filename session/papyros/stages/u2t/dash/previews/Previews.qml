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
 */

import QtQuick 1.0
import "../../common/units.js" as Units
import "../../common/utils.js" as Utils

FocusScope {
    id: previews
    property int category
    property string uri
    property variant dndUri
    property variant itemLensId
    property string mimeType
    property string name
    property string comment
    property string iconHint
    property bool active: false
    width: parent.width
    height:parent.height
    opacity: 0.0
    Behavior on opacity { NumberAnimation { duration: 800; easing.type: Easing.OutQuad } }
    signal exitRequested
    Keys.onPressed: {
        if (event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace || event.key === Qt.Key_Alt || event.key === Qt.Key_Tab || event.key === Qt.Key_Meta) {
            exitRequested()
        }
    }

    Rectangle {
        id: background
        color: unity2dConfiguration.formFactor === "tv" ? Qt.darker(unity2dConfiguration.averageBgColor,8) : "#88000000"
        anchors.fill: parent
        width: parent.width
        height:parent.height

    }

    Loader {
        id: previewLoader
        source: {
            if (mimeType == "") return ""
            else if (mimeType.substring(mimeType.lastIndexOf("/")+1) === "x-desktop")
                        return "ApplicationPreview.qml"
            else if (mimeType.indexOf("taglib/") == 0)
                        return "MusicPreview.qml"
            else if (Utils.removeExt(uri.substring(uri.lastIndexOf("http://")+7)) === "grooveshark")
                        return "MusicPreview.qml"
            else if (Utils.removeExt(uri.substring(uri.lastIndexOf("http://")+7)) === "tinysong")
                        return "MusicPreview.qml"
            else if (mimeType.indexOf("video/") == 0 && shellManager.dashActiveLens === "videos.lens")
                        return "MythTvPreview.qml"
            else if (mimeType.indexOf("image/") == 0)
                        return "ImagesPreview.qml"
            else if (shellManager.dashActiveLens === "news.lens" && mimeType.indexOf("text/") == 0)
                        return  "NewsPreviews.qml"
            else if (shellManager.dashActiveLens === "torrents.lens")
                        return "TorrentsPreview.qml"
            else if (mimeType.indexOf("inode/") === 0 )
                    return "DirPreviews.qml"
            else if (shellManager.dashActiveLens === "files.lens" && mimeType.indexOf("text/") == 0 || shellManager.dashActiveLens === "home.lens" && mimeType.indexOf("text/") == 0 || shellManager.dashActiveLens === "home.lens" && mimeType.substring(mimeType.lastIndexOf("/")+1) === "zip" || "x-deb" || "x-compressed-tar" || "pdf")
                        return "FilesPreview.qml"
           else {
                console.log("WARNING: there is not previewer capable of handling mimetype \n" + "\t\t\t" +mimeType + "\n Falling back to default previewer")
                return "DebugingPreviews.qml"
            }
        }
        anchors.fill: parent
        onLoaded: item.focus = true
        focus: true
    }
    Binding {
        target: previewLoader.item
        property: "uri"
        value: previewer.uri
        when: previewLoader.status == Loader.Ready
    }
    Binding {
        target: previewLoader.item
        property: "mimeType"
        value: previewer.mimeType
        when: previewLoader.status == Loader.Ready
    }
    Binding {
        target: previewLoader.item
        property: "name"
        value: previewer.name
        when: previewLoader.status == Loader.Ready
    }
    Binding {
        target: previewLoader.item
        property: "comment"
        value: previewer.comment
        when: previewLoader.status == Loader.Ready
    }
    Binding {
        target: previewLoader.item
        property: "iconHint"
        value: previewer.iconHint
        when: previewLoader.status == Loader.Ready
    }
    Binding {
        target: previewLoader.item
        property: "dndUri"
        value: previewer.dndUri
        when: previewLoader.status == Loader.Ready
    }
    Binding {
        target: previewLoader.item
        property: "itemLensId"
        value: previewer.itemLensId
        when: previewLoader.status == Loader.Ready
    }
    states: State {
        name: "shown"
        when: previews.active
        PropertyChanges { target: previews; opacity: 1.0 }
    }
}
