install.packages(c("tuber","tidyverse"), dependencies = T)


library(tuber)
library(tidyverse)

## Obtener comentarios e información de videos de BIOBIO

biobio_list <- c("pilmy3WBDpY", "RSTL6rpjF-g","UfF8DwLCjlg", "v-ZLcMXpBkA", "AI_VS6Cj9oo", "5kHcGQhwh40", "uL4kyVa6bdU", "Sdryz-cO9Bk", "20iTCG7iBUA",
                "BdKbrP1s5sQ", "pLPLAQxPcaQ", "X9o5hb82E7U", "LVEoiUGgET8", "wfu0KYWHssM", "HZUTdKM7CHA", "RdisQUAvdVg",
                "D3v9rc4GpPg", "XtZ1xM9e55s", "QySXHwwGN9M", "8WIDoHFYqNE", "zIioYl4ets0", "6gElqOntDYI", "kj8hRjBvPbI",
                "H7Eir-qluZQ", "JfdxwNoATiQ", "ZvpdMfTrEwQ", "2U0v8mUi0-8","QiY8O-S7XhQ", "PqArtXDCK-c", "ZcatsXmNpOY",
                "2O8IXsAOyc4", "pQkrL-82x7M", "QxgSSqseZCA", "w7JxvuYQMDg", "oOaK3yltrZo", "9qiQvB4jhsA", "3QngCpBN9ao",
                "9E-DymwHONI", "IKcA5N0lS1I", "Mgcrb4tujvk", "DiI9NUtzFN8", "27ctugDSooA", "uiD9ssD5XKU", "AUQTY78OfnE",
                "s2NIGPa2v7U", "I9BxL9CPNnI", "v3F0kq1DAOo", "29WsrvmYOro", "HL2Qvzw9Jyw")

comments_df <- data.frame() # data frame vacío donde se almacenarán los comentarios

for (video_id in biobio_list){
app_id <- "712498211952-94759t4ijodnt4t2dnl1sf0st30abfhj.apps.googleusercontent.com"
app_secret <- "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"
yt_oauth(app_id, app_secret, token = '')
comments <- get_all_comments(video_id = video_id)
comments_df <- rbind(comments_df, comments)

}


write.csv(comments_df, file = "Data/InputData/youtube_df/comments/comentarios_biobio.csv")

#Funciona de manera individual. Con el siguiente có

count_video_df <-data.frame()
video_info_df <-data.frame()

for (video_id in biobio_list){

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

write.csv(video_details, file = "Data/InputData/youtube_df/video_details/video_details_mochiatti.csv")


#unimos comentarios con detalles del video


biobio_df <-merge(video_details,comments_df, by.x ="id", by.y="videoId")


biobio_df <-biobio_df%>%
  dplyr::select(id, title, date, views,likes,comment_count,textOriginal, authorDisplayName, likeCount, publishedAt)

write.csv(biobio_df, file = "Data/InputData/youtube_df/merged_df/biobio_final.csv")



## Obtenemos comentarios y 


tabla <-biobio_df%>%
  distinct(id, authorDisplayName)%>%
  group_by(authorDisplayName)%>%
  count()%>%
  arrange(desc(n))
  

print(tabla)
