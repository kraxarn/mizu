import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

ApplicationWindow {
	id: root
	width: 540
	height: 960
	visible: true
	title: `${AppName}`

	Material.theme: Material.System
	Material.accent: "#1E88E5"

	footer: Footer {
	}

	StackLayout {
		id: content
		currentIndex: footer.currentIndex
		anchors.fill: parent

		Home {
		}

		History {
		}

		Settings {
		}
	}
}
