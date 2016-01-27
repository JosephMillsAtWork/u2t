import QtQuick 2.0
import QtQuick.Layouts 1.0
import Material 0.1
import Papyros.Components 0.1
import Papyros.Desktop 0.1
import Papyros.Indicators 0.1

Rectangle {
    width: 20
    height: 20
    IndicatorView {
        id: appDrawerButton
        width: height
        iconSize: Units.dp(24)
        indicator: AppDrawer {
            id: appDrawer
        }
    }
}
