# Copilot Instructions – MagnusChess Engine

This repository contains a modular chess engine written in **modern C++ (C++20)** with a focus on clean architecture, deterministic behavior, and performance-oriented design.

The project separates **engine logic** from the **graphical interface**, allowing both components to evolve independently.

---

# Project Architecture

The project follows a modular architecture where each subsystem has a clearly defined responsibility.

```
src/
  board/        → board representation and game state
  movegen/      → move generation
  search/       → search algorithms
  evaluation/   → position evaluation
  engine/       → engine orchestration and API
  ui/           → graphical interface
  types/        → shared data structures

include/
  public headers shared across modules

tests/
  unit tests for each subsystem

docs/
  architecture and design documentation
```

---

# Architectural Principles

Follow these principles when generating code.

### 1. Single Responsibility

Each module must implement **only one clear responsibility**.

Example:

- `board` manages board state
- `movegen` generates moves
- `search` chooses moves
- `evaluation` scores positions

---

### 2. Loose Coupling

Modules must communicate through **clear interfaces**, not direct internal dependencies.

Example interaction:

```
UI → Engine API → Board / MoveGen / Search
```

The UI must **never depend directly on board or move generation logic**.

---

### 3. Deterministic State

Avoid hidden global state.

The board state should be **fully determined by its data structures and move history**.

---

### 4. Performance Awareness

Chess engines are performance sensitive.

When generating code:

- avoid unnecessary heap allocations
- prefer stack allocation when possible
- avoid expensive copies
- use efficient data structures

---

# Core Data Representation

The engine internally uses **bitboards** for representing the chessboard.

A bitboard is a **64-bit integer where each bit represents a square**.

Typical bitboards include:

- piece type bitboards
- color bitboards
- occupancy bitboards

Example concept:

```
uint64_t whitePawns
uint64_t blackPieces
uint64_t occupancy
```

Do not implement board logic using naive 2D arrays.

---

# Module Responsibilities

## board

Responsible for:

- board representation
- piece placement
- bitboards
- move application
- move undo
- FEN parsing
- game state tracking

Example files:

```
board.cpp
board.h
fen_parser.cpp
fen_parser.h
```

Must NOT include:

- search algorithms
- evaluation logic
- UI code

---

## movegen

Responsible for:

- generating pseudo-legal moves
- generating legal moves
- move validation

Example files:

```
move_generator.cpp
move_generator.h
```

Must NOT include:

- evaluation logic
- search logic
- UI logic

---

## search

Responsible for:

- minimax search
- alpha-beta pruning
- iterative deepening
- best move selection

Example files:

```
search.cpp
search.h
```

Must NOT:

- permanently modify board state
- contain UI logic

---

## evaluation

Responsible for scoring positions.

Typical heuristics include:

- material balance
- piece-square tables
- mobility
- king safety

Example files:

```
evaluation.cpp
evaluation.h
```

Must NOT generate moves.

---

## engine

Acts as the **coordination layer** of the chess engine.

Responsibilities:

- manage game flow
- call move generation
- call search
- expose the engine API used by the UI

Example files:

```
engine.cpp
engine.h
engine_api.h
```

---

## ui

Responsible for the graphical interface.

Responsibilities:

- render chessboard
- render pieces
- manage user interaction
- send moves to the engine
- display legal moves

Example structure:

```
src/ui/
  board_view/
  pieces/
  interaction/
  state/
  assets/
```

The UI must **only communicate with the engine through the public API**.

---

## types

Contains shared data structures used across modules.

Example:

```
move.h
square.h
piece.h
color.h
```

These types must be lightweight and independent.

---

# Engine API Contract

The UI communicates with the engine through a public interface.

Example concept:

```cpp
class EngineAPI {
public:
    BoardState getBoardState();
    std::vector<std::string> getLegalMoves(std::string square);
    void makeMove(std::string from, std::string to);
};
```

The UI must **never access internal engine classes directly**.

---

# FEN Usage

FEN (Forsyth–Edwards Notation) is supported for:

- debugging
- testing
- loading positions
- future UCI integration

FEN should not be the primary internal representation of the board.

---

# Coding Style

Follow these guidelines when generating code.

Language:

C++20

Prefer:

- `std::vector`
- `std::array`
- `enum class`
- `constexpr` where appropriate

Avoid:

- macros
- raw pointers unless necessary
- global variables

Naming conventions:

```
Classes: PascalCase
functions: camelCase
variables: camelCase
constants: UPPER_CASE
```

File naming:

```
snake_case.cpp
snake_case.h
```

---

# Testing

Every module should have unit tests inside `tests/`.

Example structure:

```
tests/
  board/
  movegen/
  search/
  evaluation/
```

Tests should validate:

- board state transitions
- FEN parsing
- move generation correctness
- evaluation scoring
- search behavior

---

# Important Constraints for AI Code Generation

When generating code:

- respect module boundaries
- do not mix UI logic with engine logic
- avoid adding dependencies between unrelated modules
- prioritize readability and correctness before micro-optimizations
