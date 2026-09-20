# Cyprus Lean workshop

This project is a two-day Lean workshop with lecture scaffolds and seminar practice.

- Day 1: `Cyprus.Day1Lecture` introduces propositions, proof terms, tactics, types, equality, quantifiers, and knights-and-knaves modelling. `Cyprus.Day1Seminar` provides practice. `Cyprus.Puzzles` is the separate logic-puzzle collection.
- Day 2: `Cyprus.Day2Lecture` introduces induction, recursive functions, inductive predicates, parity, decidability, and optional Collatz. `Cyprus.Day2Seminar` provides practice.

## Setup

Install Lean with VS Code and the Lean extension, or install `elan` from https://lean-lang.org. Open this folder in VS Code; `elan` selects the version recorded in `lean-toolchain`. In a terminal in this folder, download the pinned dependencies and build:

```sh
lake exe cache get
lake build
```

## Teaching and exercises

Lecture files are live-teaching scaffolds. They may contain authored `sorry` placeholders that the instructor fills during a session; published updates retain those files unchanged. Seminar files contain complete staff proofs between `-- TO_SORRY` and `-- SORRY_END`. The student export replaces each marked proof with `sorry`. Replace a seminar `sorry` with your own proof and run `lake build` to check it. `Cyprus.lean` imports all workshop modules.
