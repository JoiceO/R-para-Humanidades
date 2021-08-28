# P4H + LEPECS - WORKSHOP DE R - 2021/2
# AULA 2: Introdução ao R

## (Continuação) NOSSAS PRIMEIRAS LINHAS DE CóDIGO ##

# # # # # # # # # # # # # # # # # # # # # # #
# Até o momento vimos os seguintes tópicos: #
# # # # # # # # # # # # # # # # # # # # # # # 

## 1. R como calculadora

3 + 2

## 2. Atribuição (<-)

idade <- 20
nome <- "Maria"

## 3. Tipo de Dados

### Numérico

20

### String/Text

"Maria"

### Fator/Factor

# > Imagina que vocês perguntaram para 8 alunos da FFLCH se eles gostam de aula online:
factor(c("Sim", "Nao", "Nao Sei", "Nao", "Sim", "Nao Sei", NA, "Sim"), levels = c("Sim", "Nao", "Nao Sei"))

### Booleano/logical

350 >= 300

"Programação" == "programação"

### NA

is.na(NA)

## 4. Estrutura de dados

### Vetores

trem <- c(100, 20, 34, 500, 150)

#### Indexando vetores

trem[1] # Queremos o valor na primeira posição

trem[c(2, 4)] # Queremos os valores na segunda e quarta posição

trem[trem >= 100] # Queremos os valores maiores ou iguais a 100


# # # # # # # # # # # # # # # 
# Na aula de hoje veremos : #
# # # # # # # # # # # # # # # 

## 1. Continuação de vetores 

## 2. Listas

## 3. Dataframes

## 4. Funções e Pacotes

########
# Listas

trem <- list(c(4, 6, 8), c("Maria", "Joao"), c(TRUE, TRUE, FALSE), "Fernando")

class(trem)

## Para facilitar, você também consegue colocar nomes em cada elemento da lista
trem <- list(horario = c(4, 6, 8), maquinista = c("Maria", "Joao"), disponibilidade = c(TRUE, TRUE, FALSE), maquinista_reserva = "Fernando")

## E da mesma forma que vetores, também podemos acessar os valores dentro dela

trem[1] # Acessando a posição 1 da lista trem. Perceba que estamos acessando uma lista dentro da lista trem e não o vetor

class(trem[1])

trem[4]

trem[[1]] # Para acessarmos o VETOR dentro da lista utilizamos  [[]]

class(trem[[1]])

trem[[1]][2] # Dessa forma conseguimos acessar os valores dentro do vetor

trem$disponibilidade # Outra forma de acessar o vetor diretamente


############
# Data Frame

tabela <- data.frame(ano = c(2014, 2014, 2015, 2015, 2016, 2016),
                     pais = c('Brasil', 'China', 'Brasil', 'China', 'Brasil', 'China'),
                     pib = c(100,130, 110, 140, 160, 170),
                     pop = c(3, 8, 4, 9, 6, 14))

tabela 

View(tabela) # mostra o banco no console

head (tabela) # mostra as seis primeiras linhas do banco no console

str(tabela)# mostra a estrutura da tabela

names(tabela) # mostra o nome das variáveis

nrow(tabela) # nº de linhas

ncol(tabela) #nº de colunas

dim(tabela) # dimensões (linhas e colunas)

### Indexando valores em data frames

tabela[1, 2] # Primeira linha, segunda coluna

tabela[1,] # Primeira linha, todas as colunas

tabela[,1] # Todas as linhas, primeira coluna

tabela[1:3,] # Linhas de 1 até 3, todas as colunas

tabela[,2:4] # todas as linhas, colunas de 2 até 4

tabela[,"pais"] # Todas as linhas da coluna "pais"

tabela[2,"pais"] # O valor da segunda linha e da coluna "pais"

tabela[, c("pais", "pib")] # Todas as linhas das colunas "pais" e "pib"

tabela[tabela$pib > 150,] # Utilizando testes logicos para filtrar a tabela

tabela$pib

tabela$pib[1]

############
# Funções e Pacotes

# FUNÇÕES

## Exemplo 1

idade <- c(20, 25, 87, 45, 63, 70)

mean(idade)

?mean()

altura <- c(1.78, 1.6, 1.5, NA)

mean(altura)

mean(altura, na.rm = TRUE)

## Exemplo 2

?seq()

seq(from = 2, to = 12, by = 2)

## Exemplo 3

valores <- rnorm(n = 200, mean = 8, sd = 2)

hist(valores)

## Exemplo 4

c(1, 2, 3, 4) # É uma função para criar vetores


# PACOTES

install.packages("readr")
install.packages("")

library(readr)

?readr

virgula <- read_csv("https://github.com/p4hUSP/material-2021/raw/master/docs/data/candidatos_sp_virgula.csv")

pontovirgula <- read_delim("https://raw.githubusercontent.com/p4hUSP/material-2021/master/docs/data/candidatos_sp_pontovirgula.csv", delim = ";")
