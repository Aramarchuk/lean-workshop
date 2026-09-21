/-
# Day 2 lecture: types, functions, and induction
-/

import Cyprus.Islanders
import Mathlib.Tactic

namespace Cyprus.Islanders.Role

def flip : Role → Role
  | .knight => .knave
  | .knave => .knight

end Cyprus.Islanders.Role

namespace Cyprus.Day2Lecture

open Cyprus.Islanders

section InductiveTypes

theorem flip_knight : Role.flip .knight = .knave := by sorry

theorem flip_flip (r : Role) : r.flip.flip = r := by sorry

theorem flip_ne_self (r : Role) : r.flip ≠ r := by sorry

end InductiveTypes

section Equality

variable {α : Type}

theorem eq_symm {x y : α} (h : x = y) : y = x := by sorry

theorem eq_trans {x y z : α} (hxy : x = y) (hyz : y = z) : x = z := by sorry

theorem congr_fun_arg {β : Type} (f : α → β) {x y : α} (h : x = y) : f x = f y := by sorry

theorem role_chain (A B : Islander) (h : role A = role B) (hB : role B = .knight) :
    role A = .knight := by
  sorry

end Equality

section Functions

variable {α β γ : Type}

def Injective (f : α → β) : Prop := ∀ x y, f x = f y → x = y

def Surjective (f : α → β) : Prop := ∀ y, ∃ x, f x = y

theorem injective_id : Injective (fun x : α => x) := by sorry

theorem flip_injective : Injective Role.flip := by sorry

theorem flip_surjective : Surjective Role.flip := by sorry

theorem injective_comp {f : α → β} {g : β → γ} (hf : Injective f) (hg : Injective g) :
    Injective (fun x => g (f x)) := by
  sorry

end Functions

section Induction

inductive MyNat where
  | zero
  | succ (n : MyNat)
  deriving DecidableEq, Repr

namespace MyNat

def add : MyNat → MyNat → MyNat
  | n, .zero => n
  | n, .succ m => .succ (add n m)

theorem add_zero (n : MyNat) : add n .zero = n := by sorry

theorem add_succ (n m : MyNat) : add n (.succ m) = .succ (add n m) := by sorry

theorem zero_add (n : MyNat) : add .zero n = n := by sorry

end MyNat

def double : Nat → Nat
  | 0 => 0
  | n + 1 => double n + 2

theorem double_eq_add_self (n : Nat) : double n = n + n := by sorry

end Induction

section InductivePredicates

inductive MyLe : Nat → Nat → Prop where
  | refl (n : Nat) : MyLe n n
  | step {n m : Nat} : MyLe n m → MyLe n (m + 1)

example : MyLe 2 4 := by sorry

theorem not_myLe_succ_zero (n : Nat) : ¬MyLe (n + 1) 0 := by sorry

theorem myLe_trans {n m k : Nat} (hnm : MyLe n m) (hmk : MyLe m k) : MyLe n k := by sorry

inductive MyEven : Nat → Prop where
  | zero : MyEven 0
  | add_two {n : Nat} : MyEven n → MyEven (n + 2)

theorem even_two_mul (n : Nat) : MyEven (2 * n) := by sorry

end InductivePredicates

section Decidable

inductive Parity (n : Nat) : Type where
  | even (k : Nat) (h : n = 2 * k)
  | odd (k : Nat) (h : n = 2 * k + 1)

def parity : (n : Nat) → Parity n
  | 0 => .even 0 rfl
  | n + 1 =>
    match parity n with
    | .even k h => .odd k (by omega)
    | .odd k h => .even (k + 1) (by omega)

def evenDecidable (n : Nat) : Decidable (MyEven n) := by sorry

end Decidable

section Collatz

def collatzStep (n : Nat) : Nat :=
  match parity n with
  | .even k _ => k
  | .odd _ _ => 3 * n + 1

inductive CollatzFinite : Nat → Prop where
  | zero : CollatzFinite 0
  | one : CollatzFinite 1
  | step {n : Nat} : CollatzFinite (collatzStep n) → CollatzFinite n

def CollatzConjecture : Prop := ∀ n, CollatzFinite n

end Collatz

end Cyprus.Day2Lecture
