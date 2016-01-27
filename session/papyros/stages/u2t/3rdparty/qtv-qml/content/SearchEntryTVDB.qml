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
 */

import QtQuick 1.1
import Effects 1.0
import "../../../common/fontUtils.js" as FontUtils
import "../../../common/units.js" as Units
import "../../../common"
import "../../../dash"
AbstractButton {
    property string searchQuery
    BorderImage {
        anchors.fill: parent
        anchors.leftMargin: -3
        anchors.topMargin: -2
        anchors.rightMargin: -4
        anchors.bottomMargin: -4
        source: "../../../dash/artwork/search_background.sci"
        smooth: false
    }

    BorderImage {
        anchors.fill: parent
        anchors.margins: Units.tvPx(-18)

        source: "../../../dash/artwork/search_glow.sci"
        opacity: ( unity2dConfiguration.formFactor == "tv" && parent.state == "selected" || parent.state == "selected-hovered" ) ? 1.0 : 0.0
        Behavior on opacity {NumberAnimation {duration: 200; easing.type: Easing.OutQuad}}
    }
    Rectangle {
        anchors.fill: parent
        radius: Units.tvPx(12)
        opacity: ( parent.state == "hovered" || parent.state == "selected-hovered" ) ? 0.4 : 0.0
        Behavior on opacity { NumberAnimation { duration: 100 } }
    }
    Item {
        anchors.fill: parent
        anchors.topMargin: Units.dtPx(6)
        anchors.bottomMargin: Units.dtPx(6)
        anchors.rightMargin: Units.dtPx(16)

        Image {
            id: search_icon

            anchors.left: parent.left
            anchors.leftMargin: Units.tvPx(17)
            anchors.verticalCenter: parent.verticalCenter
            width: Units.tvPx(46)
            height: Units.tvPx(46)

            smooth: true

            source: unity2dConfiguration.formFactor != "tv" && search_input.text ? "../../dash/artwork/search_close.png" : "../../dash/artwork/search_icon.png"
            fillMode: Image.PreserveAspectFit
        }
        MouseArea {
        //    property alias text: textInput.text


            anchors.fill: search_icon
            onClicked: { textInput.text = ''; focusScope.focus = true; textInput.openSoftwareInputPanel(); }
        }
    }
//      MouseArea {
//          id: clear_button

//            Accessible.name: "Clear"
//            Accessible.role: Accessible.PushButton

//            anchors.fill: search_icon

//            onClicked: {
//                search_input.forceActiveFocus()
//                search_input.text = ""
//            }
//        }

        TextInput {
            id: search_input

            Accessible.name: search_instructions.text
            Accessible.role: Accessible.EditableText

            effect: DropShadow {
                    id: glow

                    blurRadius: 4
                    offset.x: 0
                    offset.y: 0
                    color: "white"
                    enabled: search_input.text != "" || search_input.inputMethodComposing
                }

            anchors.left: search_icon.right
            anchors.leftMargin: Units.tvPx(14)
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft

            color: "#ffffff"
            font.pixelSize: {
                var size
                if (unity2dConfiguration.formFactor == "tv") size = "x-large"
                else size = "xx-large"
                return FontUtils.fontSizeToPixels(size)
            }
            focus: true
            selectByMouse: true
            cursorDelegate: cursor
            selectionColor: "gray"

            onTextChanged: live_search_timeout.restart()

            Timer {
                id: live_search_timeout
                interval: 200
                onTriggered: searchQuery = search_input.text
            }

         //  onSearch: {
           // currentSearchString = text;
            // feedModel.newSearch(text);
          //      }
//           Keys.onPressed: {
//               if (event.key == Qt.Key_Enter || event.key == Qt.Key_Return)
//                   returnPressed();

            Keys.onPressed: {
                if (event.key == Qt.Key_Return || event.key == Qt.Key_Enter) {
                    searchBar.currentPage.activateFirstResult()
                    event.accepted = true;
                }
            }

            Component {
                id: cursor

                Rectangle {
                    color: "white"
                    width: 2
                    height: 16
                    visible: unity2dConfiguration.formFactor == "desktop" || parent.text != ""

                    /* WARNING: that animation triggers forces the scene to be rendered
                       thus using quite a bit of resources */
                    SequentialAnimation on opacity {
                        id: cursor_pulse
                        loops: 30
                        alwaysRunToEnd: true
                        running: false
                        PropertyAnimation { duration: 1000; to: 0; easing.type: Easing.InOutQuad }
                        PropertyAnimation { duration: 1000; to: 1; easing.type: Easing.InOutQuad }
                    }
                    Connections {
                        target: parent
                        onTextChanged: cursor_pulse.running = true
                        onActiveFocusChanged: cursor_pulse.running = parent.activeFocus
                    }
                }
            }

            TextCustom {
                id: search_instructions

                anchors.left: parent.left
                anchors.right: parent.right
                elide: Text.ElideRight
                anchors.verticalCenter: parent.verticalCenter
                LayoutMirroring.enabled: false
                horizontalAlignment: isRightToLeft() ? Text.AlignRight : Text.AlignLeft

                  Accessible.name: "Clear"
                  Accessible.role: Accessible.PushButton

                  anchors.fill: search_icon

//                  onClicked: {
//                      search_input.forceActiveFocus()
//                      search_input.text = ""
//                  }
                color: "white"
                opacity: 0.5
                fontSize: unity2dConfiguration.formFactor == "tv" ? "large" : "x-large"
                font.italic: true
                text: {
                    if(search_input.text || search_input.inputMethodComposing)
                        return ""
                  //  else if(dash.currentPage != undefined && dash.currentPage.model.searchHint)
                    //    return dash.currentPage.model.searchHint
                    else
                        return u2d.tr("SearchTVDB.org")
                }
            }
        }
}


