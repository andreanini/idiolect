# tokenize_sents works

    Code
      suppressMessages(tokenize_sents(toy))
    Output
      Tokens consisting of 1 document.
      text1 :
      [1] "The cat was on the chair."      "He didn't move"                
      [3] "cat@pets.com;"                  "http://quanteda.io/ test 😻 👍"
      

---

    Code
      suppressMessages(tokenize_sents(toy.pos))
    Output
      Tokens consisting of 1 document.
      text1 :
      [1] "the N was on the N ." "he did n't move"      "N ;"                 
      [4] "N N"                 
      

