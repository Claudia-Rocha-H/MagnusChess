# Copilot Instructions – Chess Engine

This repository contains a modular chess engine written in C++.

## Architecture

The project follows a modular architecture where each subsystem has a clear responsibility.

src/
  board/        → board representation and state management
  movegen/      → move generation logic
  search/       → search algorithms (minimax, alpha-beta)
  evaluation/   → position evaluation heuristics
  engine/       → engine coordination and game logic

tests/
  unit tests for each subsystem

docs/
  architecture and design documentation

# Architectural Principles

Follow these principles when generating code:

1. **Single Responsibility**
   Each module must have a clear responsibility.

2. **Loose Coupling**
   Modules should not depend heavily on each other.

3. **Clear Interfaces**
   Communication between modules should happen through well-defined APIs.

4. **Deterministic State**
   Avoid hidden global state.

5. **Performance Awareness**
   Chess engines are performance sensitive. Avoid unnecessary allocations.
---

# Module Responsibilities

## board

Responsible for:

- board representation
- piece placement
- move application
- move undo
- game state tracking

Must NOT include:

- search algorithms
- evaluation logic

---

## movegen

Responsible for:

- generating pseudo-legal moves
- generating legal moves

Must NOT include:

- evaluation logic
- search logic

---

## search

Responsible for:

- minimax search
- alpha-beta pruning
- selecting best move

Must NOT modify board state permanently.

---

## evaluation

Responsible for:

- scoring a position
- heuristics (material, mobility, king safety)

Must NOT generate moves.

---

## engine

Responsible for:

- coordinating move generation
- calling search
- exposing engine API

---

## Design Principles

- Separation of concerns between modules
- Avoid global state
- Favor immutable data where possible
- Clear and readable algorithms
- Performance-sensitive code should avoid unnecessary allocations

## Coding Style

- C++20
- Use modern STL
- Prefer `std::vector` over raw arrays
- Avoid macros when possible
- Use descriptive names for functions and variables

## Testing

Every module should have unit tests under the `tests` directory.

Test coverage should include:
- board state transitions
- move generation correctness
- evaluation logic
- search behavior