import QtQuick.Layouts 1.14
import QtQuick.Controls 2.14
import QtQuick 2.0
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import QtPositioning 5.5
import QtLocation 5.6
import org.kde.taskmanager 0.1 as TaskManager // docs at https://api.kde.org/plasma/plasma-workspace/html/classTaskManager_1_1TasksModel.html


Item {
	id: root
	Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
	property string buttontype: Plasmoid.configuration.buttontype
	property string customIcon: Plasmoid.configuration.customIcon

	function executeAction(){
		let actions = {
			"Close": tasksModel.requestClose,
			"Minimize": tasksModel.requestToggleMinimized,
			"Maximize": tasksModel.requestToggleMaximized,
			"KeepAbove": tasksModel.requestToggleKeepAbove,
			"KeepBelow": tasksModel.requestToggleKeepBelow
			//"PinToAllDesktops": "window-pin"
		}
		actions[root.buttontype](tasksModel.activeTask)
	}

	function getIcon(){
		if(customIcon.length > 0){
			return customIcon
		}
		
		let icons = {
			"Close": "../img/window-close.svg",
			"Minimize": "window-minimize",
			"Maximize": "window-maximize",
			"KeepAbove": "window-keep-above",
			"KeepBelow": "window-keep-below",
			"PinToAllDesktops": "window-pin"
		}

		return icons[root.buttontype]
	}

	PlasmaCore.DataSource {
        id: executable
        engine: "executable"
        connectedSources: []
        onNewData: disconnectSource(sourceName)

        function exec(cmd) {
            executable.connectSource(cmd)
        }
    }

	TaskManager.TasksModel {
		id: tasksModel
	}

	/*Plasmoid.compactRepresentation: WindowButton{
		id: windowbutton
		actionName: buttontype
		iconName: customIcon
		anchors.fill: parent
	}*/

	Plasmoid.compactRepresentation: PlasmaCore.IconItem {
		property string icon: tasksModel.activeTask.valid? root.getIcon() : "system-shutdown"
		anchors.fill: parent
		source: icon
		Image{
			anchors.fill: parent
			source: icon
			fillMode: Image.PreserveAspectFit
		}
		MouseArea{
			anchors.fill: parent
			onClicked: {
				if(tasksModel.activeTask.valid){
					// do action
					root.executeAction()
				} else {
					//toggle plasmoid expanded
					plasmoid.expanded = !plasmoid.expanded
				}
			}
		}
	}

	Plasmoid.fullRepresentation: ColumnLayout{
		MyButton{
			icon.name: "system-suspend"
			text: i18n("Suspend")
			Layout.fillWidth: true
			Layout.preferredHeight: 30
			onClicked: function() {executable.exec("systemctl suspend")}
		}
		MyButton{
			icon.name: "system-reboot"
			text: i18n("Reboot")
			Layout.fillWidth: true
			Layout.preferredHeight: 30
			onClicked: function() {executable.exec("systemctl reboot")}
		}
		MyButton{
			icon.name: "system-shutdown"
			text: i18n("Shutdown")
			Layout.fillWidth: true
			Layout.preferredHeight: 30
			onClicked: function() {executable.exec("systemctl poweroff")}
		}
	}
}