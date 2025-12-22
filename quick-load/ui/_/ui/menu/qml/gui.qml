import SstComponents


MenuPanel {
	id: qMenu

	title.text: 'Space Simulation Toolkit'

	property var quickLoadFiles: null
	
	function quickLoad() {
		quickLoadFiles = null;
		eventEmit('files-list', { name: 'qMenu', method: 'quickLoadFilesList' });
	}
	
	function quickLoadFilesList(files) {
		if (files.length === 0) {
			return;
		}
		
		var latest = files[0];
		for (var i = 1; i < files.length; i++) {
			if (files[i].meta && files[i].meta.timestamp > latest.meta.timestamp) {
				latest = files[i];
			}
		}
		
		eventEmit('files-load', latest.raw);
	}

	menuElements: ListModel {
		/*
		ListElement {
			title: 'GENERATE'
			action: 'new'
			sub_menu: 'qMenuGenerate'
		}
		*/
		
		
		ListElement {
			title: 'NEW GAME'
			action: 'new'
			sub_menu: 'qMenuGame'
		}
		ListElement {
			title: 'LOAD GAME'
			action: 'load'
			sub_menu: 'qMenuLoad'
		}
		ListElement {
			title: 'QUICK LOAD'
			action: 'quickLoad'
		}
		ListElement {
			title: 'SAVE GAME'
			sub_menu: 'qMenuSave'
		}
		// ListElement {
		// 	title: 'TUTORIAL'
		// 	action: 'tutorial'
		// }
		ListElement {
			title: 'HELP'
			sub_menu: 'qMenuHelp'
			
			
		}
		ListElement {
			title: 'CHANGELOG'
			sub_menu: 'qMenuChangelog'
		}
		ListElement {
			title: 'SETTINGS'
			action: 'settings'
			sub_menu: 'qMenuSettings'
		}
		ListElement {
			title: 'EXIT'
			action: 'exit'
			callback: '.exit'
		}

	}

	Component.onCompleted: qMenu.show()

}