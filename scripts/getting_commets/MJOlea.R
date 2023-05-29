install.packages(c("tuber","tidyverse"), dependencies = T)


library(tuber)
library(tidyverse)

## Obtener comentarios e información de videos de MJOlea

MJOlea_list <- c("qMXcSm3Bh74", "S3tpwoGuXVs", "LGk-YCdThS8", "FtD7IjrpeZg", "CJxXsUnR7FU", "-845GCK2Uaw", "y3P1w-BfP1c", "sidKTdKDke8", "nAdCKDtoHtM", "j6587S3OizI","iDRegH3WcdE",
                 "a9gZY0S-UQk", "Q2KJ4DTQLHE", "ebEzcBTvTRk", "OkYc-yMxdiQ", "MwU4qj11NEI", "ECTid1l68FY", "8RaUQW2ABXc", "-4Vnzc1UPo4", "cpn8X5HXr_g", "L2M6ggPht2w", "EfecqtWFgPs",
                 "op14z2KKl8E", "Uz2lsgxtSnE", "1OcSOm9oOzE", "a0TWJgXTRTw", "qmopRn9UtFw", "0_u-MFo3Jb8", "H8hS5JxkzwM", "UsVcsyorw_w")

## Mucho ojo: están usando imagenes en videos

comments_df <- data.frame() # data frame vacío donde se almacenarán los comentarios

for (video_id in MJOlea_list){
  app_id <- "712498211952-94759t4ijodnt4t2dnl1sf0st30abfhj.apps.googleusercontent.com"
  app_secret <- "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"
  yt_oauth(app_id, app_secret, token = '')
  comments <- get_all_comments(video_id = video_id)
  comments_df <- rbind(comments_df, comments)
  
}


write.csv(comments_df, file = "Data/InputData/youtube_df/comments/comentarios_MJOlea.csv")

#Funciona de manera individual. Con el siguiente có

count_video_df <-data.frame()
video_info_df <-data.frame()

for (video_id in MJOlea_list){
  
  app_id <- "712498211952-94759t4ijodnt4t2dnl1sf0st30abfhj.apps.googleusercontent.com"
  app_secret <- "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"
  yt_oauth(app_id, app_secret, token = '')
  
  
  video <- get_video_details(video_id)
  id_info <-video[["items"]][[1]][["id"]]
  title <-video[["items"]][[1]][["snippet"]][["title"]]
  published_at <-video[["items"]][[1]][["snippet"]][["publishedAt"]]
  
  video_info<-data.frame(id = id_info,
                         title = title,
                         date = published_at)
  
  video_info_df <-rbind(video_info, video_info_df)  
  
  conteo <-get_stats(video_id)
  id_count <-conteo[["id"]]
  view_count <- conteo[["viewCount"]]
  like_count <- conteo[["likeCount"]]
  comment_count <-conteo[["commentCount"]]
  
  
  
  count_video <-data.frame(id = id_count,
                           views = view_count,
                           likes = like_count,
                           comment_count = comment_count)
  
  count_video_df <-rbind(count_video, count_video_df)
  
  
  video_details <-merge(video_info_df, count_video_df, by ="id")
  
}

#guardamos datos recolectados en un .csv

write.csv(video_details, file = "Data/InputData/youtube_df/video_details/video_details_MJOlea.csv")


#unimos comentarios con detalles del video


MJOlea_df <-merge(video_details,comments_df, by.x ="id", by.y="videoId")


MJOlea_df <-MJOlea_df%>%
  dplyr::select(id, title, date, views,likes,comment_count,textOriginal, authorDisplayName, likeCount, publishedAt)

write.csv(MJOlea_df, file = "Data/InputData/youtube_df/merged_df/MJOlea_final.csv")



## Obtenemos comentarios y 

tabla <-MJOlea_df%>%
  distinct(id, authorDisplayName)%>%
  group_by(authorDisplayName)%>%
  count()%>%
  arrange(desc(n))


print(tabla)
