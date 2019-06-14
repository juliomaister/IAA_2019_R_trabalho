#Instalar Pacotes necessários e carregar as bibliotecas
> library(mlbench)
> library(caret)
#Importando dataset
> data(Satellite)
#Pegar apenas os valores 17:20 e iniciar as variaveis
> temp_dados <- subset(Satellite, select = c(17:20, 37))
> indices <- createDataPartition(temp_dados$classes, p=0.80,list=FALSE)
> treino <- temp_dados[indices,]
> teste <- temp_dados[-indices,]
#Treinar RF, SVM e RNA com a base de Treino
> set.seed(7)
> rf <- train(classes~., data=treino, method="rf")
> predict.rf = predict(rf, teste)
> confusionMatrix(predict.rf, teste$classes)
'
Confusion Matrix and Statistics

                     Reference
Prediction            red soil cotton crop grey soil damp grey soil
  red soil                 296           0         4              1
  cotton crop                0         120         0              0
  grey soil                  7           0       237             30
  damp grey soil             0           2        21             52
  vegetation stubble         2          14         0              1
  very damp grey soil        1           4         9             41
                     Reference
Prediction            vegetation stubble very damp grey soil
  red soil                             6                   0
  cotton crop                          4                   1
  grey soil                            0                  10
  damp grey soil                       0                  37
  vegetation stubble                 120                  10
  very damp grey soil                 11                 243

Overall Statistics
                                          
               Accuracy : 0.8318          
                 95% CI : (0.8102, 0.8518)
    No Information Rate : 0.2383          
    P-Value [Acc > NIR] : < 2.2e-16       
                                          
                  Kappa : 0.7919          
                                          
Mcnemars Test P-Value : NA              

Statistics by Class:

                     Class: red soil Class: cotton crop Class: grey soil
Sensitivity                   0.9673            0.85714           0.8745
Specificity                   0.9888            0.99563           0.9536
Pos Pred Value                0.9642            0.96000           0.8345
Neg Pred Value                0.9898            0.98274           0.9660
Prevalence                    0.2383            0.10903           0.2111
Detection Rate                0.2305            0.09346           0.1846
Detection Prevalence          0.2391            0.09735           0.2212
Balanced Accuracy             0.9780            0.92639           0.9141
                     Class: damp grey soil Class: vegetation stubble
Sensitivity                        0.41600                   0.85106
Specificity                        0.94823                   0.97638
Pos Pred Value                     0.46429                   0.81633
Neg Pred Value                     0.93771                   0.98153
Prevalence                         0.09735                   0.10981
Detection Rate                     0.04050                   0.09346
Detection Prevalence               0.08723                   0.11449
Balanced Accuracy                  0.68212                   0.91372
                     Class: very damp grey soil
Sensitivity                              0.8073
Specificity                              0.9329
Pos Pred Value                           0.7864
Neg Pred Value                           0.9405
Prevalence                               0.2344
Detection Rate                           0.1893
Detection Prevalence                     0.2407
Balanced Accuracy                        0.8701
'
> svm <- train(classes~., data=treino, method="svmRadial")
> predict.svm = predict(svm, teste)
> confusionMatrix(predict.svm, teste$classes)
'
Confusion Matrix and Statistics

                     Reference
Prediction            red soil cotton crop grey soil damp grey soil
  red soil                 299           0         2              1
  cotton crop                0         117         0              0
  grey soil                  5           0       260             37
  damp grey soil             0           1         9             55
  vegetation stubble         2          18         0              1
  very damp grey soil        0           4         0             31
                     Reference
Prediction            vegetation stubble very damp grey soil
  red soil                             7                   0
  cotton crop                          0                   0
  grey soil                            0                  10
  damp grey soil                       0                  29
  vegetation stubble                 121                   8
  very damp grey soil                 13                 254

Overall Statistics
                                          
               Accuracy : 0.8614          
                 95% CI : (0.8413, 0.8798)
    No Information Rate : 0.2383          
    P-Value [Acc > NIR] : < 2.2e-16       
                                          
                  Kappa : 0.8281          
                                      
Mcnemars Test P-Value : NA              

Statistics by Class:

                     Class: red soil Class: cotton crop Class: grey soil
Sensitivity                   0.9771            0.83571           0.9594
Specificity                   0.9898            1.00000           0.9487
Pos Pred Value                0.9676            1.00000           0.8333
Neg Pred Value                0.9928            0.98029           0.9887
Prevalence                    0.2383            0.10903           0.2111
Detection Rate                0.2329            0.09112           0.2025
Detection Prevalence          0.2407            0.09112           0.2430
Balanced Accuracy             0.9834            0.91786           0.9540
                     Class: damp grey soil Class: vegetation stubble
Sensitivity                        0.44000                   0.85816
Specificity                        0.96635                   0.97463
Pos Pred Value                     0.58511                   0.80667
Neg Pred Value                     0.94118                   0.98236
Prevalence                         0.09735                   0.10981
Detection Rate                     0.04283                   0.09424
Detection Prevalence               0.07321                   0.11682
Balanced Accuracy                  0.70318                   0.91639
                     Class: very damp grey soil
Sensitivity                              0.8439
Specificity                              0.9512
Pos Pred Value                           0.8411
Neg Pred Value                           0.9521
Prevalence                               0.2344
Detection Rate                           0.1978
Detection Prevalence                     0.2352
Balanced Accuracy                        0.8975
'
> 
  > rna <- train(classes~., data=treino, method="nnet",trace=FALSE)
> predict.rna = predict(rna, teste)
> confusionMatrix(predict.rna, teste$classes)
'
Confusion Matrix and Statistics

                     Reference
Prediction            red soil cotton crop grey soil damp grey soil
  red soil                 294           0         0              1
  cotton crop                0         117         0              0
  grey soil                  5           0       251             41
  damp grey soil             0           0        18             32
  vegetation stubble         7          15         0              1
  very damp grey soil        0           8         2             50
                     Reference
Prediction            vegetation stubble very damp grey soil
  red soil                            10                   2
  cotton crop                          2                   0
  grey soil                            0                   9
  damp grey soil                       0                  19
  vegetation stubble                 113                   7
  very damp grey soil                 16                 264

Overall Statistics
                                          
               Accuracy : 0.8341          
                 95% CI : (0.8126, 0.8541)
    No Information Rate : 0.2383          
    P-Value [Acc > NIR] : < 2.2e-16       
                                          
                  Kappa : 0.7934          
                                          
Mcnemars Test P-Value : NA              

Statistics by Class:

                     Class: red soil Class: cotton crop Class: grey soil
Sensitivity                   0.9608            0.83571           0.9262
Specificity                   0.9867            0.99825           0.9457
Pos Pred Value                0.9577            0.98319           0.8203
Neg Pred Value                0.9877            0.98026           0.9796
Prevalence                    0.2383            0.10903           0.2111
Detection Rate                0.2290            0.09112           0.1955
Detection Prevalence          0.2391            0.09268           0.2383
Balanced Accuracy             0.9737            0.91698           0.9360
                     Class: damp grey soil Class: vegetation stubble
Sensitivity                        0.25600                   0.80142
Specificity                        0.96808                   0.97375
Pos Pred Value                     0.46377                   0.79021
Neg Pred Value                     0.92346                   0.97546
Prevalence                         0.09735                   0.10981
Detection Rate                     0.02492                   0.08801
Detection Prevalence               0.05374                   0.11137
Balanced Accuracy                  0.61204                   0.88759
                     Class: very damp grey soil
Sensitivity                              0.8771
Specificity                              0.9227
Pos Pred Value                           0.7765
Neg Pred Value                           0.9608
Prevalence                               0.2344
Detection Rate                           0.2056
Detection Prevalence                     0.2648
Balanced Accuracy                        0.8999
'
#Verificando qual tem o melhor resultando
> resultados <- resamples(list(rf=rf, svm=svm, rna=rna))
> summary(resultados)
'
Call:
summary.resamples(object = resultados)

Models: rf, svm, rna 
Number of resamples: 25 

Accuracy 
         Min.   1st Qu.    Median      Mean   3rd Qu.      Max. NAs
rf  0.8256545 0.8379800 0.8444790 0.8435618 0.8501853 0.8587243    0
svm 0.8488435 0.8526596 0.8573718 0.8585297 0.8633508 0.8691099    0 <---------- melhor resultado
rna 0.6181247 0.7878947 0.8066914 0.7912296 0.8224447 0.8463950    0

Kappa 
         Min.   1st Qu.    Median      Mean   3rd Qu.      Max. NAs
rf  0.7851753 0.7993159 0.8076473 0.8064463 0.8140341 0.8241970    0
svm 0.8134910 0.8178210 0.8234246 0.8247521 0.8305633 0.8377564    0
rna 0.5194219 0.7336818 0.7573341 0.7382323 0.7780950 0.8096178    0
'
> svm
'
Support Vector Machines with Radial Basis Function Kernel 

5151 samples
   4 predictor
   6 classes: 'red soil', 'cotton crop', 'grey soil', 'damp grey soil', 'vegetation stubble', 'very damp grey soil' 

No pre-processing
Resampling: Bootstrapped (25 reps) 
Summary of sample sizes: 5151, 5151, 5151, 5151, 5151, 5151, ... 
Resampling results across tuning parameters:

  C     Accuracy   Kappa    
  0.25  0.8558828  0.8213358
  0.50  0.8577180  0.8237010
  1.00  0.8585297  0.8247521

Tuning parameter 'sigma' was held constant at a value of 0.8184865
Accuracy was used to select the optimal model using the largest value.
The final values used for the model were sigma = 0.8184865 and C = 1. <--------- pegando os valores para predição final
'
#validação para modelo svm
final_model <- ksvm(type="C-svc", classes~., data=Satellite, kernel="rbfdot", C=1.0, kpar=list(sigma=0.9214115))
final_predict.svm = predict(final_model, Satellite)
confusionMatrix(final_predict.svm, Satellite$classes)
'
Confusion Matrix and Statistics

                     Reference
Prediction            red soil cotton crop grey soil damp grey soil
  red soil                1533           0         0              0
  cotton crop                0         703         0              0
  grey soil                  0           0      1354             36
  damp grey soil             0           0         4            583
  vegetation stubble         0           0         0              0
  very damp grey soil        0           0         0              7
                     Reference
Prediction            vegetation stubble very damp grey soil
  red soil                             1                   0
  cotton crop                          0                   0
  grey soil                            0                   5
  damp grey soil                       0                   2
  vegetation stubble                 704                   1
  very damp grey soil                  2                1500

Overall Statistics
                                          
               Accuracy : 0.991            <------------------ Resultado excelente
                 95% CI : (0.9884, 0.9931)
    No Information Rate : 0.2382          
    P-Value [Acc > NIR] : < 2.2e-16       
                                          
                  Kappa : 0.9889          
                                          
 Mcnemars Test P-Value : NA              

Statistics by Class:

                     Class: red soil Class: cotton crop Class: grey soil
Sensitivity                   1.0000             1.0000           0.9971
Specificity                   0.9998             1.0000           0.9919
Pos Pred Value                0.9993             1.0000           0.9706
Neg Pred Value                1.0000             1.0000           0.9992
Prevalence                    0.2382             0.1092           0.2110
Detection Rate                0.2382             0.1092           0.2104
Detection Prevalence          0.2384             0.1092           0.2168
Balanced Accuracy             0.9999             1.0000           0.9945
                     Class: damp grey soil Class: vegetation stubble
Sensitivity                        0.93131                    0.9958
Specificity                        0.99897                    0.9998
Pos Pred Value                     0.98981                    0.9986
Neg Pred Value                     0.99264                    0.9995
Prevalence                         0.09728                    0.1099
Detection Rate                     0.09060                    0.1094
Detection Prevalence               0.09153                    0.1096
Balanced Accuracy                  0.96514                    0.9978
                     Class: very damp grey soil
Sensitivity                              0.9947
Specificity                              0.9982
Pos Pred Value                           0.9940
Neg Pred Value                           0.9984
Prevalence                               0.2343
Detection Rate                           0.2331
Detection Prevalence                     0.2345
Balanced Accuracy                        0.9964
'
#salvando o modelo
saveRDS(final_model, "Satellite_svm.rds")
#
#Uma segunda predição, eu tinha rodado e confundi pensei que o melhor tinha sido o randomForest, acabei utilizando ele tambem, 
#vou colocar aqui mais para comparação, creio que eu tinha rodado os testes iniciais com o modelo inteiro direto, 
#sem o filtro, c(17:20).
#
# Continuação do mesmo código apartir da 
#
> rf
'
Random Forest 

5151 samples
  36 predictor
   6 classes: 'red soil', 'cotton crop', 'grey soil', 'damp grey soil', 'vegetation stubble', 'very damp grey soil' 

No pre-processing
Resampling: Bootstrapped (25 reps) 
Summary of sample sizes: 5151, 5151, 5151, 5151, 5151, 5151, ... 
Resampling results across tuning parameters:

  mtry  Accuracy   Kappa    
   2    0.9085281  0.8864936
  19    0.9084164  0.8864576
  36    0.8988108  0.8746016

Accuracy was used to select the optimal model using the largest value.
The final value used for the model was mtry = 2. <-------------- Usando este valor
'
#Utilizando o mtry para pegar maxnodes de no maximo 15
store_maxnode <- list()
tuneGrid <- expand.grid(.mtry = 2)
for (maxnodes in c(5:15)) {
  rf_maxnode <- train(classes~., data=treino, method='rf', Importance = TRUE, tuneGrid = tuneGrid, maxnode = maxnodes)
  current_iteration <- toString(maxnodes)
  store_maxnode[[current_iteration]] <- rf_maxnode
}
results_mtry <- resamples(store_maxnode)
summary(results_mtry)
'
Call:
summary.resamples(object = results_mtry)

Models: 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 
Number of resamples: 25 

Accuracy 
        Min.   1st Qu.    Median      Mean   3rd Qu.      Max. NAs
5  0.6652565 0.6754617 0.6825479 0.6944459 0.7234043 0.7662547    0
6  0.7436693 0.7647674 0.7708881 0.7696537 0.7755532 0.7863924    0
7  0.7524064 0.7767246 0.7807571 0.7811341 0.7869110 0.8055848    0
8  0.7674919 0.7762201 0.7806925 0.7820712 0.7866805 0.8026667    0
9  0.7701863 0.7865821 0.7916010 0.7895641 0.7938808 0.8003136    0
10 0.7828150 0.7923157 0.7960596 0.7970769 0.8031496 0.8129610    0
11 0.7760085 0.7934272 0.8002109 0.7994534 0.8060797 0.8165962    0
12 0.7942089 0.8105428 0.8145034 0.8166253 0.8214286 0.8480211    0
13 0.8036093 0.8157472 0.8268514 0.8244462 0.8317659 0.8381503    0
14 0.8073248 0.8255069 0.8297985 0.8292505 0.8340448 0.8465637    0
15 0.8146214 0.8258811 0.8318445 0.8314741 0.8357181 0.8459916    0

Kappa 
        Min.   1st Qu.    Median      Mean   3rd Qu.      Max. NAs
5  0.5699374 0.5836037 0.5907517 0.6075142 0.6474052 0.7011065    0
6  0.6738197 0.7012037 0.7089846 0.7074023 0.7139953 0.7262635    0
7  0.6879916 0.7174839 0.7214677 0.7222916 0.7293776 0.7523607    0
8  0.7068502 0.7158087 0.7213489 0.7239517 0.7293726 0.7506631    0
9  0.7074842 0.7297545 0.7348651 0.7328251 0.7384132 0.7453543    0
10 0.7247982 0.7372829 0.7422749 0.7428334 0.7496202 0.7629215    0
11 0.7191231 0.7393371 0.7467227 0.7465094 0.7532744 0.7676764    0
12 0.7403760 0.7610016 0.7654009 0.7686926 0.7746723 0.8077359    0
13 0.7532540 0.7689069 0.7814926 0.7790081 0.7879964 0.7960489    0
14 0.7580338 0.7795866 0.7861569 0.7852177 0.7907578 0.8064375    0
15 0.7664401 0.7813463 0.7879986 0.7881537 0.7940806 0.8050501    0
'
#monta grafico para ver qual é o maxnode com mais eficiencia
dotplot(results_mtry, metric="Accuracy")
#inserir imagem
fit_rf <- randomForest(Satellite, mtry = 2,Importance = TRUE, maxnode = 15)
