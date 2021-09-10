#breve revisao dos conteudos explorados na aula passada

install.packages("tidyverse")
library(tidyverse)
install.packages("nycflights")
library(nycflights13)

#rename

View(flights)
flights <- rename(flights, departure_time = dep_time)
View(flights)

#select
flights_select1 <- select(flights, year, month, day, departure_time)

View(flights_select1)

flights_select2 <- select(flights, -hour, -minute, -time_hour)

View(flights_select2)

#filter

filter(flights, origin == "JFK" & dest == "SFO" & departure_time < 800)

filter(flights,origin %in% c("LGA", "JFK") & arr_delay >= 120 & month == 12)

filter(flights, dest == "LAX" | arr_delay >= 600)

#group_by

#abrir o banco

atletas_eventos <- read_csv("athlete_events.csv")

#agrupando por sexo
atletas_grupado <- group_by(atletas_eventos, Sex)

#sumarizando o numero de homens e de mulheres

summarise(atletas_grupado, Quantidade=n())

#soma do total de atletas por ano

summarise(count(distinct(group_by(atletas_eventos,Year), Name),Name),total_atletas_ano = sum(n))

#sumarizando a altura media de homens e mulheres

summarise(atletas_grupado, media_altura = mean(Height))
summarise(atletas_grupado, media_altura = mean(Height, na.rm=T))

#sumarizando o valor maximo de idade de homens e mulheres

summarise(atletas_grupado, maximo_idade = max(Age))
summarise(atletas_grupado, maximo_idade = max(Age, na.rm=T))

#sumarizando o valor minimo de idade de homens e mulheres

summarise(atletas_grupado, minimo_idade = min(Age, na.rm=T))

#distinct

atletas_eventos
distinct(atletas_eventos, Name)
distinct(atletas_eventos, Team)

distinct(atletas_eventos, Name, Team)

#separate

View(flights)

flights_separado <- separate(flights, time_hour, c("Data","Hora"), sep = " ")

View(flights_separado)

#unite
flights_rejuntado <- unite(flights_separado, "time_hour", c(Data,Hora), sep = " ")

View(flights_rejuntado)

#separate
atletas_separado <-separate(atletas_eventos, Name, c("Nome","Sobrenome"), sep = " ")

atletas_separado

#unite
atletas_reunido <- unite(atletas_separado,"Nome_Completo", c(Nome,Sobrenome), sep = " ")

atletas_reunido

#arrange

#o padrao do arrange eh de ordenar do menor para o maior

arrange(atletas_eventos, Age)

#podemos tambem fazer na ordem inversa ...

arrange(atletas_eventos, -Age)

#outra forma de se fazer a ordem inversa eh usando o desc() sempre acompanhado do arrange

arrange(atletas_eventos,desc(Age))

#mais exemplos

arrange(atletas_eventos, Height)

arrange(atletas_eventos, - Height)

arrange(atletas_eventos, desc(Height))

#pivot ... 

#pivot_longer()

#primeiramente escolhemos identificadores unicos que nos permitam identificar os mesmos voos em linhas
#separadas uma vez virado o banco 


flights
distinct(flights, month, day, departure_time, carrier, flight, origin, dest)

#percebemos que essas variaveis sao suficientes 
#para identificar cada voo unico

voos_longo <- select(flights, month, day, departure_time, carrier, flight, origin, dest)

#o que acontece se eu rodar sem especificar
#names_to e values_to ?

voos_longo <-  pivot_longer(flights, c(origin,dest))

View(voos_longo)

voos_longo <-  pivot_longer(flights, c(origin,dest), 
               names_to = "Direcao",
               values_to = "Aeroporto")

View(voos_longo)

#notem que temos o dobro de linhas de antes

#pivot_wider()
voos_largo <- pivot_wider(voos_longo,id_cols = c(month, day, departure_time, carrier, flight),
              names_from = Direção,
              values_from = Aeroporto)

View(voos_largo)

#atalho

voos_largo <- pivot_wider(voos_longo,
                          names_from = Direção,
                          values_from = Aeroporto)

View(voos_largo)

#top_n

top_3_mais_velhos <- select(atletas_eventos, ID, Name, Age,Sex) 
top_3_mais_velhos <- arrange(top_3_mais_velhos, -Age)
top_3_mais_velhos <- distinct(top_3_mais_velhos, Name,Age)
top_3_mais_velhos <- top_n(top_3_mais_velhos, 3, Age)

top_3_mais_velhos

top_3_mais_altos <- select(atletas_eventos, ID, Name, Height,Sex) 
top_3_mais_altos <- arrange(top_3_mais_altos, -Height)
top_3_mais_altos <- distinct(top_3_mais_altos, Name,Height)
top_3_mais_altos<- top_n(top_3_mais_altos, 3, Height)

top_3_mais_altos

#importancia do %>% e porque voce deveria usa-lo

#lembram daquele codigo do summarise?
#sem o %>%

summarise(count(distinct(group_by(atletas_eventos,Year), Name),Name),total_atletas_ano = sum(n))

#com o %>%

atletas_eventos %>%
  group_by(Year) %>%
  distinct(Name) %>%
  count(Name) %>%
  summarise(total_atletas_ano = sum(n))

#top_n dos 3 atletas mais velhos
atletas_eventos %>%
  select(ID, Name, Age,Sex) %>%
  arrange(desc(Age)) %>%
  distinct(Name,Age) %>%
  top_n(3, Age)

#top 3 atletas brasileiros com mais medalhas 

top_3_brasil <- atletas_eventos %>%
                 filter(Team == "Brazil") %>%
                 group_by(Name) %>%
                 count(Medal, na.rm=T) %>%
                 summarise(Medal = sum(n)) %>%
                 arrange(desc(Medal)) %>%
                 top_n(3, Medal)

top_3_brasil

#write_csv()

write_csv(x = top_3_brasil, "top_3_brasil.csv")


atletas_brasil <- atletas_eventos %>%
                  filter(Team == "Brazil")

write_csv(x = atletas_brasil, "atletas_brasil.csv")