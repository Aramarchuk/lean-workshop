/-
# Day 1 lecture: logic, proof terms, and types

A proposition is a type in `Prop`; a proof is a term of that type.  This file
contains the instructor's worked examples.  Practice problems are in
`Cyprus.Day1Seminar`, including the separate puzzle collection.
-/

import Mathlib.Tactic

namespace Cyprus.Day1Lecture

section Logic

variable {A B C : Prop}

/-- A proof of an implication is a function on proofs. -/
theorem implication_trans : (A → B) → (B → C) → A → C := fun ab bc a => bc (ab a)

/-- A proof of a conjunction stores both component proofs. -/
theorem and_swap : A ∧ B → B ∧ A := fun ⟨a, b⟩ => ⟨b, a⟩

/-- A proof of a disjunction chooses a constructor. -/
theorem or_swap : A ∨ B → B ∨ A
  | .inl a => .inr a
  | .inr b => .inl b

/-- Tactic mode constructs the same proof terms interactively. -/
theorem deMorgan_or : ¬(A ∨ B) ↔ ¬A ∧ ¬B := by
  constructor
  · intro h
    exact ⟨fun a => h (.inl a), fun b => h (.inr b)⟩
  · rintro ⟨na, nb⟩ (a | b)
    · exact na a
    · exact nb b

end Logic

section Types

/-- A value type has data constructors, unlike a proposition. -/
inductive Role where
  | knight
  | knave
  deriving DecidableEq, Repr

/-- Pattern matching defines a program over `Role`. -/
def Role.flip : Role → Role
  | .knight => .knave
  | .knave => .knight

/-- Case analysis proves a fact for every value of a finite type. -/
theorem Role.flip_flip (r : Role) : r.flip.flip = r := by cases r <;> rfl

/-- A role-valued islander says `P` exactly when being a knight agrees with `P`. -/
def Says (r : Role) (P : Prop) : Prop := r = .knight ↔ P

/-- Worked example: a knight's statement follows from the role-valued model. -/
theorem says_of_knight {r : Role} {P : Prop} (hr : r = .knight) (h : Says r P) : P :=
  h.mp hr

/-- Equality permits replacement of equals by equals. -/
theorem eq_trans {α : Type} {x y z : α} (hxy : x = y) (hyz : y = z) : x = z :=
  hxy.trans hyz

end Types

section Functions

/-- A function is injective when equal outputs came from equal inputs. -/
def IsInjective {α β : Type} (f : α → β) : Prop :=
  ∀ x y, f x = f y → x = y

/-- A function is surjective when every output has a preimage. -/
def IsSurjective {α β : Type} (f : α → β) : Prop :=
  ∀ y, ∃ x, f x = y

/-- Worked example: `Role.flip` is its own inverse, so it is injective. -/
theorem flip_injective : IsInjective Role.flip := by
  sorry

/-- Live exercise: find a preimage for each role. -/
theorem flip_surjective : IsSurjective Role.flip := by
  sorry

end Functions

section Quantifiers

/-- A universal proof supplies a proof at every input. -/
theorem forall_and {α : Type} (P Q : α → Prop) :
    (∀ x, P x ∧ Q x) ↔ (∀ x, P x) ∧ (∀ x, Q x) := by
  constructor
  · intro h
    exact ⟨fun x => (h x).left, fun x => (h x).right⟩
  · rintro ⟨hp, hq⟩ x
    exact ⟨hp x, hq x⟩

/-- An existential proof packages a witness with its evidence. -/
theorem exists_or {α : Type} (P Q : α → Prop) :
    (∃ x, P x ∨ Q x) ↔ (∃ x, P x) ∨ (∃ x, Q x) := by
  constructor
  · rintro ⟨x, px | qx⟩
    · exact .inl ⟨x, px⟩
    · exact .inr ⟨x, qx⟩
  · rintro (⟨x, px⟩ | ⟨x, qx⟩)
    · exact ⟨x, .inl px⟩
    · exact ⟨x, .inr qx⟩

end Quantifiers

section KnightsAndKnaves

/-
For an islander, `A` means “A is a knight”.  A hypothesis `A ↔ statement`
models what A says: a knight's statement is true, and a knave's statement is
false.  The reverse implication is the knave half of the model.
-/

/-- Worked model: a knight says that B is a knight exactly when `A ↔ B`. -/
theorem knight_says_knight {A B : Prop} (hA : A ↔ B) : A → B := hA.mp

/-- Live puzzle: nobody can consistently say “I am a knave.” -/
theorem live_puzzle_self_accusation (A : Prop) (hA : A ↔ ¬ A) : False := by
  sorry

/-- Live puzzle: A says “I am a knave or B is a knight.” -/
theorem live_puzzle_knave_or_knight (A B : Prop) (hA : A ↔ (¬ A ∨ B)) : A ∧ B := by
  sorry

/-- Live puzzle: a knight cannot claim that every natural number is at most two. -/
theorem live_puzzle_bounded_naturals (A : Prop) (hA : A ↔ ∀ n : Nat, n ≤ 2) : ¬ A := by
  sorry

/- The independent seminar puzzle collection is in `Cyprus.Puzzles`. -/

end KnightsAndKnaves

end Cyprus.Day1Lecture
