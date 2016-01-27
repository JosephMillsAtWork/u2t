import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Dialogs 1.2

import U2T.Menu 1.0
import U2T.GSettings 1.0
import U2T.Hardware 1.0
import U2T.Sound 1.0
import U2T.System 1.0
import U2T.Notifications 1.0


import org.kde.plasma.networkmanagement 0.2 as PlasmaNM
import org.kde.kcoreaddons 1.0 as KCoreAddons
import org.kde.solid 1.0
import org.kde.kwindowsystem 1.0



import "notifications"

Window {
    id: shell
    x: 0; y: 0;
    visible: true
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight
    flags: Qt.SplashScreen
//    modality: Win     dow.FullScreen
    visibility: Window.FullScreen
    color: "black" //"transparent"
    property int appNumber: 99999

    // the background image
    Image{
        source: "file://" +u2tSettings.background
        anchors.fill: parent
    }




    //    // Top Pannel
    Pannel{
        id: pannel
        anchors.top:parent.top
    }

    //    // The Launcher
    LauncherLoader{
        id: launcher
        width: 64
        height: parent.height - pannel.height
        anchors.top:pannel.bottom
        onBfbClicked: {
            if(dashLoader.shown === false){
                dashLoader.shown = true
            }else if (dashLoader.shown === true) {
                dashLoader.shown = false
            }
        }
    }

    DashLoader{
        id: dashLoader
        width: shown ? parent.width - launcher.width : 0
        height: parent.height - pannel.height
        anchors.top: launcher.top
        anchors.left: launcher.right
//        visible: shown ? 1 : 0
        Behavior on width {NumberAnimation{duration: 600 ;easing.type: Easing.OutBack}}
    }






    /// SINGLETONS

    QQmlProcess{
        id: appRunner
        startDetached: true
        onProgramChanged:{
            appNumber = appNumber +1
            console.log(appNumber + " program Name "+ program)
        }
    }

    // Set all the GSettings things
    GSettings{
        id: launcherSettings
        schema.id: "com.iheartqt.U2T.Launcher"
    }
    GSettings{
        id: dashSettings
        schema.id: "com.iheartqt.U2T.Dash"
    }
    GSettings{
        id: pannelSettings
        schema.id: "com.iheartqt.U2T.Pannel"
    }
    GSettings{
        id: u2tSettings
        schema.id: "com.iheartqt.U2T"
    }



    ListModel{ id:allApps }
    ListModel{ id:systemModel }
    ListModel{ id:networkingModel }
    ListModel{ id:graphicsModel }
    ListModel{ id:officeModel }
    ListModel{ id:avModel}
    ListModel{ id:accessibilityModel }
    ListModel{ id:educationModel }
    ListModel{ id:scienceModel }
    ListModel{ id:developmentModel }
    ListModel{ id:utilityModel }
    ListModel{ id:xdgModel }
    ListModel{id: allDesktopFiles}
    ListModel{id: formFactorModel}


    // import this is only for combo box
    function getAllDesktopFiles(){
        var t = dFile.getAllFiles
        var kk = t.toString();
        var k = kk.split(",")
        //       console.log(k)
        for (var it = 0 ; it < k.length; it++){
            var tt = k[it];
            var ttt = tt.substring(tt.lastIndexOf("/")+1)
            var removeEXT = ttt.substring(0,ttt.lastIndexOf("."))
//            console.log("JOSEPH LOOK " + removeEXT)
            allDesktopFiles.append({"text": removeEXT })
        }
    }
    DesktopEntry { id: dFile }
    function reloadModel(){
//        filingModel = true
        var aFiles = dFile.getAllFiles
        var mor = aFiles.toString();
        var sFiles = mor.split(",")
        //                            console.log(sFiles)
        // Ok there is a race going on there on the length

        var cats = ["All","System", "Graphics", "Office", "AudioVideo", "Accessibility", "Education", "Science", "Game", "Development", "Utility" ]
        for(var ii = 0 ; cats.length > ii ; ii++){
            xdgModel.append({"text": cats[ii]})
        }

        for (var i = 0 ; i < sFiles.length;i++){
            dFile.filePath = "";
            dFile.filePath = sFiles[i];
            // FIXME check to make sure that it is vaild
            allApps.append({ "name" : dFile.name , "genericName": dFile.genericName, "nameUnlocalized" : dFile.nameUnlocalized , "version": dFile.version , "iconName" : dFile.icon, "icon" :   dFile.icon , "type" : dFile.type , "comment" : dFile.comment , "catagories: " : dFile.categories , "comments" : dFile.comment , "terminal": dFile.terminal , "exec" : dFile.exec , "tryExec": dFile.tryExec, "mimeType": dFile.mimeType, "url:" : dFile.url , "type": dFile.type , "path": dFile.path , "startupNotify": dFile.startupNotify, "startupWMClass": dFile.startupWMClass, "desktopFileName" : dFile.desktopFileName , "isVaild" : dFile.isValid , "noDisplay": dFile.noDisplay , "notShowIn": dFile.notShowIn , "onlyShowIn": dFile.onlyShowIn , "shouldDisplay": dFile.shouldDisplay, "isLaunching  ? " : dFile.isLaunching , "hash": dFile.hash , "hidden": dFile.hidden, "isLaunching": dFile.isLaunching })


            // catigories
            var cat = dFile.categories;
            var catt = cat.toString()

            if( catt.indexOf("System") > 1 ){
                systemModel.append({ "name" : dFile.name , "genericName": dFile.genericName, "nameUnlocalized" : dFile.nameUnlocalized , "version": dFile.version , "iconName" : dFile.icon, "icon" : dFile.icon , "type" : dFile.type , "comment" : dFile.comment , "catagories: " : dFile.categories , "comments" : dFile.comment , "terminal": dFile.terminal , "exec" : dFile.exec , "tryExec": dFile.tryExec, "mimeType": dFile.mimeType, "url:" : dFile.url , "type": dFile.type , "path": dFile.path , "startupNotify": dFile.startupNotify, "startupWMClass": dFile.startupWMClass, "desktopFileName" : dFile.desktopFileName , "isVaild" : dFile.isValid , "noDisplay": dFile.noDisplay , "notShowIn": dFile.notShowIn , "onlyShowIn": dFile.onlyShowIn , "shouldDisplay": dFile.shouldDisplay, "isLaunching  ? " : dFile.isLaunching , "hash": dFile.hash , "hidden": dFile.hidden, "isLaunching": dFile.isLaunching })
            }else if(catt.indexOf("Internet")
                     || catt.indexOf("Internet") >1
                     || catt.indexOf("Browser") >1
                     >= 1 ) {
                networkingModel.append({ "name" : dFile.name , "genericName": dFile.genericName, "nameUnlocalized" : dFile.nameUnlocalized , "version": dFile.version , "iconName" : dFile.icon, "icon" : dFile.icon , "type" : dFile.type , "comment" : dFile.comment , "catagories: " : dFile.categories , "comments" : dFile.comment , "terminal": dFile.terminal , "exec" : dFile.exec , "tryExec": dFile.tryExec, "mimeType": dFile.mimeType, "url:" : dFile.url , "type": dFile.type , "path": dFile.path , "startupNotify": dFile.startupNotify, "startupWMClass": dFile.startupWMClass, "desktopFileName" : dFile.desktopFileName , "isVaild" : dFile.isValid , "noDisplay": dFile.noDisplay , "notShowIn": dFile.notShowIn , "onlyShowIn": dFile.onlyShowIn , "shouldDisplay": dFile.shouldDisplay, "isLaunching  ? " : dFile.isLaunching , "hash": dFile.hash , "hidden": dFile.hidden, "isLaunching": dFile.isLaunching })
            }else if(catt.indexOf("Graphics") >1){
                graphicsModel.append({ "name" : dFile.name , "genericName": dFile.genericName, "nameUnlocalized" : dFile.nameUnlocalized , "version": dFile.version , "iconName" : dFile.icon, "icon" : dFile.icon , "type" : dFile.type , "comment" : dFile.comment , "catagories: " : dFile.categories , "comments" : dFile.comment , "terminal": dFile.terminal , "exec" : dFile.exec , "tryExec": dFile.tryExec, "mimeType": dFile.mimeType, "url:" : dFile.url , "type": dFile.type , "path": dFile.path , "startupNotify": dFile.startupNotify, "startupWMClass": dFile.startupWMClass, "desktopFileName" : dFile.desktopFileName , "isVaild" : dFile.isValid , "noDisplay": dFile.noDisplay , "notShowIn": dFile.notShowIn , "onlyShowIn": dFile.onlyShowIn , "shouldDisplay": dFile.shouldDisplay, "isLaunching  ? " : dFile.isLaunching , "hash": dFile.hash , "hidden": dFile.hidden, "isLaunching": dFile.isLaunching })
            }else if (catt.indexOf("Office") >1){
                officeModel.append({ "name" : dFile.name , "genericName": dFile.genericName, "nameUnlocalized" : dFile.nameUnlocalized , "version": dFile.version , "iconName" : dFile.icon, "icon" : dFile.icon , "type" : dFile.type , "comment" : dFile.comment , "catagories: " : dFile.categories , "comments" : dFile.comment , "terminal": dFile.terminal , "exec" : dFile.exec , "tryExec": dFile.tryExec, "mimeType": dFile.mimeType, "url:" : dFile.url , "type": dFile.type , "path": dFile.path , "startupNotify": dFile.startupNotify, "startupWMClass": dFile.startupWMClass, "desktopFileName" : dFile.desktopFileName , "isVaild" : dFile.isValid , "noDisplay": dFile.noDisplay , "notShowIn": dFile.notShowIn , "onlyShowIn": dFile.onlyShowIn , "shouldDisplay": dFile.shouldDisplay, "isLaunching  ? " : dFile.isLaunching , "hash": dFile.hash , "hidden": dFile.hidden, "isLaunching": dFile.isLaunching })
            }else if (catt.indexOf("AudioVideo") >1
                      ||catt.indexOf("Video") >1
                      ||catt.indexOf("Audio") >1){
                avModel.append({ "name" : dFile.name , "genericName": dFile.genericName, "nameUnlocalized" : dFile.nameUnlocalized , "version": dFile.version , "iconName" : dFile.icon, "icon" : dFile.icon , "type" : dFile.type , "comment" : dFile.comment , "catagories: " : dFile.categories , "comments" : dFile.comment , "terminal": dFile.terminal , "exec" : dFile.exec , "tryExec": dFile.tryExec, "mimeType": dFile.mimeType, "url:" : dFile.url , "type": dFile.type , "path": dFile.path , "startupNotify": dFile.startupNotify, "startupWMClass": dFile.startupWMClass, "desktopFileName" : dFile.desktopFileName , "isVaild" : dFile.isValid , "noDisplay": dFile.noDisplay , "notShowIn": dFile.notShowIn , "onlyShowIn": dFile.onlyShowIn , "shouldDisplay": dFile.shouldDisplay, "isLaunching  ? " : dFile.isLaunching , "hash": dFile.hash , "hidden": dFile.hidden, "isLaunching": dFile.isLaunching })
            }else if (catt.indexOf("Accessibility") >1){
                accessibilityModel.append({ "name" : dFile.name , "genericName": dFile.genericName, "nameUnlocalized" : dFile.nameUnlocalized , "version": dFile.version , "iconName" : dFile.icon, "icon" : dFile.icon , "type" : dFile.type , "comment" : dFile.comment , "catagories: " : dFile.categories , "comments" : dFile.comment , "terminal": dFile.terminal , "exec" : dFile.exec , "tryExec": dFile.tryExec, "mimeType": dFile.mimeType, "url:" : dFile.url , "type": dFile.type , "path": dFile.path , "startupNotify": dFile.startupNotify, "startupWMClass": dFile.startupWMClass, "desktopFileName" : dFile.desktopFileName , "isVaild" : dFile.isValid , "noDisplay": dFile.noDisplay , "notShowIn": dFile.notShowIn , "onlyShowIn": dFile.onlyShowIn , "shouldDisplay": dFile.shouldDisplay, "isLaunching  ? " : dFile.isLaunching , "hash": dFile.hash , "hidden": dFile.hidden, "isLaunching": dFile.isLaunching })
            }else if (catt.indexOf("Education") > 1 ){
                educationModel.append({ "name" : dFile.name , "genericName": dFile.genericName, "nameUnlocalized" : dFile.nameUnlocalized , "version": dFile.version , "iconName" : dFile.icon, "icon" : dFile.icon , "type" : dFile.type , "comment" : dFile.comment , "catagories: " : dFile.categories , "comments" : dFile.comment , "terminal": dFile.terminal , "exec" : dFile.exec , "tryExec": dFile.tryExec, "mimeType": dFile.mimeType, "url:" : dFile.url , "type": dFile.type , "path": dFile.path , "startupNotify": dFile.startupNotify, "startupWMClass": dFile.startupWMClass, "desktopFileName" : dFile.desktopFileName , "isVaild" : dFile.isValid , "noDisplay": dFile.noDisplay , "notShowIn": dFile.notShowIn , "onlyShowIn": dFile.onlyShowIn , "shouldDisplay": dFile.shouldDisplay, "isLaunching  ? " : dFile.isLaunching , "hash": dFile.hash , "hidden": dFile.hidden, "isLaunching": dFile.isLaunching })
            }else if (catt.indexOf("Science") > 1 ){
                scienceModel.append({ "name" : dFile.name , "genericName": dFile.genericName, "nameUnlocalized" : dFile.nameUnlocalized , "version": dFile.version , "iconName" : dFile.icon, "icon" : dFile.icon , "type" : dFile.type , "comment" : dFile.comment , "catagories: " : dFile.categories , "comments" : dFile.comment , "terminal": dFile.terminal , "exec" : dFile.exec , "tryExec": dFile.tryExec, "mimeType": dFile.mimeType, "url:" : dFile.url , "type": dFile.type , "path": dFile.path , "startupNotify": dFile.startupNotify, "startupWMClass": dFile.startupWMClass, "desktopFileName" : dFile.desktopFileName , "isVaild" : dFile.isValid , "noDisplay": dFile.noDisplay , "notShowIn": dFile.notShowIn , "onlyShowIn": dFile.onlyShowIn , "shouldDisplay": dFile.shouldDisplay, "isLaunching  ? " : dFile.isLaunching , "hash": dFile.hash , "hidden": dFile.hidden, "isLaunching": dFile.isLaunching })
            }else if (catt.indexOf("Development") > 1){
                developmentModel.append({ "name" : dFile.name , "genericName": dFile.genericName, "nameUnlocalized" : dFile.nameUnlocalized , "version": dFile.version , "iconName" : dFile.icon, "icon" : dFile.icon , "type" : dFile.type , "comment" : dFile.comment , "catagories: " : dFile.categories , "comments" : dFile.comment , "terminal": dFile.terminal , "exec" : dFile.exec , "tryExec": dFile.tryExec, "mimeType": dFile.mimeType, "url:" : dFile.url , "type": dFile.type , "path": dFile.path , "startupNotify": dFile.startupNotify, "startupWMClass": dFile.startupWMClass, "desktopFileName" : dFile.desktopFileName , "isVaild" : dFile.isValid , "noDisplay": dFile.noDisplay , "notShowIn": dFile.notShowIn , "onlyShowIn": dFile.onlyShowIn , "shouldDisplay": dFile.shouldDisplay, "isLaunching  ? " : dFile.isLaunching , "hash": dFile.hash , "hidden": dFile.hidden, "isLaunching": dFile.isLaunching })
            }else if (catt.indexOf("Utility") > 1 ){
                utilityModel.append({ "name" : dFile.name , "genericName": dFile.genericName, "nameUnlocalized" : dFile.nameUnlocalized , "version": dFile.version , "iconName" : dFile.icon, "icon" : dFile.icon , "type" : dFile.type , "comment" : dFile.comment , "catagories: " : dFile.categories , "comments" : dFile.comment , "terminal": dFile.terminal , "exec" : dFile.exec , "tryExec": dFile.tryExec, "mimeType": dFile.mimeType, "url:" : dFile.url , "type": dFile.type , "path": dFile.path , "startupNotify": dFile.startupNotify, "startupWMClass": dFile.startupWMClass, "desktopFileName" : dFile.desktopFileName , "isVaild" : dFile.isValid , "noDisplay": dFile.noDisplay , "notShowIn": dFile.notShowIn , "onlyShowIn": dFile.onlyShowIn , "shouldDisplay": dFile.shouldDisplay, "isLaunching  ? " : dFile.isLaunching , "hash": dFile.hash , "hidden": dFile.hidden, "isLaunching": dFile.isLaunching })
            }
        }
    }

    function setFormFactors(){
        var fin = ['desktop','tv','phone','tablet']
         for (var i = 0 ; i < fin.length; i++){
             var er = fin[i]
             formFactorModel.append({"text": er})
         }
    }

    function previewsShown(exec ,mimeType ,name ,comment ,icon){
//        console.log("opening preview")
        previews.iconHint = icon
        previews.name = name
//                    previews.category = category
        previews.uri = exec
        previews.mimeType = mimeType
        previews.comment = comment
        previews.shown = true
        aView.visible = false
        searchBox.visible = false
    }

    ColorDialog {
        id: colorDialog
        title: "Change U2T Average Color"
        visible: false
        onAccepted: {
            u2tSettings.averageBgColor = colorDialog.color
        }
    }

    FileDialog{
        id: fileDialog
           title: "Please choice a background Image"
           nameFilters: [ "*.jpg , *.png , *.jpeg"]
           visible: false
           folder: "/usr/share/wallpapers"
           onAccepted: {
               var tt  = fileDialog.fileUrl
               var er = tt.toString()
               var fi = er.substring(er.lastIndexOf("file://")+7)
               console.log("EWRRR " + fi)
               u2tSettings.background = fi
           }



    }
    NotificationServer {
        id: notifyServer
    }
    NotificationView  {
        color:  "transparent"
    }

    PlasmaNM.EnabledConnections {
        id: enabledConnections
    }

    PlasmaNM.AvailableDevices {
        id: availableDevices
    }

    PlasmaNM.NetworkModel {
        id: connectionModel
    }

    PlasmaNM.AppletProxyModel {
        id: appletProxyModel

        sourceModel: connectionModel
    }
    Devices { id: allDevices }
    Devices {
        id: diskVolShares
        query: "IS StorageVolume"
    }
    Devices {
        id: mice
        query: "PointingDevice.type == 'Mouse'"
    }
    ListModel{id: devicesModel}




    function getAllDevices(){
        for (var i = 0 ; i < diskVolShares.count; i++){
          devicesModel.append({
                              "devicePath": diskVolShares.devices[i] ,
                              "filesystem": diskVolShares.device( diskVolShares.devices[i], "StorageVolume" ).fsType ,
                               "size" :   diskVolShares.device( diskVolShares.devices[i], "StorageVolume" ).size ,
                               "description" : diskVolShares.device( diskVolShares.devices[i], "StorageVolume" ).description
                              })
         }
    }


    function formatSizeUnits(bytes){
            if      (bytes>=1000000000) {bytes=(bytes/1000000000).toFixed(2)+' GB';}
            else if (bytes>=1000000)    {bytes=(bytes/1000000).toFixed(2)+' MB';}
            else if (bytes>=1000)       {bytes=(bytes/1000).toFixed(2)+' KB';}
            else if (bytes>1)           {bytes=bytes+' bytes';}
            else if (bytes === 1)       {bytes=bytes+' byte';}
            else                        {bytes='0 byte';}
            return bytes;
    }
    HardwareEngine {
        id: hardware
    }
    ListModel{id: storageModel}
    function fillStorageModel(){
        for (var i = 0 ; i < hardware.storageDevices.length; i++){
            storageModel.append({
                                "hdName" : hardware.storageDevices[i].name,
                                "mounted": hardware.storageDevices[i].mounted,
                                "uid":hardware.storageDevices[i].udi

                                })
        }
    }



    KCoreAddons.KUser {
        id: currentUser
    }


    Sound {
        id: sound

        property string iconName: sound.muted || sound.master == 0
                ? "av/volume_off"
                : sound.master <= 33 ? "av/volume_mute"
                : sound.master >= 67 ? "av/volume_up"
                : "av/volume_down"

        property int notificationId: 0

        onMasterChanged: {
            soundTimer.restart()
        }

        // The master volume often has random or duplicate change signals, so this helps to
        // smooth out the signals into only real changes
        Timer {
            id: soundTimer
            interval: 10
            onTriggered: {
                if (sound.master !== volume && volume !== -1) {
                    sound.notificationId = notifyServer.notify("Sound", sound.notificationId,
                            "icon://" + sound.iconName, "Volume changed", "", [], {}, 0,
                            sound.master).id
                }
                volume = sound.master
            }

            property int volume: -1
        }
    }



    KWindowSystem {
         id: kwindowsystem
     }

//     Rectangle {
//         width: 50
//         height: 50
//         color: "blue"
//         opacity: kwindowsystem.compositingActive ? 0.5 : 1
//     }

     Text {
         anchors.centerIn: parent
         text: "currentDesktopName " + kwindowsystem.currentDesktopName
               +"\n numberOfDesktops " + kwindowsystem.numberOfDesktops
               +"\n showingDesktop " + kwindowsystem.showingDesktop
               +"\n currentDesktop " + kwindowsystem.currentDesktop
               +"\n compositingActive " + kwindowsystem.compositingActive
               +"\n desktopName 1 " + kwindowsystem.desktopName(1)
               +"\n desktopName 2 " + kwindowsystem.desktopName(2)
     }





    Component.onCompleted:{
        reloadModel()
        getAllDesktopFiles()
        setFormFactors()
        getAllDevices()
        fillStorageModel()
    }
}
