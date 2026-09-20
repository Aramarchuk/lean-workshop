/-
# Day 1: propositions, proofs, and puzzles

Lean reads a proposition as a type and a proof as a value of that type.  Work
through the exercises by replacing each marked solution with your own proof.
The larger logic puzzles live in `Cyprus.Puzzles`.
-/

import Cyprus.Day1Lecture
import Cyprus.Puzzles
import Mathlib.Tactic

namespace Cyprus.Day1Seminar

section Logic

variable {A B C : Prop}

/-- Worked example: implication is a function taking a proof of `A` to one of `B`. -/
theorem implication_trans : (A → B) → (B → C) → A → C :=
  fun ab bc a => bc (ab a)

/-- Worked example: a conjunction is a pair of proofs. -/
theorem and_swap : A ∧ B → B ∧ A :=
  fun ⟨a, b⟩ => ⟨b, a⟩

/-- Exercise: reassociate a disjunction. -/
theorem or_assoc : (A ∨ B) ∨ C → A ∨ (B ∨ C) :=
sorry

/-- Exercise: distribute a conjunction over a disjunction. -/
theorem and_distrib_or : A ∧ (B ∨ C) → (A ∧ B) ∨ (A ∧ C) :=
sorry

/-- Worked example: `False` eliminates into every proposition. -/
theorem ex_falso : False → A := False.elim

/-- Exercise: a proof of `A` gives a proof that `A` is not false. -/
theorem not_not_intro : A → ¬¬A :=
sorry

/-- Exercise: unpack an equivalence into two implications. -/
theorem iff_as_pair : (A ↔ B) → (A → B) ∧ (B → A) :=
sorry

end Logic

section Tactics

variable {A B C : Prop}

/-- Worked example using tactics. -/
theorem modus_ponens : A → (A → B) → B := by
  intro a ab
  exact ab a

/-- Exercise: prove the same distributive law using tactic mode. -/
theorem and_distrib_or_tactic : A ∧ (B ∨ C) → (A ∧ B) ∨ (A ∧ C) :=
sorry

/-- Exercise: prove one direction of De Morgan's law constructively. -/
theorem not_or_iff : ¬(A ∨ B) ↔ ¬A ∧ ¬B :=
sorry

end Tactics

section TypesAndEquality

open Cyprus.Day1Lecture

/-- Exercise: flipping twice returns the original role. -/
theorem Role.flip_flip (r : Role) : r.flip.flip = r :=
sorry

/-- Exercise: the two constructors are distinct. -/
theorem knight_ne_knave : Role.knight ≠ Role.knave :=
sorry

/-- Worked example: rewrite changes equal things in a goal. -/
theorem eq_symm {α : Type} {x y : α} (h : x = y) : y = x := by
  rw [h]

/-- Exercise: equality is transitive. -/
theorem eq_trans {α : Type} {x y z : α} (hxy : x = y) (hyz : y = z) : x = z :=
sorry

end TypesAndEquality

section Quantifiers

/-- Exercise: universal quantification distributes over conjunction. -/
theorem forall_and {α : Type} (P Q : α → Prop) :
    (∀ x, P x ∧ Q x) ↔ (∀ x, P x) ∧ (∀ x, Q x) :=
sorry

/-- Exercise: an existential witness chooses a side of a disjunction. -/
theorem exists_or {α : Type} (P Q : α → Prop) :
    (∃ x, P x ∨ Q x) ↔ (∃ x, P x) ∨ (∃ x, Q x) :=
sorry

end Quantifiers

/-
## Puzzle workshop

`Cyprus.Puzzles` is a separate module containing a collection of logic puzzles.  Use it
alongside this file: keep the puzzle statements open in one editor pane and
use the proof forms above to build their solutions.  The separation keeps the
puzzles usable without exposing this day's worked proofs.
-/

end Cyprus.Day1Seminar
