import QtQuick

Rectangle {
	id: slider

	function getDynValue() {
		var x = 2*(Math.max(0, Math.min(slider.width, mouseArea.mouseX))/slider.width) - 1;

		var move; 
		var borderValue = 0.0001; 
		curValue < 0 ? move = -1 : move = 1;

		var newValue = curValue * Math.pow(k, move * x)
		
		if ((curValue < borderValue && curValue > 0) || (newValue < borderValue && newValue > 0) 
				|| (curValue > -1 * borderValue && curValue < 0) || (newValue > -1 * borderValue && newValue < 0)) {
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

	/* Elem properties */ 
	property double value : 1
	property double k : 1.1
	property bool isEditing: false
	property bool leftButtonPressed: false
	
	property double displayValue: +slider.dynValue.toFixed(slider.precision) 
	property double curValue  : 1
	property double dynValue  : leftButtonPressed ?  getDynValue() : slider.curValue
	property string text : 'unnamed'
	property int precision : 5
	
	onValueChanged: {
		if ( !leftButtonPressed ){
			slider.curValue = slider.value
		}
	}
	
	/* Elem design */
	border.color: Qt.rgba(0.4, 0.4, 0.4, 1)
	border.width: 1

	color: Qt.rgba(0.2, 0.2, 0.2, 0.8)
	width  : 210 + qmlStyles.tree.scaleWidth
	height : propname.height + 10

	antialiasing : true

	/* Components */ 
	Rectangle {
		visible: leftButtonPressed
		
		color: qmlStyles.baseColor

		x: Math.max(0, Math.min(slider.width/2, mouseArea.mouseX))
		y: 0

		width: Math.min(slider.width/2, Math.abs(slider.width/2 - mouseArea.mouseX))	
		height: slider.height 
	}

	Rectangle {
		color: qmlStyles.baseColor
		x: slider.width/2 - 1
		y: 0
		width: 2
		height: slider.height
	}

	Text {
		id: propname 	
		color: qmlStyles.tree.color
		font: qmlStyles.tree.control.font
		text: slider.text
		anchors.left: slider.left
		anchors.top: slider.top
		anchors.leftMargin: 5
		anchors.topMargin: 5
		width: slider.width / 2
	}

	Text { 
		id: propvalue
		color: qmlStyles.tree.color
		font: propname.font
		text: slider.displayValue
		visible: !isEditing
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
				slider.curValue = newValue;
				slider.value = newValue;
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

	Text { 
		id: koefInfo
		text: 'x' + slider.k
		font.pixelSize: qmlStyles.fontSize / 2
		color: qmlStyles.baseColor
		anchors.right: slider.right
		anchors.bottom: slider.bottom
		anchors.rightMargin: koefInfo.width /2 
		anchors.bottomMargin: koefInfo.height /2
	}

	MouseArea {
		id : mouseArea
		anchors.fill : parent
		acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

		onPressed: {
			if (mouse.button === Qt.LeftButton) {
				leftButtonPressed = true;
			}
		}
		
		onReleased: {
			if (mouse.button === Qt.LeftButton) {
				slider.curValue = slider.dynValue;
				leftButtonPressed = false;
			}
		}
		
		onClicked: {
			if (mouse.button === Qt.RightButton) {
				isEditing = true;
				valueInput.text = slider.displayValue.toString();
				valueInput.visible = true;
				valueInput.selectAll();
				valueInput.forceActiveFocus();
			}
		}
		
		onWheel: {
			wheel.accepted = true
		}
	}
}
