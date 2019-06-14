# Exercício 2 - Resultados e justificativas

Para efeito de comparação, foram treinados modelos dos seguintes métodos:
 * Random Forest (rf)
 * Support Vector Machine Radial (svmRadial)
 * Neural Network (nnet)

## Composição do algoritmo
O algoritmo é composto pelas seguintes partes:

1. Carregamento e construção dos dados
1. Treinamento, criação de predições de teste e, também, o calculo de correlação entre os dados de amostra e as predições
1. Escolha e treinamento do melhor modelo de aprendizagem de máquina
1. Criação dos gráficos, para efeito de comparação
1. Saídas padrão para exibição dos dados

## Funcionamento

O algoritmo faz o treinamento dos modelos dos métodos propostos, então, para cada um deles, realiza um teste de predição para valores já existesntes. E, então calcula a correlação entre o resultado das predições e o resultado da massa de dados de treinamento.

Após ter os modelos treinados, faz uma comparação para verificar qual modelo possui uma melhor correlação. Então, este é selecionado e então o mesmo é treinado com toda a massa de dados para ser mantido para utilizações posteriores, para o mesmo caso de uso.

Logo em seguida guarda os gráficos gerados, para comparação entre os métodos. E, então, salva os outputs para análise em um arquivo.

## Arquivos gerados:
 * `modelos.png` comparação entre o resultado das predições realizadas pelos modelos, e a amostra de dados
 * `metodo_com_melhor_correlacao.png`: comparação entre as predições do método selecionado e a amostra de dados
 * `output.txt`: saída dos dados para análise da veracidade

## Resultados obtidos
Utilizando-se das saídas geradas pelo algoritmo, formatadas, a seguir.
```
Comparação de correlações entre os métodos
 - Random Forest
 - Support Vector Machine Radial
 - Neural Network

Correlações dos métodos utilizados
         rf      nnet svmRadial      alom
1 0.9267874 0.9408202 0.9253999 0.9244904

Método com melhor correlação:
nnet

Correlação do método escolhido com toda a amostra de dados
0.9426489
```

Neste caso, a melhor correlação foi obtida por pelo modelo treinado a partir do método de Rede Neural (Neural Network).

Deve-se observar que os modelos, assim como os resultados, podem variar conforme o `set.seed` utilizado. Outro fator observado foi que o resultado pode ser diferente entre máquinas, mesmo utilizando o mesmo valor para a função `set.seed`
