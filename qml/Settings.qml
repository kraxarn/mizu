import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

ColumnLayout {
	ToolBar {
		id: toolBar
		Layout.fillWidth: true

		background: Item {
			implicitHeight: 50
		}

		ToolButton {
			id: back
			padding: parent.height * 0.3
			visible: settings.depth > 1
			width: settings.depth > 1 ? undefined : 16
			onClicked: settings.pop()
			anchors {
				left: parent.left
				top: parent.top
				bottom: parent.bottom
			}
			icon {
				source: "qrc:/fa/solid/chevron-left.svg"
				width: parent.height
				height: parent.height
			}
		}

		Label {
			text: "Settings"
			verticalAlignment: Text.AlignVCenter
			anchors {
				top: parent.top
				bottom: parent.bottom
				left: back.right
			}
			font {
				pixelSize: 22
			}
		}
	}

	StackView {
		id: settings
		initialItem: main
		clip: true

		Layout.fillHeight: true
		Layout.fillWidth: true

		Component {
			id: main

			ListView {
				model: ListModel {
					ListElement {
						title: "Daily goal"
						iconName: "calendar-day"
						item: () => dailyGoal
					}
					ListElement {
						title: "Drink types"
						iconName: "bottle-droplet"
						item: () => drinkTypes
					}
					ListElement {
						title: "Presets"
						iconName: "list"
						item: () => presets
					}
				}

				delegate: ItemDelegate {
					required property string title
					required property string iconName
					required property var item

					width: parent && parent.width

					onClicked: settings.push(item())

					Icon {
						id: icon
						anchors {
							left: parent.left
						}
						source: `qrc:/fa/solid/${iconName}.svg`
						size: parent.height
					}

					Label {
						anchors {
							left: icon.right
							top: parent.top
							bottom: parent.bottom
						}
						verticalAlignment: Text.AlignVCenter
						text: parent.title
					}

					Icon {
						anchors {
							right: parent.right
						}
						source: "qrc:/fa/solid/chevron-right.svg"
						size: parent.height
					}
				}
			}
		}

		Component {
			id: dailyGoal
			DailyGoal {
			}
		}

		Component {
			id: drinkTypes
			DrinkTypes {
			}
		}

		Component {
			id: presets
			Presets {
			}
		}
	}
}
