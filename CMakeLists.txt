cmake_minimum_required(VERSION 3.20)

project(ChessEngine VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

option(CHESS_ENGINE_BUILD_TESTS "Build test targets" ON)

add_library(chess_engine INTERFACE)
target_include_directories(chess_engine INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/include)

add_executable(chess_engine_app src/main.cpp)
target_link_libraries(chess_engine_app PRIVATE chess_engine)
set_target_properties(chess_engine_app PROPERTIES OUTPUT_NAME "MagnusChess")

if(CHESS_ENGINE_BUILD_TESTS)
    enable_testing()
    add_subdirectory(tests)
endif()
