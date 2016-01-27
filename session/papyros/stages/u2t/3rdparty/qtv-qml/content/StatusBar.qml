import Qt 4.7

Item {
	id: statusBar
	width: parent.width - 50
	height: statusText.height + 4
	y: parent.height
	anchors.right: parent.right
	opacity: 0
	Rectangle {
		anchors.fill: parent
        color: "transparent"
		border.color: "white"
		border.width: 1
	}

	Text {
		id: statusText
		width: parent.width
		height: 30
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		text: ""

		color: "white"
	}

	Timer {
		id: statusTimer
		interval: 3000
		onTriggered: {
			statusBar.state = ''
			running: false
		}
	}

	states: [
		State {
			name: "Show"
			PropertyChanges {
				target: statusText
				text: {
					if (feedModel.status == XmlListModel.Null) { return ""; statusBar.state = ''; }
					if (feedModel.status == XmlListModel.Ready) { return "Ready"; statusBar.state = ''; }
					if (feedModel.status == XmlListModel.Loading) return "Loading"
					if (feedModel.status == XmlListModel.Error) return "Error"
				}
			}
			PropertyChanges {
				target: statusBar
				opacity: 1
				y: page.height - statusBar.height
			}
		}
	]

	transitions: [
		Transition {
			PropertyAnimation { properties: "y"; duration: 300}
		}
	]

}
