import QtQuick 1.0
import "../component" as Comp

Item {
    id: container
    width: parent.width
    height: parent.height

    // App layout: content pane and tab bar at the bottom which changes the content of the content pane
    Item {
        id: contentPane
        clip: false

        anchors {
            top: tabBar.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        // View switcher component, handles the view switching and animation
        Comp.ViewSwitcher {
            id: viewSwitcher
            // Rooted in contentPane
            root: contentPane
        }

        // The actual views
        Comp.ViewLoader {
            id: page1
            viewSource: "DashSettings.qml"
            keepLoaded: true


        }

        Comp.ViewLoader {
            id: page2
            viewSource: "LauncherSettings.qml"
            keepLoaded: true
        }

        Comp.ViewLoader {
            id: page3
            viewSource: "PanelSettings.qml"
            keepLoaded: true
        }
        Comp.ViewLoader {
            id: page4
            viewSource: "Lightdm.qml"
            keepLoaded: true
        }
    }

    Comp.TabBar {
        id: tabBar
        anchors {
            top: parent.top
            left: parent.left
           bottom:  parent.bottom
        }

        height: 80
        button1Text: u2d.tr("Dash");
        button2Text: u2d.tr("Launcher");
        button3Text: u2d.tr("Panel");
        button4Text: u2d.tr("Lightdm");

        onTabButtonClicked: {
            console.log("Tab-bar button clicked: " + buttonName);
            if (buttonName == "page1Button") {
                viewSwitcher.switchView(page1,0, "instant");
            } else if (buttonName == "page2Button") {
                viewSwitcher.switchView(page2,0, "instant");
            } else if (buttonName == "page3Button") {
                viewSwitcher.switchView(page3,0, "instant");
            } else if (buttonName == "page4Button") {
                viewSwitcher.switchView(page4,0, "instant");
            }

        }
    }
}
