# The R Graph Gallery - Scatterplot with automatic text repel
# Autoria do script: Jeanne Franco
# Data: 24/07/2022

# Introdução -------------------------------------------------------------------------------------------------------------------------------

### Um customizado scatterplot com rótulos posicionados para explorar o dataset
### "palmerpenguins" feito com R e tidyverse. O scatterplot customizado inclui
### uma variaedade de cores, marcadores e fontes. O pacote ggrepel é usado para
### automaticamente ajustar a posição dos rótulos no gráfico.

# Carregar pacotes -------------------------------------------------------------------------------------------------------------------------

### Primeiro é necessário carregar alguns pacotes antes de construir a figura. 
### O pacote ggrepel fornece geoms do ggplot2 para "repelir (repel)" rótulos
### que estão sendo sobrepostos. O ggrepel permite afastar os rótulos uns dos
### outros, dos pontos e das bordas do gráfico, tornando a visualização mais
### agradável. Da mesma forma, o pacote randomNames é usado para gerar nomes
### randomicamente que serão rotulados no gráfico.

library(ggrepel)
library(palmerpenguins)
library(randomNames)
library(tidyverse)

# Preparar dataset -------------------------------------------------------------------------------------------------------------------------

### Os dados palmerpenguins foram coletados e disponibilizados por Dr. Kristen
### Gorman e o Palmer Station, Antarctica LTER, um membro do Long Term Ecological
### Research Network. Esse dataset foi popularizado por Allison Horst no pacote
### palmerpenguins do R com o objetivo de oferecer uma alternativa ao iris dataset
### para exploração e visualização de dados.

data("penguins", package = "palmerpenguins")

### Primeiro, as informações perdidas devem ser removidas do dataset.

penguins <- drop_na(penguins)

### Para cada observação é assinado um nome randômico. Uma nova variável highlight
### é adicionada ao dataset para indicar quais nomes são destacados no plot. Esses
### são os nomes iniciados com a letra "C".

## Generate random names
# The results of set.seed may depends on R version.
set.seed(2021 + 03 + 27)
name_vector <- randomNames(nrow(penguins), which.names = "first")

## Create 'highlight' indicator variable
penguins <- penguins %>% 
  mutate(
    name = name_vector,
    highlight = case_when(
      str_starts(name, "C") ~ name,
      TRUE ~ ""
      )
    ) 

# Gráfico de base --------------------------------------------------------------------------------------------------------------------------

### O gráfico de base é um scatterplot que mostra a associação entre o comprimento
### das nadadeiras e comprimento do bicos de pinguins. Os pontos são coloridos
### de acordo com as espécies que indica uma informação extra na camada do gráfico.

# Note `color = species` and s`hape = species`.
# This means each species will have BOTH  a different color and shape.
plt <- ggplot(penguins, aes(x = flipper_length_mm, y = bill_length_mm)) +
  geom_point(
    aes(color = species, shape = species),
    size = 1.5, 
    alpha = 0.8 # It's nice to add some transparency because there may be overlap.
  ) +
  # Use custom colors
  scale_color_manual(
    values = c("#386cb0", "#fdb462", "#7fc97f")
  )
plt
