# content masking works

    Code
      contentmask(enron.parsed, algorithm = "POSnoise")
    Output
      Corpus consisting of 6 documents and 1 docvar.
      allen-p_16.txt :
      "P , the J N is having a J N V with the D N that is to be V a..."
      
      allen-p_37.txt :
      "P , P P V B the N N for two N while P P was on a J leave . s..."
      
      bass-e_195.txt :
      "P , i work for P P on the P P P P and he has some N on P " P..."
      
      bass-e_308.txt :
      "N to V with P at N P D , by P P P P P despite the V N of the..."
      
      mcvicker-m_8.txt :
      "want to have N ? want to get on a N show ? want to help N ? ..."
      
      mcvicker-m_9.txt :
      "P P will be V a N for P P P P and other N N on P , P N from ..."
      

---

    Code
      contentmask(enron.parsed, algorithm = "framenoise")
    Output
      Corpus consisting of 6 documents and 1 docvar.
      allen-p_16.txt :
      "P , the back N is V a hard N V with the D N that is to be V ..."
      
      allen-p_37.txt :
      "P , P P V together the N N for D N while P P was on a person..."
      
      bass-e_195.txt :
      "P , i V for P P on the P P P P and he V some N on P " P P " ..."
      
      bass-e_308.txt :
      "N to V with P at N P D , by P P P P P despite the V N of the..."
      
      mcvicker-m_8.txt :
      "V to V N ? V to V on a N N ? V to V N ? N you will V an N th..."
      
      mcvicker-m_9.txt :
      "P P will be V a N for P P P P and other N N on P , P N from ..."
      

