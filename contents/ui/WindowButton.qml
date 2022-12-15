import QtQuick 2.15
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.3
import QtQuick.Window 2.2
import org.kde.taskmanager 0.1 as TaskManager // docs at https://api.kde.org/plasma/plasma-workspace/html/classTaskManager_1_1TasksModel.html
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item{
	id: windowbutton
	property string actionName: "Close"
	property string iconName: "window-close"
	property alias icon: mybutton.icon
	
	TaskManager.TasksModel {
		id: tasksModel
	}

	MyButton{
		id: mybutton
		anchors.fill: parent
		icon.name: iconName.length > 1 ? iconName : getIcon()
		//isUrl: i.includes(".") || i.includes("/")
		
		visible: tasksModel.activeTask.valid

		function getIcon(){
			let actions = {
				"Close": "window-close",//"../img/window-close-true.svg",
				"Minimize": "window-minimize",
				"Maximize": "window-maximize",
				"KeepAbove": "window-keep-above",
				"KeepBelow": "window-keep-below",
				"PinToAllDesktops": "window-pin"
			}

			return actions[actionName]
		}

		onClicked: function() {
			let actions = {
				"Close": tasksModel.requestClose,
				"Minimize": tasksModel.requestToggleMinimized,
				"Maximize": tasksModel.requestToggleMaximized,
				"KeepAbove": tasksModel.requestToggleKeepAbove,
				"KeepBelow": tasksModel.requestToggleKeepBelow
				//"PinToAllDesktops": "window-pin"
			}
			actions[windowbutton.actionName](tasksModel.activeTask)
		}
	}

	MyButton{
		icon.name: "system-shutdown"
		anchors.fill: parent
		visible: !tasksModel.activeTask.valid
		onClicked: function() {
			plasmoid.expanded = !plasmoid.expanded
		}
	}
}