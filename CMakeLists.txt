cmake_minimum_required(VERSION 3.20)

project(ChessEngine VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_AUTORCC ON)

option(CHESS_ENGINE_BUILD_TESTS "Build test targets" ON)
option(MAGNUSCHESS_BUILD_UI "Build Qt/QML UI" ON)

add_library(chess_engine INTERFACE)
target_include_directories(chess_engine INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/include)

if(MAGNUSCHESS_BUILD_UI)
    find_package(Qt6 QUIET COMPONENTS Core Quick Qml)
endif()

if(MAGNUSCHESS_BUILD_UI AND Qt6_FOUND)
    add_executable(chess_engine_app
        src/main.cpp
        src/ui/qml/qml.qrc
    )

    target_link_libraries(chess_engine_app PRIVATE
        chess_engine
        Qt6::Core
        Qt6::Quick
        Qt6::Qml
    )
else()
    add_executable(chess_engine_app src/main_console.cpp)
    target_link_libraries(chess_engine_app PRIVATE chess_engine)
endif()

set_target_properties(chess_engine_app PROPERTIES OUTPUT_NAME "MagnusChess")

if(CHESS_ENGINE_BUILD_TESTS)
    enable_testing()
    add_subdirectory(tests)
endif()
