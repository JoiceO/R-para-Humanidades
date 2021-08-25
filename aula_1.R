# P4H + LEPECS - WORKSHOP DE R - 2021/2
# AULA 1: Introção ao R

## NOSSAS PRIMEIRAS LINHAS DE CóDIGO ##

# Podemos utilizar o R como calculadora (mas o potencial da linguagem é muito maior que isso!)

3 + 1 # Soma

3 - 2 # Subtração

4 * 2 # Multiplicação

5 / 2 # Divisão

5 ^ 2 # Exponenciação

(3 - 2)/2 # Combinando operações

# - - - - - - - - - - - - - - - - - - - - - - - #

# Atribuindo valores a variáveis

3 + 1

a <- 3 + 1 # Repare o Workspace - 'a' é uma variavel que contém o valor 3 + 1 = 4

c <- a * 2

c <- c + a

# # # # # # # # # # # #
# Qual é o valor de c?  #
# # # # # # # # # # # #

b <- c("Olá mundo!") # o c() é a função para formar um vetor! Cada argumento é combinado

b

# # # # # # # # # # # #
# Qual é o valor de B?  #
# # # # # # # # # # # #

peso <- 82.45
altura <- 1.77
imc <- peso / (altura ^ 2)
imc

vetor <- c(1, 2, 3, 4, 5, 6)

vetor

# - - - - - - - - - - - - - - - - - - - - - - - #

# Tipo de Dados

## Numérico

42 # número inteiro

55.4 # número real

## String

"Vargas"

'Jânio Quadros'

"1945"

# Exemplo do que não fazer: 'Não intercale as aspas" (aspas simples e depois aspas duplas, por exemplo)

## Factor

factor(c("Discordo totalmente", "Discordo parcialmente", "Indiferente", "Concordo parcialmente", "Concordo totalmente")) # Note os nivelS/Levels. Eles estao ordenados?

factor(c("Discordo totalmente", "Discordo parcialmente", "Indiferente", "Concordo parcialmente", "Concordo totalmente"),
       levels = c("Discordo totalmente", "Discordo parcialmente", "Indiferente", "Concordo parcialmente", "Concordo totalmente"))
#inclui-se a parte 'levels' para o R identificar esta variável categórica


## Booleanos/logical

3 > 2 # 3 é maior que dois?

3 >= 2 # 3 é maior ou igual a dois?

3 == 2 # 3 é igual a dois?

3 != 2 # 3 é diferente a dois?

"FFLCH" == "ICB" # FFLCH é igual ao ICB?

"Acre" > "São Paulo" # Acre é maior que São Paulo? 

"A" > "B" # https://stackoverflow.com/questions/58779906/why-does-the-expression-ab-return-false-in-python


## Valores Missings/Ausentes/NA

is.na(NA) #função que retorna se o valor dentro dos parênteses é ausente ou não

NA == NA #Pq esse valor retorna ausente/NA? Por que não tem como comparar dados não disponíveis



# # # # # # # # # # # # # #
# Qual é o tipo de dado?  #
# # # # # # # # # # # # # #

class("1")

class(1)

class(1.2)

class("Ola")

class(factor(c("Sim", "Nao")))

class(3 == 2) # o resultado é FALSE, e FALSE é logical

class(TRUE)

class(NA)

# - - - - - - - - - - - - - - - - - - - - - - - #

# Estrutura de Dados

## Vetores

c(120, 29, 191, 18, 39) # O vetor só pode ter um tipo de dado

fflch <- c("Ciencias Sociais", "Historia", "Geografia", "Letras", "Filosofia")



### Indexando valores em vetores

fflch[1]

fflch[5]

fflch[6] # Qual é o resultado que temos aqui? Resposta: NA

fflch[1, 2] # Esse código deu certo? Resposta: não, devido às dimensões

fflch[c(1, 2)]

fflch[c(1, 3)]

fflch[2:4]

trem <- c(120, 29, 191, 18, 39)

trem[trem > 100] # Você também consegue indexar valores com condicionais booleanos

predio_do_meio <- c("Ciencias Sociais", "Filosofia")

fflch %in% predio_do_meio

fflch[fflch %in% predio_do_meio]



## Listas

lista <- list(1934, "FFLCH", c("Prof. Dr. Aziz Simão", "Profa. Dra. Eunice Ribeiro Durham")) 



### Indexando valores em listas

lista[1]

lista[3]

lista[[3]][2]

class(lista[3])

class(lista[[3]])