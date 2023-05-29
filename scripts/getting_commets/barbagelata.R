install.packages(c("tuber","tidyverse"), dependencies = T)


library(tuber)
library(tidyverse)
library(dplyr)

## Obtener comentarios e información de videos de barbagelata

barbagelata_list <- c("DdeUF-bmR7A", "1xBXN9-jRI8", "PlIpOfU9FbM", "1sT3PibOYS4", "1sT3PibOYS4", "KjZcViYBUbQ", "zujQJJrOFQg",
                      "3oHjINWI85w", "HjYwMFAjEyA", "mpyi4S1b2IQ", "S8gkdUmiDKY", "xcMXUeRXg7U", "LvK5KjrONnc", "OjKJVr_ah28",
                      "0zzHtVOo8sg", "xHq0viK1qdk", "Fx9CrKw3bkY", "pMbtS50p_u8", "Cs3LvWTnIPA", "p7j9i7sLENc", "NI4L_gcK9R4",
                      "KiTNxByeHn8", "oFY-GT6N9YA", "FBBOMeqVXVM", "DLIiwIQhcR4", "MR7RaDJYqwM", "5aspaz3Ku0M", "_QwbXAPvVIw",
                      "EIdJCVWeHD0", "B9yXVYQdZxE", "nLE-cI0ZC44", "yfllQaPwtvY", "8-sNArctu-4", "wslvTOdwiXM", "jvsrQO9tkUY",
                      "hCJeLN-Yhs8", "be--J-6V_pM", "X_G6YIaz7tw", "AQ0DitLpv4g", "lZWGNugM9qY", "N4-oTE5FuGo", "Ny3GgrdEEng",
                      "BueyzWrVYKk", "GmwfzJOtjMs", "KG4zcN0URzE", "l2z9z1QKQ4Y")

comments_df <- data.frame() # data frame vacío donde se almacenarán los comentarios

for (video_id in barbagelata_list){
  app_id <- "712498211952-94759t4ijodnt4t2dnl1sf0st30abfhj.apps.googleusercontent.com"
  app_secret <- "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"
  yt_oauth(app_id, app_secret, token = '')
  comments <- get_all_comments(video_id = video_id)
  comments_df <- rbind(comments_df, comments)
  
}


write.csv(comments_df, file = "Data/InputData/youtube_df/comments/comentarios_barbagelata.csv")

#Funciona de manera individual. Con el siguiente có

count_video_df <-data.frame()
video_info_df <-data.frame()

for (video_id in barbagelata_list){
  
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

write.csv(video_details, file = "Data/InputData/youtube_df/video_details/video_details_barbagelata.csv")

#video_details <-dplyr::distinct(video_details)


#unimos comentarios con detalles del video


barbagelata_df <-merge(video_details,comments_df, by.x ="id", by.y="videoId")


barbagelata_df <-barbagelata_df%>%
  dplyr::select(id, title, date, views,likes,comment_count,textOriginal, authorDisplayName, likeCount, publishedAt)

write.csv(barbagelata_df, file = "Data/InputData/youtube_df/merged_df/barbagelata_final.csv")



## Obtenemos comentarios y 


tabla <-barbagelata_df%>%
  distinct(id, authorDisplayName)%>%
  group_by(authorDisplayName)%>%
  count()%>%
  arrange(desc(n))


print(tabla)
