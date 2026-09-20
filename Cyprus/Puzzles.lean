import Mathlib.Tactic

/-!
# Cyprus workshop: knights and knaves

`A : Prop` means “A is a knight”. A hypothesis `A ↔ S` models A saying `S`:
a knight's statement is true and a knave's statement is false. The source map
in `SOURCES.md` identifies each adaptation or original workshop variant.

`Yes` and `AnswerYes` are propositions for an observed yes-answer. A hypothesis
`Yes ↔ statement` records that the answer is yes exactly when the queried
statement holds. Nested biconditionals model a question about a prior answer.
-/

namespace Cyprus.Puzzles

/-- 1. A says: “I am a knave.” (Smullyan self-reference adaptation.) -/
theorem puzzle_01 (A : Prop) (hA : A ↔ ¬ A) : False :=
sorry


/-- 2. A says B is a knight; B says A is a knave. (Two-islander adaptation.) -/
theorem puzzle_02 (A B : Prop) (hA : A ↔ B) (hB : B ↔ ¬ A) : False :=
sorry


/-- 3. A says B is a knave; B says that A and B are different kinds. -/
theorem puzzle_03 (A B : Prop)
    (hA : A ↔ ¬ B) (hB : B ↔ ((A ∧ ¬ B) ∨ (¬ A ∧ B))) : ¬ A ∧ B :=
sorry


/-- 4. A says that at least one of B and C is a knight; B says C is a knave. -/
theorem puzzle_04 (A B C : Prop)
    (hA : A ↔ B ∨ C) (hB : B ↔ ¬ C) : A :=
sorry


/-- 5. A says B and C are the same kind; B says C is a knight. -/
theorem puzzle_05 (A B C : Prop)
    (hA : A ↔ (B ↔ C)) (hB : B ↔ C) : A :=
sorry


/-- 6. A says exactly one of B and C is a knight; B says A is a knight; C says B is a knave. -/
theorem puzzle_06 (A B C : Prop)
    (hA : A ↔ ((B ∧ ¬ C) ∨ (¬ B ∧ C))) (hB : B ↔ A) (hC : C ↔ ¬ B) :
    A ∧ B ∧ ¬ C :=
sorry


/-- 7. A says B and C are both knaves; B and C each say A is a knave. -/
theorem puzzle_07 (A B C : Prop)
    (hA : A ↔ ¬ B ∧ ¬ C) (hB : B ↔ ¬ A) (hC : C ↔ ¬ A) : B ↔ C :=
sorry


/-- 8. A says “if B is a knight, then C is”; B says C is a knave. -/
theorem puzzle_08 (A B C : Prop)
    (hA : A ↔ (B → C)) (hB : B ↔ ¬ C) : A ↔ C :=
sorry


/-- 9. A says B is a knight; B says C is a knight. -/
theorem puzzle_09 (A B C : Prop) (hA : A ↔ B) (hB : B ↔ C) : A ↔ C :=
sorry


/-- 10. A says B and C are the same kind; B says C is a knave. -/
theorem puzzle_10 (A B C : Prop)
    (hA : A ↔ (B ↔ C)) (hB : B ↔ ¬ C) : ¬ A :=
sorry


/-- 11. A says B or C is a knight; B says A is a knave; C says A is a knight. -/
theorem puzzle_11 (A B C : Prop)
    (hA : A ↔ B ∨ C) (hB : B ↔ ¬ A) (hC : C ↔ A) : A ∧ ¬ B ∧ C :=
sorry


/-- 12. A says at least two of B, C, D are knights; B and C say A is a knight; D says A is a knave. -/
theorem puzzle_12 (A B C D : Prop)
    (hA : A ↔ ((B ∧ C) ∨ (B ∧ D) ∨ (C ∧ D)))
    (hB : B ↔ A) (hC : C ↔ A) (hD : D ↔ ¬ A) : B ↔ C :=
sorry


/-- 13. `L` means the left door leads to the treasure and `R` means the right door does. Exactly one door does. A says the left door leads to treasure; B says the right door does not. -/
theorem puzzle_13 (A B L R : Prop)
    (hA : A ↔ L) (hB : B ↔ ¬ R) (hOne : L ↔ ¬ R) : A ↔ B :=
sorry


/-- 14. A says that B being a knight implies C is a knave; B says that C being a knight implies A is a knight; C says A is a knave. -/
theorem puzzle_14 (A B C : Prop)
    (hA : A ↔ (B → ¬ C)) (hB : B ↔ (C → A)) (hC : C ↔ ¬ A) : A ∧ B ∧ ¬ C :=
sorry


/-- 15. `L` and `R` mean that the left and right boxes contain the treasure. Exactly one box does. A identifies the left box; B identifies the right box. -/
theorem puzzle_15 (A B L R : Prop)
    (hA : A ↔ L) (hB : B ↔ R) (hOne : L ↔ ¬ R) : A ↔ ¬ B :=
sorry


/-- 16. A says every visitor has P, but a named visitor lacks P. -/
theorem puzzle_16 {α : Type} (A : Prop) (P : α → Prop)
    (hA : A ↔ ∀ x, P x) (x : α) (hx : ¬ P x) : ¬ A :=
sorry


/-- 17. A says someone has P; B says nobody has P. -/
theorem puzzle_17 {α : Type} (A B : Prop) (P : α → Prop)
    (hA : A ↔ ∃ x, P x) (hB : B ↔ ∀ x, ¬ P x) : A ↔ ¬ B :=
sorry


/-- 18. A says every visitor is a knight; B says some visitor is a knave. -/
theorem puzzle_18 {α : Type} (A B : Prop) (K : α → Prop)
    (hA : A ↔ ∀ x, K x) (hB : B ↔ ∃ x, ¬ K x) : ¬ (A ∧ B) :=
sorry


/-- 19. A says B and C differ; B says C is a knight; C says A is a knave. -/
theorem puzzle_19 (A B C : Prop)
    (hA : A ↔ ((B ∧ ¬ C) ∨ (¬ B ∧ C))) (hB : B ↔ C) (hC : C ↔ ¬ A) :
    ¬ A ∧ B ∧ C :=
sorry


/-- 20. A says B and C are knights; B says A is a knave or C is a knight; C says B is a knave. -/
theorem puzzle_20 (A B C : Prop)
    (hA : A ↔ B ∧ C) (hB : B ↔ ¬ A ∨ C) (hC : C ↔ ¬ B) : ¬ A ∧ B ∧ ¬ C :=
sorry


/-- Smullyan 28. A says: “At least one of us is a knave.” -/
theorem smullyan_28 (A B : Prop) (hA : A ↔ (¬ A ∨ ¬ B)) : A ∧ ¬ B :=
sorry

/-- Smullyan 29. A says: “I am a knave or B is a knight.” -/
theorem smullyan_29 (A B : Prop) (hA : A ↔ (¬ A ∨ B)) : A ∧ B :=
sorry

/-- Smullyan 30. A says: “I am a knave or two plus two equals five.” -/
theorem smullyan_30 (A : Prop) (hA : A ↔ (¬ A ∨ False)) : False :=
sorry

/-- Smullyan 31. A says all three are knaves; B says exactly one is a knight. -/
theorem smullyan_31 (A B C : Prop)
    (hA : A ↔ (¬ A ∧ ¬ B ∧ ¬ C))
    (hB : B ↔ ((A ∧ ¬ B ∧ ¬ C) ∨ (¬ A ∧ B ∧ ¬ C) ∨ (¬ A ∧ ¬ B ∧ C))) :
    ¬ A ∧ B ∧ ¬ C :=
sorry

/-- Smullyan 32. A says all three are knaves; B says exactly one is a knave. -/
theorem smullyan_32 (A B C : Prop)
    (hA : A ↔ (¬ A ∧ ¬ B ∧ ¬ C))
    (hB : B ↔ ((¬ A ∧ B ∧ C) ∨ (A ∧ ¬ B ∧ C) ∨ (A ∧ B ∧ ¬ C))) : ¬ A ∧ C :=
sorry

/-- Smullyan 33. A says: “I am a knave, but B is not.” -/
theorem smullyan_33 (A B : Prop) (hA : A ↔ (¬ A ∧ B)) : ¬ A ∧ ¬ B :=
sorry

/-- Smullyan 34. A says B is a knave; B says A and C are the same kind. -/
theorem smullyan_34 (A B C : Prop) (hA : A ↔ ¬ B) (hB : B ↔ (A ↔ C)) : ¬ C :=
sorry

/-- Smullyan 35. A says B and C are alike; C is asked whether A and B are alike. -/
theorem smullyan_35 (A B C Yes : Prop) (hA : A ↔ (B ↔ C))
    (hAnswer : Yes ↔ (C ↔ (A ↔ B))) : Yes :=
sorry

/-- Smullyan 36. A positive answer to “is either of you a knight?” cannot identify both roles. -/
theorem smullyan_36 (A B AnswerYes : Prop)
    (hObs : AnswerYes ↔ (A ↔ (A ∨ B)))
    (hUnique : ∀ (X Y : Prop),
      (AnswerYes ↔ (X ↔ (X ∨ Y))) → ((X ↔ A) ∧ (Y ↔ B))) :
    ¬ AnswerYes ∧ ¬ A ∧ B :=
sorry

/-- Smullyan 37. Each islander is asked whether the other is a knight. -/
theorem smullyan_37 (A B YesA YesB : Prop)
    (hYesA : YesA ↔ (A ↔ B)) (hYesB : YesB ↔ (B ↔ A)) : YesA ↔ YesB :=
sorry

end Cyprus.Puzzles
