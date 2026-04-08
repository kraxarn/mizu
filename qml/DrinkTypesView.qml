import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import Database
import Models.DrinkType

Item {
	Database {
		id: db
	}

	ListView {
		anchors.fill: parent
		model: DrinkTypeModel {
		}
		delegate: ItemDelegate {
			required property int rowId
			required property string iconName
			required property string name
			required property real impact

			width: parent.width
			text: name
		}
	}

	RoundButton {
		padding: 25
		anchors {
			bottom: parent.bottom
			bottomMargin: 20
			right: parent.right
			rightMargin: 20
		}
		icon {
			source: "qrc:/fa/solid/add.svg"
		}
		onClicked: db.insertDrinkType()
	}
}
