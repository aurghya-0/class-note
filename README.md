# class-note 📝

A clean, modern, and rich academic lecture note template for [Typst](https://typst.app/). Designed for students, researchers, and educators who want structured, beautifully formatted notes with built-in support for mathematical environments, callouts, questions and answers, and code blocks.

---

## ✨ Features

- 🎨 **Hero Card & Header Banner**: Elegant document header with customizable title, subtitle, faculty, course code, department, semester, and date.
- 📐 **Theorem & Math Environments**: Built-in support for `#theorem`, `#lemma`, `#proposition`, `#corollary`, `#definition`, `#example`, and `#proof` (with auto Q.E.D. $square$ symbol).
- 💬 **Rich Callouts**: Built-in callout cards for `#callout(type: "info" | "tip" | "warning" | "important" | "note")` as well as legacy custom background colors.
- ❓ **Question & Answer Cards**: Structured `#question` blocks with optional point badges and answers, plus `#qna` helper lists for quick self-assessments.
- 📌 **Key Takeaways & TODOs**: `#keypoint` boxes for highlighting core concepts and inline `#todo` badges for lecture note action items.
- 💻 **Syntax Highlighted Code & Styled Tables**: Modern block & inline raw code styling and automatic alternating-row table styling.
- 📄 **Clean Headers & Footers**: Automatic page numbering, subject running header on pages after the first page, and document title running footer.

---

## 🚀 Quick Start

Import `classnotes.typ` into your document:

```typst
#import "classnotes.typ": *

#show: classnote.with(
  title: "Arrays and Functions",
  subtitle: "Discussing Arrays and Functions through Code Snippets",
  faculty: "Dr. A. Sharma",
  semester: 2,
  dept_short: "CSE",
  subject: "Programming for Problem Solving",
  code: "ESCS201",
  date: "August 3, 2026",
  accent: rgb("#1e3a8a"),
)

= 1. Introduction

#definition(term: "Array")[
  An array is a contiguous block of memory holding homogenous elements.
]

#callout(type: "tip", title: "Pro Tip")[
  Remember that array indexing is 0-based in C/C++/Java/Python.
]

#theorem(title: "Linear Search Time Complexity")[
  Searching an un-sorted array of size $N$ takes $O(N)$ comparisons in the worst case.
]

#proof[
  The target element may be at index $N-1$ or not present at all.
]

#question(
  [What is the spatial complexity of static array allocation?],
  answer: [$O(1)$ auxiliary space beyond the allocated memory block.],
  points: 5
)
```

---

## 📑 Component Reference

### 1. Main Document Template (`#classnote`)

| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `title` | `str` | `""` | Document main title |
| `subtitle` | `str` | `""` | Optional subtitle or topic description |
| `faculty` | `str` | `""` | Instructor / Professor name |
| `semester` | `str` / `int` | `""` | Semester number or label |
| `dept_short` | `str` | `""` | Department abbreviation (e.g. `"CSE"`) |
| `dept` | `str` | `""` | Full department name |
| `subject` | `str` | `""` | Course / Subject name |
| `code` | `str` | `""` | Course code (e.g. `"ESCS201"`) |
| `date` | `str` / `content` | `""` | Lecture date |
| `accent` | `color` / `str` | `rgb("#1e3a8a")` | Primary theme accent color |
| `paper` | `str` | `"a4"` | Paper size |
| `font` | `array` / `str` | `("DejaVu Sans", ...)` | Font family fallback list |

---

### 2. Theorems & Proofs

```typst
#theorem(title: "Theorem Name")[ Theorem statement... ]
#lemma(title: "Lemma Name")[ Lemma statement... ]
#proposition(title: "Proposition Name")[ Proposition statement... ]
#corollary(title: "Corollary Name")[ Corollary statement... ]
#definition(term: "Term Name")[ Definition statement... ]
#example(title: "Example Title")[ Example description... ]
#proof[ Proof steps... ]
```

---

### 3. Callouts & Notes

```typst
#callout(type: "info", title: "Information")[ ... ]
#callout(type: "tip", title: "Pro Tip")[ ... ]
#callout(type: "warning", title: "Caution")[ ... ]
#callout(type: "important", title: "Critical")[ ... ]
#callout(type: "note", title: "Note")[ ... ]

// Custom background & stroke callout (backward compatible):
#callout("#ace6e2", [ Custom colored callout body ], head: "Custom Header")
```

---

### 4. Questions & Answers

```typst
// Single question card with points badge and answer
#question(
  [What is the time complexity of Binary Search?],
  answer: [$O(\log N)$],
  points: 5
)

// Q&A List helper
#qna(items: (
  (
    question: "What is an array?",
    answer: "A contiguous memory block of homogenous elements."
  ),
  (
    question: "What is a pointer?",
    answer: "A variable that stores the memory address of another variable."
  )
))
```

---

### 5. Key Points & Action Items

```typst
#keypoint[ Key formula or core takeaway to remember! ]
#todo("Complete problem set #3 before next lecture")
```

---

## 🛠 Compilation

To compile your notes into a PDF using the Typst CLI:

```bash
typst compile main.typ output.pdf
```

To enable live re-compilation on file save:

```bash
typst watch main.typ output.pdf
```

---

## 📄 License

This template is licensed under the [MIT-0 License](LICENSE).
