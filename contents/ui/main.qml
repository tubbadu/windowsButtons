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

	Plasmoid.compactRepresentation: WindowButton{
		actionName: buttontype
		iconName: customIcon
		anchors.fill: parent
	}

	Plasmoid.fullRepresentation: ColumnLayout{
		ToolButton{
			icon.name: "system-suspend"
			text: i18n("Suspend")
			onClicked: {
				executable.exec("systemctl suspend")
			}
		}
		ToolButton{
			icon.name: "system-reboot"
			text: i18n("Reboot")
			onClicked: {
				executable.exec("systemctl reboot")
			}
		}
		ToolButton{
			icon.name: "system-shutdown"
			text: i18n("Shutdown")
			onClicked: {
				executable.exec("systemctl poweroff")
			}
		}
		/*Image{
			height: 50
			width: 50
			source: "prova.png"
		}*/
		Image{
			id: img
			height: 50
			width: 50
			fillMode: Image.PreserveAspectFit
			source: icon.url()
			
		}
	}
}
