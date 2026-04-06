import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import Settings

Item {
	readonly property int padding: 20

	Settings {
		id: settings
	}

	TextField {
		id: amount
		placeholderText: "Daily goal"
		text: settings.dailyGoal
		validator: IntValidator {
			bottom: 0
			top: 5000
		}
		anchors {
			top: parent.top
			topMargin: parent.padding
			left: parent.left
			leftMargin: parent.padding
			right: unit.left
			rightMargin: 10
		}
		onEditingFinished: {
			settings.dailyGoal = text
		}
	}

	Label {
		id: unit
		text: "ml"
		verticalAlignment: Text.AlignVCenter
		anchors {
			top: amount.top
			bottom: amount.bottom
			right: parent.right
			rightMargin: parent.padding
		}
	}
}
