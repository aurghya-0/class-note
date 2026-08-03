// Class Note Typst Template
// Clean, modern, and rich academic note-taking template for Typst.

// Internal counters
#let theorem-counter = counter("classnote-theorem")
#let question-counter = counter("classnote-question")
#let example-counter = counter("classnote-example")

// Helper function to safely parse color inputs (strings or color objects)
#let parse-color(c, default: rgb("#1e3a8a")) = {
  if type(c) == color {
    c
  } else if type(c) == str {
    rgb(c)
  } else {
    default
  }
}

// Predefined callout styles
#let callout-styles = (
  info: (
    fill: rgb("#eff6ff"),
    stroke: rgb("#bfdbfe"),
    title-color: rgb("#1e40af"),
    icon: "ℹ"
  ),
  tip: (
    fill: rgb("#f0fdf4"),
    stroke: rgb("#bbf7d0"),
    title-color: rgb("#166534"),
    icon: "💡"
  ),
  warning: (
    fill: rgb("#fffbeb"),
    stroke: rgb("#fde68a"),
    title-color: rgb("#92400e"),
    icon: "⚠️"
  ),
  important: (
    fill: rgb("#fef2f2"),
    stroke: rgb("#fecaca"),
    title-color: rgb("#991b1b"),
    icon: "🚨"
  ),
  note: (
    fill: rgb("#f8fafc"),
    stroke: rgb("#e2e8f0"),
    title-color: rgb("#334155"),
    icon: "📌"
  )
)

// Main template function
#let classnote(
  title: "",
  subtitle: "",
  faculty: "",
  semester: "",
  dept_short: "",
  dept: "",
  subject: "",
  code: "",
  date: "",
  accent: rgb("#1e3a8a"),
  paper: "a4",
  margin: (x: 2cm, y: 2.5cm),
  font: ("DejaVu Sans", "Ubuntu Sans", "Nimbus Sans"),
  body
) = {
  let accent-color = parse-color(accent, default: rgb("#1e3a8a"))
  
  // Document metadata
  set document(
    author: if faculty != "" { (faculty,) } else { () },
    title: title
  )
  
  // Set font family and text settings
  set text(font: font, size: 10.5pt, fill: rgb("#1f2937"))
  set par(justify: true, leading: 0.65em)
  
  // Heading styling
  show heading: it => {
    set text(fill: accent-color, weight: "bold")
    if it.level == 1 {
      v(1.2em)
      block(
        width: 100%,
        stroke: (bottom: 1.5pt + accent-color),
        inset: (bottom: 0.4em),
        [#it.body]
      )
      v(0.6em)
    } else if it.level == 2 {
      v(1em)
      [#it.body]
      v(0.4em)
    } else {
      v(0.8em)
      [#it.body]
      v(0.3em)
    }
  }

  // Code block styling
  show raw.where(block: true): it => {
    block(
      width: 100%,
      fill: rgb("#f8fafc"),
      stroke: 1pt + rgb("#e2e8f0"),
      radius: 6pt,
      inset: 10pt,
      outset: 0pt,
      [
        #set text(font: ("DejaVu Sans Mono", "Ubuntu Mono", "Noto Sans Mono"), size: 9pt)
        #it
      ]
    )
  }

  // Inline code styling
  show raw.where(block: false): it => {
    box(
      fill: rgb("#f1f5f9"),
      radius: 3pt,
      inset: (x: 4pt, y: 2pt),
      outset: 0pt,
      text(font: ("DejaVu Sans Mono", "Ubuntu Mono", "Noto Sans Mono"), size: 9pt, fill: rgb("#0f172a"), it)
    )
  }

  // Table styling
  show table: set table(
    stroke: 0.5pt + rgb("#cbd5e1"),
    fill: (x, y) => if y == 0 { accent-color.lighten(90%) } else if calc.odd(y) { rgb("#f8fafc") } else { none }
  )

  // Page layout
  set page(
    paper: paper,
    margin: margin,
    header: context {
      let page-num = counter(page).get().first()
      if page-num > 1 [
        #grid(
          columns: (1fr, 1fr),
          align: (left, right),
          [
            #text(size: 8.5pt, fill: rgb("#64748b"), weight: "medium")[
              #if dept_short != "" [#smallcaps[Dept. of #dept_short] • ]
              #if subject != "" [#subject]
              #if code != "" [ (#code)]
            ]
          ],
          [
            #text(size: 8.5pt, fill: rgb("#64748b"), weight: "medium")[
              #if semester != "" [Semester #semester ] else [Class Notes]
            ]
          ]
        )
        #v(-4pt)
        #line(length: 100%, stroke: 0.5pt + rgb("#cbd5e1"))
      ]
    },
    footer: context {
      grid(
        columns: (1fr, 1fr, 1fr),
        align: (left, center, right),
        [#text(size: 8.5pt, fill: rgb("#64748b"))[#smallcaps[#title]]],
        [#text(size: 8.5pt, fill: rgb("#475569"), weight: "bold")[#counter(page).display()]],
        [#text(size: 8.5pt, fill: rgb("#64748b"))[#date]]
      )
    }
  )

  // Title Banner / Hero Card
  block(
    width: 100%,
    fill: accent-color,
    radius: 8pt,
    inset: (x: 18pt, y: 16pt),
    [
      #align(center)[
        #text(title, weight: "bold", size: 20pt, fill: white)
        #if subtitle != "" [
          #v(4pt)
          #text(subtitle, style: "italic", size: 11pt, fill: white.darken(10%))
        ]
      ]
      
      #let meta-items = ()
      #if subject != "" { meta-items.push([*Subject:* #subject #if code != "" [(#code)]]) }
      #if semester != "" { meta-items.push([*Semester:* #semester]) }
      #if dept != "" { meta-items.push([*Department:* #dept]) } else if dept_short != "" { meta-items.push([*Dept:* #dept_short]) }
      #if faculty != "" { meta-items.push([*Faculty:* #faculty]) }
      #if date != "" { meta-items.push([*Date:* #date]) }

      #if meta-items.len() > 0 [
        #v(10pt)
        #line(length: 100%, stroke: 0.5pt + white.transparentize(60%))
        #v(6pt)
        #align(center)[
          #text(size: 9.5pt, fill: white.darken(5%))[
            #meta-items.join([ #h(8pt) • #h(8pt) ])
          ]
        ]
      ]
    ]
  )

  v(12pt)
  body
}

// Flexible Callout function supporting both positional (legacy) and named parameters
#let callout(
  ..args,
  title: "",
  head: "",
  type: "info",
  icon: none,
  fill: none,
  stroke: none
) = {
  let pos = args.pos()
  let body = []
  let custom-fill = fill
  
  if pos.len() == 1 {
    body = pos.at(0)
  } else if pos.len() >= 2 {
    custom-fill = pos.at(0)
    body = pos.at(1)
  }
  
  let header-title = if title != "" { title } else { head }
  let style = callout-styles.at(type, default: callout-styles.info)
  
  let bg-color = if custom-fill != none { parse-color(custom-fill) } else { style.fill }
  let border-color = if stroke != none { parse-color(stroke) } else if custom-fill != none { parse-color(custom-fill).darken(20%) } else { style.stroke }
  let icon-text = if icon != none { icon } else { style.icon }

  block(
    width: 100%,
    fill: bg-color,
    stroke: (left: 4pt + border-color, rest: 1pt + border-color.lighten(40%)),
    radius: (right: 6pt),
    inset: (x: 12pt, y: 10pt),
    above: 0.8em,
    below: 0.8em,
    [
      #grid(
        columns: (auto, 1fr),
        gutter: 8pt,
        align: (left + top, left),
        [#text(size: 12pt)[#icon-text]],
        [
          #if header-title != "" [
            #text(weight: "bold", size: 10.5pt, fill: style.title-color)[#header-title]
            #v(2pt)
          ]
          #text(size: 10pt)[#body]
        ]
      )
    ]
  )
}

// Definition block
#let definition(
  body,
  term: "",
  topic: "",
  fill: rgb("#f0fdf4"),
  stroke: rgb("#86efac")
) = {
  let title-text = if term != "" { term } else { topic }
  let fill-color = parse-color(fill)
  let stroke-color = parse-color(stroke)

  block(
    width: 100%,
    fill: fill-color,
    stroke: (left: 4pt + stroke-color.darken(20%), rest: 1pt + stroke-color),
    radius: (right: 6pt),
    inset: (x: 12pt, y: 10pt),
    above: 0.8em,
    below: 0.8em,
    [
      #text(weight: "bold", size: 10.5pt, fill: stroke-color.darken(40%))[
        Definition#if title-text != "" [ (#title-text)]:
      ]
      #v(2pt)
      #text(style: "italic", size: 10pt)[#body]
    ]
  )
}

// Theorem block
#let theorem(
  body,
  title: "",
  reset: false,
  fill: rgb("#eff6ff"),
  stroke: rgb("#93c5fd")
) = [
  #if reset { theorem-counter.update(0) }
  #theorem-counter.step()
  #let fill-color = parse-color(fill)
  #let stroke-color = parse-color(stroke)
  #block(
    width: 100%,
    fill: fill-color,
    stroke: (left: 4pt + stroke-color.darken(20%), rest: 1pt + stroke-color),
    radius: (right: 6pt),
    inset: (x: 12pt, y: 10pt),
    above: 0.8em,
    below: 0.8em,
    [
      #text(weight: "bold", size: 10.5pt, fill: stroke-color.darken(40%))[
        Theorem #context theorem-counter.display()#if title != "" [ (#title)]:
      ]
      #v(2pt)
      #text(style: "italic", size: 10pt)[#body]
    ]
  )
]

// Lemma block
#let lemma(
  body,
  title: "",
  fill: rgb("#f5f3ff"),
  stroke: rgb("#c4b5fd")
) = {
  let fill-color = parse-color(fill)
  let stroke-color = parse-color(stroke)
  block(
    width: 100%,
    fill: fill-color,
    stroke: (left: 4pt + stroke-color.darken(20%), rest: 1pt + stroke-color),
    radius: (right: 6pt),
    inset: (x: 12pt, y: 10pt),
    above: 0.8em,
    below: 0.8em,
    [
      #text(weight: "bold", size: 10.5pt, fill: stroke-color.darken(40%))[
        Lemma#if title != "" [ (#title)]:
      ]
      #v(2pt)
      #text(style: "italic", size: 10pt)[#body]
    ]
  )
}

// Corollary block
#let corollary(
  body,
  title: "",
  fill: rgb("#f8fafc"),
  stroke: rgb("#cbd5e1")
) = {
  let fill-color = parse-color(fill)
  let stroke-color = parse-color(stroke)
  block(
    width: 100%,
    fill: fill-color,
    stroke: (left: 4pt + stroke-color.darken(20%), rest: 1pt + stroke-color),
    radius: (right: 6pt),
    inset: (x: 12pt, y: 10pt),
    above: 0.8em,
    below: 0.8em,
    [
      #text(weight: "bold", size: 10.5pt, fill: stroke-color.darken(40%))[
        Corollary#if title != "" [ (#title)]:
      ]
      #v(2pt)
      #text(style: "italic", size: 10pt)[#body]
    ]
  )
}

// Proposition block
#let proposition(
  body,
  title: "",
  fill: rgb("#f0fdfa"),
  stroke: rgb("#99f6e4")
) = {
  let fill-color = parse-color(fill)
  let stroke-color = parse-color(stroke)
  block(
    width: 100%,
    fill: fill-color,
    stroke: (left: 4pt + stroke-color.darken(20%), rest: 1pt + stroke-color),
    radius: (right: 6pt),
    inset: (x: 12pt, y: 10pt),
    above: 0.8em,
    below: 0.8em,
    [
      #text(weight: "bold", size: 10.5pt, fill: stroke-color.darken(40%))[
        Proposition#if title != "" [ (#title)]:
      ]
      #v(2pt)
      #text(style: "italic", size: 10pt)[#body]
    ]
  )
}

// Proof block
#let proof(
  body,
  title: "Proof"
) = block(
  width: 100%,
  stroke: (left: 2.5pt + rgb("#94a3b8")),
  inset: (left: 10pt, top: 4pt, bottom: 4pt),
  above: 0.8em,
  below: 0.8em,
  [
    #text(weight: "bold", style: "italic", size: 10pt, fill: rgb("#475569"))[#title:]
    #h(6pt)
    #body
    #align(right)[#text(fill: rgb("#64748b"))[$square$]]
  ]
)

// Example block
#let example(
  body,
  title: "",
  reset: false,
  fill: rgb("#fff7ed"),
  stroke: rgb("#ffedd5")
) = [
  #if reset { example-counter.update(0) }
  #example-counter.step()
  #let fill-color = parse-color(fill)
  #let stroke-color = parse-color(stroke)
  #block(
    width: 100%,
    fill: fill-color,
    stroke: (left: 4pt + rgb("#f97316"), rest: 1pt + stroke-color),
    radius: (right: 6pt),
    inset: (x: 12pt, y: 10pt),
    above: 0.8em,
    below: 0.8em,
    [
      #text(weight: "bold", size: 10.5pt, fill: rgb("#c2410c"))[
        Example #context example-counter.display()#if title != "" [ (#title)]:
      ]
      #v(2pt)
      #text(size: 10pt)[#body]
    ]
  )
]

// Single Question block
#let question(
  body,
  answer: "",
  points: none,
  reset: false,
  fill: rgb("#fafafa"),
  stroke: rgb("#e4e4e7")
) = [
  #if reset { question-counter.update(0) }
  #question-counter.step()
  #let fill-color = parse-color(fill)
  #let stroke-color = parse-color(stroke)
  #block(
    width: 100%,
    fill: fill-color,
    stroke: 1pt + stroke-color,
    radius: 6pt,
    inset: (x: 14pt, y: 12pt),
    above: 0.8em,
    below: 0.8em,
    [
      #grid(
        columns: (1fr, auto),
        align: (left, right),
        [
          #text(weight: "bold", size: 10.5pt, fill: rgb("#09090b"))[
            Question #context question-counter.display()
          ]
        ],
        [
          #if points != none [
            #box(
              fill: rgb("#e0e7ff"),
              radius: 10pt,
              inset: (x: 8pt, y: 3pt),
              text(size: 8.5pt, weight: "bold", fill: rgb("#3730a3"))[#points #if type(points) == int or type(points) == float [pt#if points != 1 [s]]]
            )
          ]
        ]
      )
      #v(4pt)
      #text(size: 10pt)[#body]
      #if answer != "" [
        #v(6pt)
        #line(length: 100%, stroke: 0.5pt + stroke-color)
        #v(4pt)
        #text(weight: "bold", size: 9.5pt, fill: rgb("#27272a"))[Answer:]
        #v(2pt)
        #text(size: 10pt, fill: rgb("#3f3f46"))[#answer]
      ]
    ]
  )
]

// Q&A List helper
#let qna(items: ()) = {
  let item-list = if type(items) == array { items } else { () }
  for (i, item) in item-list.enumerate() [
    #block(
      width: 100%,
      fill: rgb("#f8fafc"),
      stroke: 1pt + rgb("#e2e8f0"),
      radius: 6pt,
      inset: 12pt,
      above: 0.5em,
      below: 0.5em,
      [
        #text(weight: "bold", fill: rgb("#1e293b"))[Q#str(i + 1): #item.at("question", default: "")]
        #if "answer" in item [
          #v(4pt)
          #text(style: "italic", fill: rgb("#475569"))[A: #item.answer]
        ]
      ]
    )
  ]
}

// Key Takeaway banner
#let keypoint(body, title: "Key Takeaway") = [
  #block(
    width: 100%,
    fill: rgb("#fef3c7"),
    stroke: 1pt + rgb("#fde047"),
    radius: 6pt,
    inset: (x: 12pt, y: 10pt),
    above: 0.8em,
    below: 0.8em,
    [
      #text(weight: "bold", size: 10pt, fill: rgb("#854d0e"))[⭐ #title:]
      #h(6pt)
      #text(size: 10pt, fill: rgb("#713f12"))[#body]
    ]
  )
]

// Inline TODO badge
#let todo(body) = [
  #box(
    fill: rgb("#fee2e2"),
    stroke: 0.5pt + rgb("#fca5a5"),
    radius: 4pt,
    inset: (x: 6pt, y: 3pt),
    text(size: 9pt, weight: "bold", fill: rgb("#991b1b"))[📌 TODO: #body]
  )
]