# Cyprus workshop sources

## Read source

Raymond Smullyan, *What Is the Name of This Book?*, chapter “Knights and
Knaves”, Internet Archive scan and OCR:

- https://archive.org/details/WhatIsTheNameOfThisBook
- https://archive.org/download/WhatIsTheNameOfThisBook/What-is-the-Name-of-this-Book_djvu.txt

## Status and map

`puzzle_01` through `puzzle_25` are original workshop exercises. They use the
Smullyan knight/knave convention but are not presented as adaptations of a
specific source problem.

The declarations below are direct formal adaptations of numbered problems in
the cited chapter. Names preserve the source locator; a puzzle whose question
is who is what also has an `answer_` declaration of the same name.

| Declaration | Source problem | Formalization note |
| --- | --- | --- |
| `smullyan_28` | 28 | A’s at-least-one-knave statement. |
| `smullyan_29` | 29 | A’s disjunctive self-reference. |
| `smullyan_30` | 30 | The false arithmetic disjunct is `False`. |
| `smullyan_31` | 31 | All-knaves and exactly-one-knight claims. |
| `smullyan_32` | 32 | All-knaves and exactly-one-knave claims; B is undetermined, so the answer covers A and C. |
| `smullyan_33` | 33 | A’s conjunction about A and B. |
| `smullyan_34` | 34 | A’s and B’s same-kind statements; the answer covers C. |
| `smullyan_35` | 35 | `Yes` records C’s answer to the stated question. |
| `smullyan_36` | 36 | `AnswerYes` and uniqueness formalize the observed answer. |
| `smullyan_37` | 37 | Two observed answers are modeled separately. |

All puzzles are in `Cyprus/Day1Seminar.lean`. Staff-only witnesses and
no-model checks are in `DROP` regions. Student answers and proof bodies use
`TO_SORRY` and `SORRY_END`.
