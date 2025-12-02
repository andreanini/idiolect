# tokenize_sents works

    Code
      tokenize_sents(toy)
    Message
      spaCy is already initialized
    Output
      Tokens consisting of 1 document.
      text1 :
      [1] "The cat was on the chair."      "He didn't move"                
      [3] "cat@pets.com;"                  "http://quanteda.io/ test 😻 👍"
      

---

    Code
      tokenize_sents(toy.pos)
    Message
      successfully initialized (spaCy Version: 3.8.7, language model: en_core_web_sm)
    Output
      Tokens consisting of 1 document.
      text1 :
      [1] "the N was on the N ." "he did n't move"      "N ;"                 
      [4] "N N"                 
      

