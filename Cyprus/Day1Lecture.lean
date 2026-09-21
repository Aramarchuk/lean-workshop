/-
# Day 1 lecture: logic
-/

import Cyprus.Islanders
import Mathlib.Tactic

namespace Cyprus.Day1Lecture

section Connectives

variable {A B C : Prop}

-- ## Truth and implication

theorem true_is_true : True := by sorry

theorem self_imp : A → A := by sorry

theorem imp_const : A → B → A := by sorry

theorem modus_ponens : A → (A → B) → B := by sorry

theorem imp_trans : (A → B) → (B → C) → A → C := by sorry

-- ## Conjunction

theorem and_intro (a : A) (b : B) : A ∧ B := by sorry

theorem and_left : A ∧ B → A := by sorry

theorem and_swap : A ∧ B → B ∧ A := by sorry

-- ## Disjunction

theorem or_intro_left : A → A ∨ B := by sorry

theorem or_elim (f : A → C) (g : B → C) : A ∨ B → C := by sorry

theorem or_swap : A ∨ B → B ∨ A := by sorry

-- ## False and negation

theorem ex_falso : False → A := by sorry

theorem not_intro (h : A → False) : ¬A := by sorry

theorem no_contradiction : ¬(A ∧ ¬A) := by sorry

theorem contrapositive (f : A → B) : ¬B → ¬A := by sorry

-- ## Equivalence

theorem iff_of_imps (f : A → B) (g : B → A) : A ↔ B := by sorry

theorem iff_swap : (A ↔ B) → (B ↔ A) := by sorry

end Connectives

section Tactics

variable {A B C : Prop}

theorem imp_trans_tactic : (A → B) → (B → C) → A → C := by sorry

theorem and_swap_tactic : A ∧ B → B ∧ A := by sorry

theorem or_swap_tactic : A ∨ B → B ∨ A := by sorry

theorem contrapositive_tactic (f : A → B) : ¬B → ¬A := by sorry

theorem not_or_iff : ¬(A ∨ B) ↔ ¬A ∧ ¬B := by sorry

end Tactics

section Classical

variable {A B : Prop}

theorem not_not_elim : ¬¬A → A := by sorry

theorem not_and_iff : ¬(A ∧ B) ↔ ¬A ∨ ¬B := by sorry

theorem imp_iff_not_or : (A → B) ↔ ¬A ∨ B := by sorry

end Classical

section Quantifiers

variable {α : Type} {P Q : α → Prop}

theorem forall_imp_of_forall (h : ∀ x, P x → Q x) (hp : ∀ x, P x) : ∀ x, Q x := by sorry

theorem exists_of_forall (a : α) (h : ∀ x, P x) : ∃ x, P x := by sorry

theorem exists_or_iff : (∃ x, P x ∨ Q x) ↔ (∃ x, P x) ∨ (∃ x, Q x) := by sorry

theorem not_forall_of_exists_not (h : ∃ x, ¬P x) : ¬∀ x, P x := by sorry

end Quantifiers

section KnightsAndKnaves

open Cyprus.Islanders

theorem knight_ne_knave : Role.knight ≠ Role.knave := by sorry

theorem role_dichotomy (r : Role) : r = .knight ∨ r = .knave := by sorry

/-- A says “I am a knave.” -/
def answerSelfAccusation : Answer ["A"] := sorry

theorem puzzleSelfAccusation (A : Islander) (hA : Says A (role A = .knave)) :
    claim% answerSelfAccusation [A] := by
  sorry

/-- A says “B is a knight.”  B says “A and I are not the same.” -/
def answerDifferent : Answer ["A", "B"] := sorry

theorem puzzleDifferent (A B : Islander)
    (hA : Says A (role B = .knight)) (hB : Says B (role A ≠ role B)) :
    claim% answerDifferent [A, B] := by
  sorry

/-- A says “We are both knaves.” -/
def answerBothKnaves : Answer ["A", "B"] := sorry

theorem puzzleBothKnaves (A B : Islander)
    (hA : Says A (role A = .knave ∧ role B = .knave)) :
    claim% answerBothKnaves [A, B] := by
  sorry

/-- A says “Everyone on this island is a knave.” -/
def answerAllKnaves : Answer ["A"] := sorry

theorem puzzleAllKnaves (A : Islander) (hA : Says A (∀ x, role x = .knave)) :
    claim% answerAllKnaves [A] := by
  sorry

end KnightsAndKnaves

end Cyprus.Day1Lecture
