import QtQuick 1.0
Item {
	id: progresDialog
    width: parent.width / 3
    height: parent.height / 3
	property alias text: progresText.text
	Rectangle {
		id: background
		anchors.fill: parent
        color: "#44000000"
		border.color: "white"
		border.width: 1
	}

	Text {
		id: progresText
		text: ""
		width: parent.width - 40
        color: "white"
        font.pixelSize: 20
        anchors{
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 20
        }
	}

	Image {
		id: indicatorImg
        width: 128
        height: 128
        smooth: true
        source: "/usr/share/unity/5/launcher_bfb.png"
        anchors{
            verticalCenter:  parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }
            RotationAnimation {
			target: indicatorImg;
			running: true
			loops: Animation.Infinite
			duration: 1000
			direction: RotationAnimation.Clockwise
			from: 0
			to: 360
		}
	}
}
