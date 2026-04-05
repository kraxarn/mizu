include(FetchContent)

FetchContent_Declare(font-awesome
	GIT_REPOSITORY https://github.com/FortAwesome/Font-Awesome.git
	GIT_TAG 7.2.0
)

message(STATUS "Downloading font-awesome")
FetchContent_MakeAvailable(font-awesome)
