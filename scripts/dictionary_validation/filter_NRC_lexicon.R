# Filter NRC Lexicon non-value words
library(tidyverse)
library(dplyr)


NRC <-read.csv("Data/InputData/Spanish-NRC-EmoLex.csv")

## Eliminar las columnas de anticipation y trust

NRC <-NRC%>%
  dplyr::select(English.Word, anger, disgust, fear, joy, negative, positive, sadness, surprise, Spanish.Word)


# filtrar las filas que tienen valor "0" en las 10 columnas de emociones

NRC_short <- NRC[rowSums(NRC[, 2:9]) != 0, ]

# donde "datos" es el nombre de tu base de datos y "2:9" son las columnas que contienen las emociones

# guardar la nueva base de datos
write.csv(NRC_short, file = "Data/InputData/NRC_reduced_1.csv")
