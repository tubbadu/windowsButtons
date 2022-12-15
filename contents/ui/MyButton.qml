import QtQuick 2.15
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.3

RowLayout{
	id: mybutton
	property alias text: label.text
	property alias icon: img.source
	property bool isUrl: false
	Rectangle{
		height: parent.height
		width: height
		radius: height
		Image{
			id: img
			anchors.fill: parent
			fillMode: Image.PreserveAspectFit
			Icon{
				id: icon
				name: "plasma"
			}
			source: icon.url
		}
	}
	Label{
		id: label
		text: "ciao"
	}
}