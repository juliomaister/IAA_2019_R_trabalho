install.packages("caret")
install.packages("e1071")
install.packages("mlbench")
install.packages("mice")
library(mlbench)
library(caret)
library(mice)
library("caret")

set.seed(7)

# -----------------------------------------------------------------------------
# CARREGAMENTO E CONSTRUÇÃO DOS DADOS
# -----------------------------------------------------------------------------

volumes = read.csv("Volumes.csv", sep = ";", dec = ",")
dataset = subset(volumes, select = -NR)
indices <- createDataPartition(dataset$VOL, p=0.80, list = FALSE)
treinamento <- dataset[indices,]
teste <- dataset[-indices,]

# -----------------------------------------------------------------------------
# TREINAMENTOS
# -----------------------------------------------------------------------------
# Random Forest
rf <- train(VOL~., data=treinamento, method="rf")
predicoes.rf <- predict(rf, teste)
cor.rf <- cor(teste$VOL, predicoes.rf)

# Svm Radial
svm <-train(VOL~., data=treinamento, method="svmRadial")
predicoes.svm <- predict(svm, teste)
cor.svm <- cor(teste$VOL, predicoes.svm)

# Neural Network
rna <- train(VOL~., data = treinamento, method = "nnet", trace = F, linout=T,
             tuneGrid=expand.grid(size = 10, decay = 0.1))
predicoes.rna <- predict(rna, teste)
cor.rna <- cor(teste$VOL, predicoes.rna)[1]

# Alometric Spurr
alom <- nls(VOL ~ b0 + b1*(DAP*DAP)*HT, treinamento, start = list(b0=0.5,b1=0.5))
predicoes.alom <- predict(alom, teste)
cor.alom <- cor(teste$VOL, predicoes.alom)

# -----------------------------------------------------------------------------
# ESCOLHA E TREINAMENTO DO MELHOR MODELO
# -----------------------------------------------------------------------------

# Accuracy of models
correlacoes <- as.data.frame(list(rf=cor.rf, rna=cor.rna, svmRadial=cor.svm, alom=cor.alom))
melhor_metodo <- colnames(correlacoes)[which(correlacoes == max(correlacoes))]

# Treinamento do melhor modelo
if (melhor_metodo == "rf" || melhor_metodo == "svmRadial"){
  melhor_modelo <- train(VOL~., data=dataset, method=melhor_metodo)
} else if(melhor_metodo == "rna"){
  melhor_modelo <- train(VOL~., data = dataset, method = "nnet", trace = F, linout=T, 
                         tuneGrid=expand.grid(size = 10, decay = 0.1))
} else if (melhor_metodo == "alom"){
  melhor_modelo <- nls(VOL ~ b0 + b1*(DAP*DAP)*HT, dataset, start = list(b0=0.5,b1=0.5))
}
save(melhor_modelo, file = "melhor_modelo_atual.RData")
melhor_predicao <- predict(melhor_modelo, dataset)
melhor_cor <- cor(dataset$VOL, melhor_predicao)

# -----------------------------------------------------------------------------
# GRÁFICOS 
# -----------------------------------------------------------------------------

maior_predicao = max(predicoes.rf)
# Gráfico de comparação das correlações dos métodos
plot(teste$VOL, pch = 19, cex = 0.5, ylab="Predições", main = "Predições dos métodos")
with(dataset, points(x = predicoes.rf, pch = 19, cex = 0.5, col="red"))
with(dataset, points(x = predicoes.alom, pch = 19, cex = 0.5, col="green"))
with(dataset, points(x = predicoes.svm, pch = 19, cex = 0.5, col = "blue"))
with(dataset, points(x = predicoes.rna, pch = 19, cex = 0.5, col="purple"))
xgrid_metodos = expand.grid(X1=volumes$NR,X2=seq(0, max(c(max(melhor_predicao),max(dataset$VOL))), 0.01))
plot(xgrid_metodos, pch = 20, cex = 0.1, col = "grey", main = paste("Comparação entre amostra e predições para", melhor_metodo), ylab="Volume", xlab = "Distribuição de amostras")

# Gráfico de comparação das correlações do melhor método atual
xgrid = expand.grid(X1=volumes$NR,X2=seq(0, max(c(max(melhor_predicao),max(dataset$VOL))), 0.01))
plot(xgrid, pch = 20, cex = 0.1, col = "grey", main = paste("Comparação entre amostra e predições para", melhor_metodo), ylab="Volume", xlab = "Distribuição de amostras")
points(dataset$VOL, pch = 19, cex=0.3)
points(melhor_predicao, pch = 19, col = "red", cex=0.3)


# -----------------------------------------------------------------------------
# OUTPUTS
# -----------------------------------------------------------------------------

print("Melhor método:")
print(melhor_metodo)
print(correlacoes)
print("Correlação com toda a amostra de dados")
print(melhor_cor)