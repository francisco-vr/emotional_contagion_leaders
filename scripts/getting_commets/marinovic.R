### Captura de comentarios e información de videos Teresa Marinovic, Fundación Nueva Mente (marinovic)


library(tuber)
library(tidyverse)

## Obtener comentarios e información de videos de BIOBIO

marinovic_list <- c("BQDXk-gEa64", "8TkL3mE3Nyk", "xD4I5KEOZEg", "kBApsFg_0qI", "rSGJv6vIw2A", "Ga4L0IKafe4", "TuKEjWmZTw8", "-gaEq9GevCk",
                    "tRS_c4EzLVI", "LoakgWcpbF8", "8gWfMD_b_Ic", "yK_DEtg-t3U", "A5m0dHUe8Ew", "XJWNFnoIETY", "C99XNkt_wgA", "eyM5zczUX_c",
                    "HNf2sRwUcx0", "RSuEFTt77L0", "q6tdyuXwH6g", "Fi0ITqSZIUA", "1MGbkft_RL4", "iA61KyRAp90", "NR8tZNubzaQ", "N9QXjq3s7-I",
                    "EI5bUkLeBe0", "iVV5Wh3l9So", "3vO9jOROVTs", "6jwH4a0rYD8", "qak37Wwk7pA", "3SuE9iO5x2Y", "1Ft8XfzC5QY", "YXcV5RjkP_Q",
                    "BtfFv449oJw", "7tJ_5XK9ntI", "U81hHT15_AI", "S1nNOcsxeYY", "YSW64PZhkb4", "N0irPr-cR4Q", "h0A48ZGzhh0", "nWEkUrSu6M4",
                    "oUINNep1QHw")

comments_df <- data.frame() # data frame vacío donde se almacenarán los comentarios

for (video_id in marinovic_list){
  app_id <- "712498211952-94759t4ijodnt4t2dnl1sf0st30abfhj.apps.googleusercontent.com"
  app_secret <- "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"
  yt_oauth(app_id, app_secret, token = '')
  comments <- get_all_comments(video_id = video_id)
  comments_df <- rbind(comments_df, comments)
  
}


write.csv(comments_df, file = "Data/InputData/youtube_df/comments/comentarios_marinovic.csv")

#Funciona de manera individual. Con el siguiente có

count_video_df <-data.frame()
video_info_df <-data.frame()

for (video_id in marinovic_list){
  
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
  
  
  video_details_marinovic <-merge(video_info_df, count_video_df, by ="id")
  
}

#guardamos datos recolectados en un .csv

write.csv(video_details_marinovic, file = "Data/InputData/youtube_df/video_details/video_details_marinovic.csv")


#unimos comentarios con detalles del video


marinovic_df <-merge(video_details_marinovic,comments_df, by.x ="id", by.y="videoId")


marinovic_df <-marinovic_df%>%
  dplyr::select(id, title, date, views,likes,comment_count,textOriginal, authorDisplayName, likeCount, publishedAt)

write.csv(marinovic_df, file = "Data/InputData/youtube_df/merged_df/marinovic_final.csv")

## Obtenemos comentarios y 


tabla <-marinovic_df%>%
  distinct(id, authorDisplayName)%>%
  group_by(authorDisplayName)%>%
  count()%>%
  arrange(desc(n))


print(tabla)

