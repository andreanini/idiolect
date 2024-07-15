# content masking works

    Code
      contentmask(enron.small, algorithm = "POSnoise", output = "corpus")
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
      contentmask(enron.small, algorithm = "frames", output = "corpus")
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
      contentmask(enron.small, algorithm = "POSnoise", output = "sentences")
    Message
      successfully initialized (spaCy Version: 3.7.4, language model: en_core_web_sm)
    Output
      Tokens consisting of 3 documents and 2 docvars.
      allen-p_16.txt :
      [1] "P , the J N is having a J N V with the D N that is to be V as N N by the P N then V from the P of the P ."       
      [2] "is your N that the P N will V N each N V on the N below ."                                                       
      [3] "the P of the P V to V N to the P N as V : P P P P P P P may P P P P P P P this N V a N N J to P P P by the P N ."
      [4] "the N N is S D S P on P S P ( P thru P ) and P S P ( D thru P ) ."                                               
      [5] "the P P of the P has V to V the N N for this N ."                                                                
      [6] "let me know if you V ."                                                                                          
      [7] "N"                                                                                                               
      
      allen-p_37.txt :
       [1] "P , P P V B the N N for two N while P P was on a J leave ."                                    
       [2] "she V a J N of N to the P N during that N ."                                                   
       [3] "she frequently came to work before am to V N N ."                                              
       [4] "P worked N a week during this N ."                                                             
       [5] "if J N were not enough , there was a N N during this N which put J N into the N and J N on P ."
       [6] "she did n't V and V much needed N during this N ."                                             
       [7] "P is V the N of a N but being V as a P ."                                                      
       [8] "P ."                                                                                           
       [9] "V on her J N , she V a P ."                                                                    
      [10] "let me know what is an J N N ."                                                                
      [11] "N"                                                                                             
      
      bass-e_195.txt :
      [1] "P , i work for P P on the P P P P and he has some N on P \" P P \" N ."                                                                                         
      [2] "specifically , we V S V N at the P P P and were V the \" P P \" N of the the P V due to N - N , i.e. can we V P P in that N and what N are V for in the P N N ?"
      [3] "additionally , we V S N N at P N N such as P P P and were J about the P P N and N for these N N ."                                                              
      [4] "i do not know if you are the J N to N regarding this N , but if you can V any N i would B V it ."                                                               
      [5] "N in N ."                                                                                                                                                       
      [6] "B , P P P - D"                                                                                                                                                  
      

---

    Code
      contentmask(enron.small, algorithm = "frames", output = "sentences")
    Message
      successfully initialized (spaCy Version: 3.7.4, language model: en_core_web_sm)
    Output
      Tokens consisting of 3 documents and 2 docvars.
      allen-p_16.txt :
      [1] "NNP , the back NN VBZ VBG a hard NN VBG with the CD NNS that VBZ to VB VBN as NN NN by the NNP NN then VBN from the NNP of the NNP ."                                         
      [2] "VBZ PRP$"                                                                                                                                                                     
      [3] "NN that the NNP NN will VB NN each NN VBN on the NN below ."                                                                                                                  
      [4] "the NNP of the NNP VBZ to VB NN to the NNP NN as VBZ : NNP NNP NNP NNP NNP NNP NNP NNP NNP NNP NNP NNP NNP NNP NNP this NN VBZ a NN NN payable to NNP NNP NNP by the NNP NN ."
      [5] "the NN NN VBZ $ CD / NNP on NNP / NNP ( NNP NNP NNP ) and NNP / NNP ( CD thru NNP ) ."                                                                                        
      [6] "the NNP NNP of the NNP VBZ VBN to VB the NN NN for this NN ."                                                                                                                 
      [7] "VB PRP VB if PRP VBP ."                                                                                                                                                       
      [8] "NN"                                                                                                                                                                           
      
      allen-p_37.txt :
       [1] "NNP , NNP NNP VBD together the NN NN for CD NNS while NNP NNP VBD on a personal NN ."                              
       [2] "PRP VBD a tremendous NN of NN to the NNP NN during that NN ."                                                      
       [3] "PRP frequently VBD to NN before NNP to VB NNS NNS ."                                                               
       [4] "NNP VBD NNS a NN during this NN ."                                                                                 
       [5] "if long NNS VBD not enough , there VBD a NN NN during this NN which VBD extra NN into the NN and extra NN on NNP ."
       [6] "PRP VBD n't VB and VBD much VBN NN during this NN ."                                                               
       [7] "NNP VBZ VBG the NNS of a NN but VBG VBN as a NNP ."                                                                
       [8] "NNP ."                                                                                                             
       [9] "VBN on PRP$ heroic NNS , PRP VBZ a NNP ."                                                                          
      [10] "VB PRP VB what VBZ an acceptable NN NN ."                                                                          
      [11] "NN"                                                                                                                
      
      bass-e_195.txt :
      [1] "NNP , PRP VBP for NNP NNP on the NNP NNP NNP NNP and PRP VBZ some NNS on NNP \" NNP NNP \" NN ."                                                                                                        
      [2] "specifically , PRP VBP / VB NN at the NNP NNP NNP and VBD VBG the \" NNP NNP \" NNS of the the NNP VBG due to NN - NNS , i.e. can PRP VB NNP NNP in that NN and what NNS VBP VBN for in the NNP NN NN ?"
      [3] "additionally , PRP VBP / NN NN at NNP NN NNS such as NNP NNP NNP and VBD curious about the NNP NNP NNS and NNS for these NN NNS ."                                                                      
      [4] "PRP VBP not VB if PRP VBP the right NN to NN VBG this NN , but if PRP can VB any NN PRP would greatly VB PRP ."                                                                                         
      [5] "NNS in NN ."                                                                                                                                                                                            
      [6] "sincerely , NNP NNP NNP - CD"                                                                                                                                                                           
      

---

    Code
      contentmask(toy.corpus, algorithm = "POSnoise")
    Message
      successfully initialized (spaCy Version: 3.7.4, language model: en_core_web_sm)
    Output
      Corpus consisting of 1 document.
      text1 :
      "the N was on the N . he did n't move N ; N N  "
      

---

    Code
      contentmask(toy.corpus, algorithm = "POSnoise", remove_emojis = F)
    Message
      successfully initialized (spaCy Version: 3.7.4, language model: en_core_web_sm)
    Output
      Corpus consisting of 2 documents.
      text1 :
      "the N was on the N . he did n't move   N ;   N N P 👍"
      
      text2 :
      "D 👍"
      

