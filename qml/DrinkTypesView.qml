import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import Database

Item {
	Database {
		id: db
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
