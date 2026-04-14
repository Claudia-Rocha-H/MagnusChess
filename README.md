# Magnus Chess

Magnus Chess is a modular chess engine project built with modern C++ and a Qt/QML user interface.

## Project Structure

- docs/: architecture and project documentation.
- include/: shared public headers.
- scripts/: local automation scripts.
- src/: source code.
- src/board/: board-state domain module.
- src/movegen/: move generation module.
- src/search/: search algorithms.
- src/evaluation/: evaluation logic.
- src/engine/: engine orchestration.
- src/ui/qml/: Qt/QML user interface.
- tests/: test targets and future unit tests.

## Tech Stack

- C++20
- CMake 3.20+
- Qt 6 (Core, Qml, Quick)
- QML for UI layout and rendering

## Development Principles

- Single responsibility per module.
- Loose coupling and clear interfaces.
- No hidden global state.
- Performance-aware implementation choices.
- Test-first or test-alongside development for core logic.

## Prerequisites (Windows)

1. Visual Studio Build Tools with C++ workload.
2. Qt installed in C:/Qt with an MSVC kit, for example C:/Qt/6.11.0/msvc2022_64.
3. CMake available in PATH.

## Quick Start (Recommended)

Run this command from the project root:

powershell -ExecutionPolicy Bypass -File .\scripts\run-app.ps1

What this script does:

1. Loads the Visual Studio developer shell.
2. Configures the project with MAGNUSCHESS_BUILD_UI=ON.
3. Builds the executable.
4. Deploys required Qt runtime files.
5. Launches the app.

## Manual Run (Alternative)

1. Configure:

cmake -S . -B build -DMAGNUSCHESS_BUILD_UI=ON -DCMAKE_PREFIX_PATH="C:/Qt/6.11.0/msvc2022_64"

2. Build:

cmake --build build

3. Run:

.\build\MagnusChess.exe

## How To Verify Board Rendering

After launching the app:

1. The board shell appears immediately.
2. The 64-square board renders before piece placement.
3. Initial pieces appear from the mock FEN state.
4. Press New Game to repeat reset and initial load.

## Troubleshooting

- If the app exits immediately, use the run script instead of launching the exe directly.
- If CMake cannot find Qt, verify CMAKE_PREFIX_PATH points to the correct Qt MSVC kit.
- If compilation fails with missing standard headers, ensure build commands run from Visual Studio developer environment.

