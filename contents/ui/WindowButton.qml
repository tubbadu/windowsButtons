import QtQuick 2.15
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.3
import QtQuick.Window 2.2
import org.kde.taskmanager 0.1 as TaskManager // docs at https://api.kde.org/plasma/plasma-workspace/html/classTaskManager_1_1TasksModel.html


ToolButton{
	id: windowbutton
	property string actionName: "Close"
	property string iconName: "window-close"

	enum WindowTypes {Close, Minimize, Maximize, PinToAllDesktops, AlwaysAnTop}

	icon.name: iconName.length > 1 ? iconName : getIcon()

	function getIcon(){
		let actions = {
			"Close": "window-close",
			"Minimize": "window-minimize",
			"Maximize": "window-maximize",
			"KeepAbove": "window-keep-above",
			"KeepBelow": "window-keep-below",
			"PinToAllDesktops": "window-pin"
		}

		return actions[actionName]
	}

	TaskManager.TasksModel {
        id: tasksModel
    }

	onClicked:{
		/*switch(windowbutton.actionName){
			case "close":
				tasksModel.requestClose(tasksModel.activeTask);
				break
			case "minimize":
				tasksModel.requestToggleMinimized(tasksModel.activeTask);
				break
		}*/

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
