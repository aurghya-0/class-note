#let classnote(
  title: "",
  subtitle: "",
  faculty: "",
  semester: "",
  dept_short: "",
  subject: "",
  code: "",
  date: "",
  body
) = {
  set document(author: faculty, title: title)
  set page(
    paper: "a4",
    header: [
      #grid(
        columns: (1fr, 1fr),
        
        [
          #if dept_short != "" {
            smallcaps[Department of #dept_short]
          }
          \
          #if semester == "" {
            [Class Notes]
          } else {
            [Semester #semester Class Notes]
          }
        ],
        [
          #align(right)[
            #code\
            #subject
          ]
        ], 
      )
    ],
    footer: [
      #grid(
        columns: (1fr, 1fr, 1fr),
        [#align(left)[#smallcaps[#title]]],
        [#align(center)[#context counter(page).display()]],
        [#align(right)[#date]]
      )
    ]
  )
  
  set par(justify: true)
  counter(page).update(1)
  set page(
    numbering: "1", 
    number-align: center,
  )
  box(width: 1fr, fill: navy, inset: 10pt, [ 
    #align(center)[
    #text(title, weight: "bold", size: 18pt, white)\
    #v(1pt)
    #text(subtitle, style: "italic", white)
  ]])
  body
}

#let callout(bg, body, head: "") = [
  #box(width: 1fr, fill: rgb(bg), radius: 8pt, stroke: black, inset: 16pt, [
    #if head != "" {
      align(center)[#text(size: 14pt, weight: "bold", [#smallcaps[#head]])]
      line(length: 100%)
    }
    #text(style: "italic", size: 14pt, body)
  ])
]

#let definition(body, topic: "") = [
   #box(width: 1fr, fill: rgb("#e6acac"), radius: 8pt, inset: 16pt, [
    #if topic != "" {
      align(center)[#text(size: 14pt, weight: "bold", [#smallcaps[#topic]])]
      line(length: 100%)
    }
    #text(style: "normal", weight: "bold", size: 12pt, "Definition: ")
    #text(style: "italic", size: 12pt, body)
  ])
]

#let qna(items: array) = [
  #for (item, i) in items {
    block(
      fill: luma(240),
      padding: 8pt,
      radius: 6pt,
      spacing: 6pt,
      [
        #text(bold, "Q", i + 1, ": ", item.question)
        #text(italic, "A: ", item.answer)
      ]
    )
    par()
  }
]
#let c = counter("questions")
#let question(it, answer: "", reset: false) = block[
  #if reset {
    c.update(c => 0)
  }
  #c.step()
  *#context c.display().*
  #emph[#it]
  #if answer != "" {
    [
      \
      *Answer #context c.display():*\
      #answer
    ]
  }
]