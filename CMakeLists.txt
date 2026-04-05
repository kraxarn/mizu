cmake_minimum_required(VERSION 3.16)

project(mizu-app
	VERSION 0.1
	LANGUAGES CXX
)

set(APP_NAME "mizu")

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS
	Core
	Quick
	QuickControls2
)

qt_standard_project_setup(REQUIRES 6.10)

qt_add_executable(${APP_NAME})

add_subdirectory(src)

include(deps/font-awesome.cmake)

include(qml.cmake)

target_include_directories(${APP_NAME} PRIVATE
	"${CMAKE_CURRENT_SOURCE_DIR}/src"
)

target_compile_definitions(${APP_NAME} PRIVATE
	# App info
	APP_NAME="${APP_NAME}"
	APP_VERSION="v${PROJECT_VERSION}"
	ORG_NAME="kraxarn"
	ORG_DOMAIN="kraxarn.com"
	# Qt config
	QT_NO_CAST_FROM_ASCII
	QT_NO_CAST_TO_ASCII
)

if (CMAKE_BUILD_TYPE STREQUAL "Debug")
	target_compile_definitions(${APP_NAME} PRIVATE QT_QML_DEBUG)
endif ()

set_target_properties(${APP_NAME} PROPERTIES
	# macOS
	MACOSX_BUNDLE TRUE
	MACOSX_BUNDLE_GUI_IDENTIFIER "com.kraxarn.${PROJECT_NAME}"
	MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
	MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
	MACOSX_BUNDLE_ICON_FILE "mizu.icns"
	# Android
	QT_ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/res/android"
	QT_ANDROID_VERSION_NAME "${PROJECT_VERSION}"
	QT_ANDROID_PACKAGE_NAME "com.kraxarn.mizu"
	QT_ANDROID_APP_NAME "Mizu"
	QT_ANDROID_APP_ICON "@mipmap/ic_launcher"
	# Windows
	WIN32_EXECUTABLE TRUE
)

# Disable exceptions
if (MSVC)
	set_target_properties(${APP_NAME} PROPERTIES
		COMPILE_FLAGS "/EHsc"
	)
else ()
	set_target_properties(${APP_NAME} PROPERTIES
		COMPILE_FLAGS "-fno-exceptions"
	)
endif ()

target_link_libraries(${APP_NAME} PRIVATE
	Qt6::Core
	Qt6::Quick
	Qt6::QuickControls2
)

include(GNUInstallDirs)
install(TARGETS ${APP_NAME}
	BUNDLE DESTINATION .
	LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
	RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

if (UNIX)
	install(FILES res/mizu.svg DESTINATION share/icons/hicolor/scalable/apps)
	install(FILES res/mizu.desktop DESTINATION share/applications)
endif ()
