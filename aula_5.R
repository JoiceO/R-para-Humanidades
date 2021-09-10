##
##AULA VISUALIZACAO DE DADOS
##

#para importar o banco

library(readr)
install.packages('curl')
banco <- read_csv("https://raw.githubusercontent.com/p4hUSP/material-2021/master/athlete_events.csv", show_col_types = FALSE)

#1. ggplot2 
##Vamos carregar as bibliotecas que utilizaremos
library(ggplot2)
library(dplyr)
#install.packages("Amelia")
library(Amelia)


#vamos ver um resumo do nosso banco?
glimpse(banco)


#Vamos ver quantos casos missings (NA) temos no nosso banco:
Amelia::missmap(banco)


## vamos fazer algumas modificacoes: 
#1. Filtrar peso, altura e idade apenas por valores que nao possuem NA. 
#2. Alem disso, selecionar apenas os jogos de verao e, em seguida, excluir a variavel "Season".

## 
banco <- banco %>% filter(is.na(Height)==FALSE, is.na(Weight)==FALSE, is.na(Age)==FALSE,  #1
                          Season=="Summer") %>% select(-Season) #2


#vamos ver como ficou nosso banco
Amelia::missmap(banco)


#agora, vamos criar uma variavvel dividindo medalhistas e nao medalhistas
banco <- banco %>% 
  mutate(Medalhista = ifelse(is.na(Medal)==TRUE, "Nao-medalhista", "Medalhista")) 

#vamos ver se funcionou
head(banco)
table(banco$Medal, banco$Medalhista)


#########
#GGPLOT2#
#########

####Lembrando, os elementos gramaticais que temos no `ggplot2` sao:
#a. Data - O dado que serah plotado, mapeando as variaveis de interesse.
#b. Aesthetics - A escala em que o dado serah plotado, sinalizando os eixos x e y, cor, tamanho, preenchimento e etc.
#c. Geom - Estrutura que serah utilizada nos seus dados, como por exemplo, grafico de dispersao, linha, boxplot e etc.
#d. Facets - plotar multiplos grupos
#e. Stats - Transformacoes estatisticas
#f. Coordinates System - O espaco no qual o dado sera plotado, como por exemplo, espaco cartesiano, polar e entre outros.
#g. Theme - Controle e modificacao de aparencia de tudo que nao diz respeito ao dado utilizado.
####


#####################################
##Como fazer um grafico no `ggplot2`#
#####################################

#Podemos comparar o processo de fazer um grafico no ggplot ao de fazer um grafico em papel transparente,
#sobrepondo camada sobre camada.

#Passo 1 (papel em branco): dados (data)
ggplot(data= banco)

#Passo 2 (segunda camada): definir eixo x e eixo y (aes)
ggplot(data = banco, mapping = aes(x = Age , y = Height)) #data e aesthetics

#Passo 3 (terceira camada): definir tipo de grafico (geom)
ggplot(data = banco, mapping = aes(x = Age, y = Height)) +  #data e aesthetics
  geom_point() #geometries

#com essas 3 camadas (data, aesthetics e geom) jah podemos ter um grafico basico. 
#Mas vamos colocar uma nova camada para melhorar a interpretacao
ggplot(data = banco, mapping = aes(x = Age, y = Height)) +  #data e aesthetics
  geom_point() + #geometries
  geom_smooth() # geom e stats. Eh a linha de tendencia


#############
##AESTHETICS#
#############

#dentro do aes, podemos utilIzar, alem dos eixos x e y, parametros de color, shape, size, fill, width.

#shape. Cada categoria da variavel medalhista recebe uma forma
ggplot(data = banco, mapping = aes(x = Age, y = Height, shape=Medalhista)) + #data e aesthetics 
  geom_point() + #geom
  geom_smooth(stat="smooth") #geom e stat 

#color. Cada categoria da variavel medalhista recebe uma cor
ggplot(data = banco, mapping = aes(x = Age, y = Height, color=Medalhista)) + #data e aesthetics 
  geom_point() + #geom
  geom_smooth(stat="smooth") #geom e stat 

#Perceba que usar a cor para o mapeamento eh diferente de simplesmente mudar a cor do grafico
ggplot(data = banco, mapping = aes(x = Age, y = Height, color="blue")) + #data e aesthetics 
  geom_point() + #geom
  geom_smooth(stat="smooth") #geom e stat


#######
#GEOMS#
#######

#Podemos mudar a aparencia do grafico mexendo nos geoms

#Vamos pintar nossos pontos de azul
ggplot(data = banco, mapping = aes(x = Age, y = Height)) + 
  geom_point(color="blue") +
  geom_smooth()

#Vamos mudar o tamanho e forma dos pontos
ggplot(data = banco, mapping = aes(x = Age, y = Height)) + 
  geom_point(color="blue",
             shape =  "square",
             size=1) +
  geom_smooth()


####
####Vamos ver outros geom?
####


####### geom_col()
#######
#vamos criar uma tabela para contar a quantidade e proporcao de medalhistas e nao medalhistas
tab1 <- banco %>% 
  group_by(Medalhista) %>% 
  summarise(n = n()) %>% mutate(freq = n/sum(n))

tab1

#Vamos para o geom_col()
ggplot(data = tab1, mapping = aes(x = Medalhista, y = freq)) + 
  geom_col()

#Podemos fazer alguams alteracoes de aparencia, assim como no grafico anterior.
ggplot(data = tab1, mapping = aes(x = Medalhista, y = freq)) + 
  geom_col(fill = "red",  width = 0.5)


#######geom_histogram() e geom_density()
#######

ggplot(banco, aes(x = Age)) + 
  geom_histogram(bins = 20)

ggplot(banco, aes(x = Age)) +
  geom_histogram(bins = 20, color = "blue", fill = "green")


ggplot(banco, aes(x = Age)) + 
  geom_density(color = "blue", fill = "green", alpha = 0.5)

ggplot(banco, aes(x = Age, fill = Medalhista)) + 
  geom_density(color = "blue", alpha = 0.5)


######## geom_boxplot() e geom_violin()
########
ggplot(banco, aes(x = Medalhista, y = Age)) + 
  geom_boxplot(fill = "#444054", color = "#cc3f0c") #se quiser ver outras cores, visite (https://coolors.co/app)

ggplot(banco, aes(x = Medalhista, y = Age)) + 
  geom_violin(fill = "#8c1c13", alpha = 1/2)


######## geom_line()
########
#para este exercicio, vamos criar uma tabela com o numero de competidores por ano
tab3 <- banco %>% 
  group_by(Year) %>% 
  summarise(n = n())
tab3

#geom_line()
ggplot(data = tab3, mapping = aes(x = Year, y =n)) + 
  geom_line() 

#EXERCICIO:  inclua um geom_point e altere a cor dos pontos
ggplot(data = tab3, mapping = aes(x = Year, y = n)) + 
  geom_line()  


########
#FACETS#
########

ggplot(banco, aes(x = Medalhista, y = Age)) + 
  geom_boxplot(fill = "#444054", color = "#cc3f0c") + 
  facet_wrap(~Sex)

#############
#COORDENATES#
#############

#coord_polar()
tab1
ggplot(data = tab1, mapping = aes(x = factor(1), y = freq, fill = Medalhista)) + 
  geom_col()+ 
  coord_polar(theta = 'y')#coordendas polares

#coord_flip()
#para este grAfico, vamos fazer uma tabelas com os esportes mais praticados nas olimpiaadas
tab4 <- banco %>% group_by(Sport) %>% summarise(n=n()) %>% 
  filter(n>100) #vamos considerar apenas os esportes com mais de 100 atletas na historia das olimpiadas
tab4

#grafico de colunas 'normal'
ggplot(data = tab4, mapping = aes(x = reorder(Sport, n), y= n)) + #A funcao reorder serve para colcoar nossos valores em ordem crescente.
  geom_col()

#gráfico com eixos invertidos
ggplot(data = tab4, mapping = aes(x = reorder(Sport, n), y= n)) + #A funcao reorder serve para colcoar nossos valores em ordem crescente.
  geom_col() +
  coord_flip()  #inverte eixos x e y


#############
#THEMES######
#############

#vamos mudar a aparencia do nosso grafico

#labs
ggplot(data = tab4, mapping = aes(x = reorder(Sport, n), y= n)) + #A funcao reorder serve para colocar nossos valores em ordem crescente.
  geom_col(fill="light green") +
  coord_flip()+
  labs(title = "Atletismo eh o esporte mais praticado da historia das olimpiadas",
       x = "Esporte", 
       y = "Numero de praticantes",
       caption = "Athlete events")  #adiciona legendas

#theme
ggplot(data = tab4, mapping = aes(x = reorder(Sport, n), y= n)) + #A funcaoo reorder serve para coloecoar nossos valores em ordem crscente.
  geom_col(fill="light green") +
  coord_flip()+
  labs(title = "Atletismo eh o esporte mais praticado da historia das olimpiadas",
       x = "Esporte", 
       y = "Numero de praticantes",
       caption = "Athlete events (1896-2020)") + #adiciona legendas
  theme_bw() #aplica um tema

