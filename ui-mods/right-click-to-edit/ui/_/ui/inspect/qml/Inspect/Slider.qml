import QtQuick

Rectangle {
	id: widget

	function getDynValue() {
		var x = 2 * (Math.max(0, Math.min(widget.width, mouseArea.mouseX)) / widget.width) - 1;

		var move;
		var borderValue = 0.0001;
		curValue < 0 ? move = -1 : move = 1;

		var newValue = curValue * Math.pow(k, move * x)

		if ((curValue < borderValue && curValue > 0) || (newValue < borderValue && newValue > 0) ||
			(curValue > -1 * borderValue && curValue < 0) || (newValue > -1 * borderValue && newValue < 0)) {
			newValue = 0;
		}

		if (curValue == 0 && x > 0) {
			newValue = borderValue;
		}

		if (curValue == 0 && x < 0) {
			newValue = -1 * borderValue;
		}

		return newValue;
	}

	property double value: 1
	property double k: 1.1
	property int extraWidth: 0
	property bool isEditing: false
	property bool leftButtonPressed: false
	property double displayValue: +widget.dynValue.toFixed(widget.precision)
	property double curValue: 1
	property double dynValue: leftButtonPressed ? getDynValue() : widget.curValue
	property string title: ''
	property string hint: ''
	property string variable: ''
	property int precision: 5

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

	onValueChanged: {
		if (!leftButtonPressed) {
			widget.curValue = widget.value
		}
	}

	/* Elem design */
	border.color: Qt.rgba(0.4, 0.4, 0.4, 1)
	border.width: 1
	antialiasing: true
	color: Qt.rgba(0.2, 0.2, 0.2, 0.8)
	width: 210 + qmlStyles.tree.scaleWidth + extraWidth
	height: propname.height + 10

	

	/* Components */
	Rectangle {
		visible: leftButtonPressed
		color: qmlStyles.baseColor

		x: Math.max(0, Math.min(widget.width / 2, mouseArea.mouseX))
		y: 0

		width: Math.min(widget.width / 2, Math.abs(widget.width / 2 - mouseArea.mouseX))
		height: widget.height
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

	
	MouseArea {
		id: mouseArea
		anchors.fill: parent
		hoverEnabled: true
		acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
		
		onPressed: {
			if (mouse.button === Qt.LeftButton) {
				leftButtonPressed = true;
			}
		}
		
		onReleased: {
			if (mouse.button === Qt.LeftButton) {
				widget.curValue = widget.dynValue;
				leftButtonPressed = false;
			}
		}
		
		onClicked: {
			if (mouse.button === Qt.RightButton) {
				isEditing = true;
				valueInput.text = widget.displayValue.toString();
				valueInput.visible = true;
				valueInput.selectAll();
				valueInput.forceActiveFocus();
			}
		}
		
		onWheel: {
			wheel.accepted = true
		}
		onEntered: {
			if (widget.hint != '') {
				timer.setTimeout(function() {
					hintBox.visible = true;
					widget.parent.parent.z = 1000;
				}, 500);
			}
		}
		onExited: {
			timer.setTimeout(function() {
				hintBox.visible = false;
				widget.parent.parent.z = 0;
			}, 100);
		}
	}

	Rectangle {
		color: qmlStyles.baseColor
		x: widget.width / 2 - 1
		y: 0
		width: 2
		height: widget.height
	}

	Text {
		id: propname
		color: qmlStyles.tree.color
		font: qmlStyles.tree.control.font
		text: widget.title
		anchors.left: widget.left
		anchors.top: widget.top
		anchors.leftMargin: 5
		anchors.topMargin: 5
		width: widget.width / 2
	}

	Text {
		id: propvalue
		color: qmlStyles.tree.color
		font: propname.font
		text: widget.displayValue
		visible: !isEditing
		anchors.top: propname.top
		anchors.right: widget.right
		anchors.rightMargin: 5
	}
	
	TextInput {
		id: valueInput
		visible: false
		color: qmlStyles.baseColor
		font: propname.font
		selectByMouse: true
		anchors.top: propname.top
		anchors.right: widget.right
		anchors.rightMargin: 5
		
		onAccepted: {
			var newValue = parseFloat(text);
			if (!isNaN(newValue)) {
				widget.curValue = newValue;
				widget.value = newValue;
			}
			isEditing = false;
			valueInput.visible = false;
		}
		
		Keys.onEscapePressed: {
			isEditing = false;
			valueInput.visible = false;
		}
		
		onActiveFocusChanged: {
			if (!activeFocus && isEditing) {
				// Lost focus, cancel editing
				isEditing = false;
				valueInput.visible = false;
			}
		}
	}
/*
	Text {
		id: koefInfo
		text: 'x' + widget.k
		font.pixelSize: qmlStyles.fontSize / 2
		color: qmlStyles.baseColor
		anchors.right: widget.right
		anchors.bottom: widget.bottom
		anchors.rightMargin: koefInfo.width / 2
		anchors.bottomMargin: koefInfo.height / 2
	}
	*/
}
