import SstComponents


// Column {
Rectangle {
	id        : 'qTools'
	objectName: 'qTools'
	
	
	property var dragStartX: 0
	property var dragStartY: 0
	
	
	property var tool: []
	property var activeToolUid: 0
	property var dragTool  : null
	property int maxMaterialColumns: 10
	
	function reset() {
		activeTool = null
	}
	
	function calculateMaxColumns() {
		let maxCount = 0;
		for (let i = 0; i < subtoolView.model.count; i++) {
			let category = subtoolView.model.get(i);
			if (category.subtools && category.subtools.count) {
				maxCount = Math.max(maxCount, category.subtools.count);
			}
		}
		let cols = Math.floor(maxCount / 5) * 5;
		return Math.max(5, cols);
	}

/*
	property var ioMan: new IoMan.IoMan()
	function ioDrop( opts ) { ioMan.drop( opts ); }
	function ioReg(  opts ) { ioMan.reg(  opts ); }
	function ioSet(  opts ) { ioMan.set(  opts ); }
	function ioGet(  opts ) { ioMan.get(  opts ); }
*/

	Component.onCompleted: {
		someRoot.state[qTools.objectName] = qTools
	}
	
	function show(data) {
		console.info('SHOW TOOLS!');
		//console.info(JSON.stringify(data));
		
		/*
		if (toolView.model.count>0){
			for ( let x=0;x<toolView.model.count;x++ ){
				let item = toolView.model.get(x);
				
				if ( item.ii > -1 ){
					toolView.model.remove(x);
					x--;
				};
			};
		};
		*/

		//else{
			
		toolView.model.clear();
		
			
			data.forEach(function (node,i) {
				toolView.model.append(node);

			});
			

			for ( let x=0;x<toolView.model.count;x++ ){
				let item = toolView.model.get(x);

				if (item.active && item.subtools){
					subtoolView.model = item.subtools;
				}
			};
			
			maxMaterialColumns = calculateMaxColumns();
		
	}
	
	function clear(data) {
		
		toolView.model.clear();
		
	}
	
	width: 100
	height: toolView.contentHeight + 30
	
	color: '#00000000'
	
	anchors.top: parent.top
	// anchors.right: parent.right
	
	anchors.rightMargin: 0
	anchors.right: parent.right
	
	ListView {
		
		id: toolView
		
		anchors.fill: parent
		
		anchors.rightMargin: 10
		anchors.right: parent.right
		
		anchors.topMargin: 10
		anchors.bottomMargin: 10
		
		boundsBehavior: Flickable.StopAtBounds
		
		height: 200
		
		delegate: Row {

			padding: 2
			
			property bool isOpen: false
			
			//property var list: model.submode
			//property string title: model.title
			
			anchors.rightMargin: 0
			anchors.right: parent?.right
			
			Column {
				
				Row {
					width: 70
					//width: 150
					
					spacing: 10
					
					anchors.rightMargin: 0
					anchors.right: parent.right
					
					Rectangle {
						width: 56
						height: 56
						//anchors.horizontalCenter: parent.horizontalCenter
						//anchors.top: parent.top

						
						color: '#77777777'
						//border.color: "#ff777777"
						//border.color: model.active ? "#ff7777ff" : "#ff777777"
						// border.color: "#ffffffff"
						//border.width: 2
						border.color: model.active ? "#ff33AAff" : "#ffffffff"
						//border.color: model.active ? "#ffffffff" : "#ff777777"
						border.width: model.active ? 3 : 2
						radius: width*0.5


						IconAwesome {
							name: model.icon
							size: 26
							anchors.centerIn: parent
							color: qmlStyles.button.color
						}
						
						ToolTip.delay: 350
						ToolTip.visible: mouseArea1.containsMouse
						ToolTip.text: model.title
						
						MouseArea {
							id : mouseArea1
							hoverEnabled : true
							anchors.fill : parent
							onClicked : {
								// eventEmit('change-tool', { uid: model.uid });
								
								qTools.activeToolUid = model.uid;
								qTools.dragTool   = model.drag;
								
								
								console.info('TOOL CLICK!', model.title );
								
								eventEmit('open-tool', { uid: model.uid });
								
								
								console.info('SHOW SUBTOOLS!');
								
								subtoolView.model = model.subtools;
								
								
								
								/*
								console.info(model.subtools);
								
								subtoolView.model.clear();
								
								model.subtools.forEach(function (node) {
									subtoolView.model.append(node);
								});
								*/
								
								
								
							}
							
							
						}
						
					}
					
					
					/*
					Text {
						id : menuLabel
						text : model.title
						
						anchors.verticalCenter: parent.verticalCenter
						
						// anchors.centerIn : parent
						
						font: qmlStyles.button.font
						color : qmlStyles.button.color
						styleColor : qmlStyles.button.styleColor
					}
					*/
				}

				
			}
			
		}
		
		model   : ListModel { }
	}
	
	
	

Rectangle {
		width: subtoolsCol.width + 40
		height: subtoolsCol.height + 40
		
		
		anchors.rightMargin: 210 - 100
		anchors.right: parent.right
		
		anchors.top: parent.top
		anchors.topMargin: 10
		
		// anchors.bottomMargin: 10
		
	//anchors.horizontalCenter: parent.horizontalCenter
	//anchors.top: parent.top
	
	color: '#77777777'
	border.color: "#ffffffff"
	border.width: 2
	radius: 32
	
	
	Column {
		id: subtoolsCol
		
		// anchors.fill: parent
		anchors.horizontalCenter: parent.horizontalCenter
		
		//anchors.top: parent.top
		//anchors.topMargin: 10
		
		anchors.top: parent.top
		anchors.topMargin: 10
		
		//anchors.fill  : parent
		//anchors.margin: 10
		
		spacing: 5
		
		
		Repeater {
			id: subtoolView
			
			model    : ListModel { }
			
			delegate : Column {
					// width: 200
					
					// width: parent.width
					
					// height: 20
					
					spacing: 5
					anchors.horizontalCenter: parent.horizontalCenter
					
					
					/*
					Rectangle {
						
						height: 1
						width: parent.width
						color: '#CCFFFFFF'
						
						anchors.horizontalCenter: parent.horizontalCenter
					}
					*/
					
					Text {
						id : menuLabel1
						text : model.title
						
						height: 20
						
						
						anchors.horizontalCenter: parent.horizontalCenter
						// anchors.centerIn : parent
						
						
						font: qmlStyles.button.font
						color : qmlStyles.button.color
						styleColor : qmlStyles.button.styleColor
					}
					
			
		Component.onCompleted: {
			console.info('COMPLETED!');
			
			if ( model.subtools ){
				subtoolView2.model = model.subtools
			}
			
			
		}
			

		Grid {
			//columns: 8
			columns: qTools.activeToolUid == 'material' ? Math.max(5, qTools.maxMaterialColumns) : 3
			spacing: 5
			
			// anchors.fill: parent
			
			//width: 200
			
			anchors.horizontalCenter: parent.horizontalCenter
			
			Repeater {
				id: subtoolView2
				
				delegate: Column {
					width: qTools.activeToolUid == 'material' ? 52 : 52
					//width: 64
					//height: 150
					
					
					spacing: 5
					
					//anchors.rightMargin: 0
					//anchors.right: parent.right
					
					Rectangle {
						width: qTools.activeToolUid == 'material' ? 48 : 48
						height: qTools.activeToolUid == 'material' ? 48 : 48
						
						anchors.horizontalCenter: parent.horizontalCenter
						
						// anchors.horizontalCenter: Drag.active ? null : parent.horizontalCenter
						// anchors.horizontalCenter: Drag.active ? '' : parent.horizontalCenter
						
						
						//anchors.top: parent.top
						
						//ToolTip.visible: down
						//ToolTip.text: qsTr("tooltip")
						
						
						
						
						color: model.invert ? '#77777777' : model.color ? model.color : '#77777777'
						border.color: model.active ? "#ff33AAff" : "#ffffffff"
						//border.color: model.active ? "#ffffffff" : "#ff777777"
						border.width: model.active ? 3 : 2
						radius: width*0.5
						

/*
Button {
    text: qsTr("Button")
    hoverEnabled: true

    ToolTip.delay: 1000
    ToolTip.timeout: 5000
    ToolTip.visible: hovered
    ToolTip.text: qsTr("This tool tip is shown after hovering the button for a second.")
}
*/
						ToolTip.delay: 350
						ToolTip.visible: !mouseArea2.drag.active && mouseArea2.containsMouse
						ToolTip.text: model.title
						
						
						
						Drag.active: mouseArea2.drag.active
						
						/*
						Drag.onDragFinished: {
							console.info('DRAG FINISH!');
							
						}
						*/
						
						
						MouseArea {
							id : mouseArea2
							hoverEnabled : true
							anchors.fill : parent
							
							
							drag.target: dragTool ? parent : null
							// onReleased: parent.Drag.drop()
							
							acceptedButtons: Qt.LeftButton | Qt.RightButton
							
							onPressed: {
								qTools.dragStartX = parent.x;
								qTools.dragStartY = parent.y;
								
								
							}
							
							onReleased: {
								
								if ( qTools.dragTool ){
									
									let dx = qTools.dragStartX - parent.x;
									let dy = qTools.dragStartY - parent.y;
									
									let dist = Math.sqrt(dx*dx+dy*dy);
									
									// пока быстрый фикс - просто проверяем, что оттащил на достаточное расстояние
									if ( dist > 64 ){
										var pos = parent.mapToItem(someRoot, 0, 0);
										
										// console.log("X: " + globalCoordinares.x + " y: " + globalCoordinares.y);
										
										eventEmit('change-tool', { uid: model.uid, pid: qTools.activeToolUid, pos: [pos.x, pos.y] });
										
										// console.info('DROP SUBTOOL!', pos.x, pos.y );
										
									};
									
									
									
									parent.x = qTools.dragStartX;
									parent.y = qTools.dragStartY;
									parent.Drag.drop();
								};
								
								
								
							}
							
							
							/*
							onDragActiveChanged: {
								if(drag.active) { //
									console.info('subtool drag start!');
									// ... // Dragging started
								} else {
									console.info('subtool drag finish!');
									
									// ... // Dragging finished
								}
							*/
							
							
							onClicked : (mouse) => {
								if (model.title === "clone material" && mouse.button === Qt.RightButton) {
									return;
								}
								if ( !qTools.dragTool ){
									console.info('TOOL CLICK!', model.title, model.uid, qTools.activeToolUid );
									
									eventEmit('change-tool', { uid: model.uid, pid: qTools.activeToolUid, rightclick: mouse.button == Qt.RightButton ? 1 : 0 });
									
									// qTools.activeTool = currentTool


									


									
								};
								
								
							}
							
							
						}
						
						IconAwesome {
							name: model.icon
							size: (qTools.activeToolUid == 'material' ? 48 : 48) / 2
							anchors.centerIn: parent
							color : model.invert ? model.color : qmlStyles.button.color
						}
						
						
					}
					
					Text {
						id : materialLabel
						text : model.title + (qTools.activeToolUid == 'material' && model.title !== "clone material" && model.uid !== undefined ? " (" + model.uid + ")" : "")
						
						width: parent.width
						horizontalAlignment: Text.AlignHCenter
						wrapMode: Text.Wrap
						
						anchors.horizontalCenter: parent.horizontalCenter
						
						font.pixelSize: 9
						font.italic: model.active
						
						color: model.active ? "#33AAff" : qmlStyles.button.color
						style: Text.Outline
						styleColor: "#000000"
					}
					
					
				}
				
				model   : ListModel { }
				// model   : model.subtools
				
			}
		}
		
	}
	}
	

	Column {
		
	Text {
		visible: qTools.dragTool ? true : false
		
		text: '(drag)'
		
		height: 20
		// anchors.verticalCenter: parent.verticalCenter
		
		//anchors.centerIn : parent
		
		font: qmlStyles.button.font
		color : '#FF777777'
		//color : qmlStyles.button.color
		styleColor : qmlStyles.button.styleColor
	}
	
	}

}

}


	
}
