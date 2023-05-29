install.packages(c("tuber","tidyverse"), dependencies = T)


library(tuber)
library(tidyverse)

## Obtener comentarios e información de videos de omegna

omegna_list <- c("67DUvnyYkOI","2kFGQuNWyQk", "LUcAlnj2Asg", "CSakh-QNoGs", "zvDcwXcKgws", "TnDzfJm-61A", "JaEMDLTgrMY", "a1IdcRiYIUs",
                 "_hwuEJMnVuw", "-E9yesPSUoc", "SKirI9q64ec", "QmgCHXJP7ZY", "2DJ8cTDRqSQ", "PyFnie96dnw", "iSLhxV827MA", "57Yj20Dm4T0")

comments_df <- data.frame() # data frame vacío donde se almacenarán los comentarios

for (video_id in omegna_list){
  app_id <- "712498211952-94759t4ijodnt4t2dnl1sf0st30abfhj.apps.googleusercontent.com"
  app_secret <- "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"
  yt_oauth(app_id, app_secret, token = '')
  comments <- get_all_comments(video_id = video_id)
  comments_df <- rbind(comments_df, comments)
  
}


write.csv(comments_df, file = "Data/InputData/youtube_df/comments/comentarios_omegna.csv")

#Funciona de manera individual. Con el siguiente có

count_video_df <-data.frame()
video_info_df <-data.frame()

for (video_id in omegna_list){
  
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

write.csv(video_details, file = "Data/InputData/youtube_df/video_details/video_details_omegna.csv")


#unimos comentarios con detalles del video


omegna_df <-merge(video_details,comments_df, by.x ="id", by.y="videoId")


omegna_df <-omegna_df%>%
  dplyr::select(id, title, date, views,likes,comment_count,textOriginal, authorDisplayName, likeCount, publishedAt)

write.csv(omegna_df, file = "Data/InputData/youtube_df/merged_df/omegna_final.csv")



## Obtenemos comentarios y 


tabla <-omegna_df%>%
  distinct(id, authorDisplayName)%>%
  group_by(authorDisplayName)%>%
  count()%>%
  arrange(desc(n))


print(tabla)
