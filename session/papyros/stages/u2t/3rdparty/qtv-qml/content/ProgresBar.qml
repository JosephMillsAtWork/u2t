import Qt 4.7

Item {
	id: progresBar
	width: 200; height: 20

	property real value: 0

	Rectangle {
		id: background
		anchors.fill: parent

		radius: 2
		smooth: true

        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#cfcfcf"
            }

            GradientStop {
                position: 0.5
                color: "#fdfdfd"
            }

            GradientStop {
                position: 1
                color: "#cfcfcf"
            }
        }

        border.color: "gray"
		border.width: 2

	}

    Rectangle {
		id: bar
		x: 1; y: 1; width: (parent.width - 2) * value; height: parent.height - 2

        gradient: Gradient {
            GradientStop { position: 0.0; color: "lightgreen" }
            GradientStop { position: 0.5; color: "green" }
            GradientStop { position: 1.0; color: "lightgreen" }
        }

		Behavior on width { PropertyAnimation { duration: 300 }}
	}
}
