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
nnet <- train(VOL~., data = treinamento, method = "nnet", trace = F, linout=T,
             tuneGrid=expand.grid(size = 10, decay = 0.1))
predicoes.nnet <- predict(nnet, teste)
cor.nnet <- cor(teste$VOL, predicoes.nnet)[1]

# Alometric Spurr
alom <- nls(VOL ~ b0 + b1*(DAP*DAP)*HT, treinamento, start = list(b0=0.5,b1=0.5))
predicoes.alom <- predict(alom, teste)
cor.alom <- cor(teste$VOL, predicoes.alom)

# -----------------------------------------------------------------------------
# ESCOLHA E TREINAMENTO DO MELHOR MODELO
# -----------------------------------------------------------------------------

# Accuracy of models
correlacoes <- as.data.frame(list(rf=cor.rf, nnet=cor.nnet, svmRadial=cor.svm, alom=cor.alom))
melhor_metodo <- colnames(correlacoes)[which(correlacoes == max(correlacoes))]

# Treinamento do melhor modelo
if (melhor_metodo == "rf" || melhor_metodo == "svmRadial"){
  melhor_modelo <- train(VOL~., data=dataset, method=melhor_metodo)
} else if(melhor_metodo == "nnet"){
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
with(dataset, points(x = predicoes.nnet, pch = 19, cex = 0.5, col="purple"))
dev.copy(png,'metodos.png')
dev.off()

# Gráfico de comparação das correlações do melhor método atual
xgrid = expand.grid(X1=volumes$NR,X2=seq(0, max(c(max(melhor_predicao),max(dataset$VOL))), 0.01))
plot(xgrid, pch = 20, cex = 0.1, col = "grey", main = paste("Comparação entre amostra e predições para", melhor_metodo), ylab="Volume", xlab = "Distribuição de amostras")
points(dataset$VOL, pch = 19, cex=0.3)
points(melhor_predicao, pch = 19, col = "red", cex=0.3)
dev.copy(png,'metodo_com_melhor_correlacao.png')
dev.off()


# -----------------------------------------------------------------------------
# OUTPUTS
# -----------------------------------------------------------------------------


sink("output.txt")
print("Comparação de correlações entre os métodos")
print(" - Random Forest")
print(" - Support Vector Machine Radial")
print(" - Neural Network")
print("Correlações dos métodos utilizados")
print(correlacoes)
print("Método com melhor correlação:")
print(melhor_metodo)
print("Correlação do método escolhido com toda a amostra de dados")
print(melhor_cor)
sink()