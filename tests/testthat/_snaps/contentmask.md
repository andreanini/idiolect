# content masking works

    Code
      contentmask(enron.small, algorithm = "POSnoise")
    Message
      spaCy is already initialized
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
      successfully initialized (spaCy Version: 3.7.6, language model: en_core_web_sm)
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
      contentmask(enron.small, algorithm = "textdistortion")
    Message
      successfully initialized (spaCy Version: 3.7.6, language model: en_core_web_sm)
    Output
      Corpus consisting of 3 documents and 2 docvars.
      allen-p_16.txt :
      "* , the * * is having a * * * with the * * that is to be * a..."
      
      allen-p_37.txt :
      "* , * * * * the * * for two * while * * was on a * leave . s..."
      
      bass-e_195.txt :
      "* , i work for * * on the * * * * and he has some * on * " *..."
      

---

    Code
      contentmask(toy.corpus, algorithm = "POSnoise")
    Message
      successfully initialized (spaCy Version: 3.7.6, language model: en_core_web_sm)
    Output
      Corpus consisting of 1 document.
      text1 :
      "the N was on the N . he did n't move   N ;   N i.e. a N"
      

---

    Code
      contentmask(toy.corpus, algorithm = "POSnoise", replace_non_ascii = F)
    Message
      successfully initialized (spaCy Version: 3.7.6, language model: en_core_web_sm)
    Output
      Corpus consisting of 2 documents.
      text1 :
      "the N was on the N . he did n't move   N ;   N i.e. a N B 👍"
      
      text2 :
      "D 👍"
      

---

    Code
      contentmask(toy.corpus, algorithm = "textdistortion")
    Message
      successfully initialized (spaCy Version: 3.7.6, language model: en_core_web_sm)
    Output
      Corpus consisting of 1 document.
      text1 :
      "the * was on the * . he did n't move   * ;   * i.e. a *"
      

