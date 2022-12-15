import QtQuick.Layouts 1.14
import QtQuick.Controls 2.14
import QtQuick 2.0
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import QtPositioning 5.5
import QtLocation 5.6

Item {
	id: root
	Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
	property string buttontype: Plasmoid.configuration.buttontype
	property string customIcon: Plasmoid.configuration.customIcon

	PlasmaCore.DataSource {
        id: executable
        engine: "executable"
        connectedSources: []
        onNewData: disconnectSource(sourceName)

        function exec(cmd) {
            executable.connectSource(cmd)
        }
    }

	Plasmoid.compactRepresentation: Item{
		WindowButton{
			id: windowbutton
			actionName: buttontype
			iconName: customIcon
			width: parent.width
			height: width
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