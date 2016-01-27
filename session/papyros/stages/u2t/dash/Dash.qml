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
import Unity2d 1.0
import QtMultimediaKit 1.1
import "../common"
import "../common/visibilityBehaviors"
import "../common/utils.js" as Utils
import "../common/units.js" as Units
import "../3rdparty/BackgroundSwitcher/"
import "../indicators"
import "filters/sidebar"
import "filters"
import "renderTypes"
import "previews"


FocusScope {
    id: dash
    objectName: "Dash"
    Accessible.name: "dash"
    LayoutMirroring.enabled: launcher2dConfiguration.launcherLocation === "right" && dconfsettingsActive !== true
    LayoutMirroring.childrenInherit: true
    property variant currentPage
    property variant active
    property bool softwarecenterActive: false
    property bool epgActive: false
    property bool youtubeActive: false
    property bool systemsettingsActive: false
    property bool qtmediahubActive: false
    property bool portalActive: false
    property bool nokiaActive: false
    property bool weatherActive: false
    property bool usersettingsActive: false
    property bool qtvviewerActive: false
    property bool videffectActive: false
    property bool mythwebActive: false
    property bool itvActive: false
    property bool homeActive: false
    property bool dconfsettingsActive: false

    Binding {
        target: shellManager
        property: "dashActive"
        value: dash.active
    }
    Binding {
        target: dash
        property: "active"
        value: shellManager.dashActive
    }
    onActiveChanged: if (dash.active) shellManager.dashShell.forceActivateWindow()

    Connections {
        target: shellManager
        onDashShellChanged: {
            if (dash.active) {
                background.trigger()
                shellManager.dashShell.forceActivateWindow()
            }
        }
    }

    Connections {
        target: unity2dConfiguration
        onFormFactorChanged: {
            if (unity2dConfiguration.formFactor === "tv") {
                activateLens(startupLens)
            }
        }
    }

    Connections {
        target: unity2dConfiguration
        onFormFactorChanged: {
            if (unity2dConfiguration.formFactor === "tablet") {
                activateLens(startupLens)
            }
        }
    }

    Timer {
        id: delayHidePreview
        interval: 500
        onTriggered: hidePreview()
    }
    property variant queuedLensId
    property bool expanded: (currentPage && currentPage.expanded != undefined) ? currentPage.expanded : true
    property string startupLens
    startupLens: {
        switch (unity2dConfiguration.formFactor) {
        case "desktop": return "home.lens"
        case "tv": return "video.lens"
        case "tablet": return "home.lens"
        default: return ""
        }
    }

    Connections {
        target: lenses
        onLoaded: if (unity2dConfiguration.formFactor === "tv" && startupLens)
                      activateLens(startupLens)
                  else
                      "home.lens"
    }

    Binding {
        target: shellManager
        property: "dashMode"
        value: shellManager.dashAlwaysFullScreen || dash2dConfiguration.fullScreen ?
                   ShellManager.FullScreenMode : ShellManager.DesktopMode
    }

    Connections {
        target: shellManager
        onDashActivateHome: activateHome()
        onDashActivateLens: activateLens(lensId)
    }

    Connections {
        target: shellManager.dashShell
        onFocusChanged: if (!shellManager.dashShell.focus) active = false
    }

    function edgeEvent(event) {
        if (unity2dConfiguration.formFactor === "tv"
                && (event.key === Qt.Key_F3 || event.key == Qt.Key_MediaPlay)
                && declarativeView.activeLens !== ""
                && !previewer.active) {
            if (!sidebar.activeFocus) {
                sidebar.forceActiveFocus()
            } else {
                sidebar.focus = false
                dash.forceActiveFocus()
            }
            event.accepted = true
        }
    }

    function activatePage(page) {
        if (page === currentPage) {
            return
        }

        if (currentPage != undefined) {
            currentPage.visible = false
        }
        currentPage = page
        currentPage.visible = true
    }

    function buildLensPage(lens) {
        search_entry.focus = true
        pageLoader.setSource("LensView.qml")
        pageLoader.item.model = lens
        activatePage(pageLoader.item)
    }

    /* Set all Lenses as Hidden when Dash closes */
    function deactivateAllLenses() {
        for (var i=0; i<lenses.rowCount(); i++) {
            lenses.get(i).viewType = Lens.Hidden
        }
        shellManager.dashActiveLens = ""
        pageLoader.setSource("")

    }

    SpreadMonitor {
        id: spreadMonitor

    }

    function activateLens(lensId) {
        if (spreadMonitor.shown) return
        /* check if lenses variable was populated already */
        if (lenses.rowCount() == 0) {
            queuedLensId = lensId
            return
        }
        var lens = lenses.get(lensId)
        if (lens == null) {
            console.log("No match for lens: %1".arg(lensId))
            return
        }
        if (lensId == shellManager.dashActiveLens && dash.active) {
            /* we don't need to activate the lens, just show its UI */
            buildLensPage(lens)
            return
        }
        for (var i=0; i<lenses.rowCount(); i++) {
            var thislens = lenses.get(i)
            if (lensId == "home.lens") {
                if (thislens.id == lensId) {
                    thislens.viewType = Lens.LensView
                    continue
                }
                /* When Home is shown, need to notify all other lenses. Those in the global view
                    (in home search results page) are set to HomeView, all others to Hidden */
                thislens.viewType = (thislens.searchInGlobal) ? Lens.HomeView : Lens.Hidden
            } else {
                thislens.viewType = (lens === thislens) ?  Lens.LensView : Lens.Hidden
            }
        }
        buildLensPage(lens)
        shellManager.dashActiveLens = lens.id
        dash.active = true
        search_entry.height = search_entry.height === 0 ? Units.dtPx(42) : Units.dtPx(42)
        search_entry.opacity = search_entry.height === 0 ?  1 : 1
        filterPane.opacity = search_entry.height === 0 ? 1 : 1
        indicators.visible = indicators.visible === false && unity2dConfiguration.formFactor === "tv" ? true : false
    }
    function activateHome() {
        if (spreadMonitor.shown) return
        if (shellManager.dashHaveCustomHomeShortcuts) {
            for (var i=0; i<lenses.rowCount(); i++) {
                lenses.get(i).viewType = Lens.Hidden
            }
            search_entry.focus = true
            pageLoader.setSource("homeLens/Home.qml")
            activatePage(pageLoader.item)
            shellManager.dashActiveLens = ""
            dash.active = true
        } else {
            activateLens(startupLens)
        }
    }
    function activateYoutube() {
        youtubeActive = true
        pageLoader.setSource("../3rdparty/youtube/Youtube.qml")
        activatePage(pageLoader.item)
        shellManager.dashActiveLens = ""
        search_entry.height = 0
        search_entry.opacity = 0
        filterPane.opacity = 0
        indicators.visible = false
        dash.active = true
    }
    function activateEpg() {
        epgActive = true
        pageLoader.setSource("EPG.qml")
        activatePage(pageLoader.item)
        shellManager.dashActiveLens = ""
        search_entry.height = 0
        search_entry.opacity = 0
        filterPane.opacity = 0
        indicators.visible = false
        dash.active = true
    }
    function activateSoftwarecenter() {
        softwarecenterActive = true
        pageLoader.setSource("../3rdparty/softwarefake/Softwarecenter.qml")
        activatePage(pageLoader.item)
        shellManager.dashActiveLens = ""
        search_entry.height = 0
        search_entry.opacity = 0
        filterPane.opacity = 0
        dash.active = true
        indicators.visible = false
    }
    function activateSystemsettings() {
        systemsettingsActive = true
        pageLoader.setSource("../systeminfo/Systemsettings.qml")
        activatePage(pageLoader.item)
        shellManager.dashActiveLens = ""
        search_entry.height = 0
        search_entry.opacity = 0
        filterPane.opacity = 0
        indicators.visible = false
        dash.active = true
    }
    function activateProtal() {
        portalActive = true
        pageLoader.setSource("portal/PannelButtons.qml")
        activatePage(pageLoader.item)
        shellManager.dashActiveLens = ""
        dash.active = true
    }
    function activateNokiaMaps() {
        nokiaActive = true
        pageLoader.setSource("../3rdparty/nokiamaps/NokiaMaps.qml")
        activatePage(pageLoader.item)
        shellManager.dashActiveLens = ""
        search_entry.height = 0
        search_entry.opacity = 0
        filterPane.opacity = 0
        indicators.visible = false
        dash.active = true
    }
    function activateWeather() {
        weatherActive = true
        pageLoader.setSource("../3rdparty/WeatherWindow.qml")
        activatePage(pageLoader.item)
        shellManager.dashActiveLens = ""
        dash.active = true
        search_entry.height = 0
        search_entry.opacity = 0
        filterPane.opacity = 0
        indicators.visible = false
    }
    function activateUsersettings() {
        usersettingsActive = true
        pageLoader.setSource("../systeminfo/UserSettings.qml")
        activatePage(pageLoader.item)
        shellManager.dashActiveLens = ""
        dash.active = true
        search_entry.height = 0
        search_entry.opacity = 0
        filterPane.opacity = 0
        indicators.visible = false
    }
    function activateQtvviewer() {
        qtvviewerActive = true
        pageLoader.setSource("../3rdparty/qtv-qml/main.qml")
        activatePage(pageLoader.item)
        shellManager.dashActiveLens = ""
        dash.active = true
        search_entry.height = 0
        search_entry.opacity = 0
        filterPane.opacity = 0
        indicators.visible = false
    }
    function activateVideffect() {
        videffectActive = true
        pageLoader.setSource("../3rdparty/qmlvideofx/qml/qmlvideofx/main-largescreen.qml")
        activatePage(pageLoader.item)
        shellManager.dashActiveLens = ""
        dash.active = true
        search_entry.height = 0
        search_entry.opacity = 0
        filterPane.opacity = 0
        indicators.visible = false
    }
    function activateMythweb() {
        mythwebActive = true
        pageLoader.setSource("../3rdparty/mythweb/MythWeb.qml")
        activatePage(pageLoader.item)
        shellManager.dashActiveLens = ""
        dash.active = true
        search_entry.height = 0
        search_entry.opacity = 0
        filterPane.opacity = 0
        indicators.visible = false
    }
    function activateQtmediahub() {
        qtmediahubActive = true
        pageLoader.setSource("../3rdparty/confluence/r720/RootMenu.qml")
        activatePage(pageLoader.item)
        shellManager.dashActiveLens = ""
        dash.active = true
        search_entry.height = 0
        search_entry.opacity = 0
        filterPane.opacity = 0
    }
    function activateItv() {
        itvActive = true
        pageLoader.setSource("../3rdparty/ITV/ITV.qml")
        activatePage(pageLoader.item)
        shellManager.dashActiveLens = ""
        dash.active = true
        search_entry.height = 0
        search_entry.opacity = 0
        filterPane.opacity = 0
        indicators.visible = false
    }

    function activateDconfsettings() {
        dconfsettingsActive = true
        pageLoader.setSource("../systeminfo/DconfSettings.qml")
        activatePage(pageLoader.item)
        shellManager.dashActiveLens = ""
        dash.active = true
        search_entry.height = 0
        search_entry.opacity = 0
        filterPane.opacity = 0
        indicators.visible = false
    }
    function activateLensWithOptionFilter(lensId, filterId, optionId) {
        var lens = lenses.get(lensId)
        var filter = lens.filters.getFilter(filterId)
        var option = filter.getOption(optionId)
        filter.clear()
        option.active = true
        filterPane.folded = false
        activateLens(lensId)
    }
    function activateLensAndClearFilter(lensId, filterId) {
        var lens = lenses.get(lensId)
        var filter = lens.filters.getFilter(filterId)
        filter.clear()
        activateLens(lensId)
    }
    function activateUriWithLens(lens, uri, mimetype) {
            shellManager.dashActive = false
            lens.activate(uri)
//
//Fix me make a "debug" for Unity 2d so vis dbus to make things like this show up.
//
//        console.log("\n |||||||||||||||||||||||||||||||||||| THIS IS FOR DEBUGING ||||||||||||||||||||||||||||||||||||| \n"
//                + " || This is the lensId :\t\t"+  lens +"\t\t\t     ||"
//                +"\n || This is the Uri: \t"+  uri
//                + "\n || This is the mimeTyp:\t\t"+ mimetype + "\t\t\t\t     ||"
//                  + "\n |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||")
    }

    function activateApplication(application) {
        if (unity2dConfiguration.formFactor === "desktop") {
            dash.active = false
        }
        application.activate()
    }
    property variant lenses: Lenses {}
    /* If unity-2d-places is launched on demand by an activateLens() dbus call,
       "lenses" is not yet populated, so activating "commands.lens",
       for example, triggered by Alt+F2 fails.
       This following connection fixes this issue by checking if any lenses
       should be activated as long as "lenses" is being populated. lp:883392 */
    Connections {
        target: lenses
        onRowsInserted: {
            if (queuedLensId != "") {
                var lens = lenses.get(queuedLensId)
                if (lens != null) {
                    activateLens(queuedLensId)
                    queuedLensId = "";
                    return
                }
            }
        }
        onActivateLensRequested: activateLens(lens_id)
    }
    /* Previewer */
    function showPreview(category, uri, mimeType, name,comment,iconHint,dndUri,itemLensId){
        previewer.category = category
        previewer.uri = uri
        previewer.mimeType = mimeType
        previewer.name = name
        previewer.comment = comment
        previewer.iconHint = iconHint
        previewer.dndUri = dndUri
        previewer.itemLensId = itemLensId
        previewer.active = true
        previewer.focus = true
        pageLoader.opacity  = .33
        search_entry.height = 0
        search_entry.opacity = 0
        filterPane.opacity = 0
        lensBar.height = 0
        lensBar.opacity = 0
//        launcherLoader.x = launcher2dConfiguration.launcherLocation === "left" ? - launcherLoader.width : launcherLoader.width
    }

    function hidePreview() {
        if (!previewer.active) return
        previewer.active = false
        pageLoader.focus = true
        previewer.uri = ""
        previewer.mimeType = ""
        previewer.comment = ""
        previewer.name = ""
        previewer.iconHint = ""
        previewer.dndUri = ""
        previewer.itemLensId = ""
        pageLoader.opacity = 1
        search_entry.height = Units.dtPx(42)
        search_entry.opacity = 1
        filterPane.opacity = 1
        lensBar.height = Units.dtPx(44)
        lensBar.opacity = 1
//        launcherLoader.x = launcher2dConfiguration.launcherLocation === "left" ?  launcherLoader.width : + launcherLoader.width
    }

    Background {
        id: background
        property bool transparent: unity2dConfiguration.formFactor !== "tv"
        visible: background.transparent
        anchors{
            fill: parent
        }
        active: dash.active
        fullscreen: shellManager.dashMode !== ShellManager.DesktopMode
        view: shellManager.dashShell
    }
    FocusScope {
        id: content
        focus: true
        anchors.fill: parent
        /* Margins in DesktopMode set so that the content does not overlap with
           the border defined by the background image.
        */
        anchors.bottomMargin: background.bottomBorderThickness
        anchors.rightMargin: background.rightBorderThickness


        /* FIXME: deactivated because it makes the user lose the focus very often */
        //Keys.forwardTo: [search_entry]
        Keys.onPressed: {
            if ((event.key === Qt.Key_Tab || event.key === Qt.Key_PageDown) && event.modifiers === Qt.ControlModifier) {
                changeLens(1);
                event.accepted = true
            } else if ((event.key === Qt.Key_Backtab && event.modifiers == (Qt.ControlModifier | Qt.ShiftModifier)) ||
                       (event.key === Qt.Key_PageUp && event.modifiers == Qt.ControlModifier)) {
                changeLens(-1);
                event.accepted = true
            }
        }

        function activeLensIndex() {
            var count = lenses.rowCount()
            for (var i = 0; i < count; i++) {
                if (lenses.get(i).id === shellManager.dashActiveLens) {
                    return i
                }
            }
            return -1
        }

        function changeLens(step) {
            var activeLens = activeLensIndex()
            if (activeLens != -1) {
                var lensesCount = lenses.rowCount()
                if (step < 0) {
                    // Can't do lenses.get(negativeNumber) so instead of adding a negative step
                    // we add the positive number that results in the same value when doing the modulus
                    step = lensesCount + step
                }
                var nextLensIndex = (activeLens + step) % lensesCount
                var nextLens = lenses.get(nextLensIndex)
                while (!nextLens.visible && nextLensIndex != activeLens) {
                    nextLensIndex = (nextLensIndex + step) % lensesCount
                    nextLens = lenses.get(nextLensIndex)
                }
                activateLens(nextLens.id)
            } else {
                console.log("Could not find the active dash lens")
            }
        }
        Behavior on opacity { NumberAnimation { duration: 250 } }

//        BackgroundSwitcher{
//            id: welcomeHome
////            visable:  unity2dConfiguration.formFactor === "tv" ? true : false
//            property int musicPlayerRotation
//            property string bottomtext
//            property color bottomTextColor
//            property double bottomTextOpacity
////            property int bottomTextPixelSize
//            property string toptext
//            property double topTextOpacity
////            property int topPixelSize
//            property color topTextColor
//            property double musicPlayerOpacity

//        rotation: 0
//        Behavior on rotation{NumberAnimation{from: 0 ; to:360;duration: 700;easing.type: Easing.OutCubic}}
//        scale: 1
//        Behavior on scale{NumberAnimation{ duration: 1200; easing.type: Easing.OutSine}}
//        opacity: toptext === ""&& unity2dConfiguration.formFactor === "desktop" ? 0 : 1
//        Behavior on opacity{ NumberAnimation{ duration: 1200 ; easing.type:  Easing.OutSine}}
//        anchors{centerIn: content }
//        }
        Image {
            id: panelBorder
            height: 1
            anchors{
                top: parent.top
                left: parent.left
                right: parent.right
            }
            source: "../common/artwork/panel_border.png"
            fillMode: Image.Stretch
        }
//FixME need to send a signal to change width when other "dash apps --joseph"
        SearchEntry {
            id: search_entry
            focus: true
            KeyNavigation.right: {
                if (unity2dConfiguration.formFactor === "desktop" || unity2dConfiguration.formFactor === "tablet") return filterPane.visible ? filterPane : search_entry
                else if (unity2dConfiguration.formFactor === "tv") return indicators
                else return search_entry
            }
            KeyNavigation.down: pageLoader
            anchors {
                top: parent.top
                topMargin: Units.dtPx(11)
                left: parent.left
                leftMargin: Units.dtPx(10)
                right: unity2dConfiguration.formFactor == "desktop" ? filterPane.left : indicators.left
                rightMargin: unity2dConfiguration.formFactor == "desktop" ? Units.dtPx(15) : Units.tvPx(80)
            }
            height: unity2dConfiguration.formFactor === "desktop" ? Units.dtPx(42) : 64
            Behavior on height {NumberAnimation{duration: 1200;easing.type: Easing.OutQuad}}
            active: dash.active
            placeHolderText: {
                if(dash.currentPage !== undefined && dash.currentPage.model.searchHint)
                    return dash.currentPage.model.searchHint
                else
                    return u2d.tr("Search")
            }

            onActivateFirstResult: if (dash.currentPage !== undefined) dash.currentPage.activateFirstResult()
        }

        Binding {
            /* not using 'when' clause since target needs these check anyway, otherwise it gives warnings if dash.currentPage is undefined */
            target: dash.currentPage !== undefined ? dash.currentPage.model : null
            property: "searchQuery"
            value: search_entry.searchQuery
        }



        FilterPane {
            id: filterPane
            KeyNavigation.left: search_entry
            visible: if (unity2dConfiguration.formFactor === "desktop" && shellManager.dashActiveLens != "home.lens" && shellManager.dashActiveLens != "" && shellManager.dashActiveLens != "commands.lens")
                         return true
                     else if ( unity2dConfiguration.formFactor === "tablet" && shellManager.dashActiveLens != "home.lens" && shellManager.dashActiveLens != "" && shellManager.dashActiveLens != "commands.lens")
                         return true
                     else
                         false


            lens: visible && currentPage != undefined ? currentPage.model : undefined
            headerHeight: search_entry.height
            width: Units.dtPx(300)
            anchors{
                top: search_entry.anchors.top
                topMargin: search_entry.anchors.topMargin
                bottom: unity2dConfiguration.formFactor != "tv" ? lensBar.top : parent.bottom
                right: parent.right
                rightMargin: Units.dtPx(15)
            }
        }

        Loader {
            id: pageLoader
            objectName: "pageLoader"
            Accessible.name: "loader"
            KeyNavigation.right: filterPane.visible && !filterPane.folded ? filterPane : pageLoader
            KeyNavigation.up: search_entry
            KeyNavigation.down: lensBar
            KeyNavigation.left: unity2dConfiguration.formFactor === "tv" ? launcherLoader : ""
            Behavior on height{ NumberAnimation{duration: 900; easing.type: Easing.OutBack}}
            anchors{
                top: search_entry.height === 0 ? parent.top : search_entry.bottom
                bottom: unity2dConfiguration.formFactor != "tv" ? lensBar.top : parent.bottom
                left: parent.left
                right: !filterPane.visible || filterPane.folded ? parent.right : filterPane.left
                rightMargin: !filterPane.visible || filterPane.folded ? 0 : 15
            }
            onLoaded: item.focus = true

            /* Workaround loss of focus issue happening when the loaded item has
               active focus and is then destroyed. The active focus was completely
               lost instead of being relinquished to the Loader.

               Ref.: https://bugreports.qt.nokia.com/browse/QTBUG-22939
            */
            function setSource(newSource) {
                sourceAnimation.restart()
                var hadActiveFocus = activeFocus
                source = newSource
                if (hadActiveFocus) forceActiveFocus()
            }
            //FixMe add checks for opengl if so make better animations
            SequentialAnimation {
                id: sourceAnimation
                property string source
                property bool hadActiveFocus
                PropertyAction {
                    target: pageLoader;
                    property: "opacity";
                    value: 0
                }
                NumberAnimation {
                    target: pageLoader;
                    property: "opacity";
                    to: 1;
                    duration: 300;
                    easing.type: Easing.OutQuad
                }
            }
        }

        DashIndicators {
            id: indicators
            height: Units.tvPx(120)
            anchors{
                verticalCenter: search_entry.verticalCenter
                right: parent.right
                rightMargin: Units.tvPx(27)
            }
            KeyNavigation.left: search_entry
            KeyNavigation.down: pageLoader
            visible: unity2dConfiguration.formFactor === "tv"

            onActiveFocusChanged: {
                if (!activeFocus) leftIndicator.focus = true
            }
        }

        Previews {
            id: previewer
            onExitRequested: hidePreview()
        }

        LensBar {
            id: lensBar
            KeyNavigation.up: pageLoader
            height: Units.dtPx(44)
            Behavior on height {NumberAnimation{duration: 900;easing.type: Easing.OutQuad}}
            state: ""
            visible: unity2dConfiguration.formFactor === "tv" || unity2dConfiguration.formFactor === "tablet" ? false : true
            anchors{
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }
        }


    }

    Rectangle {
        anchors.fill: sidebar
        color: "black"
        opacity: 0.5
        visible: unity2dConfiguration.formFactor === "tv"
    }
    MouseArea {
        anchors.fill: content
        enabled: !content.activeFocus
        onClicked: content.focus = true
    }


    //Fix me make so visable is controled via dbus/glib : alkso make test for opengl
    Sidebar {
        id: sidebar
        source: unity2dConfiguration.formFactor === "tv" ? "LensSidebar.qml" : ""
        visible: unity2dConfiguration.formFactor === "tv" && shellManager.dashActive == true
        width: parent.width
        x: if (launcher2dConfiguration.launcherLoader === "left"){
               sidebarVisibility.shown ? parent.width - width : parent.width
           }else
               sidebarVisibility.shown ? parent.width - width : parent.width + launcherLoader.width
        Behavior on x { NumberAnimation {
                duration: 675
                easing.type: Easing.InOutBack
            }
        }
        anchors{
            top: parent.top
            bottom: parent.bottom
        }
        Keys.onPressed:{ if (event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace) {
                sidebar.focus = false
                content.forceActiveFocus()
            }
        }
        // Prevent key navigation from the sidebar
        Keys.onLeftPressed: {}
        Keys.onRightPressed: {}

        Binding {
            target: sidebar.item
            property: "lens"
            value: currentPage !== undefined ? currentPage.model : undefined
            when: sidebar.status == Loader.Ready
        }
    }

    VisibilityController {
        id: sidebarVisibility
        behavior: ImmediateHideBehavior {
            target: sidebar
        }
        onShownChanged: if (!shown) {
                            sidebar.focus = false
                            content.forceActiveFocus()
                        }
    }

    property int desktopCollapsedHeight: 115
    property int desktopExpandedHeight: 615
    property int desktopWidth: 996

    states: [
        State {
            name: "desktop"
            when: shellManager.dashMode === ShellManager.DesktopMode
            PropertyChanges {
                target: dash
                width: desktopWidth
                height: expanded ? desktopExpandedHeight : desktopCollapsedHeight
            }
        },
        State {
            name: "fullscreen"
            when: shellManager.dashMode === ShellManager.FullScreenMode
            PropertyChanges {
                target: dash
                width: shellManager.dashShell != undefined ? shellManager.dashShell.screen.panelsFreeGeometry.width : 0
                height: shellManager.dashShell != undefined ? shellManager.dashShell.screen.panelsFreeGeometry.height : 0
            }
        }
    ]
}
