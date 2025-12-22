import QtQuick
import QtQuick.Controls

Rectangle {
	id: clicker

	signal clicked()

	/* Elem properties */ 
	property double value    : 1 
	property string tvalue   : ''
	property string text : 'unnamed'
	property double minValue : 1
	property double maxValue : 5
	property bool isEditing: false
	
	/* Elem design */
	border.color: Qt.rgba(0.4, 0.4, 0.4, 1)
	border.width: 1

	color: Qt.rgba(0.2, 0.2, 0.2, 0.8)
	width  : 210 + qmlStyles.tree.scaleWidth // и тут следует ввести поправочный коэффициент на расширение
	height : propname.height + 10

	antialiasing : true

	/* Components */ 
	Button {
		id: decrease
		text: "–"
		// font: qmlStyles.tree.input.font
		width: clicker.height
		height: clicker.height
		anchors.top: clicker.top
		anchors.left: clicker.left

		onClicked: clicker.value > clicker.minValue ? clicker.value-- : clicker.value  
			
		Rectangle {
			anchors.fill: parent
			color: qmlStyles.baseColor
		}
	}

	Rectangle {
		anchors.left: decrease.right
		anchors.right: increase.left
		anchors.leftMargin: 5
		anchors.rightMargin: 5
		height: clicker.height
		color: 'transparent'
		
		MouseArea {
			anchors.fill: parent
			acceptedButtons: Qt.LeftButton | Qt.RightButton
			
			onClicked: (mouse) => {
				if (mouse.button === Qt.RightButton) {
					clicker.isEditing = true;
					valueInput.text = clicker.value.toString();
					valueInput.visible = true;
					valueInput.selectAll();
					valueInput.forceActiveFocus();
				} else {
					clicker.clicked();
				}
			}
		}
		

		Text {
			id: propname 
			color: 'white'
			text: clicker.text + ':'
			font: qmlStyles.tree.control.font
			anchors.left: parent.left
			anchors.top: parent.top
			anchors.topMargin: 5

		}

		Text { 
			id: propvalue
			visible: !clicker.isEditing
			color: 'white'
			text: clicker.tvalue || clicker.value
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
					if (newValue < clicker.minValue) newValue = clicker.minValue;
					if (newValue > clicker.maxValue) newValue = clicker.maxValue;
					clicker.value = newValue;
				}
				clicker.isEditing = false;
				valueInput.visible = false;
			}
			
			Keys.onEscapePressed: {
				clicker.isEditing = false;
				valueInput.visible = false;
			}
			
			onActiveFocusChanged: {
				if (!activeFocus && clicker.isEditing) {
					clicker.isEditing = false;
					valueInput.visible = false;
				}
			}
		}
		
	}

	Button {
		anchors.top: clicker.top
		anchors.right: clicker.right
		id: increase
		text: "+"
		width: clicker.height
		height: clicker.height
		onClicked: clicker.value < clicker.maxValue ? clicker.value++ : clicker.value  
		Rectangle {
			anchors.fill: parent
			color: qmlStyles.baseColor
		}
	}
}
