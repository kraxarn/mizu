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

	Dialog {
		id: iconDialog
		title: "Icon"
		modal: true
		standardButtons: Dialog.Cancel
		width: parent.width * 0.75
		height: parent.height * 0.5
		x: (parent.width - width) / 2
		y: (parent.height / 2) - (height / 2)

		ListView {
			anchors.fill: parent
			model: ["bottle-water", "glass-water", "jar", "mug-hot", "mug-saucer", "whiskey-glass", "wine-glass"]
			delegate: ItemDelegate {
				width: parent.width
				text: modelData
				icon.source: `qrc:/fa/solid/${modelData}.svg`
			}
		}
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
				onClicked: iconDialog.open()
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
