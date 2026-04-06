import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

TabBar {
	id: tabs
	width: parent.width
	bottomPadding: root.SafeArea.margins.bottom

	TabButton {
		text: "Today"
		icon.source: `qrc:/fa/${tabs.currentIndex === 0 ? "solid" : "regular"}/house.svg`
		display: AbstractButton.TextUnderIcon
	}

	TabButton {
		text: "History"
		icon.source: `qrc:/fa/${tabs.currentIndex === 1 ? "solid" : "regular"}/calendar.svg`
		display: AbstractButton.TextUnderIcon
	}

	TabButton {
		text: "Settings"
		icon.source: `qrc:/fa/${tabs.currentIndex === 2 ? "solid" : "regular"}/rectangle-list.svg`
		display: AbstractButton.TextUnderIcon
	}
}
