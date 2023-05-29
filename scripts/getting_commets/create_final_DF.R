

library(dplyr)
library(tidyverse)

AB <-read.csv(file = "Data/InputData/youtube_df/merged_df/AB_final.csv")
andrews <-read.csv(file = "Data/InputData/youtube_df/merged_df/andrews_final.csv")
navia <-read.csv(file = "Data/InputData/youtube_df/merged_df/navia_final.csv")
marinovic <-read.csv(file = "Data/InputData/youtube_df/merged_df/FNM_final.csv")
MJOlea <-read.csv(file = "Data/InputData/youtube_df/merged_df/MJOlea_final.csv")
mochiatti <-read.csv(file = "Data/InputData/youtube_df/merged_df/biobio_final.csv")
omegna <-read.csv(file = "Data/InputData/youtube_df/merged_df/omegna_final.csv")
parisi <-read.csv(file = "Data/InputData/youtube_df/merged_df/parisi_final.csv")
cantuarias <-read.csv(file = "Data/InputData/youtube_df/merged_df/cantuarias_final.csv")



parisi$leader <-"Franco Parisi"
AB$leader <-"Another Brother"
andrews$leader <-"Carlos A. Andrews"
navia$leader <- "Patricio navia"
marinovic$leader <-"Teresa Marinovic"
MJOlea$leader <-"María José Olea"
mochiatti$leader <-"Tomás Mochiatti"
omegna$leader <-"Italo Omegna"
cantuarias$leader <-"Rocío Cantuarias"



#create new df with all opinion leaders

leaders_df <-rbind(AB, andrews, navia, marinovic, MJOlea, mochiatti, omegna, parisi, cantuarias)

write.csv(leaders_df, file = "Data/FinalData/leaders_comments.csv")


tabla_parisi <-video_details_parisi%>%
  dplyr::summarise(media_views = mean(as.numeric(video_details_parisi$views)),
                   sd_views = sd(as.numeric(video_details_parisi$views)),
                   max_views = max(as.numeric(video_details_parisi$views)),
                   min_views = min(as.numeric(video_details_parisi$views)),
                   media_likes = mean(as.numeric(video_details_parisi$likes)),
                   sd_likes = sd(as.numeric(video_details_parisi$likes)),
                   max_likes = max(as.numeric(video_details_parisi$likes)),
                   min_likes = min(as.numeric(video_details_parisi$likes)),
                   media_comments = median(as.numeric(video_details_parisi$comment_count)),
                   sd_comments = sd(as.numeric(video_details_parisi$comment_count)),
                   max_comments = max(as.numeric(video_details_parisi$comment_count)),
                   min_comments = min(as.numeric(video_details_parisi$comment_count)))

tabla_parisi$leader <-"Franco Parisi"


tabla_AB <-video_details_AB%>%
  dplyr::summarise(media_views = mean(as.numeric(video_details_AB$views)),
                   sd_views = sd(as.numeric(video_details_AB$views)),
                   max_views = max(as.numeric(video_details_AB$views)),
                   min_views = min(as.numeric(video_details_AB$views)),
                   media_likes = mean(as.numeric(video_details_AB$likes)),
                   sd_likes = sd(as.numeric(video_details_AB$likes)),
                   max_likes = max(as.numeric(video_details_AB$likes)),
                   min_likes = min(as.numeric(video_details_AB$likes)),
                   media_comments = median(as.numeric(video_details_AB$comment_count)),
                   sd_comments = sd(as.numeric(video_details_AB$comment_count)),
                   max_comments = max(as.numeric(video_details_AB$comment_count)),
                   min_comments = min(as.numeric(video_details_AB$comment_count)))

tabla_AB$leader <-"Another Brother"


video_details_andrews <-dplyr::distinct(video_details_andrews, id, title, date, views, likes, comment_count)
  
tabla_andrews <-video_details_andrews%>%
  dplyr::summarise(media_views = mean(as.numeric(video_details_andrews$views)),
                   sd_views = sd(as.numeric(video_details_andrews$views)),
                   max_views = max(as.numeric(video_details_andrews$views)),
                   min_views = min(as.numeric(video_details_andrews$views)),
                   media_likes = mean(as.numeric(video_details_andrews$likes)),
                   sd_likes = sd(as.numeric(video_details_andrews$likes)),
                   max_likes = max(as.numeric(video_details_andrews$likes)),
                   min_likes = min(as.numeric(video_details_andrews$likes)),
                   media_comments = median(as.numeric(video_details_andrews$comment_count)),
                   sd_comments = sd(as.numeric(video_details_andrews$comment_count)),
                   max_comments = max(as.numeric(video_details_andrews$comment_count)),
                   min_comments = min(as.numeric(video_details_andrews$comment_count)))

tabla_andrews$leader <-"Carlos A. Andrews"


tabla_marinovic <-video_details_marinovic%>%
  dplyr::summarise(media_views = mean(as.numeric(video_details_marinovic$views)),
                   sd_views = sd(as.numeric(video_details_marinovic$views)),
                   max_views = max(as.numeric(video_details_marinovic$views)),
                   min_views = min(as.numeric(video_details_marinovic$views)),
                   media_likes = mean(as.numeric(video_details_marinovic$likes)),
                   sd_likes = sd(as.numeric(video_details_marinovic$likes)),
                   max_likes = max(as.numeric(video_details_marinovic$likes)),
                   min_likes = min(as.numeric(video_details_marinovic$likes)),
                   media_comments = median(as.numeric(video_details_marinovic$comment_count)),
                   sd_comments = sd(as.numeric(video_details_marinovic$comment_count)),
                   max_comments = max(as.numeric(video_details_marinovic$comment_count)),
                   min_comments = min(as.numeric(video_details_marinovic$comment_count)))

tabla_marinovic$leader <-"Teresa Marinovic"



tabla_MJOlea <-video_details_MJOlea%>%
  dplyr::summarise(media_views = mean(as.numeric(video_details_MJOlea$views)),
                   sd_views = sd(as.numeric(video_details_MJOlea$views)),
                   max_views = max(as.numeric(video_details_MJOlea$views)),
                   min_views = min(as.numeric(video_details_MJOlea$views)),
                   media_likes = mean(as.numeric(video_details_MJOlea$likes)),
                   sd_likes = sd(as.numeric(video_details_MJOlea$likes)),
                   max_likes = max(as.numeric(video_details_MJOlea$likes)),
                   min_likes = min(as.numeric(video_details_MJOlea$likes)),
                   media_comments = median(as.numeric(video_details_MJOlea$comment_count)),
                   sd_comments = sd(as.numeric(video_details_MJOlea$comment_count)),
                   max_comments = max(as.numeric(video_details_MJOlea$comment_count)),
                   min_comments = min(as.numeric(video_details_MJOlea$comment_count)))
  
tabla_MJOlea$leader <- "Maria Jose Olea"


tabla_mochiatti <-video_details_mochiatti%>%
  dplyr::summarise(media_views = mean(as.numeric(video_details_mochiatti$views)),
                   sd_views = sd(as.numeric(video_details_mochiatti$views)),
                   max_views = max(as.numeric(video_details_mochiatti$views)),
                   min_views = min(as.numeric(video_details_mochiatti$views)),
                   media_likes = mean(as.numeric(video_details_mochiatti$likes)),
                   sd_likes = sd(as.numeric(video_details_mochiatti$likes)),
                   max_likes = max(as.numeric(video_details_mochiatti$likes)),
                   min_likes = min(as.numeric(video_details_mochiatti$likes)),
                   media_comments = median(as.numeric(video_details_mochiatti$comment_count)),
                   sd_comments = sd(as.numeric(video_details_mochiatti$comment_count)),
                   max_comments = max(as.numeric(video_details_mochiatti$comment_count)),
                   min_comments = min(as.numeric(video_details_mochiatti$comment_count)))

tabla_mochiatti$leader <-"Tomás Mochiatti"


tabla_navia <-video_details_navia%>%
  dplyr::summarise(media_views = mean(as.numeric(video_details_navia$views)),
                   sd_views = sd(as.numeric(video_details_navia$views)),
                   max_views = max(as.numeric(video_details_navia$views)),
                   min_views = min(as.numeric(video_details_navia$views)),
                   media_likes = mean(as.numeric(video_details_navia$likes)),
                   sd_likes = sd(as.numeric(video_details_navia$likes)),
                   max_likes = max(as.numeric(video_details_navia$likes)),
                   min_likes = min(as.numeric(video_details_navia$likes)),
                   media_comments = median(as.numeric(video_details_navia$comment_count)),
                   sd_comments = sd(as.numeric(video_details_navia$comment_count)),
                   max_comments = max(as.numeric(video_details_navia$comment_count)),
                   min_comments = min(as.numeric(video_details_navia$comment_count)))

tabla_navia$leader <-"Patricio Navia"

tabla_omegna <-video_details_omegna%>%
  dplyr::summarise(media_views = mean(as.numeric(video_details_omegna$views)),
                   sd_views = sd(as.numeric(video_details_omegna$views)),
                   max_views = max(as.numeric(video_details_omegna$views)),
                   min_views = min(as.numeric(video_details_omegna$views)),
                   media_likes = mean(as.numeric(video_details_omegna$likes)),
                   sd_likes = sd(as.numeric(video_details_omegna$likes)),
                   max_likes = max(as.numeric(video_details_omegna$likes)),
                   min_likes = min(as.numeric(video_details_omegna$likes)),
                   media_comments = median(as.numeric(video_details_omegna$comment_count)),
                   sd_comments = sd(as.numeric(video_details_omegna$comment_count)),
                   max_comments = max(as.numeric(video_details_omegna$comment_count)),
                   min_comments = min(as.numeric(video_details_omegna$comment_count)))

tabla_omegna$leader <-"Italo Omegna"


leaders_ranking <-rbind(tabla_AB, tabla_andrews, tabla_marinovic, tabla_MJOlea, tabla_mochiatti, tabla_navia, tabla_omegna, tabla_parisi)

leaders_ranking <-leaders_ranking[order(leaders_ranking$media_comments, decreasing = TRUE),]

leaders_ranking<-dplyr::select(leaders_ranking, leader, media_comments, sd_comments, media_views, sd_views, media_likes, sd_likes)


