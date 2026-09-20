/-
# Day 2 lecture: induction, predicates, and computation

Recursive programs follow the constructors of their input.  Induction follows
the constructors of a proof or value.  The seminar turns these patterns into
practice problems.
-/

import Mathlib.Tactic

namespace Cyprus.Day2Lecture

/-- Addition on a natural-number type built from zero and successor. -/
inductive MyNat where
  | zero
  | succ (n : MyNat)
  deriving Repr

namespace MyNat

def add : MyNat → MyNat → MyNat
  | n, .zero => n
  | n, .succ m => .succ (add n m)

theorem zero_add (n : MyNat) : add .zero n = n := by
  induction n with
  | zero => rfl
  | succ n ih => simp [add, ih]

end MyNat

/-- A recursive program over the built-in naturals. -/
def double : Nat → Nat
  | 0 => 0
  | n + 1 => double n + 2

theorem double_eq_add_self (n : Nat) : double n = n + n := by
  induction n with
  | zero => rfl
  | succ n ih =>
    rw [double, ih]
    omega

/-- An inductive relation is specified by rules for constructing derivations. -/
inductive MyLe : Nat → Nat → Prop where
  | refl (n : Nat) : MyLe n n
  | step {n m : Nat} : MyLe n m → MyLe n (m + 1)

/-- Worked example: two applications of `step` derive `2 ≤ 4`. -/
example : MyLe 2 4 := MyLe.step (MyLe.step (MyLe.refl 2))

/-- Live case analysis: no successor has a derivation to zero. -/
theorem not_myLe_succ_zero (n : Nat) : ¬ MyLe (n + 1) 0 := by
  sorry

/-- Live induction over a derivation composes two `MyLe` proofs. -/
theorem myLe_trans (n m k : Nat) (hnm : MyLe n m) (hmk : MyLe m k) : MyLe n k := by
  sorry

/-- An inductive predicate is specified by rules for constructing its proofs. -/
inductive MyEven : Nat → Prop where
  | zero : MyEven 0
  | add_two {n : Nat} : MyEven n → MyEven (n + 2)

theorem even_two_mul (n : Nat) : MyEven (2 * n) := by
  induction n with
  | zero => exact .zero
  | succ n ih =>
    rw [Nat.mul_succ]
    exact .add_two ih

/-- A `Parity n` result is data carrying evidence about `n`. -/
inductive Parity (n : Nat) : Type where
  | even (k : Nat) (h : n = 2 * k)
  | odd (k : Nat) (h : n = 2 * k + 1)

def parity : (n : Nat) → Parity n
  | 0 => .even 0 rfl
  | n + 1 =>
    match parity n with
    | .even k h => .odd k (by omega)
    | .odd k h => .even (k + 1) (by omega)

/-- `Decidable` packages a computation that can return proof evidence. -/
def evenDecidable (n : Nat) : Decidable (MyEven n) := by
  sorry

/-- The optional Collatz step branches on computed parity. -/
def collatzStep (n : Nat) : Nat :=
  match parity n with
  | .even k _ => k
  | .odd _ _ => 3 * n + 1

/-- Repeated application separates the recursion pattern from Collatz. -/
def iterate {α : Type} (f : α → α) : Nat → α → α
  | 0, a => a
  | k + 1, a => iterate f k (f a)

/-- A number is Collatz-finite when repeatedly stepping it reaches zero or one. -/
inductive CollatzFinite : Nat → Prop where
  | zero : CollatzFinite 0
  | one : CollatzFinite 1
  | step {n : Nat} : CollatzFinite (collatzStep n) → CollatzFinite n

/-- The Collatz conjecture is stated here, not proved. -/
def CollatzConjecture : Prop := ∀ n, CollatzFinite n

end Cyprus.Day2Lecture
