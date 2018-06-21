# NEDMineR


# <img src="img/NEDLogo.png" align="right" />

Functions to create synthetic data and analytical tools for the National Endoscopy Database.

The synthetic data has been created along the principles of 

1. Correct formatting according to the data definitions from NED
2. The principles of making sense
  Simply stated this means that the report is algorithmically created such that it would more or less make sense to a human reader. The algorithm is pretty straightforward
  
      a) Firstly the procedure type is created
      b) Indications/ Diagnoses etc are seperated in a list according to which is likely to be found depending on the procedure is being carried out
      c) Having created the lists the next step is to determine what was seen- the biopsies taken is conditional on this
      d) The next conditional is to list the number and site of biopsies based on the diagnosis, and clearly if no biopsies were taken then  the number of biopsies generated is zero
      e) Any therapeutic procedure also has to be relevant to the diagnosis- no one puts a stent in for gastritis for example 
      
      The data is also created in the order which is likely to appear on a report submitted to NED- again so that it can make sense
      
      Finally a script is included to demonstrate ways in which the NED data might be utilised. I strongly recommend the principles set out in the [EndoMineR project](https://ropensci.github.io/EndoMineR/) or a less technical explanation found [here](https://sebastiz.github.io/gastrodatascience/CornerstonesIntro.html)
