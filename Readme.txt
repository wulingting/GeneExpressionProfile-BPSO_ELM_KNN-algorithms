A total of three large folders are experiment of data preprocssing, lncRNA  and result of experiment.

1.The file of "Data preprocessing"

  (1)The experimental environment for algorithm: operating system si 64 Windows8.1 
     which is the professional edition; Inter processor (R) Pentium (R) CPU G3240 @ 3.10GHz;
     running memory is 12GB; the data processing, the realization and running of the code are
     main use of Java language in MyEclipse10.0.
     
  (2)The data collected from the database is preprocessed, and the different species can run as long as the parameters in 
     the code are adjusted.
     
2. The file of "Experiment of LncRNA"

2.1 The experimental environment for algorithm: operating system si 64 Windows8.1, which ia the professional edition:Inter 
    processor (R) Pentium (R) CPU G3240 @ 3.10GHz;running memory is 12GB; the realization and running of the code are
     main use of MatlabR2014b 
  
2.2 There are five sub files in the file, five files are the experimental code for five different species, namely,colon
    adenocarcinoma, breast invasive carcinoma, liver carcinoma, lung adenocarcinoma and lung squamous cell carcinoma. 
    Taking species breast as an example, to introduce the detailed process of the code.
    The file of "experiment of breast".
   
   (1)Pretreatment.m: The main purpose of this step is to filter out the lncRNA of 0 in the expression spectrum.
  
   (2)informationgain.m: The main purpose of this step is to screen out the final data set by calculating the information 
      gain rate of each feature. 
   
   (3)chose.m: Determine the number of final lncRNA experiments and select random selection (100 selected 90), and then 
      initialize the data set of the experiment based on the selected data.
   
   (4)Main.m: This is the core of the experiment, and the BPSO-ELM algorithm model is used. After the initial feature selection,
      we get the concise subset containing key lncRNA. After that, we will apply it to the key lncRNA prediction model 
      based on improved BPSO-ELM to locate the key lncRNA accurately.
   
   (5)mytest.m: This is subset evaluation part. The key lncRNA predicted by the model is trained by the constructed classifier model,
      and finally the performance of lncRNA subset is evaluated by the accuracy of prediction. The classifier model used in 
      this method is ELM.
   
   (6)MainVSKnn.m: The same as "Main.m".
   
   (7)mytest_knn.m: This is subset evaluation part. The key lncRNA predicted by the model is trained by the constructed classifier model,
      and finally the performance of lncRNA subset is evaluated by the accuracy of prediction. The classifier model used in 
      this method is KNN.
   
   (8)elm.m: The code of the classifier ELM.
   
   (9)KNN.m: This is the core of the experiment, and the BPSO-KNN algorithm model is used. After the initial feature selection,
      we get the concise subset containing key lncRNA. After that, we will apply it to the key lncRNA prediction model 
      based on improved BPSO-KNN to locate the key lncRNA accurately.
  
   (10)breast.mat: This is the preprocessed data set. The other "*.mat" files in the folder are all the files produced during the code run,
      and you don't tell them all about it.
                   
2.3 The running process of the code
    This study involves three models, including BPSO-ELM, BPSO-KNN and BPSO-ELM-KNN. All the codes are included in the folder. Next, we 
    introduce the running sequence of each model.
    
    (1)The model of BPSO-ELM
    
       Pretreatment.m -> informationgain.m -> chose.m -> Main.m -> mytest.m;
       
    (2)The model of BPSO-KNN
    
       Pretreatment.m -> informationgain.m -> chose.m -> KNN.m -> mytest_knn.m;
       
    (3)The model of BPSO-ELM-KNN
       
       Pretreatment.m -> informationgain.m -> chose.m -> Main.m -> mytest_knn.

3.The file of "result of experiment"
  
  There are the results of BPSO-ELM-KNN algorithm experiments, corresponding to the results of five different species.
    