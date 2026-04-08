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

			Button {
				id: icon
				anchors {
					left: parent.left
				}
				flat: true
				icon.source: `qrc:/fa/solid/${parent.iconName}.svg`
			}

			Label {
				id: name
				anchors {
					left: icon.right
					top: parent.top
					bottom: parent.bottom
				}
				verticalAlignment: Text.AlignVCenter
				text: `${parent.rowId}: ${parent.name}`
			}

			Button {
				id: impact
				anchors {
					right: remove.left
				}
				flat: true
				text: `${parent.impact}x`
			}

			Button {
				id: remove
				anchors {
					right: parent.right
				}
				flat: true
				icon.source: "qrc:/fa/solid/trash.svg"
				onClicked: db.deleteDrinkType(parent.rowId)
			}
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
