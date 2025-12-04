import SstComponents
import DevTree
import Tree
import Mode
import QuickFps
Item {
    // color: 'transparent'
    anchors.fill: parent
    
    property int clickNum 	: 0
    property bool isShown 	: false
    
    property bool demo_mode: false
    // активное в настоящий момент окно меню, управляется из menu/qml/MenuPanel.qml 	
    property var menuPanel: null
    
    // slideshow
	Item {
		id: bgSlideshow
		anchors.fill: parent
		z: -1
		visible: menuPanel && menuPanel.visible
		
		property var imageFiles: [
			"iterator by noah.png",
			"massive plant by bigulator.png",
			"old castle town by jade.skal.png"
		]
		
		property var images: []
		property int currentIndex: 0
		property int displayInterval: 10
		property int fadeDuration: 1500
		property int failCount: 0
		property bool initialized: false
		property string lastShownImage: ""
		
		objectName: "bgSlideshow"
		
		function shuffleArray() {
			var arr = images.slice();
			for (var i = arr.length - 1; i > 0; i--) {
				var rand = Math.random();
				var j = Math.floor(rand * (i + 1));
				var temp = arr[i];
				arr[i] = arr[j];
				arr[j] = temp;
			}
			
			if (arr.length > 1 && arr[0] === lastShownImage) {
				var temp = arr[0];
				arr[0] = arr[1];
				arr[1] = temp;
			}
			
			images = arr;
		}
		
		// img 1
		Image {
			id: img1
			anchors.fill: parent
			fillMode: Image.PreserveAspectFit
			opacity: 0
			z: 0
			Behavior on opacity { NumberAnimation { duration: bgSlideshow.fadeDuration; easing.type: Easing.InOutQuad } }
			onStatusChanged: {
				if (status === Image.Error) {
					console.log("slideshow error:", source);
					bgSlideshow.failCount++;
					if (bgSlideshow.failCount >= bgSlideshow.images.length) {
						console.log("slideshow failed: no images loaded");
					}
				}
			}
		}
		
		// img 2
		Image {
			id: img2
			anchors.fill: parent
			fillMode: Image.PreserveAspectFit
			opacity: 0
			z: 1
			Behavior on opacity { NumberAnimation { duration: bgSlideshow.fadeDuration; easing.type: Easing.InOutQuad } }
			onStatusChanged: {
				if (status === Image.Error) {
					console.log("slideshow error:", source);
					bgSlideshow.failCount++;
				}
			}
		}
		
		Timer {
			id: cycleTimer
			interval: bgSlideshow.displayInterval * 1000
			running: bgSlideshow.images.length > 1 && bgSlideshow.visible && bgSlideshow.initialized
			repeat: true
			onTriggered: {
				bgSlideshow.currentIndex++;
				
				if (bgSlideshow.currentIndex >= bgSlideshow.images.length) {
					bgSlideshow.shuffleArray();
					bgSlideshow.currentIndex = 0;
				}
				
				var nextImage = bgSlideshow.images[bgSlideshow.currentIndex];
				bgSlideshow.lastShownImage = nextImage;
				
				if (img1.opacity > 0.5) {
					img2.source = nextImage;
					img2.opacity = 1;
					img1.opacity = 0;
				} else {
					img1.source = nextImage;
					img1.opacity = 1;
					img2.opacity = 0;
				}
			}
		}
		
		Component.onCompleted: {
			if (initialized) {
				return;
			}
			
			var basePath = Qt.resolvedUrl('../../../slideshow/');
			
			var tempImages = imageFiles.map(function(img) {
				if (img.indexOf('file:///') === 0 || img.indexOf('http') === 0) {
					return img;
				}
				return basePath + img;
			});
			
			console.log("Mapped images:", JSON.stringify(tempImages));
			
			if (tempImages.length === 0) {
				console.log("slideshow failed: no images in list");
				return;
			}
			
			images = tempImages;
			shuffleArray();
			
			img1.source = images[0];
			img1.opacity = 1;
			lastShownImage = images[0];
			
			initialized = true;
		}
	}
    
    // накопительное состояние GUI. К нему можно цеплять конкретные создаваемые блоки
    // и обращаться к его property через someRoot.state[ident]
    property var state: ({})
    objectName: "some-name"
    id 	 	: someRoot
    
    Alert {} // Dialog handler
    // IconAwesomeHelper {}
    
    // TuiFlex {
    // 	width: 200
    // 	height: 300
    // 	colors: "secondary"
    // 	padding: "15"
    	
    // 	QtObject { objectName: 'ttt' }
    	
    // 	TuiText {
    // 		text: "Regular"
    // 		colors: "primarytext"
    // 		kind: "regular"
    // 		shadow: "sm"
    // 	}
    // 	TuiText {
    // 		text: "Semi"
    // 		colors: "warningtext"
    // 		kind: "semi"
    // 		shadow: "md"
    // 	}
    // 	TuiText {
    // 		text: "Bold"
    // 		colors: "errortext"
    // 		kind: "bold"
    // 		shadow: "none"
    // 	}
    	
    // 	TuiFlex {
    // 		direction: "row"
    // 		colors: "primary"
    		
    // 		TuiIcon {
    // 			colors: "error"
    // 			name: "fa_sun_o"
    // 		}
    		
    // 		TuiIcon {
    // 			colors: "warningtext"
    // 			name: "fa_star"
    // 		}
    // 	}
    // }
    
    QuickFps {
        objectName: "quick-fps"
        
        fps: 0
        
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 15
    }
    
    function updateSettings(key, value) {
        SstSettings[key] = value;
    }
    function uploadSettings(settings) {
        SstSettings.upload(settings);
    }
    
    Styles {
        id: qmlStyles
    }
    ////////////////////
    
    property var recalls: ({});
    
    function globalset( data ) {
        demo_mode = data.demo_mode;
    }
    
    function recall(data) {
        recalls[ data.i ][ data.method ]( data.data );
    }
    
    
    
    function load( data ) {
        // for (let i = 0; i < moduleList.count; i++) {
        // 	const item = moduleList.get(i);
        // 	if (item.source === data.source) {
        // 		console.log('found', item.source);
        // 		return;
        // 	}
        // }
        moduleList.append( data );
    }
    /*
        Keys.onPressed: {
            console.info('KEY');
            if (event.key == Qt.Key_Enter) {
                state = 'ShowDetails';
                
            };
        }
    */
    
    
    
    DragPanel {
        id: treeDrag
        linkedBlock: guiTree
        anchors.top: fl_showDevTree.bottom
        anchors.topMargin: 0
        anchors.leftMargin: 0
        
        visible: false
        
        Tree {
            id: guiTree
            anchors.left: treeDrag.dragRect.left
            anchors.top: treeDrag.dragRect.bottom
            // anchors.top: fl_showDevTree ? fl_showDevTree.bottom : parent.top
            objectName: 'dynamic-tree'
        }
    } 	
    
    Repeater {
        delegate: Loader {
            
            id 	 	: moduleLoader
            onLoaded: {
                // console.info( 'RECALL REG', model.i, model.source);
                
                recalls[ model.i ] = moduleLoader.item;
                //console.log (model.i, recalls[model.i]);
                // прокидываем parent, чтобы у динамических модулей также работали anchors
                
                moduleLoader.item.parent = someRoot;
            }
            
            source: model.source
        }
        
        model: ListModel {
            id: moduleList
        }
    }
    
    ////////////////////
    
    /*
    Rectangle {
        id 	 	: 'qMenu2'
        objectName: 'qMenu2'
        
        color: '#AA333333'
        
        // anchors.right: parent.right
        // anchors.rightMargin: 250
        
        // anchors.rightMargin: 0
        // anchors.right: parent.right
        
        // anchors.fill: parent
        anchors.centerIn: parent
        
        width: 	100
        height: 100
        
        
        Text {
            text : 'Space Simulation Toolkit'
            
            font.pixelSize : 50
            color : "#FFFFFFFF"
            styleColor : "black"
        }
    }
    */
    
    
    
    Mode {
        objectName: 'dynamic-mode'
        function reset(data) {
            console.log ('do reset mode', data)
            activeMode = null
        }
    }
    
    
    DragPanel {
        visible: false
        id: devTreeDrag
        linkedBlock: guiDevTree
        
        anchors.left: fl_showDevTree.right
        anchors.top: fl_showDevTree.top
        DevTree {
            id: guiDevTree
            anchors.left: devTreeDrag.dragRect.left
            anchors.top: devTreeDrag.dragRect.bottom
            objectName: 'dynamic-devtree'
        }
    }
    
    CheckBox {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.leftMargin: 10
        
        id: fl_showDevTree
        // text: qsTr("show memory")
        checked: false
        
        visible: false
        
    }
    
    
}
