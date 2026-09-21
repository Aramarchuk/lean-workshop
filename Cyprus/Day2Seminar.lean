/-
# Day 2 seminar: types, functions, and induction

Replace each `sorry` with a proof.  Sections follow the lecture, and within a
section the exercises go from routine to harder.  The definitions come from
`Cyprus.Day2Lecture`; do not redefine them.  The Collatz section is for anyone
who finishes early.
-/

import Cyprus.Day1Lecture
import Cyprus.Day2Lecture
import Mathlib.Tactic

namespace Cyprus.Day2Seminar

open Cyprus.Islanders Cyprus.Day2Lecture Cyprus.Day1Lecture

section Roles

theorem flip_knave : Role.flip .knave = .knight :=
sorry

theorem flip_eq_knight_iff (r : Role) : r.flip = .knight ↔ r = .knave :=
sorry

theorem role_eq_of_flip_eq (r s : Role) (h : r.flip = s.flip) : r = s :=
sorry

end Roles

section Functions

variable {α β γ : Type}

theorem surjective_id : Surjective (fun x : α => x) :=
sorry

theorem surjective_comp {f : α → β} {g : β → γ} (hf : Surjective f) (hg : Surjective g) :
    Surjective (fun x => g (f x)) :=
sorry

theorem injective_of_comp_injective (f : α → β) (g : β → γ)
    (h : Injective (fun x => g (f x))) : Injective f :=
sorry

/-- Every function out of `Role` that is injective is also surjective. -/
theorem role_surjective_of_injective (f : Role → Role) (hf : Injective f) : Surjective f :=
sorry

end Functions

section Induction

open MyNat

theorem succ_add (n m : MyNat) : add (.succ n) m = .succ (add n m) :=
sorry

theorem add_comm (n m : MyNat) : add n m = add m n :=
sorry

/-- A Boolean equality test on `Nat`. -/
def isEq : Nat → Nat → Bool
  | 0, 0 => true
  | _ + 1, 0 => false
  | 0, _ + 1 => false
  | n + 1, m + 1 => isEq n m

example : isEq 3 3 = true := rfl

theorem isEq_sound (n m : Nat) : isEq n m = true → n = m :=
sorry

/-- Induction meets yesterday's definitions. -/
theorem double_injective : Injective double :=
sorry

end Induction

section InductivePredicates

theorem myLe_zero (n : Nat) : MyLe 0 n :=
sorry

theorem myLe_succ_succ {n m : Nat} (h : MyLe n m) : MyLe (n + 1) (m + 1) :=
sorry

theorem myLe_iff_exists_add (n m : Nat) : MyLe n m ↔ ∃ k, n + k = m :=
sorry

theorem not_myEven_one : ¬MyEven 1 :=
sorry

theorem myEven_add {n m : Nat} (hn : MyEven n) (hm : MyEven m) : MyEven (n + m) :=
sorry

theorem myEven_exists {n : Nat} (h : MyEven n) : ∃ k, n = 2 * k :=
sorry

end InductivePredicates

section Collatz

theorem collatzStep_two_mul (n : Nat) : collatzStep (2 * n) = n :=
sorry

/-- Follow 6 down to 1 by hand. -/
theorem collatzFinite_six : CollatzFinite 6 :=
sorry

theorem collatzFinite_two_mul {n : Nat} (h : CollatzFinite n) : CollatzFinite (2 * n) :=
sorry

end Collatz

end Cyprus.Day2Seminar
