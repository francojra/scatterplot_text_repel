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


