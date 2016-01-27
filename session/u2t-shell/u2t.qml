import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Dialogs 1.2
import U2T.Menu 1.0
import U2T.GSettings 1.0
import U2T.System 1.0
import QtSpeechRecognition 0.5
import "notifications"
import org.kde.kcoreaddons 1.0 as KCoreAddons

/////////////////////////////
//
// This is the main File for the Unity Like DE for GreenIsland
//
/////////////////////////////


Rectangle {
    id: shell
    color: "transparent"
    anchors.fill: parent
    property string  lastSpokenWord
    // the background image
    Image{
        source: "file://" +u2tSettings.background
        anchors.fill: parent
    }
    Text {
        anchors.centerIn: parent
        color: "white"
        font.pixelSize: 48
            text:{
            var aL = root.windowList
//            var k ,r;
            var t = aL.toString();


            "FPS: " +  fpsCounter.fps + "\nWindowList: " +  t +"\nsomething: " + compositor.state
        }
    }
    // Top Pannel
    Pannel{ id: pannel; anchors.top:parent.top }

    // The Launcher
    LauncherLoader{
        id: launcher
        width: 64
        height: parent.height - pannel.height
        anchors.top: pannel.bottom
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
        Behavior on width {NumberAnimation{duration: 600 ;easing.type: Easing.OutBack}}
    }



    ///////////////////////////////////////////////
    //
    // Set all the GSettings things
    //
    /////////////////////////////////////////////
    GSettings{ id: launcherSettings; schema.id: "com.iheartqt.U2T.Launcher" }
    GSettings{ id: dashSettings; schema.id: "com.iheartqt.U2T.Dash" }
    GSettings{ id: pannelSettings; schema.id: "com.iheartqt.U2T.Pannel" }
    GSettings{ id: u2tSettings; schema.id: "com.iheartqt.U2T" }

    NotificationView  {color:"transparent"}
    ////////////////////////////////////
    // CORE JS Functions
    //////////////////////////////////

    // import this is only for combo box
    function getAllDesktopFiles(){
        var t = dFile.getAllFiles
        var kk = t.toString();
        var k = kk.split(",")
        for (var it = 0 ; it < k.length; it++){
            var tt = k[it];
            var ttt = tt.substring(tt.lastIndexOf("/")+1)
            var removeEXT = ttt.substring(0,ttt.lastIndexOf("."))
            allDesktopFiles.append({"text": removeEXT })
        }
    }
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
//            console.log(i)
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
        previews.iconHint = icon
        previews.name = name
        previews.uri = exec
        previews.mimeType = mimeType
        previews.comment = comment
        previews.shown = true
        aView.visible = false
        searchBox.visible = false
    }

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

    function fillStorageModel(){
        for (var i = 0 ; i < hardware.storageDevices.length; i++){
            storageModel.append({
                                "hdName" : hardware.storageDevices[i].name,
                                "mounted": hardware.storageDevices[i].mounted,
                                "uid":hardware.storageDevices[i].udi
                                })
        }
    }

    //////////////////////
    ///MODELS
    ///////////////////////

    // models
    ListModel{ id:allApps }
    ListModel{ id:systemModel }
    ListModel{ id:networkingModel }
    ListModel{ id:graphicsModel }
    ListModel{ id:officeModel }
    ListModel{ id:avModel }
    ListModel{ id:accessibilityModel }
    ListModel{ id:educationModel }
    ListModel{ id:scienceModel }
    ListModel{ id:developmentModel }
    ListModel{ id:utilityModel }
    ListModel{ id:xdgModel }
    ListModel{ id: allDesktopFiles }
    ListModel{ id: formFactorModel }
    ListModel{ id: devicesModel }
    ListModel{ id: storageModel }
    ListModel{id: openApps}


//////////////////////////////////////
// Current Users and Things like OS
//////////////////////////////////////
KCoreAddons.KUser {id: currentUser}

////////////////////////////////
// DIALOGS
////////////////////////////////
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


    Component.onCompleted:{
        reloadModel(); getAllDesktopFiles(); setFormFactors(); getAllDevices(); fillStorageModel()
    }
}
