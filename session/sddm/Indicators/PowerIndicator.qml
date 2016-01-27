import QtQuick 2.0
import Material 0.1
import Material.ListItems 0.1 as ListItem
import Papyros.Indicators 0.1

Indicator {
    id: indicator

    iconSource: "icon://action/power_settings_new"
    tooltip: "Power"
    visible: sddm.canSuspend || sddm.canHibernate || sddm.canPowerOff || sddm.canReboot

    view: Column {

        ListItem.Standard {
            iconSource: Qt.resolvedUrl("images/sleep.svg")
            text: "Sleep"
            visible: sddm.canSuspend
            onClicked: {
                sddm.suspend()
                indicator.close()
            }
        }

        ListItem.Standard {
            iconName: "file/file_download"
            text: "Suspend to disk"
            visible: sddm.canHibernate
            onClicked: {
                sddm.hibernate()
                indicator.close()
            }
        }

        ListItem.Standard {
            iconName: "action/power_settings_new"
            text: "Power off"
            visible: sddm.canPowerOff
            onClicked: {
                sddm.powerOff()
                indicator.close()
            }
        }

        ListItem.Standard {
            iconSource: Qt.resolvedUrl("images/reload.svg")
            text: "Reboot"
            visible: sddm.canReboot
            onClicked: {
                sddm.reboot()
                indicator.close()
            }
        }
    }
}
