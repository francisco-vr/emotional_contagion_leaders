### Get 50 random phrares from comments

library(tidyverse)

num_filas <- nrow(leaders_comments)

set.seed(123)

# Seleccionar aleatoriamente 50 filas
muestras <- leaders_comments %>%
  sample_n(50)

print(muestras$textOriginal)


write.csv(muestras, file = "Data/FinalData/pilotaje_comentarios.csv")


## sampleo de comentarios

mochiatti <-read.csv(file = "Data/InputData/youtube_df/video_details/video_details_mochiatti.csv")
marinovic <-read.csv(file = "Data/InputData/youtube_df/video_details/video_details_marinovic.csv")
MJOlea <- read.csv(file = "Data/InputData/youtube_df/video_details/video_details_MJOlea.csv")
omegna <-read.csv(file ="Data/InputData/youtube_df/video_details/video_details_omegna.csv")
andrews <-read.csv(file = "Data/InputData/youtube_df/video_details/video_details_andrews.csv")
AB <-read.csv(file = "Data/InputData/youtube_df/video_details/video_details_AB.csv")


text_videos_df <-rbind(mochiatti, marinovic, MJOlea, omegna, andrews, AB)

write.csv(text_videos_df, file = "Data/InputData/sample_videotext.csv")
