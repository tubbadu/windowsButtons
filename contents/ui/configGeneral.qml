import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import org.kde.kirigami 2.4 as Kirigami
import org.kde.plasma.components 2.0 as PlasmaComponents

Kirigami.FormLayout {
	id: page

	property alias cfg_buttontype: buttontype.value //get(buttonType.currentIndex).text
	property alias cfg_buttontypeindex: buttontype.currentIndex
	property alias cfg_customIcon: customIcon.text

	PlasmaComponents.ComboBox{
		id: buttontype
		readonly property string value: buttontype.model[buttontype.currentIndex].value
		property var actions: {
			"Close": i18n("close"),
			"Minimize": i18n("minimize"),
			"Maximize": i18n("maximize"),
			"KeepAbove": i18n("keep above"),
			"KeepBelow": i18n("keep below"),
			"PinToAllDesktops": i18n("pin to all desktops")
		}

		model: [
			{ value: "Close", text: buttontype.actions["Close"] },
			{ value: "Minimize", text: buttontype.actions["Minimize"] },
			{ value: "Maximize", text: buttontype.actions["Maximize"] },
			{ value: "KeepAbove", text: buttontype.actions["KeepAbove"] },
			{ value: "KeepBelow", text: buttontype.actions["KeepBelow"] },
		]
		Kirigami.FormData.label: i18n("Button action")
	}
	TextField {
		id: customIcon
		Kirigami.FormData.label: i18n("Custom icon name or full path (leave empty for default)")
	}
}
