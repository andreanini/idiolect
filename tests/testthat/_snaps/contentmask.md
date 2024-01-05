# content masking works

    Code
      contentmask(enron.small, algorithm = "POSnoise", replace_non_ascii = F)
    Message <simpleMessage>
      successfully initialized (spaCy Version: 3.7.1, language model: en_core_web_sm)
    Output
      Corpus consisting of 1 document and 2 docvars.
      allen-p_16.txt :
      "P , the J N is having a J N V with the D N that is to be V a..."
      

---

    Code
      contentmask(enron.small, algorithm = "frames", replace_non_ascii = F)
    Message <simpleMessage>
      successfully initialized (spaCy Version: 3.7.1, language model: en_core_web_sm)
    Output
      Corpus consisting of 1 document and 2 docvars.
      allen-p_16.txt :
      "NNP , the back NN VBZ VBG a hard NN VBG with the CD NNS that..."
      

