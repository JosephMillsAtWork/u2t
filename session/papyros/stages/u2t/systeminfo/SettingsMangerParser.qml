import QtQuick 1.0
import Unity2d 1.0
import "../dash"
SystemManagerButton {
//    property int  iconSize: application.iconSourceSize
    property alias contentType: defaultApplication.contentType
    /* If the desktopFile property is set and points to an existing
     * application, the contentType property is ignored.
     */
    property alias desktopFile: defaultApplication.defaultDesktopFile
    GioDefaultApplication {
        id: defaultApplication
    }
    Application {
        id: application
        desktop_file: defaultApplication.desktopFile
    }
    visible: application.desktop_file != ""
    onClicked: dash.activateApplication(application)
    text: ""
    icon: "image://icons/" + application.icon
}
