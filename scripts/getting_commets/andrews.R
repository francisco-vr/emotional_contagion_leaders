install.packages(c("tuber","tidyverse"), dependencies = T)


library(tuber)
library(tidyverse)

## Obtener comentarios e información de videos de andrews

andrews_list <- c("fnENAx3QGVo", "K5Yooi9mVSQ", "MjmjSEqhCzo", "OAUA_MbgvLI", "FEisI7PSUKU", "F8tlay9u89c", "B5knPkftVnw", "I5IvxUL74HA", "s0lT1_cr4fQ", "yLzSdArJc2g", "WC0Hn4iQJyw",
                  "5DY38BtN7Zs", "SHplq20tHpQ", "L-AgTS5VtgM", "fesukrjaZtA", "1GiNyI-f7bI", "cpB5lAqUkNo", "yG9Hz5y6Lvk", "pG3sSSwPVD0", "UWfK6mweaYM", "PACfMnWyxKs", "eZGGMYzhWFw",
                  "MjmjSEqhCzo", "bi3eyR3ioCw")

comments_df <- data.frame() # data frame vacío donde se almacenarán los comentarios

for (video_id in andrews_list){
  app_id <- "712498211952-94759t4ijodnt4t2dnl1sf0st30abfhj.apps.googleusercontent.com"
  app_secret <- "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"
  yt_oauth(app_id, app_secret, token = '')
  comments <- get_all_comments(video_id = video_id)
  comments_df <- rbind(comments_df, comments)
  
}


write.csv(comments_df, file = "Data/InputData/youtube_df/comments/comentarios_andrews.csv")

#Funciona de manera individual. Con el siguiente có

count_video_df <-data.frame()
video_info_df <-data.frame()

for (video_id in andrews_list){
  
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

write.csv(video_details, file = "Data/InputData/youtube_df/video_details/video_details_andrews.csv")


#unimos comentarios con detalles del video


andrews_df <-merge(video_details,comments_df, by.x ="id", by.y="videoId")


andrews_df <-andrews_df%>%
  dplyr::select(id, title, date, views,likes,comment_count,textOriginal, authorDisplayName, likeCount, publishedAt)

write.csv(andrews_df, file = "Data/InputData/youtube_df/merged_df/andrews_final.csv")



## Obtenemos comentarios y 

tabla <-andrews_df%>%
  distinct(id, authorDisplayName)%>%
  group_by(authorDisplayName)%>%
  count()%>%
  arrange(desc(n))


print(tabla)
