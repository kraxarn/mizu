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

		property int rowId: 0

		ListView {
			anchors.fill: parent
			model: ["bottle-water", "glass-water", "jar", "mug-hot", "mug-saucer", "whiskey-glass", "wine-glass"]
			delegate: ItemDelegate {
				width: parent.width
				text: modelData
				icon.source: `qrc:/fa/solid/${modelData}.svg`
				onClicked: {
					db.setDrinkTypeIcon(iconDialog.rowId, modelData)
					iconDialog.accept()
				}
			}
		}
	}

	Dialog {
		id: nameDialog
		title: "Name"
		modal: true
		standardButtons: Dialog.Ok | Dialog.Cancel
		width: parent.width * 0.75
		height: 180
		x: (parent.width - width) / 2
		y: (parent.height / 2) - (height / 2)
		onAccepted: {
			db.setDrinkTypeName(nameDialog.rowId, name.text)
		}

		property int rowId: 0
		property alias name: name.text

		TextField {
			id: name
			width: parent.width
		}
	}

	Dialog {
		id: impactDialog
		title: "Impact"
		modal: true
		standardButtons: Dialog.Ok | Dialog.Cancel
		width: parent.width * 0.75
		height: 180
		x: (parent.width - width) / 2
		y: (parent.height / 2) - (height / 2)
		onAccepted: {
			db.setDrinkTypeImpact(
				impactDialog.rowId,
				parseFloat(impact.text.replace(",", "."))
			)
		}

		property int rowId: 0
		property alias impact: impact.text

		TextField {
			id: impact
			anchors {
				left: parent.left
				right: unit.left
				rightMargin: 5
			}
			validator: DoubleValidator {
				bottom: 0
				top: 2
				decimals: 2
			}
		}

		Label {
			id: unit
			anchors {
				right: parent.right
				bottom: impact.bottom
				top: impact.top
			}
			verticalAlignment: Text.AlignVCenter
			text: "x"
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

			id: delegate
			width: parent.width

			onClicked: {
				nameDialog.rowId = delegate.rowId
				nameDialog.name = delegate.name
				nameDialog.open()
			}

			Button {
				id: icon
				anchors {
					left: parent.left
				}
				flat: true
				icon.source: `qrc:/fa/solid/${parent.iconName}.svg`
				onClicked: {
					iconDialog.rowId = parent.rowId
					iconDialog.open()
				}
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
				onClicked: {
					impactDialog.rowId = delegate.rowId
					impactDialog.impact = delegate.impact
					impactDialog.open()
				}
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
