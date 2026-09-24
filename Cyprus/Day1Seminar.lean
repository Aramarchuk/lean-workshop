/-
# Day 1 seminar: logic

Prove the theorems below by replacing each `sorry` with a proof.  They are
ordered by section as in the lecture, and within each section from routine to
harder: the first ones are a single term or a line or two of tactics, the last
ones need an idea.  Term mode and tactic mode are both fine; try to use each
at least once.

The seminar's second half is the puzzle collection.  An islander
`A : Islander` has a role `role A`, and a hypothesis `Says A s` records that A
said `s`.  Every puzzle asks a question and wants two things: an answer and a
proof.

- When the question is who is what, the answer is an `Answer`: `impossible`
  when nobody could have said what was said, otherwise a
  `verdict (A is-a knight, B is-a knave, ...)` listing the islanders the
  question asks about, in order.  The theorem's goal is `claim% answer [...]`,
  which unfolds to whatever your answer claims once you fill it in.
- When the question is about a relation between islanders, or about an
  observed answer, the theorem states it directly and only needs a proof.

`SOURCES.md` records which puzzles adapt Raymond Smullyan's numbered problems.
-/

import Cyprus.Day1Lecture
import Mathlib.Tactic

namespace Cyprus.Day1Seminar

open Cyprus.Islanders

section Implication

variable {A B C : Prop}

theorem imp_comp_flipped : (B → C) → (A → B) → A → C := fun f g x => f (g x)

theorem imp_weaken : (A → C) → A → B → C := by
    intro f x y
    apply f
    assumption

theorem imp_apply_both : A → B → (A → B → C) → C := by
    intro x y f
    apply f
    · exact x
    · exact y

theorem imp_of_self_imp (f : (A → A) → B) : B := by
    apply f
    intros
    assumption

end Implication

section AndOr

variable {A B C D : Prop}

theorem and_map_left (f : A → C) (h : A ∧ B) : C ∧ B := ⟨ (match h with | ⟨a, _⟩ => f a), h.right⟩

theorem and_assoc_back (h : A ∧ (B ∧ C)) : (A ∧ B) ∧ C := ⟨ ⟨h.left, h.right.left ⟩, h.right.right ⟩

theorem or_elim_triple (f : A → D) (g : B → D) (k : C → D) (h : A ∨ B ∨ C) : D :=
    h.elim
        (f)
        (fun bc => bc.elim g k)

theorem and_or_distrib (h : A ∧ (B ∨ C)) : (A ∧ B) ∨ (A ∧ C) :=
    match h.right with
    | Or.inl hb => Or.inl (And.intro h.left hb)
    | Or.inr hc => Or.inr (And.intro h.left hc)

theorem or_and_distrib (h : A ∨ (B ∧ C)) : (A ∨ B) ∧ (A ∨ C) :=
    match h with
    | Or.inl ha => And.intro (Or.inl ha) (Or.inl ha)
    | Or.inr hbc => And.intro (Or.inr hbc.left) (Or.inr hbc.right)

theorem curry_and_iff : ((A ∧ B) → C) ↔ (A → B → C) := by
    constructor
    · intro x y z; apply x; exact ⟨y, z⟩
    · intro x ⟨y, z⟩; apply x; assumption; assumption

end AndOr

section Negation

variable {A B : Prop}

theorem not_not_intro : A → ¬¬A :=
    fun ha => (fun hna => hna ha)


theorem not_of_imp_not (f : A → ¬A) : ¬A :=
    fun ha: A => (f ha) ha


theorem iff_not_congr (h : A ↔ B) : ¬A ↔ ¬B := by
    constructor
    · intro hna hb; apply hna; apply h.mpr; exact hb
    · intro hna ha; apply hna; apply h.mp; exact ha


/-- Excluded middle holds up to a double negation, with no classical axiom. -/
/- (((A ∨ ¬A) → False) → False) -/
theorem not_not_em : ¬¬(A ∨ ¬A) := by
    intro f
    apply f
    right
    intro ha
    apply f
    left
    exact ha

end Negation

section Tactics

variable {A B C : Prop}

/-! Write the proofs in this section in tactic mode. -/

theorem or_comm_iff : A ∨ B ↔ B ∨ A := by
    constructor <;>
    · intro hab
      cases hab with
    | inl ha =>
        right
        exact ha
    | inr ha => left; assumption;

theorem imp_and_iff : (A → B ∧ C) ↔ (A → B) ∧ (A → C) :=
sorry

theorem or_imp_iff : (A ∨ B → C) ↔ (A → C) ∧ (B → C) :=
sorry

/-- Which direction needs `by_cases`? -/
theorem not_imp_iff : ¬(A → B) ↔ A ∧ ¬B :=
sorry

/-- Peirce's law is equivalent to excluded middle; prove it from `by_cases`. -/
theorem peirce : ((A → B) → A) → A :=
sorry

end Tactics

section Quantifiers

variable {α : Type} {P Q : α → Prop}

theorem exists_imp_exists (h : ∀ x, P x → Q x) : (∃ x, P x) → ∃ x, Q x :=
sorry

theorem forall_and_iff : (∀ x, P x ∧ Q x) ↔ (∀ x, P x) ∧ (∀ x, Q x) :=
sorry

theorem not_exists_iff : ¬(∃ x, P x) ↔ ∀ x, ¬P x :=
sorry

/-- Only one direction is provable without a classical case split.  Find it,
then do the other one too. -/
theorem not_forall_iff : ¬(∀ x, P x) ↔ ∃ x, ¬P x :=
sorry

/-- The drinker paradox: in any bar with at least one person, there is someone
such that if they drink, everyone drinks. -/
theorem drinker (a : α) : ∃ x, P x → ∀ y, P y :=
sorry

end Quantifiers

section Puzzles

/-! ## Two and three islanders -/

/-- 1. A says B is a knight; B says A is a knave.  What are they? -/
def answer_01 : Answer ["A", "B"] :=
sorry

theorem puzzle_01 (A B : Islander)
    (hA : Says A (role B = .knight)) (hB : Says B (role A = .knave)) :
    claim% answer_01 [A, B] :=
sorry


/-- 2. A says B is a knave.  Show that A and B are different kinds. -/
theorem puzzle_02 (A B : Islander) (hA : Says A (role B = .knave)) : role A ≠ role B :=
sorry

/-- 3. A says B is a knave; B says A and B are different kinds.  What are they? -/
def answer_03 : Answer ["A", "B"] :=
sorry

theorem puzzle_03 (A B : Islander)
    (hA : Says A (role B = .knave)) (hB : Says B (role A ≠ role B)) :
    claim% answer_03 [A, B] :=
sorry


/-- 4. A says “I am a knight or B is a knight.”  B says A is a knave.  What are
they? -/
def answer_04 : Answer ["A", "B"] :=
sorry

theorem puzzle_04 (A B : Islander)
    (hA : Says A (role A = .knight ∨ role B = .knight)) (hB : Says B (role A = .knave)) :
    claim% answer_04 [A, B] :=
sorry


/-- 5. A says at least one of B and C is a knight; B says C is a knave.  What
is A? -/
def answer_05 : Answer ["A"] :=
sorry

theorem puzzle_05 (A B C : Islander)
    (hA : Says A (role B = .knight ∨ role C = .knight)) (hB : Says B (role C = .knave)) :
    claim% answer_05 [A] :=
sorry


/-- 6. A says B and C are the same kind; B says C is a knight.  What is A? -/
def answer_06 : Answer ["A"] :=
sorry

theorem puzzle_06 (A B C : Islander)
    (hA : Says A (role B = role C)) (hB : Says B (role C = .knight)) :
    claim% answer_06 [A] :=
sorry


/-- 7. A says B and C are the same kind; B says C is a knave.  What is A? -/
def answer_07 : Answer ["A"] :=
sorry

theorem puzzle_07 (A B C : Islander)
    (hA : Says A (role B = role C)) (hB : Says B (role C = .knave)) :
    claim% answer_07 [A] :=
sorry


/-- 8. A says B is a knight; B says C is a knight.  Show that A and C are the
same kind. -/
theorem puzzle_08 (A B C : Islander)
    (hA : Says A (role B = .knight)) (hB : Says B (role C = .knight)) : role A = role C :=
sorry

/-- 9. A says B and C are different kinds; B says A is a knight; C says B is a
knave.  What are they? -/
def answer_09 : Answer ["A", "B", "C"] :=
sorry

theorem puzzle_09 (A B C : Islander)
    (hA : Says A (role B ≠ role C)) (hB : Says B (role A = .knight))
    (hC : Says C (role B = .knave)) :
    claim% answer_09 [A, B, C] :=
sorry


/-- 10. A says B and C are both knaves; B says A is a knave; C says B is a
knave.  What are they? -/
def answer_10 : Answer ["A", "B", "C"] :=
sorry

theorem puzzle_10 (A B C : Islander)
    (hA : Says A (role B = .knave ∧ role C = .knave)) (hB : Says B (role A = .knave))
    (hC : Says C (role B = .knave)) :
    claim% answer_10 [A, B, C] :=
sorry


/-- 11. A says “if B is a knight, then so is C”; B says C is a knave.  Show
that A and C are the same kind. -/
theorem puzzle_11 (A B C : Islander)
    (hA : Says A (role B = .knight → role C = .knight)) (hB : Says B (role C = .knave)) :
    role A = role C :=
sorry

/-- 12. A says B or C is a knight; B says A is a knave; C says A is a knight.
What are they? -/
def answer_12 : Answer ["A", "B", "C"] :=
sorry

theorem puzzle_12 (A B C : Islander)
    (hA : Says A (role B = .knight ∨ role C = .knight)) (hB : Says B (role A = .knave))
    (hC : Says C (role A = .knight)) :
    claim% answer_12 [A, B, C] :=
sorry


/-- 13. A says B and C are not both knights; B and C each say A is a knight.
What are they? -/
def answer_13 : Answer ["A", "B", "C"] :=
sorry

theorem puzzle_13 (A B C : Islander)
    (hA : Says A (¬(role B = .knight ∧ role C = .knight)))
    (hB : Says B (role A = .knight)) (hC : Says C (role A = .knight)) :
    claim% answer_13 [A, B, C] :=
sorry


/-- 14. A says B being a knight implies C is a knave; B says C being a knight
implies A is a knight; C says A is a knave.  What are they? -/
def answer_14 : Answer ["A", "B", "C"] :=
sorry

theorem puzzle_14 (A B C : Islander)
    (hA : Says A (role B = .knight → role C = .knave))
    (hB : Says B (role C = .knight → role A = .knight))
    (hC : Says C (role A = .knave)) :
    claim% answer_14 [A, B, C] :=
sorry


/-- 15. A says B and C differ; B says C is a knight; C says A is a knave.
What are they? -/
def answer_15 : Answer ["A", "B", "C"] :=
sorry

theorem puzzle_15 (A B C : Islander)
    (hA : Says A (role B ≠ role C)) (hB : Says B (role C = .knight))
    (hC : Says C (role A = .knave)) :
    claim% answer_15 [A, B, C] :=
sorry


/-- 16. A says B and C are knights; B says A is a knave or C is a knight; C
says B is a knave.  What are they? -/
def answer_16 : Answer ["A", "B", "C"] :=
sorry

theorem puzzle_16 (A B C : Islander)
    (hA : Says A (role B = .knight ∧ role C = .knight))
    (hB : Says B (role A = .knave ∨ role C = .knight))
    (hC : Says C (role B = .knave)) :
    claim% answer_16 [A, B, C] :=
sorry


/-! ## Reported speech

`Says C (Says A s)` records that C said “A said `s`.” -/

/-- 17. A says B is a knight.  C says “A said that B is a knave.”  What is C? -/
def answer_17 : Answer ["C"] :=
sorry

theorem puzzle_17 (A B C : Islander)
    (hA : Says A (role B = .knight)) (hC : Says C (Says A (role B = .knave))) :
    claim% answer_17 [C] :=
sorry


/-- 18. You do not catch what A says.  B says “A said he is a knave.”  C says
B is lying.  What are B and C? -/
def answer_18 : Answer ["B", "C"] :=
sorry

theorem puzzle_18 (A B C : Islander)
    (hB : Says B (Says A (role A = .knave))) (hC : Says C (role B = .knave)) :
    claim% answer_18 [B, C] :=
sorry


/-! ## Treasure

`L` and `R` mean that the left and the right door lead to the treasure.
Exactly one of them does. -/

/-- 19. A says the left door leads to the treasure; B says the right door does
not.  Show that A and B are the same kind. -/
theorem puzzle_19 (A B : Islander) (L R : Prop)
    (hA : Says A L) (hB : Says B (¬R)) (hOne : L ↔ ¬R) : role A = role B :=
sorry

/-- 20. A says the left door leads to the treasure; B says the right door does.
Show that A and B are different kinds. -/
theorem puzzle_20 (A B : Islander) (L R : Prop)
    (hA : Says A L) (hB : Says B R) (hOne : L ↔ ¬R) : role A ≠ role B :=
sorry

/-! ## Quantifiers

Statements about everyone quantify over `Islander`; `P : α → Prop` is a
property of the visitors to the island. -/

/-- 21. A says everyone on the island is a knight; B says A is a knave.  What
are they? -/
def answer_21 : Answer ["A", "B"] :=
sorry

theorem puzzle_21 (A B : Islander)
    (hA : Says A (∀ x, role x = .knight)) (hB : Says B (role A = .knave)) :
    claim% answer_21 [A, B] :=
sorry

/-- 22. A says someone on the island is a knight; B says A is a knave.  What
are they? -/
def answer_22 : Answer ["A", "B"] :=
sorry

theorem puzzle_22 (A B : Islander)
    (hA : Says A (∃ x, role x = .knight)) (hB : Says B (role A = .knave)) :
    claim% answer_22 [A, B] :=
sorry

/-- 23. A says every visitor has `P`; B says some visitor lacks `P`.  Show that
A and B are different kinds. -/
theorem puzzle_23 {α : Type} (A B : Islander) (P : α → Prop)
    (hA : Says A (∀ x, P x)) (hB : Says B (∃ x, ¬P x)) : role A ≠ role B :=
sorry

/-- 24. A says every visitor has `P`; B says A is a knave; C says B is a knave.
Show that if some visitor lacks `P`, then C is a knave. -/
theorem puzzle_24 {α : Type} (A B C : Islander) (P : α → Prop)
    (hA : Says A (∀ x, P x)) (hB : Says B (role A = .knave)) (hC : Says C (role B = .knave))
    (h : ∃ x, ¬P x) : role C = .knave :=
sorry

/-- 25. A says everyone on the island is a knave.  Show that there is a
knight. -/
theorem puzzle_25 (A : Islander) (hA : Says A (∀ x, role x = .knave)) :
    ∃ x, role x = .knight :=
sorry

/-! ## Smullyan's problems

Direct adaptations of numbered problems from the “Knights and Knaves” chapter
of *What Is the Name of This Book?*. -/

/-- Smullyan 28. A says “At least one of us is a knave.”  What are A and B? -/
def answer_smullyan_28 : Answer ["A", "B"] :=
sorry

theorem smullyan_28 (A B : Islander) (hA : Says A (role A = .knave ∨ role B = .knave)) :
    claim% answer_smullyan_28 [A, B] :=
sorry


/-- Smullyan 29. A says “I am a knave or B is a knight.”  What are A and B? -/
def answer_smullyan_29 : Answer ["A", "B"] :=
sorry

theorem smullyan_29 (A B : Islander) (hA : Says A (role A = .knave ∨ role B = .knight)) :
    claim% answer_smullyan_29 [A, B] :=
sorry


/-- Smullyan 30. A says “I am a knave or two plus two is five.”  What is A? -/
def answer_smullyan_30 : Answer ["A"] :=
sorry

theorem smullyan_30 (A : Islander) (hA : Says A (role A = .knave ∨ 2 + 2 = 5)) :
    claim% answer_smullyan_30 [A] :=
sorry


/-- Smullyan 31. A says all three are knaves; B says exactly one of the three
is a knight.  What are they? -/
def answer_smullyan_31 : Answer ["A", "B", "C"] :=
sorry

theorem smullyan_31 (A B C : Islander)
    (hA : Says A (role A = .knave ∧ role B = .knave ∧ role C = .knave))
    (hB : Says B ((role A = .knight ∧ role B = .knave ∧ role C = .knave) ∨
      (role A = .knave ∧ role B = .knight ∧ role C = .knave) ∨
      (role A = .knave ∧ role B = .knave ∧ role C = .knight))) :
    claim% answer_smullyan_31 [A, B, C] :=
sorry


/-- Smullyan 32. A says all three are knaves; B says exactly one of the three
is a knave.  What are A and C? -/
def answer_smullyan_32 : Answer ["A", "C"] :=
sorry

theorem smullyan_32 (A B C : Islander)
    (hA : Says A (role A = .knave ∧ role B = .knave ∧ role C = .knave))
    (hB : Says B ((role A = .knave ∧ role B = .knight ∧ role C = .knight) ∨
      (role A = .knight ∧ role B = .knave ∧ role C = .knight) ∨
      (role A = .knight ∧ role B = .knight ∧ role C = .knave))) :
    claim% answer_smullyan_32 [A, C] :=
sorry


/-- Smullyan 33. A says “I am a knave, but B is not.”  What are A and B? -/
def answer_smullyan_33 : Answer ["A", "B"] :=
sorry

theorem smullyan_33 (A B : Islander) (hA : Says A (role A = .knave ∧ role B = .knight)) :
    claim% answer_smullyan_33 [A, B] :=
sorry


/-- Smullyan 34. A says B is a knave; B says A and C are the same kind.
What is C? -/
def answer_smullyan_34 : Answer ["C"] :=
sorry

theorem smullyan_34 (A B C : Islander)
    (hA : Says A (role B = .knave)) (hB : Says B (role A = role C)) :
    claim% answer_smullyan_34 [C] :=
sorry


/-! ## Questions and answers

An islander asked a yes-or-no question answers yes exactly when they would
assert the queried statement: `Yes ↔ Says C s` records C's answer to “is `s`
true?”. -/

/-- Smullyan 35. A says B and C are the same kind.  C is asked whether A and B
are the same kind.  Show that C answers yes. -/
theorem smullyan_35 (A B C : Islander) (Yes : Prop)
    (hA : Says A (role B = role C)) (hYes : Yes ↔ Says C (role A = role B)) : Yes :=
sorry


/-- Smullyan 37. A is asked whether B is a knight and B is asked whether A is
a knight.  Show that they give the same answer. -/
theorem smullyan_37 (A B : Islander) (YesA YesB : Prop)
    (hYesA : YesA ↔ Says A (role B = .knight)) (hYesB : YesB ↔ Says B (role A = .knight)) :
    YesA ↔ YesB :=
sorry

/-- Smullyan 36. A is asked “is at least one of you a knight?” and answers
`AnswerYes`.  You are told that the answer lets you work out what both A and B
are, which `hUnique` records: any pair of roles `x, y` consistent with the
observed answer is the actual one.  What are A and B? -/
def answer_smullyan_36 : Answer ["A", "B"] :=
sorry

theorem smullyan_36 (A B : Islander) (AnswerYes : Prop)
    (hUnique : ∀ x y : Role,
      (AnswerYes ↔ (x = .knight ↔ (x = .knight ∨ y = .knight))) → x = role A ∧ y = role B) :
    claim% answer_smullyan_36 [A, B] :=
sorry


end Puzzles

end Cyprus.Day1Seminar
