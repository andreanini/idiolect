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
      "PROPN , the back NOUN is VERB a hard NOUN VERB with the NUM ..."
      
      allen-p_37.txt :
      "PROPN , PROPN PROPN VERB together the NOUN NOUN for NUM NOUN..."
      
      bass-e_195.txt :
      "PROPN , i VERB for PROPN PROPN on the PROPN PROPN PROPN PROP..."
      

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
      contentmask(toy.corpus, algorithm = "frames")
    Message
      successfully initialized (spaCy Version: 3.7.6, language model: en_core_web_sm)
    Output
      Corpus consisting of 1 document.
      text1 :
      "the NOUN was on the NOUN . he did n't VERB   NOUN ;   NOUN i..."
      

---

    Code
      contentmask(toy.corpus, algorithm = "textdistortion")
    Message
      successfully initialized (spaCy Version: 3.7.6, language model: en_core_web_sm)
    Output
      Corpus consisting of 1 document.
      text1 :
      "the * was on the * . he did n't move   * ;   * i.e. a *"
      

---

    Code
      contentmask(toy.corpus, algorithm = "textdistortion", fw_list = c("the", "on"))
    Message
      successfully initialized (spaCy Version: 3.7.6, language model: en_core_web_sm)
    Output
      Corpus consisting of 1 document.
      text1 :
      "the * * on the * * * * * * * * * * * * * *"
      

---

    Code
      contentmask(toy.corpus, algorithm = "textdistortion", fw_list = "the")
    Message
      successfully initialized (spaCy Version: 3.7.6, language model: en_core_web_sm)
    Output
      Corpus consisting of 1 document.
      text1 :
      "the * * * the * * * * * * * * * * * * * *"
      

