Rectangle{
    id:highContrastRec
    width: parent.width
    Behavior on width {NumberAnimation{from: 0; to: parent.width;duration: 1200;easing.type: Easing.OutQuint}}
    height: parent.height / 8
    border.color: "#55FFFFFF"
    border.width: 1
    gradient: Gradient {
        GradientStop { position: 0; color: "#42FFFFFF"}
        GradientStop { position: 0.5; color: "#66808080"}
        GradientStop { position: 1; color: "#42FFFFFF"}

    }
    Text {
        font.pixelSize: 18
        color: "white"
        text: u2d.tr("Play The Drums ?:")
        anchors{
            verticalCenter: highContrastRec.verticalCenter
            left: highContrastRec.left
            leftMargin: highContrastRec.width / 20
        }
    }
    Image{
        id: highContrastIconButtonRec
        source: "../../../../artwork/tick_box.png"
        anchors{
            right: parent.right
            rightMargin: parent.width / 12.5
            verticalCenter: highContrastRec.verticalCenter
        }
        Image{
            id:highContrastIconButton
            source: "../../../../artwork/tick.png"
            visible: if(lightDmConfiguration.highContrast === true)
                         true
            else
                         false
            scale: 1.5
            smooth: true
            anchors{
                right: parent.right
                rightMargin: parent.width / 12.5
                verticalCenter: highContrastIconButtonRec.verticalCenter
            }
        }MouseArea{
            anchors.fill:highContrastIconButton
            onClicked: if (lightDmConfiguration.highContrast === true)
                           lightDmConfiguration.highContrast = false
                       else if (lightDmConfiguration.highContrast === false)
                           lightDmConfiguration.highContrast = true
        }
    }
}
