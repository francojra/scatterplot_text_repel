# The R Graph Gallery - Scatterplot with automatic text repel
# Autoria do script: Jeanne Franco
# Data: 24/07/2022
# Referência: https://r-graph-gallery.com/web-scatterplot-and-ggrepel.html

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

# Adicionar rótulos sem sobreposição -------------------------------------------------------------------------------------------------------

### É um desafio adicionar muitos rótulos em um gráfico devido à tendência de 
### sobreposição tornar a figura incompreensível. Felizmente, o pacote ggrepel
### resolve esse problema. Ele promove um algoritmo que automaticamente realoca
### os rótulos. 

plt <- plt + 
  geom_text_repel(
    aes(label = highlight),
    family = "Poppins",
    size = 3,
    min.segment.length = 0, 
    seed = 42, 
    box.padding = 0.5,
    max.overlaps = Inf,
    arrow = arrow(length = unit(0.010, "npc")),
    nudge_x = .15,
    nudge_y = .5,
    color = "grey50"
  )
plt

# Gráfico final ----------------------------------------------------------------------------------------------------------------------------

### O gráfico acima está quase pronto para publicação. O que é necessário agora é
### um bom título, uma legenda para tornar cores e formas mais perspicaz, e algumas
### customizações nos eixos.

plt <- plt + 
  # Add axes labels, title, and subtitle
  labs(
    title = "Palmer Penguins Data Visualization",
    subtitle = "Scatter plot of flipper lenth vs bill length",
    x = "flip length (mm)",
    y = "bill length (mm)"
  ) +  
  theme(
    # The default font when not explicitly specified
    text = element_text(family = "Lobster Two", size = 8, color = "black"),
    
    # Customize legend text, position, and background.
    legend.text = element_text(size = 9, family = "Roboto"),
    legend.title = element_text(face = "bold", size = 12, family = "Roboto"),
    legend.position = c(1, 0),
    legend.justification = c(1, 0),
    legend.background = element_blank(),
    # This one removes the background behind each key in the legend
    legend.key = element_blank(),
    
    # Customize title and subtitle font/size/color
    plot.title = element_text(
      family = "Lobster Two", 
      size = 20,
      face = "bold", 
      color = "#2a475e"
    ),
    plot.subtitle = element_text(
      family = "Lobster Two", 
      size = 15, 
      face = "bold", 
      color = "#1b2838"
    ),
    plot.title.position = "plot",
    
    # Adjust axis parameters such as size and color.
    axis.text = element_text(size = 10, color = "black"),
    axis.title = element_text(size = 12),
    axis.ticks = element_blank(),
    # Axis lines are now lighter than default
    axis.line = element_line(colour = "grey50"),
    
    # Only keep y-axis major grid lines, with a grey color and dashed type.
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.major.y = element_line(color = "#b4aea9", linetype = "dashed"),
    
    # Use a light color for the background of the plot and the panel.
    panel.background = element_rect(fill = "#fbf9f4", color = "#fbf9f4"),
    plot.background = element_rect(fill = "#fbf9f4", color = "#fbf9f4")
  )
plt
