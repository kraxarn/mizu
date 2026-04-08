# QML files are in qml/
if (QT_KNOWN_POLICY_QTP0004)
	qt_policy(SET QTP0004 NEW)
endif ()

qt_add_qml_module(${APP_NAME}
	URI "kraxarn.${APP_NAME}"
	VERSION "${PROJECT_VERSION}"
	NO_RESOURCE_TARGET_PATH

	QML_FILES
	qml/DailyGoalView.qml
	qml/DrinkTypesView.qml
	qml/Footer.qml
	qml/HistoryPage.qml
	qml/HomePage.qml
	qml/Icon.qml
	qml/Main.qml
	qml/PresetsView.qml
	qml/SettingsPage.qml

	RESOURCES
	sql/drink_types_create.sql
	sql/drink_types_insert.sql
	sql/presets_create.sql
)

set(FA_DIR "${font-awesome_SOURCE_DIR}/svgs")
file(RELATIVE_PATH FA_DIR "${CMAKE_CURRENT_SOURCE_DIR}" "${FA_DIR}")

qt_add_resources(${APP_NAME} MDI
	BASE "${FA_DIR}"
	PREFIX "fa"
	FILES
	"${FA_DIR}/regular/calendar.svg"
	"${FA_DIR}/regular/house.svg"
	"${FA_DIR}/regular/rectangle-list.svg"
	"${FA_DIR}/solid/add.svg"
	"${FA_DIR}/solid/bottle-droplet.svg"
	"${FA_DIR}/solid/calendar-day.svg"
	"${FA_DIR}/solid/calendar.svg"
	"${FA_DIR}/solid/chevron-left.svg"
	"${FA_DIR}/solid/chevron-right.svg"
	"${FA_DIR}/solid/house.svg"
	"${FA_DIR}/solid/list.svg"
	"${FA_DIR}/solid/rectangle-list.svg"
	"${FA_DIR}/solid/trash.svg"
)
