import QtQuick 2.15
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.3
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras



Item{
	id: icon
	property string name
	property string source
	property int size: 10
	height: size
	width: size
	PlasmaCore.IconItem{
		anchors.fill: parent
		source: icon.name
		//visible: name != undefined && source == undefined
		usesPlasmaTheme: true
	}
	Image{
		anchors.fill: parent
		source: icon.source
		//visible: source != undefined
		fillMode: Image.PreserveAspectFit 
	}
}