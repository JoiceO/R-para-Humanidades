#abrindo as bibliotecas necessarias 
install.packages("dplyr")
library(dplyr)
install.packages("tidyr")
library(tidyr)
install.packages("readr")
library(readr)

#abrindo o banco de dados 
#funçao read_csv para ler arquivos em csv
atletas_eventos <- read_csv("C:/Users/Joice/Documents/R/aula3_athlete_events.csv")

View(atletas_eventos)

#rename()
#mudando o nome das variaveis para o portugues

atletas_eventos <-
  rename(atletas_eventos,"Nome"="Name",
         "Sexo"="Sex",
         "Idade"="Age",
         "Altura"="Height",
         "Peso"="Weight",
         "Time"="Team",
         "CON"="NOC",
         "Jogos"="Games",
         "Ano"="Year",
         "EstaÃ§Ã£o"="Season",
         "Cidade"="City",
         "Esporte"="Sport",
         "Evento"="Event",
         "Medalha"="Medal")

atletas_eventos

#select()

select(atletas_eventos,Nome,Sexo,Idade)

#excluindo coluna do banco
select(atletas_eventos,-CON)

#filter()

filter(atletas_eventos, Sexo == "F")

#mais de um filter

filter(atletas_eventos, Ano == 2016 & Idade < 18 & Time == "Brazil")

#ou

filter(atletas_eventos, Altura <= 165 | Peso >60 )

#atletas que participaram de todos os jogos depois de 2004 e que possuem
#altura de 1,65 ou peso maior ou igual a 70kg

filter(atletas_eventos, (Altura == 165 | Peso >= 70) &  Ano > 2004)

#mutate()

#criando variavel

atletas_mutate <- 
mutate(atletas_eventos, Idade_Categoria = ifelse(Idade >=60,"IDOSO","ADULTO"))

View(atletas_mutate)

atletas_mutate2 <-
mutate(atletas_eventos, Age_Category = case_when(Idade >= 60 ~ "IDOSO",
                                                 Idade < 60 ~ "ADULTO"))

View(atletas_mutate2)

#mudando o nome de observaçoes dentro de uma variavel

atletas_eventos <-
mutate(atletas_eventos, Medalha = case_when(Medalha == "Gold"~"Ouro",
                                          Medalha =="Silver"~"Prata",
                                          TRUE ~ Medalha))
View(atletas_eventos)

#count()

count(atletas_eventos, Idade)

count(atletas_eventos, Medalha)

#dica: se quisermos omitir os NA podemos usar a funçao na.omit()
na.omit(count(atletas_eventos,Medalha))