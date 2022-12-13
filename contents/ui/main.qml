import QtQuick.Layouts 1.0
import QtQuick 2.0
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
	id: root
	Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation
	property string buttontype: Plasmoid.configuration.buttontype
	property string customIcon: Plasmoid.configuration.customIcon

	WindowButton{
		actionName: buttontype
		iconName: customIcon
		anchors.fill: parent
	}
}
