install.packages(c("tuber","tidyverse"), dependencies = T)


library(tuber)
library(tidyverse)
library(dplyr)

## Obtener comentarios e información de videos de parisi

parisi_list <- c("z1dzJdhJ9OI","fnLUiEm6BGc","_-GJnZnL0cE","l5nJsi70hJE","baE0Q4mqOGg","6nPIwOE7-Eo","UUT3B-o0O8w",
                 "-OiIhIDu8IE","TswPay9PCVk","3a-MFiMd2qk","JCENrI6l3W0","zixQxSFO-o0","kQ69zP6y4wA","0AjiJmPvq1E",
                 "9OAaszi-M0I","RDvuUyibOHk","lYSsYbofkRc","lYSsYbofkRc","RDvuUyibOHk","nRKiHxXbUBs","K0AlRg5mrSs",
                 "QpPfIen4i0o","_yFtKE99DhQ","oz_uV_MWLLk","stAKYmYG90g","HzStZ4_CG0A","iAfARZv-PcM","RdipkGoUrcw",
                 "GL-0XDDBWRg","gVaPoZfspDQ","j_j3iJeBg9c","agP8LntK-Cc","uE6E7YhqeKI","m4y4KOdixZ0","n2AgMuOgDV8",
                 "9vbjo7X99NM","esFYEJxmQrY","6iCqvY6xmQk","LD1or7jCrlE","UpyHabXR8G8","eGY-EVMpRNw","5_5A8j5nwhg",
                 "Uc2pcG1Qvjs","l_BNuQeayL4","rczPppew5IA","D1kVEHGJXnI","rVrbgAGhsao","b-IsQsqn8mo")

comments_df <- data.frame() # data frame vacío donde se almacenarán los comentarios

for (video_id in parisi_list){
  app_id <- "712498211952-94759t4ijodnt4t2dnl1sf0st30abfhj.apps.googleusercontent.com"
  app_secret <- "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"
  yt_oauth(app_id, app_secret, token = '')
  comments <- get_all_comments(video_id = video_id)
  comments_df <- rbind(comments_df, comments)
  
}


write.csv(comments_df, file = "Data/InputData/youtube_df/comments/comentarios_parisi.csv")

#Funciona de manera individual. Con el siguiente có

count_video_df <-data.frame()
video_info_df <-data.frame()

for (video_id in parisi_list){
  
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

write.csv(video_details, file = "Data/InputData/youtube_df/video_details/video_details_parisi.csv")

#video_details <-dplyr::distinct(video_details)


#unimos comentarios con detalles del video


parisi_df <-merge(video_details,comments_df, by.x ="id", by.y="videoId")


parisi_df <-parisi_df%>%
  dplyr::select(id, title, date, views,likes,comment_count,textOriginal, authorDisplayName, likeCount, publishedAt)

write.csv(parisi_df, file = "Data/InputData/youtube_df/merged_df/parisi_final.csv")



## Obtenemos comentarios y 


tabla <-parisi_df%>%
  distinct(id, authorDisplayName)%>%
  group_by(authorDisplayName)%>%
  count()%>%
  arrange(desc(n))


print(tabla)
