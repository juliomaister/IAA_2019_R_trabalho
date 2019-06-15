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
set.seed(7) #segui o modelo do professor e deixei o seed 7
rf <- train(classes~., data=treino, method="rf")
predict.rf = predict(rf, teste)
confusionMatrix(predict.rf, teste$classes)

svm <- train(classes~., data=treino, method="svmRadial")
predict.svm = predict(svm, teste)
confusionMatrix(predict.svm, teste$classes)

rna <- train(classes~., data=treino, method="nnet",trace=FALSE)
predict.rna = predict(rna, teste)
confusionMatrix(predict.rna, teste$classes)

#Verificando qual tem o melhor resultando
resultados <- resamples(list(rf=rf, svm=svm, rna=rna))
summary(resultados)

svm

#validação para modelo svm
final_model <- ksvm(type="C-svc", classes~., data=Satellite, kernel="rbfdot", C=1.0, kpar=list(sigma=0.9214115))
final_predict.svm = predict(final_model, Satellite)
confusionMatrix(final_predict.svm, Satellite$classes)
#salvando o modelo
saveRDS(final_model, "Satellite_svm.rds")