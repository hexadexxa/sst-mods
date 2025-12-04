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
	
	property int rowsPerPage: 2
	
	property bool showNames: false
	property bool showIds: false
	
	// arrays dont work nice so we get to manually do this instead
	property int cat0page: 0
	property int cat1page: 0
	property int cat2page: 0
	property int cat3page: 0
	property int cat4page: 0
	property int cat5page: 0
	property int cat6page: 0
	property int cat7page: 0
	property int cat8page: 0
	property int cat9page: 0
	property int cat10page: 0
	property int cat11page: 0
	property int cat12page: 0
	property int cat13page: 0
	property int cat14page: 0
	property int cat15page: 0
	property int cat16page: 0
	property int cat17page: 0
	property int cat18page: 0
	property int cat19page: 0
	property int cat20page: 0
	property int cat21page: 0
	property int cat22page: 0
	property int cat23page: 0
	property int cat24page: 0
	property int cat25page: 0
	property int cat26page: 0
	property int cat27page: 0
	property int cat28page: 0
	property int cat29page: 0
	property int cat30page: 0
	property int cat31page: 0
	
	function reset() {
		activeToolUid = 0;
		dragTool = null;
		subtoolView.model = [];
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
		
		z: 5
		
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
								
								// reset pages on tool switch. all 32. realistically who will have 32 categories why did i do this
								qTools.cat0page = 0; qTools.cat1page = 0; qTools.cat2page = 0; qTools.cat3page = 0
								qTools.cat4page = 0; qTools.cat5page = 0; qTools.cat6page = 0; qTools.cat7page = 0
								qTools.cat8page = 0; qTools.cat9page = 0; qTools.cat10page = 0; qTools.cat11page = 0
								qTools.cat12page = 0; qTools.cat13page = 0; qTools.cat14page = 0; qTools.cat15page = 0
								qTools.cat16page = 0; qTools.cat17page = 0; qTools.cat18page = 0; qTools.cat19page = 0
								qTools.cat20page = 0; qTools.cat21page = 0; qTools.cat22page = 0; qTools.cat23page = 0
								qTools.cat24page = 0; qTools.cat25page = 0; qTools.cat26page = 0; qTools.cat27page = 0
								qTools.cat28page = 0; qTools.cat29page = 0; qTools.cat30page = 0; qTools.cat31page = 0
								
								
								console.info('TOOL CLICK!', model.title );
								
								eventEmit('open-tool', { uid: model.uid });
								
								
								console.info('SHOW SUBTOOLS!');
								
								subtoolView.model = null;
								subtoolView.model = model.subtools ? model.subtools : [];
								
								
								
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

		visible: qTools.activeToolUid !== 0 && qTools.activeToolUid !== "" && subtoolView.model.count > 0

		width: subtoolsCol.width + 40
		height: subtoolsCol.height + 40
		
		
		anchors.rightMargin: 210 - 100
		anchors.right: parent.right
		
		anchors.top: parent.top
		anchors.topMargin: 10
		
		// anchors.bottomMargin: 10
		
		z: 10
		
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
		
		spacing: 3
		
		// toggles
		Row {
			anchors.horizontalCenter: parent.horizontalCenter
			spacing: 12
			
			Row {
				spacing: 6
				
				Rectangle {
					width: 16
					height: 16
					radius: 3
					color: nameToggleMouse.containsMouse ? '#55FFFFFF' : '#33FFFFFF'
					border.color: '#FFFFFF'
					border.width: 1
					
					Text {
						anchors.centerIn: parent
						text: qTools.showNames ? "✓" : ""
						font.pixelSize: 12
						color: '#FFFFFF'
					}
					
					MouseArea {
						id: nameToggleMouse
						anchors.fill: parent
						hoverEnabled: true
						onClicked: qTools.showNames = !qTools.showNames
					}
				}
				
				Text {
					text: "Names"
					font.pixelSize: 10
					color: '#FFFFFF'
					anchors.verticalCenter: parent.verticalCenter
				}
			}
			
			Row {
				visible: qTools.activeToolUid === 'material'
				spacing: 6
				
				Rectangle {
					width: 16
					height: 16
					radius: 3
					color: idToggleMouse.containsMouse ? '#55FFFFFF' : '#33FFFFFF'
					border.color: '#FFFFFF'
					border.width: 1
					
					Text {
						anchors.centerIn: parent
						text: qTools.showIds ? "✓" : ""
						font.pixelSize: 12
						color: '#FFFFFF'
					}
					
					MouseArea {
						id: idToggleMouse
						anchors.fill: parent
						hoverEnabled: true
						onClicked: qTools.showIds = !qTools.showIds
					}
				}
				
				Text {
					text: "IDs"
					font.pixelSize: 10
					color: '#FFFFFF'
					anchors.verticalCenter: parent.verticalCenter
				}
			}
		}
		
		Item { width: 1; height: 5 }
		
		
		Repeater {
			id: subtoolView
			
			model    : ListModel { }
			
			delegate : Column {
					id: subtoolSection
					// width: 200
					
					// width: parent.width
					
					// height: 20
					
					spacing: 3
					anchors.horizontalCenter: parent.horizontalCenter
					
					property int catIndex: index
					
					// the evil really long switch
					property int currentPage: {
						switch (catIndex) {
							case 0: return qTools.cat0page
							case 1: return qTools.cat1page
							case 2: return qTools.cat2page
							case 3: return qTools.cat3page
							case 4: return qTools.cat4page
							case 5: return qTools.cat5page
							case 6: return qTools.cat6page
							case 7: return qTools.cat7page
							case 8: return qTools.cat8page
							case 9: return qTools.cat9page
							case 10: return qTools.cat10page
							case 11: return qTools.cat11page
							case 12: return qTools.cat12page
							case 13: return qTools.cat13page
							case 14: return qTools.cat14page
							case 15: return qTools.cat15page
							case 16: return qTools.cat16page
							case 17: return qTools.cat17page
							case 18: return qTools.cat18page
							case 19: return qTools.cat19page
							case 20: return qTools.cat20page
							case 21: return qTools.cat21page
							case 22: return qTools.cat22page
							case 23: return qTools.cat23page
							case 24: return qTools.cat24page
							case 25: return qTools.cat25page
							case 26: return qTools.cat26page
							case 27: return qTools.cat27page
							case 28: return qTools.cat28page
							case 29: return qTools.cat29page
							case 30: return qTools.cat30page
							default: return qTools.cat31page
						}
					}
					
					function prevPage() {
						if (currentPage <= 0) return;
						switch (catIndex) {
							case 0: qTools.cat0page--; break
							case 1: qTools.cat1page--; break
							case 2: qTools.cat2page--; break
							case 3: qTools.cat3page--; break
							case 4: qTools.cat4page--; break
							case 5: qTools.cat5page--; break
							case 6: qTools.cat6page--; break
							case 7: qTools.cat7page--; break
							case 8: qTools.cat8page--; break
							case 9: qTools.cat9page--; break
							case 10: qTools.cat10page--; break
							case 11: qTools.cat11page--; break
							case 12: qTools.cat12page--; break
							case 13: qTools.cat13page--; break
							case 14: qTools.cat14page--; break
							case 15: qTools.cat15page--; break
							case 16: qTools.cat16page--; break
							case 17: qTools.cat17page--; break
							case 18: qTools.cat18page--; break
							case 19: qTools.cat19page--; break
							case 20: qTools.cat20page--; break
							case 21: qTools.cat21page--; break
							case 22: qTools.cat22page--; break
							case 23: qTools.cat23page--; break
							case 24: qTools.cat24page--; break
							case 25: qTools.cat25page--; break
							case 26: qTools.cat26page--; break
							case 27: qTools.cat27page--; break
							case 28: qTools.cat28page--; break
							case 29: qTools.cat29page--; break
							case 30: qTools.cat30page--; break
							default: qTools.cat31page--
						}
					}
					
					function nextPage() {
						if (currentPage >= pages - 1) return;
						switch (catIndex) {
							case 0: qTools.cat0page++; break
							case 1: qTools.cat1page++; break
							case 2: qTools.cat2page++; break
							case 3: qTools.cat3page++; break
							case 4: qTools.cat4page++; break
							case 5: qTools.cat5page++; break
							case 6: qTools.cat6page++; break
							case 7: qTools.cat7page++; break
							case 8: qTools.cat8page++; break
							case 9: qTools.cat9page++; break
							case 10: qTools.cat10page++; break
							case 11: qTools.cat11page++; break
							case 12: qTools.cat12page++; break
							case 13: qTools.cat13page++; break
							case 14: qTools.cat14page++; break
							case 15: qTools.cat15page++; break
							case 16: qTools.cat16page++; break
							case 17: qTools.cat17page++; break
							case 18: qTools.cat18page++; break
							case 19: qTools.cat19page++; break
							case 20: qTools.cat20page++; break
							case 21: qTools.cat21page++; break
							case 22: qTools.cat22page++; break
							case 23: qTools.cat23page++; break
							case 24: qTools.cat24page++; break
							case 25: qTools.cat25page++; break
							case 26: qTools.cat26page++; break
							case 27: qTools.cat27page++; break
							case 28: qTools.cat28page++; break
							case 29: qTools.cat29page++; break
							case 30: qTools.cat30page++; break
							default: qTools.cat31page++
						}
					}
					
					property int cols: qTools.activeToolUid == 'material' ? Math.min(8, Math.max(4, subtoolView2.model.count)) : 3
					
					property int itemCount: subtoolView2.model.count
					// do we have an int for this? no? one, how did the user do this, two, they shouldnt all be weirdly linked 
					property int perPage: catIndex > 31 ? itemCount : cols
					property int pages: Math.max(1, Math.ceil(itemCount / perPage))
					
					// shrink when theres a lot
					property bool shrink: itemCount >= 6
					property int iconSize: shrink ? 36 : 48
					property int itemSize: shrink ? 40 : 52
					
					property int maxRows: Math.max(1, Math.ceil(Math.min(itemCount, perPage) / cols))
					
					property int fixedWidth: cols * itemSize + (cols - 1) * 3
					property bool showingLabels: qTools.showNames || qTools.showIds
					
					// figure out tallest label in this category
					property int maxLabelLength: {
						if (!showingLabels) return 0;
						var max = 0;
						for ( let x=0;x<subtoolView2.model.count;x++ ){
							let item = subtoolView2.model.get(x);
							let labelTitle = qTools.showNames ? (item.title.length > 14 ? item.title.substring(0, 14) + "..." : item.title) : "";
							let labelUid = (qTools.showIds && qTools.activeToolUid === 'material' && item.uid !== undefined && item.title !== "clone material") ? item.uid.toString() : "";
							let label = labelTitle && labelUid ? labelTitle + " (" + labelUid + ")" : labelTitle ? labelTitle : labelUid;
							if (label.length > max) max = label.length;
						};
						return max;
					}
					property int textPad: showingLabels ? Math.max(1, Math.ceil(maxLabelLength / 9)) * 10 : 0
					
					property int itemRowHeight: itemSize + 2 + textPad
					property int fixedGridHeight: maxRows * itemRowHeight

					Connections {
						target: model.subtools ? model.subtools : null
						function onCountChanged() {
							sortAndLoadSubtools();
						}
					}
    
					// a bit of space between categories
					Item {
						visible: subtoolSection.catIndex > 0
						width: 1
						height: 5
					}
					
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
			
			if (model.subtools) {
				sortAndLoadSubtools();
			}
		}

		function sortAndLoadSubtools() {
			var withUid = [];
			var noUidIndices = [];
			var noUidItems = [];
			
			for ( let x=0;x<model.subtools.count;x++ ){
				let item = model.subtools.get(x);
				if (item.uid !== undefined) {
					withUid.push(item);
				} else {
					noUidIndices.push(x);
					noUidItems.push(item);
				};
			};
			
			// sort only items that have uid
			withUid.sort(function(a, b) {
				return a.uid - b.uid;
			});
			
			var result = [];
			var uidIndex = 0;
			var noUidIndex = 0;
			
			for ( let x=0;x<model.subtools.count;x++ ){
				if (noUidIndices.indexOf(x) !== -1) {
					result.push(noUidItems[noUidIndex]);
					noUidIndex++;
				} else {
					result.push(withUid[uidIndex]);
					uidIndex++;
				};
			};
			
			subtoolView2.model.clear();
			for ( let x=0;x<result.length;x++ ){
				subtoolView2.model.append(result[x]);
			};
		}
			
		Item {
			width: subtoolSection.fixedWidth
			height: subtoolSection.fixedGridHeight
			anchors.horizontalCenter: parent.horizontalCenter

		Grid {
			//columns: 8
			columns: subtoolSection.cols
			spacing: 3
			
			// anchors.fill: parent
			
			//width: 200
			
			anchors.horizontalCenter: parent.horizontalCenter
			
			Repeater {
				id: subtoolView2
				
				delegate: Item {
					id: itemDelegate
					
					property int pageStart: subtoolSection.currentPage * subtoolSection.perPage
					property int pageEnd: pageStart + subtoolSection.perPage
					property bool shouldShow: index >= pageStart && index < pageEnd
					
					// title + uid with brackets, or just uid without brackets
					property string labelTitle: qTools.showNames ? (model.title.length > 14 ? model.title.substring(0, 14) + "..." : model.title) : ""
					property string labelUid: (qTools.showIds && qTools.activeToolUid === 'material' && model.uid !== undefined && model.title !== "clone material") ? model.uid.toString() : ""
					property string labelText: {
						if (labelTitle && labelUid) return labelTitle + " (" + labelUid + ")";
						if (labelTitle) return labelTitle;
						if (labelUid) return labelUid;
						return "";
					}
					
					visible: shouldShow
					width: subtoolSection.itemSize
					height: shouldShow ? (subtoolSection.itemSize + 2 + subtoolSection.textPad) : 0
					
					//anchors.rightMargin: 0
					//anchors.right: parent.right
					
					Rectangle {
						id: iconRect
						width: subtoolSection.iconSize
						height: subtoolSection.iconSize
						
						anchors.horizontalCenter: parent.horizontalCenter
						anchors.top: parent.top
						
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
									// mr sst, what does this mean?
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
							size: subtoolSection.iconSize / 2
							anchors.centerIn: parent
							color : model.invert ? model.color : qmlStyles.button.color
						}
						
						
					}
					
					Text {
						id : materialLabel
						visible: subtoolSection.showingLabels && itemDelegate.labelText !== ""
						text : itemDelegate.labelText
						
						width: parent.width
						horizontalAlignment: Text.AlignHCenter
						wrapMode: Text.Wrap
						
						anchors.horizontalCenter: parent.horizontalCenter
						anchors.top: iconRect.bottom
						anchors.topMargin: 2
						
						font.pixelSize: 8
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
		
		// spacing above page buttons
		Item {
			visible: subtoolSection.pages > 1
			width: 1
			height: 5
		}

		Row {
			visible: subtoolSection.pages > 1
			spacing: 12
			anchors.horizontalCenter: parent.horizontalCenter
			z: 20
			
			Rectangle {
				width: 36
				height: 26
				radius: 4
				color: pMouseL.containsMouse ? '#55FFFFFF' : '#33FFFFFF'
				border.color: '#FFFFFF'
				border.width: 1
				opacity: subtoolSection.currentPage > 0 ? 1.0 : 0.35
				
				Text {
					anchors.centerIn: parent
					text: "◀"
					font.pixelSize: 14
					color: '#FFFFFF'
				}
				
				MouseArea {
					id: pMouseL
					anchors.fill: parent
					hoverEnabled: true
					onClicked: subtoolSection.prevPage()
				}
			}
			
			Text {
				text: "Page " + (subtoolSection.currentPage + 1) + "/" + subtoolSection.pages
				font.pixelSize: 11
				color: '#FFFFFF'
				anchors.verticalCenter: parent.verticalCenter
			}
			
			Rectangle {
				width: 36
				height: 26
				radius: 4
				color: pMouseR.containsMouse ? '#55FFFFFF' : '#33FFFFFF'
				border.color: '#FFFFFF'
				border.width: 1
				opacity: subtoolSection.currentPage < subtoolSection.pages - 1 ? 1.0 : 0.35
				
				Text {
					anchors.centerIn: parent
					text: "▶"
					font.pixelSize: 14
					color: '#FFFFFF'
				}
				
				MouseArea {
					id: pMouseR
					anchors.fill: parent
					hoverEnabled: true
					onClicked: subtoolSection.nextPage()
				}
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
