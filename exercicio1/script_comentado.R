#Instalar Pacotes necessários e carregar as bibliotecas
library(mlbench)
library(caret)
#Importando dataset
data(Satellite)
#Pegar apenas os valores 17:20 e iniciar as variaveis
temp_dados <- subset(Satellite, select = c(17:20, 37))
indices <- createDataPartition(temp_dados$classes, p=0.80,list=FALSE)
treino <- temp_dados[indices,]
teste <- temp_dados[-indices,]
#Treinar RF, SVM e RNA com a base de Treino
set.seed(7)
rf <- train(classes~., data=treino, method="rf")
predict.rf = predict(rf, teste)
confusionMatrix(predict.rf, teste$classes)
'Confusion Matrix and Statistics

                     Reference
Prediction            red soil cotton crop grey soil damp grey soil
  red soil                 297           0         2              2
  cotton crop                0         127         0              0
  grey soil                  2           0       237             24
  damp grey soil             0           1        22             68
  vegetation stubble         7          10         0              0
  very damp grey soil        0           2        10             31
                     Reference
Prediction            vegetation stubble very damp grey soil
  red soil                             4                   0
  cotton crop                          0                   1
  grey soil                            1                   6
  damp grey soil                       1                  45
  vegetation stubble                 120                   8
  very damp grey soil                 15                 241

Overall Statistics
                                          
               Accuracy : 0.8489          
                 95% CI : (0.8281, 0.8681)
    No Information Rate : 0.2383          
    P-Value [Acc NIR] : < 2.2e-16       
                                          
                  Kappa : 0.8136          
                                          
 Mcnemars Test P-Value : NA              

Statistics by Class:

                     Class: red soil Class: cotton crop Class: grey soil
Sensitivity                   0.9706            0.90714           0.8745
Specificity                   0.9918            0.99913           0.9674
Pos Pred Value                0.9738            0.99219           0.8778
Neg Pred Value                0.9908            0.98875           0.9665
Prevalence                    0.2383            0.10903           0.2111
Detection Rate                0.2313            0.09891           0.1846
Detection Prevalence          0.2375            0.09969           0.2103
Balanced Accuracy             0.9812            0.95313           0.9210
                     Class: damp grey soil Class: vegetation stubble
Sensitivity                        0.54400                   0.85106
Specificity                        0.94047                   0.97813
Pos Pred Value                     0.49635                   0.82759
Neg Pred Value                     0.95031                   0.98156
Prevalence                         0.09735                   0.10981
Detection Rate                     0.05296                   0.09346
Detection Prevalence               0.10670                   0.11293
Balanced Accuracy                  0.74223                   0.91460
                     Class: very damp grey soil
Sensitivity                              0.8007
Specificity                              0.9410
Pos Pred Value                           0.8060
Neg Pred Value                           0.9391
Prevalence                               0.2344
Detection Rate                           0.1877
Detection Prevalence                     0.2329
Balanced Accuracy                        0.8708'

svm <- train(classes~., data=treino, method="svmRadial")
predict.svm = predict(svm, teste)
confusionMatrix(predict.svm, teste$classes)
'Confusion Matrix and Statistics

                     Reference
Prediction            red soil cotton crop grey soil damp grey soil
  red soil                 301           0         2              1
  cotton crop                0         123         0              1
  grey soil                  2           0       254             28
  damp grey soil             1           1        15             66
  vegetation stubble         2          13         0              1
  very damp grey soil        0           3         0             28
                     Reference
Prediction            vegetation stubble very damp grey soil
  red soil                             4                   0
  cotton crop                          0                   1
  grey soil                            1                  12
  damp grey soil                       1                  41
  vegetation stubble                 121                   4
  very damp grey soil                 14                 243

Overall Statistics
                                          
               Accuracy : 0.8629          
                 95% CI : (0.8429, 0.8813)
    No Information Rate : 0.2383          
    P-Value [Acc NIR] : < 2.2e-16       
                                          
                  Kappa : 0.8306          
                                          
 Mcnemars Test P-Value : NA              

Statistics by Class:

                     Class: red soil Class: cotton crop Class: grey soil
Sensitivity                   0.9837            0.87857           0.9373
Specificity                   0.9928            0.99825           0.9576
Pos Pred Value                0.9773            0.98400           0.8552
Neg Pred Value                0.9949            0.98533           0.9828
Prevalence                    0.2383            0.10903           0.2111
Detection Rate                0.2344            0.09579           0.1978
Detection Prevalence          0.2399            0.09735           0.2313
Balanced Accuracy             0.9883            0.93841           0.9474
                     Class: damp grey soil Class: vegetation stubble
Sensitivity                        0.52800                   0.85816
Specificity                        0.94909                   0.98250
Pos Pred Value                     0.52800                   0.85816
Neg Pred Value                     0.94909                   0.98250
Prevalence                         0.09735                   0.10981
Detection Rate                     0.05140                   0.09424
Detection Prevalence               0.09735                   0.10981
Balanced Accuracy                  0.73855                   0.92033
                     Class: very damp grey soil
Sensitivity                              0.8073
Specificity                              0.9542
Pos Pred Value                           0.8438
Neg Pred Value                           0.9418
Prevalence                               0.2344
Detection Rate                           0.1893
Detection Prevalence                     0.2243
Balanced Accuracy                        0.8808'

rna <- train(classes~., data=treino, method="nnet",trace=FALSE)
predict.rna = predict(rna, teste)
confusionMatrix(predict.rna, teste$classes)
'Confusion Matrix and Statistics

                     Reference
Prediction            red soil cotton crop grey soil damp grey soil
  red soil                 298           0         3              2
  cotton crop                0         119         0              0
  grey soil                  1           0       252             56
  damp grey soil             0           0         4              3
  vegetation stubble         7          18         0              1
  very damp grey soil        0           3        12             63
                     Reference
Prediction            vegetation stubble very damp grey soil
  red soil                             6                   0
  cotton crop                          2                   0
  grey soil                            1                  26
  damp grey soil                       0                   4
  vegetation stubble                 116                   9
  very damp grey soil                 16                 262

Overall Statistics
                                          
               Accuracy : 0.8178          
                 95% CI : (0.7955, 0.8385)
    No Information Rate : 0.2383          
    P-Value [Acc NIR] : < 2.2e-16       
                                          
                  Kappa : 0.7717          
                                          
 Mcnemars Test P-Value : NA              

Statistics by Class:

                     Class: red soil Class: cotton crop Class: grey soil
Sensitivity                   0.9739            0.85000           0.9299
Specificity                   0.9888            0.99825           0.9171
Pos Pred Value                0.9644            0.98347           0.7500
Neg Pred Value                0.9918            0.98194           0.9800
Prevalence                    0.2383            0.10903           0.2111
Detection Rate                0.2321            0.09268           0.1963
Detection Prevalence          0.2407            0.09424           0.2617
Balanced Accuracy             0.9813            0.92413           0.9235
                     Class: damp grey soil Class: vegetation stubble
Sensitivity                       0.024000                   0.82270
Specificity                       0.993097                   0.96938
Pos Pred Value                    0.272727                   0.76821
Neg Pred Value                    0.904163                   0.97793
Prevalence                        0.097352                   0.10981
Detection Rate                    0.002336                   0.09034
Detection Prevalence              0.008567                   0.11760
Balanced Accuracy                 0.508549                   0.89604
                     Class: very damp grey soil
Sensitivity                              0.8704
Specificity                              0.9044
Pos Pred Value                           0.7360
Neg Pred Value                           0.9580
Prevalence                               0.2344
Detection Rate                           0.2040
Detection Prevalence                     0.2773
Balanced Accuracy                        0.8874'
#Verificando qual tem o melhor resultando
resultados <- resamples(list(rf=rf, svm=svm, rna=rna))
summary(resultados)
'Call:
summary.resamples(object = resultados)

Models: rf, svm, rna 
Number of resamples: 25 

Accuracy 
         Min.   1st Qu.    Median      Mean   3rd Qu.      Max. NA's
rf  0.8206207 0.8331573 0.8380697 0.8380145 0.8432112 0.8536585    0
svm 0.8385870 0.8567639 0.8603293 0.8609359 0.8672660 0.8739496    0
rna 0.3501312 0.7091295 0.7996803 0.7508498 0.8198529 0.8408728    0

Kappa 
         Min.   1st Qu.    Median      Mean   3rd Qu.      Max. NA's
rf  0.7787827 0.7937628 0.7996598 0.7995789 0.8054875 0.8189208    0
svm 0.8004627 0.8223911 0.8268148 0.8277197 0.8354336 0.8431552    0
rna 0.1942723 0.6378864 0.7494028 0.6871626 0.7749431 0.8019299    0'
#validação para modelo svm
final_model <- ksvm(type="C-svc", classes~., data=Satellite, kernel="rbfdot", C=1.0, kpar=list(sigma=0.9423008))
final_predict.svm = predict(final_model, Satellite)
confusionMatrix(final_predict.svm, Satellite$classes)
'Confusion Matrix and Statistics

                     Reference
Prediction            red soil cotton crop grey soil damp grey soil
  red soil                1533           0         0              0
  cotton crop                0         703         0              0
  grey soil                  0           0      1354             34
  damp grey soil             0           0         4            586
  vegetation stubble         0           0         0              0
  very damp grey soil        0           0         0              6
                     Reference
Prediction            vegetation stubble very damp grey soil
  red soil                             1                   0
  cotton crop                          0                   0
  grey soil                            0                   5
  damp grey soil                       0                   2
  vegetation stubble                 704                   1
  very damp grey soil                  2                1500

Overall Statistics
                                          
               Accuracy : 0.9915          
                 95% CI : (0.9889, 0.9936)
    No Information Rate : 0.2382          
    P-Value [Acc NIR] : < 2.2e-16       
                                          
                  Kappa : 0.9894          
                                          
 Mcnemars Test P-Value : NA              

Statistics by Class:

                     Class: red soil Class: cotton crop Class: grey soil
Sensitivity                   1.0000             1.0000           0.9971
Specificity                   0.9998             1.0000           0.9923
Pos Pred Value                0.9993             1.0000           0.9720
Neg Pred Value                1.0000             1.0000           0.9992
Prevalence                    0.2382             0.1092           0.2110
Detection Rate                0.2382             0.1092           0.2104
Detection Prevalence          0.2384             0.1092           0.2165
Balanced Accuracy             0.9999             1.0000           0.9947
                     Class: damp grey soil Class: vegetation stubble
Sensitivity                        0.93610                    0.9958
Specificity                        0.99897                    0.9998
Pos Pred Value                     0.98986                    0.9986
Neg Pred Value                     0.99315                    0.9995
Prevalence                         0.09728                    0.1099
Detection Rate                     0.09106                    0.1094
Detection Prevalence               0.09200                    0.1096
Balanced Accuracy                  0.96753                    0.9978
                     Class: very damp grey soil
Sensitivity                              0.9947
Specificity                              0.9984
Pos Pred Value                           0.9947
Neg Pred Value                           0.9984
Prevalence                               0.2343
Detection Rate                           0.2331
Detection Prevalence                     0.2343
Balanced Accuracy                        0.9965'
saveRDS(final_model, "Satellite_svm.rds")
###
# dados random forest 
###
#procurando o melhor maxnode
store_maxnode <- list()
tuneGrid <- expand.grid(.mtry = 2)
for (maxnodes in c(5:15)){
+   rf_maxnode <- train(classes~., data=treino, method='rf', metric="Accuracy", importance = TRUE, maxnodes=maxnodes)
+   current_iteration <- toString(maxnodes)
+   store_maxnode[[current_iteration]] <- rf_maxnode
+ }
results_mtry <- resamples(store_maxnode)
summary(results_mtry)
'
Call:
summary.resamples(object = results_mtry)

Models: 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 
Number of resamples: 25 

Accuracy 
        Min.   1st Qu.    Median      Mean   3rd Qu.      Max. NAs
5  0.6612223 0.6709062 0.6781003 0.6808501 0.6816000 0.7694737    0
6  0.7567855 0.7686722 0.7764141 0.7763608 0.7840849 0.7958005    0
7  0.7621853 0.7723663 0.7797927 0.7792149 0.7831074 0.8034464    0
8  0.7637041 0.7738903 0.7784272 0.7792136 0.7852988 0.7899838    0
9  0.7763088 0.7841802 0.7867725 0.7890357 0.7931398 0.8082627    0
10 0.7777183 0.7879747 0.7958533 0.7958780 0.8025410 0.8272059    0
11 0.7847222 0.7953488 0.8007172 0.8017877 0.8075923 0.8203909    0
12 0.7869919 0.8048907 0.8163158 0.8126673 0.8240209 0.8287526    0
13 0.8023073 0.8090241 0.8141026 0.8159057 0.8226152 0.8397436    0
14 0.8027572 0.8137461 0.8183749 0.8190948 0.8280494 0.8339483    0
15 0.7858672 0.8090531 0.8178964 0.8181030 0.8275316 0.8499733    0

Kappa 
        Min.   1st Qu.    Median      Mean   3rd Qu.      Max. NAs
5  0.5640933 0.5766288 0.5852825 0.5896068 0.5904259 0.7071780    0
6  0.6912079 0.7094272 0.7164240 0.7180082 0.7285500 0.7425165    0
7  0.6979328 0.7126915 0.7222441 0.7209737 0.7271646 0.7515107    0
8  0.7013375 0.7150034 0.7199213 0.7210712 0.7289357 0.7342479    0
9  0.7176023 0.7275714 0.7305470 0.7337331 0.7379908 0.7578194    0
10 0.7186440 0.7320762 0.7422245 0.7423239 0.7507128 0.7824719    0
11 0.7278340 0.7418666 0.7497795 0.7508600 0.7581390 0.7734898    0
12 0.7323931 0.7551231 0.7698003 0.7655087 0.7791949 0.7846607    0
13 0.7518233 0.7595479 0.7683189 0.7691996 0.7777327 0.7992664    0
14 0.7520110 0.7680023 0.7733689 0.7737409 0.7841418 0.7918293    0
15 0.7320357 0.7613275 0.7708526 0.7724472 0.7851199 0.8122913    0'
#comparar graficamente o maxnode
dotplot(results_mtry, metric="Accuracy")
#Treinar com os dados fornecidos acima
fit_rf <- randomForest(classes~., data=treino, maxnodes = 15, mtry = 2)
final_predict.rf = predict(fit_rf, Satellite)
confusionMatrix(final_predict.rf, Satellite$classes)
'Confusion Matrix and Statistics

                     Reference
Prediction            red soil cotton crop grey soil damp grey soil
  red soil                1493          49        22             81
  cotton crop                0         610         0              0
  grey soil                 31           0      1282            132
  damp grey soil             1           3        46            230
  vegetation stubble         7          31         0              0
  very damp grey soil        1          10         8            183
                     Reference
Prediction            vegetation stubble very damp grey soil
  red soil                           156                  75
  cotton crop                          4                   0
  grey soil                            5                  35
  damp grey soil                       0                 126
  vegetation stubble                 450                  23
  very damp grey soil                 92                1249

Overall Statistics
                                         
               Accuracy : 0.8258         
                 95% CI : (0.8163, 0.835)
    No Information Rate : 0.2382         
    P-Value [Acc NIR] : < 2.2e-16      
                                         
                  Kappa : 0.7823         
                                         
 Mcnemars Test P-Value : NA             

Statistics by Class:

                     Class: red soil Class: cotton crop Class: grey soil
Sensitivity                   0.9739            0.86771           0.9440
Specificity                   0.9219            0.99930           0.9600
Pos Pred Value                0.7958            0.99349           0.8633
Neg Pred Value                0.9912            0.98402           0.9846
Prevalence                    0.2382            0.10925           0.2110
Detection Rate                0.2320            0.09479           0.1992
Detection Prevalence          0.2915            0.09542           0.2308
Balanced Accuracy             0.9479            0.93351           0.9520
                     Class: damp grey soil Class: vegetation stubble
Sensitivity                        0.36741                   0.63649
Specificity                        0.96970                   0.98935
Pos Pred Value                     0.56650                   0.88063
Neg Pred Value                     0.93432                   0.95662
Prevalence                         0.09728                   0.10987
Detection Rate                     0.03574                   0.06993
Detection Prevalence               0.06309                   0.07941
Balanced Accuracy                  0.66856                   0.81292
                     Class: very damp grey soil
Sensitivity                              0.8282
Specificity                              0.9403
Pos Pred Value                           0.8095
Neg Pred Value                           0.9471
Prevalence                               0.2343
Detection Rate                           0.1941
Detection Prevalence                     0.2398
Balanced Accuracy                        0.8843'
saveRDS(final_model, "Satellite_rf.rds")
varImpPlot(fit_rf)