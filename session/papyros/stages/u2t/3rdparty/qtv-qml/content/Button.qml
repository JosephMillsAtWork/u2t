import Qt 4.7

Rectangle {
	SystemPalette { id: palette; colorGroup: SystemPalette.Active }
	/*  The property button.operation, exposed ouside, is connect to the property of inner item label.text. See 'Property aliases' (http://doc.qt.nokia.com/4.7-snapshot/qml-extending-types.html#property-aliases) */
	property alias text: label.text
	/*  Toggle behavior of button, default is not toggable. The property of button 'Advanced Mode' is set true. */
	property bool toggable: false
	/*  Porperty to tracking the toggle state of button. */
	property bool toggled: false

	/*  We want the button has a signal called clicked. */
	signal clicked

	id: button; width: label.width + 30
	//width: 50; height: 30

	/*  border.color is a item among grouped property border. See 'Grouped property'(http://doc.qt.nokia.com/4.7-snapshot/qdeclarativeintroduction.html#grouped-properties) palette gives access to the system Qt color. e.g dark, light mid and so forth. See 'QML SystemPalette Element Reference'(http://doc.qt.nokia.com/4.7-snapshot/qml-systempalette.html#mid-prop) */
	border.color: palette.mid

	/*  This property holds the corner radius used to draw a rounded rectangle. See 'Rectangle.radius' (http://doc.qt.nokia.com/4.7-snapshot/qml-rectangle.html#radius-prop) */
	//radius: 6
	/*  1) The gradient to use to fill the rectangle. Here gradientStop1 is the start color from upper boundary, while gradientStop2 is the end color at the bottom. See 'Gradient' (http://doc.qt.nokia.com/4.7-snapshot/qml-rectangle.html#gradient-prop)
		2) Qt.lighter is a global function return a color lighter than given color. See 'Global Function' (http://doc.qt.nokia.com/4.7-snapshot/qdeclarativeglobalobject.html)
		*/
	gradient: Gradient {
		GradientStop { id: gradientStop1; position: 0.0; color: Qt.lighter(palette.button) }
		GradientStop { id: gradientStop2; position: 1.0; color: palette.button }
	}

	/*  Button text is located at enter of button and use system default buttonText*/
	Text { id: label; anchors.centerIn: parent; color: palette.buttonText }

	/*  The MouseArea item enables simple mouse handling.*/
	MouseArea {
		id: clickRegion
		/*  Area covers entire button.*/
		anchors.fill: parent
		/*  Signal Handlers for click on MouseArea. */
		onClicked: {
			/*???*/
			//doOp(operation);
			/*  A 'clicked' signal of parent is emitted.*/
			button.clicked();
			/*  For toggle behavior of button.*/
			if (!button.toggable) return;
			if (button.toggled) button.toggled = false; else button.toggled = true
		}
	}

	/*  Beside of default state, the button has the other action states: Pressed and Toggled. Notice they have own condition to enter the state. In these two actions states, the starting gredient changes to palette.dark to distinguish from default appearance. */
	states: [

		State {
			name: "Pressed"; when: clickRegion.pressed == true
			PropertyChanges { target: gradientStop1; color: palette.dark }
			PropertyChanges { target: gradientStop2; color: palette.button }
		},
		State {
			name: "Toggled"; when: button.toggled == true
			PropertyChanges { target: gradientStop1; color: palette.dark }
			PropertyChanges { target: gradientStop2; color: palette.button }
		}
	]
}
