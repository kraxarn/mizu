import QtQuick
import QtQuick.Controls

Item {
	property url source
	property int size

	width: size
	height: size

	AbstractButton {
		anchors.fill: parent
		z: 1
	}

	Button {
		anchors.fill: parent
		flat: true
		checkable: false
		padding: 0
		icon {
			source: parent.source
			width: parent.size
			height: parent.size
		}
	}
}
