/-
# Day 2: induction, predicates, and computation

Today recursive definitions and inductive proofs explain one another.  The
Collatz section is optional: it illustrates the boundary between computation
and an open mathematical conjecture.
-/

import Cyprus.Day2Lecture
import Mathlib.Tactic

namespace Cyprus.Day2Seminar

section Induction

/-- Natural numbers built from zero and successor. -/
inductive MyNat where
  | zero
  | succ (n : MyNat)
  deriving Repr

namespace MyNat

/-- Addition recurses on its second argument. -/
def add : MyNat → MyNat → MyNat
  | n, .zero => n
  | n, .succ m => .succ (add n m)

/-- Worked example: the defining equation for addition. -/
theorem add_zero (n : MyNat) : add n .zero = n := rfl

/-- Exercise: prove the other zero law by induction. -/
theorem zero_add (n : MyNat) : add .zero n = n :=
sorry

end MyNat

/-- A recursive function on Lean's built-in naturals. -/
def double : Nat → Nat
  | 0 => 0
  | n + 1 => double n + 2

/-- Worked example: recursive computation reduces definitionally. -/
example : double 3 = 6 := rfl

/-- Exercise: prove the specification of `double`. -/
theorem double_eq_add_self (n : Nat) : double n = n + n :=
sorry

/-- Exercise: a Boolean equality test is sound. -/
def isEq : Nat → Nat → Bool
  | 0, 0 => true
  | _ + 1, 0 => false
  | 0, _ + 1 => false
  | n + 1, m + 1 => isEq n m

theorem isEq_sound (n m : Nat) : isEq n m = true → n = m :=
sorry

end Induction

section InductivePredicates

/-- A less-than-or-equal relation specified by inference rules. -/
inductive MyLe : Nat → Nat → Prop where
  | refl (n : Nat) : MyLe n n
  | step {n m : Nat} : MyLe n m → MyLe n (m + 1)

/-- Worked example: a derivation is a value built from the rules. -/
example : MyLe 2 4 := MyLe.step (MyLe.step (MyLe.refl 2))

/-- Exercise: no successor is at most zero. -/
theorem not_succ_le_zero (n : Nat) : ¬ MyLe (n + 1) 0 :=
sorry

/-- Exercise: compose two derivations of the built-in `≤` predicate. -/
theorem le_transitive (n m k : Nat) (hnm : n ≤ m) (hmk : m ≤ k) : n ≤ k :=
sorry

/-- Exercise: compare `≤` with addition. -/
theorem le_iff_exists_add (n m : Nat) : n ≤ m ↔ ∃ k, n + k = m :=
sorry

end InductivePredicates

section Parity

/-- The inductive proposition that a natural number is even. -/
inductive MyEven : Nat → Prop where
  | zero : MyEven 0
  | add_two {n : Nat} : MyEven n → MyEven (n + 2)

/-- Exercise: every multiple of two is even. -/
theorem even_two_mul (n : Nat) : MyEven (2 * n) :=
sorry

/-- Worked example: induction turns an even derivation into a multiplication witness. -/
lemma even_exists (n : Nat) (h : MyEven n) : ∃ k, n = 2 * k := by
  induction h with
  | zero => exact ⟨0, rfl⟩
  | add_two _ ih =>
    obtain ⟨k, hk⟩ := ih
    exact ⟨k + 1, by omega⟩

/-- A parity result stores a quotient and a proof of the corresponding equation. -/
inductive Parity (n : Nat) : Type where
  | even (k : Nat) (h : n = 2 * k)
  | odd (k : Nat) (h : n = 2 * k + 1)

/-- Computation can return both data and a proof about that data. -/
def parity : (n : Nat) → Parity n
  | 0 => .even 0 rfl
  | n + 1 =>
    match parity n with
    | .even k h => .odd k (by omega)
    | .odd k h => .even (k + 1) (by omega)

/-- Worked example: extract the quotient while discarding the proof. -/
def half (n : Nat) : Nat :=
  match parity n with
  | .even k _ => k
  | .odd k _ => k

example : half 7 = 3 := rfl

/-- `Decidable P` is an algorithm that returns either a proof of `P` or one of `¬ P`. -/
instance (n : Nat) : Decidable (MyEven n) :=
  match parity n with
  | .even k h => isTrue (h ▸ even_two_mul k)
  | .odd k h => isFalse fun he => by
      obtain ⟨j, hj⟩ := even_exists n he
      omega

/-- Worked example: Lean can execute the decision procedure. -/
example : MyEven 10 := by decide

end Parity

section OptionalCollatz

/-- The optional Collatz step uses the computed parity witness. -/
def collatzStep (n : Nat) : Nat :=
  match parity n with
  | .even k _ => k
  | .odd _ _ => 3 * n + 1

/-- Exercise: an even input is halved by `collatzStep`. -/
theorem collatzStep_two_mul (n : Nat) : collatzStep (2 * n) = n :=
sorry

/-- Repeatedly apply a function. -/
def iterate {α : Type} (f : α → α) : Nat → α → α
  | 0, a => a
  | k + 1, a => iterate f k (f a)

/-- Numbers known to reach zero or one under Collatz steps. -/
inductive CollatzFinite : Nat → Prop where
  | zero : CollatzFinite 0
  | one : CollatzFinite 1
  | step {n : Nat} : CollatzFinite (collatzStep n) → CollatzFinite n

/-- The optional conjecture remains a proposition, not an available theorem. -/
def CollatzConjecture : Prop := ∀ n, CollatzFinite n

end OptionalCollatz

end Cyprus.Day2Seminar
