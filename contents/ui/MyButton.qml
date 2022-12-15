import QtQuick 2.15
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.3
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras

Item{
	id: mybutton
	property alias text: label.text
	property alias icon: iconItem
	//property bool isUrl: false //(icon.includes(".") || icon.includes("/"))
	property var onClicked: function() {
		//mybutton.visible = false
	}

	height: 30
	width: height + 2* row.spacing + label.width 
	Row{
		id: row
		anchors.fill: parent

		Icon{
			id: iconItem
			size: parent.height
		}

		PlasmaComponents.Label {
			id: label
			text: ""
		}
	}
	MouseArea{
		anchors.fill: mybutton
		onClicked: {
			mybutton.onClicked()
		}
	}
}
