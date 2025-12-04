import QtQuick

Rectangle {
	id: widget

	signal clicked()

	/* Elem properties */
	property double value: 1
	property string tvalue: ''
	property string title: 'unnamed'
	property string hint: ''
	property int extraWidth: 0
	property double minValue: 1
	property double maxValue: 5
	property string variable: ''
	property bool isEditing: false
	
	/* Elem design */
	border.color: Qt.rgba(0.4, 0.4, 0.4, 1)
	border.width: 1

	color: Qt.rgba(0.2, 0.2, 0.2, 0.8)
	width: 210 + qmlStyles.tree.scaleWidth + widget.extraWidth
	height: propname.height + 10

	antialiasing: true
	
	MouseArea {
		id: mouseArea
		anchors.fill: parent
		hoverEnabled: true
		propagateComposedEvents: true

		onEntered: {
			if (widget.hint != '') {
				timer.setTimeout(function() {
					widget.parent.parent.z = 1000;
					hintBox.visible = true;
				}, 500);
			}
		}
		onExited: {
			timer.setTimeout(function() {
				widget.parent.parent.z = 0;
				hintBox.visible = false;
			}, 100);
		}
	}


	Timer {
		id: timer
		function setTimeout(cb, delayTime) {
			timer.interval = delayTime;
			timer.repeat = false;
			timer.triggered.connect(cb);
			timer.triggered.connect(function release() {
				timer.triggered.disconnect(cb); // This is important
				timer.triggered.disconnect(release); // This is important as well
			});
			timer.start();
		}
	}

	// tooltip
	Rectangle {
		id: hintBox
		visible: false
		
		anchors.left: parent.right
		anchors.top: parent.top

		anchors.leftMargin: 25

		width: 250
		height: hintText.height

		color: Qt.rgba(0.2, 0.2, 0.2, 1)
		border.color: Qt.rgba(0.6, 0.6, 0.6, 0.8)
		border.width: 1

		Text {
			id: hintText
			color: qmlStyles.tree.color
			font: qmlStyles.tree.control.font
			text: widget.hint + '<br><br>Tech name: <i><b>' + widget.variable + '</i></b>'

			width: parent.width
			wrapMode: Text.Wrap

			anchors.left: parent.left
			anchors.top: parent.top

			padding: 7
		}
	}

	/* Components */
	Button {
		id: decrease
		text: "–"
		// font: qmlStyles.tree.input.font
		width: widget.height
		height: widget.height
		anchors.top: widget.top
		anchors.left: widget.left

		color: qmlStyles.baseColor
		onClicked: widget.value > widget.minValue ? widget.value-- : widget.value
	}

	Rectangle {
		anchors.left: decrease.right
		anchors.right: increase.left
		anchors.leftMargin: 5
		anchors.rightMargin: 5
		height: widget.height
		color: 'transparent'

		MouseArea {
			anchors.fill: parent
			acceptedButtons: Qt.LeftButton | Qt.RightButton
			
			onClicked: (mouse) => {
				if (mouse.button === Qt.RightButton) {
					widget.isEditing = true;
					valueInput.text = widget.value.toString();
					valueInput.visible = true;
					valueInput.selectAll();
					valueInput.forceActiveFocus();
				} else {
					widget.clicked();
				}
			}
		}

		Text {
			id: propname
			color: 'white'
			text: widget.title
			font: qmlStyles.tree.control.font
			anchors.left: parent.left
			anchors.top: parent.top
			anchors.topMargin: 5
		}

		Text {
			id: propvalue
			visible: !widget.isEditing
			color: 'white'
			text: widget.tvalue || widget.value
			font: propname.font
			anchors.left: propname.right
			anchors.leftMargin: 5
			anchors.top: propname.top
		}
		
		TextInput {
			id: valueInput
			visible: false
			color: qmlStyles.baseColor
			font: propname.font
			selectByMouse: true
			anchors.left: propname.right
			anchors.leftMargin: 5
			anchors.top: propname.top
			
			onAccepted: {
				var newValue = parseFloat(text);
				if (!isNaN(newValue)) {
					// clamp to min/max
					if (newValue < widget.minValue) newValue = widget.minValue;
					if (newValue > widget.maxValue) newValue = widget.maxValue;
					widget.value = newValue;
				}
				widget.isEditing = false;
				valueInput.visible = false;
			}
			
			Keys.onEscapePressed: {
				widget.isEditing = false;
				valueInput.visible = false;
			}
			
			onActiveFocusChanged: {
				if (!activeFocus && widget.isEditing) {
					widget.isEditing = false;
					valueInput.visible = false;
				}
			}
		}
	}

	Button {
		anchors.top: widget.top
		anchors.right: widget.right
		id: increase
		text: "+"
		width: widget.height
		height: widget.height
		color: qmlStyles.baseColor
		onClicked: widget.value < widget.maxValue ? widget.value++ : widget.value
	}
}
