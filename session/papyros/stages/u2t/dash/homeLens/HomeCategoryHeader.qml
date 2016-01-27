import QtQuick 1.0
import Effects 1.0
import "../../common"
import "../../common/units.js" as Units
import "../"
AbstractCategoryHeader {
    id: categoryHeader

    height: visible ? Units.dtPx(32) : 0

    Accessible.name: "%1 %2 %3".arg(title.text).arg(label.text).arg(folded ? u2d.tr("not expanded") : u2d.tr("expanded"))

    /* HACK: DropShadow causes visual artifacts while being moved. The previously painted
       DropShadow can remain in areas where nothing draws over it. Work around this by
       detecting the flicking movement and disable DropShadow when it happens.
       DropShadow not officially supported until Qt4.8, when hopefully this will be fixed.
    */
    effect: DropShadow {
                blurRadius: 6
                offset.x: 0
                offset.y: 0
                color: "white"
                enabled: ( categoryHeader.state == "pressed" && !moving )
            }

    Image {
        id: iconImage

        source: icon

        width: Units.dtPx(22)
        height: Units.dtPx(22)
        anchors.bottom: underline.top
        anchors.bottomMargin: Units.dtPx(5)
        anchors.left: parent.left
        fillMode: Image.PreserveAspectFit
        sourceSize.width: width
        sourceSize.height: height
    }

    TextCustom {
        id: title

        text: categoryHeader.label

        fontSize: "large"
        anchors.baseline: underline.top
        anchors.baselineOffset: Units.dtPx(-10)
        anchors.left: iconImage.right
        anchors.leftMargin: Units.dtPx(8)
    }

    Item {
        id: moreResults

        visible: availableCount > 0
        anchors.left: title.right
        anchors.leftMargin: Units.dtPx(14)
        anchors.baseline: title.baseline

        opacity: ( categoryHeader.state == "selected" || categoryHeader.state == "pressed"
                  || categoryHeader.state == "hovered" ) ? 1.0 : 0.5
        Behavior on opacity {NumberAnimation { duration: 100 }}

        effect: DropShadow {
                    blurRadius: 4
                    offset.x: 0
                    offset.y: 0
                    color: "white"
                    enabled: ( moreResults.opacity == 1.0 && !moving )
                }

        TextCustom {
            id: label

            fontSize: "small"
            text: if(categoryHeader.folded) {
                      return u2d.tr("See %1 more result", "See %1 more results", availableCount).arg(availableCount)
                  } else {
                      return u2d.tr("See fewer results")
                  }

            anchors.left: parent.left
            anchors.baseline: parent.baseline
        }

        FoldingArrow {
            id: arrow

            folded: categoryHeader.folded
            anchors.left: label.right
            anchors.leftMargin: Units.dtPx(10)
            anchors.verticalCenter: label.verticalCenter
        }
    }

    Rectangle {
        id: underline

        color: "#21ffffff"

        height: 1
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
    }
}




///*
// * This file is part of unity-2d
// *
// * Copyright 2010-2011 Canonical Ltd.
// *
// * This program is free software; you can redistribute it and/or modify
// * it under the terms of the GNU General Public License as published by
// * the Free Software Foundation; version 3.
// *
// * This program is distributed in the hope that it will be useful,
// * but WITHOUT ANY WARRANTY; without even the implied warranty of
// * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// * GNU General Public License for more details.
// *
// * You should have received a copy of the GNU General Public License
// * along with this program.  If not, see <http://www.gnu.org/licenses/>.


//import QtQuick 1.0
//import "../common"
//import "../common/units.js" as Units

//AbstractCategoryHeader {
//    id: categoryHeader

//    height: visible ? Units.tvPx(80) : 0

//  Accessible.name: "%1 %2 %3".arg(title.text).arg(label.text).arg(folded ? u2d.tr("not expanded") : u2d.tr("expanded"))
//    Rectangle {
//        anchors.left: parent.left
//        anchors.right: parent.right
//        anchors.top: title.top
//        anchors.bottom: title.bottom
//        anchors.bottomMargin: -4
//        opacity: categoryHeader.state == "hovered" || categoryHeader.state == "selected-hovered" ? 0.4 : 0.0

//        Behavior on opacity { NumberAnimation { duration: 100 } }
//    }

//    Image {
//        id: icon
//        anchors.bottom: title.bottom
//        anchors.bottomMargin: Units.tvPx(2)
//        anchors.left: parent.left
//        anchors.leftMargin: Units.tvPx(-5)
//        source: "../common/artwork/category_arrow.png"

//        opacity: uncollapsed ? 1.0 : 0.0
//        Behavior on opacity {NumberAnimation { duration: 100 }}
//    }

//    TextCustom {
//        id: title

//        text: categoryHeader.label

//        fontSize: "large"
//        anchors.bottom: parent.bottom
//        anchors.left: icon.right
//        anchors.leftMargin: Units.tvPx(3)
//    }

//    TextCustom {
//        id: count

//        text: "(%1)".arg(parent.count)

//        fontSize: "large"
//        anchors.baseline: title.baseline
//        anchors.left: title.right
//        anchors.leftMargin: Units.tvPx(25)

//        opacity: 0.3
//    }
//}
