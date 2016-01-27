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

import QtQuick 1.0
import Unity2d 1.0
import "../common"
import "../common/utils.js" as Utils
import "../common/units.js" as Units
import  "renderTypes/"
FocusScope {
    id: lensView

    /* An instance of Lens */
    property variant model
    property string firstNonEmptyCategory

    function updateFirstCategory() {
        if (lensView.model.results.count == 0)
            return
        var firstCategory = -1
        for (var i = 0; i < lensView.model.results.count; i++) {
            var result = lensView.model.results.get(i)
            if (result.column_2 < firstCategory || firstCategory == -1) {
                firstCategory = result.column_2
                if (firstCategory == 0) {
                    break
                }
            }
        }
        var category = lensView.model.categories.get(firstCategory)
        firstNonEmptyCategory = category.column_0
    }

    Connections {
        target: lensView.model != undefined ? lensView.model.results : null
        onCountChanged: updateFirstCategory()
    }

    function activateFirstResult() {
        var firstResult = null
        for (var i = 0; i < lensView.model.results.count; i++) {
            var result = lensView.model.results.get(i)
            var category = result.column_2
            if ((firstResult === null) || (category < firstResult.column_2)) {
                firstResult = result
            }
        }
        if (firstResult === null) {
            return
        }
        var uri = firstResult.column_0
        var category1 = firstResult.column_2
        var mimetype = firstResult.column_3
        dash.activateUriWithLens(model, category, uri, mimetype)
    }

    /* Optional 'No results...' hint for lens search results.
     */
    TextCustom {
        id: noResultsText
        objectName: "noResultsText"
        fontSize: "large"
        color: "white"
        visible: lensView.model == undefined ? false : lensView.model.noResultsHint != ""
        text: lensView.model != undefined ? lensView.model.noResultsHint : ""
        anchors{
            centerIn: parent
            verticalCenterOffset: -6
}
        Connections {
            target: lensView.model != undefined ? lensView.model : null
            onSearchQueryChanged: {
                if (noResultsText.visible) {
                    hideNoResultHintAnimation.start()
                }
            }

            onSearchFinished: {
                hideNoResultHintAnimation.stop();
                noResultsText.opacity = 1.0
            }
        }

        Connections {
            target: lensView != undefined ? lensView : null
            onModelChanged: {
                lensView.model.noResultsHint = "";
            }
        }

        SequentialAnimation {
            id: hideNoResultHintAnimation

            PropertyAction {
                target: noResultsText;
                property: "opacity";
                value: 1.0
            }

            PauseAnimation {
                duration: 150
            }

            NumberAnimation {
                target: noResultsText;
                property: "opacity";
                from: 1;
                to: 0;
                duration: 1250;
                easing.type: Easing.OutBack
            }
        }
    }

    ListViewWithScrollbar {
        id: results
        focus: true
        anchors{
            fill: parent
}
        /* The category's delegate is chosen dynamically depending on what
           rendererName is returned by the CategoriesModel.

           Each rendererName should have a corresponding QML file with the
           same name that will be used as delegate.
           For example:

           If rendererName == 'UnityShowcaseRenderer' then it will look for
           the file 'UnityShowcaseRenderer.qml' and use it to render the category.
        */
        bodyDelegate: Loader {
            id:renderLoader
            visible: category_model.count > 0
            width: parent.width
            height: item ? visible ? item.contentHeight : 0 : 0

            property string name: model.column_0
            property string iconHint: model.column_1
            property string rendererName: dash2dConfiguration.dashView === "tile-horizontal" ? renderLoader.source : model.column_2
            property int categoryId: index
            property bool uncollapsed: true

//    FIX ME there needs to be a way at this point for the user to pick what kinda Render type that they are going to want to use
//    I think that I will make a new thing under com.canonical.Unity2d.Dash called dash-view that can make render type change
            source: if(dash2dConfiguration.dashView === "tabletflow")
                        "renderTypes/RenderTabletFlow.qml"
                    else if(dash2dConfiguration.dashView === "coverflow")
                        "renderTypes/RendererCoverFlow.qml"
                    else if(dash2dConfiguration.dashView === "tile-horizontal")
                        "renderTypes/TileHorizontal.qml"
                    else if(dash2dConfiguration.dashView === "tile-vertical")
                        "renderTypes/TileVertical.qml"
//                    else
//                        return source ? Utils.convertToCamelCase(source) + ".qml" : ""

//            onStatusChanged: {
//                updateFirstCategory()
//                if (status == Loader.Error) {
//                    console.log("Failed to load renderer %1. Using default renderer instead.".arg(source))
//                    source = "TileHorizontal.qml"

//                }
//            }

            /* Model that will be used by the category's delegate */

            property variant category_model: SortFilterProxyModel {
                model: lensView.model.results

                /* resultsModel contains data for all the categories of a given Lens.
                   Each row has a column (the second one) containing the id of
                   the category it belongs to (categoryId).
                */
                filterRole: 2 /* second column (see above comment) */
                filterRegExp: RegExp("^%1$".arg(categoryId)) /* exact match */
            }

            /* Required by ListViewWithHeaders when the loaded Renderer is a Flickable.
               In that case the list view scrolls the Flickable appropriately.
            */
            property int totalHeight: item.totalHeight != undefined ? item.totalHeight : 0
            property variant currentItem: item.currentItem

            Binding {
                target: item;
                property: "name";
                value: name
            }
            Binding {
                target: item;
                property: "iconHint";
                value: iconHint
            }
            Binding {
                target: item;
                property: "categoryId";
                value: categoryId
            }
            Binding {
                target: item;
                property: "category_model";
                value: category_model
            }
            Binding {
                target: item;
                property: "lens";
                value: lensView.model
            }
            Binding {
                target: item;
                property: "lensId";
                value: lensView.model.id
            }
            Binding {
                target: item;
                property: "uncollapsed";
                value: uncollapsed
            }

            onLoaded: item.focus = true
        }

        headerDelegate: Loader {
            source: if (unity2dConfiguration.formFactor === "desktop" || unity2dConfiguration.formFactor === "tablet") "CategoryHeader.qml"
                    else if (unity2dConfiguration.formFactor === "tv") "TVCategoryHeader.qml"
            visible: body.item ? body.item.needHeader && body.visible : false
            property bool isFirst: firstNonEmptyCategory === body.name
            property bool foldable: body.item ? body.item.folded !== undefined : false
            Binding {
                target: item;
                property: "count";
                value: body.category_model.count
            }
            Binding {
                target: item;
                property: "availableCount";
                value: foldable ? body.category_model.count - body.item.cellsPerRow : 0
            }
            Binding {
                target: item;
                property: "folded";
                value: foldable ? body.item.folded : false
            }
            Binding {
                target: item;
                property: "uncollapsed";
                value: body.uncollapsed
            }
            Binding {
                target: item;
                property: "moving";
                value: flickerMoving
            }
            Binding {
                target: item;
                property: "icon";
                value: body.iconHint
            }
            Binding {
                target: item;
                property: "label";
                value: body.name
            }
            Connections {
                target: item;
                onClicked:
                    if(foldable) body.item.folded = !body.item.folded;
                    else { item.focusPath.currentIndex = item.focusIndex
                    }
            }

            onLoaded: item.focus = true
        }

        model: lensView.model !== undefined ? lensView.model.categories : undefined
    }
}
