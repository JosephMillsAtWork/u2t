import Qt 4.7

Item {
	id: series
	signal clicked()
	x: 15
	width: listView.width - 30
	height: topLayout.height + 14
	Rectangle {
        color: bannerImg.status === Image.Error ? "#66000000" : "transparent"
        anchors.fill: parent
        border.color: "#88FFFFFF"
        border.width: 3
		smooth: true
	}
    Image {
        id: bannerImg
        anchors.fill: parent
        source: "http://thetvdb.com/banners/"+banner
        opacity: .88
    }
	MouseArea {
		anchors.fill: parent
        onClicked:{series.clicked()}
	}
	Item {
		id: topLayout
		x: 20; width: parent.width; height: titleLabel.height
		anchors.verticalCenter: parent.verticalCenter
		Text {
			id: titleLabel
			text: name
			color: "white"
            font.pixelSize: 36
			font.bold: true;
			wrapMode: Text.WordWrap
		}
	}
}
