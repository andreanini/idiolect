# content masking works

    Code
      contentmask(enron.small, algorithm = "POSnoise")
    Message
      successfully initialized (spaCy Version: 3.7.4, language model: en_core_web_sm)
    Output
      Corpus consisting of 3 documents and 2 docvars.
      allen-p_16.txt :
      "P , the J N is having a J N V with the D N that is to be V a..."
      
      allen-p_37.txt :
      "P , P P V B the N N for two N while P P was on a J leave . s..."
      
      bass-e_195.txt :
      "P , i work for P P on the P P P P and he has some N on P " P..."
      

---

    Code
      contentmask(enron.small, algorithm = "frames")
    Message
      successfully initialized (spaCy Version: 3.7.4, language model: en_core_web_sm)
    Output
      Corpus consisting of 3 documents and 2 docvars.
      allen-p_16.txt :
      "NNP , the back NN VBZ VBG a hard NN VBG with the CD NNS that..."
      
      allen-p_37.txt :
      "NNP , NNP NNP VBD together the NN NN for CD NNS while NNP NN..."
      
      bass-e_195.txt :
      "NNP , PRP VBP for NNP NNP on the NNP NNP NNP NNP and PRP VBZ..."
      

---

    Code
      contentmask(toy.corpus, algorithm = "POSnoise")
    Message
      successfully initialized (spaCy Version: 3.7.4, language model: en_core_web_sm)
    Output
      Corpus consisting of 1 document.
      text1 :
      "the N was on the N . he did n't move   N ;   N N"
      

---

    Code
      contentmask(toy.corpus, algorithm = "POSnoise", replace_non_ascii = F)
    Message
      successfully initialized (spaCy Version: 3.7.4, language model: en_core_web_sm)
    Output
      Corpus consisting of 2 documents.
      text1 :
      "the N was on the N . he did n't move   N ;   N N P 👍"
      
      text2 :
      "D 👍"
      

