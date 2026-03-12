# Chess Engine

A modular chess engine written in **modern C++ (C++20)**, focused on clean architecture, deterministic behavior, and performance-oriented design.
This project aims to build a fully functional chess engine from scratch while maintaining strong engineering practices such as modular design, testability, and clear separation of responsibilities.

## Project Goals

- Develop a **maintainable and extensible chess engine**.
- Enforce **clear architectural boundaries** between engine components.
- Maintain **deterministic state transitions** for reproducible analysis.
- Enable **incremental development with unit tests** for each subsystem.
- Explore classic chess engine techniques such as **alpha-beta pruning, evaluation heuristics, and efficient move generation**.

## Repository Structure

- `docs/` — architecture notes, design decisions, and technical documentation.
- `include/` — public headers shared across modules.
- `scripts/` — helper scripts for local development and automation.
- `src/` — engine source code, split by responsibility:
  - `board/` — board representation and game-state transitions.
  - `movegen/` — pseudo-legal and legal move generation.
  - `search/` — minimax, alpha-beta, and move selection.
  - `evaluation/` — position scoring heuristics.
  - `engine/` — orchestration layer and public engine API.
- `tests/` — unit tests for each subsystem.

### Responsibilities

**Board**
- Maintains the current board state
- Applies and undoes moves
- Tracks game state (turn, castling rights, etc.)

**Move Generation**
- Generates pseudo-legal moves
- Filters legal moves
- Ensures rule compliance

**Evaluation**
- Scores positions based on heuristics
- Material balance
- Positional advantages

**Search**
- Explores game trees
- Applies minimax with alpha-beta pruning
- Selects the best move

**Engine**
- Coordinates subsystems
- Provides the public interface for the engine

---

# Tech Stack

| Component | Technology |
|--------|--------|
Language | C++20 |
Build System | CMake (3.20+) |
Testing | Planned (GoogleTest / Catch2) |
Target Platform | Cross-platform |

## Getting Started

### 1. Configure

```bash
cmake -S . -B build
```

### 2. Build

```bash
cmake --build build
```

## Development Principles

- Single responsibility per module.
- Loose coupling and clear interfaces.
- No hidden global state.
- Performance-aware implementation choices.
- Test-first or test-alongside development for core logic.

## License

MIT License
Copyright (c) 2026 Claudia Rocha, Eliana Brand