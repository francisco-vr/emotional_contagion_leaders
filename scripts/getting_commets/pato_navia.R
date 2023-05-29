install.packages(c("tuber","tidyverse"), dependencies = T)


library(tuber)
library(tidyverse)

## Obtener comentarios e información de videos de navia

navia_list <- c("aY4B7VDwYRk", "Ghs7BZR0VN4", "pjzTmwBwJpg", "23yhFr4fusw", "V3cdrqCxvaQ", "GATFHvYPCI8", "sXA3IJIW2Ow", "koxUMvfCl4s", "gKhKfDEDPYE", "Y4t1hYqg8x8",
                "gAw63AaslVk", "2hgsTcZgjkk", "ZknF4kBiVYU", "uU4qBrJ0rVE", "Qnq-Ck-bE0E", "CSAGhjr_6l8", "XkJJmVDQJpY", "EWP0u2javRU", "KhOOTl8kMSE", "YM_zUeKoba0",
                "8ZLHkiVmnd4", "rPn7XV4klLs", "TVQP0kHNOuQ", "2dmMvVoyG9U", "NRy2xZjN518", "8jqr4LJpiuU", "Z7Ypj6JJCKU", "dECUsnY_kBA", "OJUdBdjR_mo", "Q0UgGaCvATY",
                "OLWJqwSPg6I", "7f5U5PfG2_0", "Vj1EDkU5I6A", "H8BtWDbmL14", "AudnK16KYgk", "g8oYcKRCWMI", "HHiRChEQB6E", "Hp5MFxNbmjE", "ekatgGmyVK8", "ei1H7LmHhPQ",
                "JdJXgbUilJ4", "367EijdUVYs", "gtrsKJkYVIc", "Setvqsn5gXw", "d69PvK-UWFg", "lQACmibn4y0", "DXxUZlNXtKU", "t97QqgTVMUY", "5o-p__VUZDc", "II7XQJw56rA",
                "QgowBaxgu2Y", "0uwVOMFDEus", "tJtDTIkfHck", "BReC7wD7MNU", "JBIzXqxVr6Y", "jfzSr6KFKWY", "lplXZYlvFU0", "7J9VzhhNvlI", "UkEbxStXzL0", "61_tIqgv9SI",
                "TSctOMFB2zw", "fyCVT177ur8", "BMj8Gpow7d0", "_4xihbucPEo", "WtHdMbsdxIQ", "-JfpbnKkq48", "iATjV2e45_M", "HfkJ82Zbsbo", "4Cn_4wabc10", "FmDlRdnKEe0",
                "gq7rhQXU7ys", "LToHzppjhZ8", "jMECZ_YDU0s", "MZ_ZHy6YmIQ", "HlleYfBzF7I", "ar8Najwh9R4", "W11-ZPD5r3w", "G31pPyq7b20", "eQTmRz_9bf8", "2G9e9uqnWmE",
                "cx8kYWK3s14", "IukfF3FSbFE", "WirgxeqDrlE", "JctTmbgFfSw", "xuf8N8NEDmE", "lRDV5-8PIpE", "INeq7ZKb9Sk", "a0pUdgWw1nU", "cAz7XEehANA", "XYcT5mmphDE",
                "LXrj2YT4aGY", "jZRuwogHMRQ", "eCWHsRoiLHY", "myGwbPLJMwM", "oZfGjzmfeyA", "Txjokv1xTsY", "Txjokv1xTsY", "1OyTigVB0Gk", "_yNcGYb0EY0", "qbbu3nUSPd4",
                "7JsBiSg_UQE", "HDNgl9ZWK3g")

comments_df <- data.frame() # data frame vacío donde se almacenarán los comentarios

for (video_id in navia_list){
  app_id <- "712498211952-94759t4ijodnt4t2dnl1sf0st30abfhj.apps.googleusercontent.com"
  app_secret <- "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"
  yt_oauth(app_id, app_secret, token = '')
  comments <- get_all_comments(video_id = video_id)
  comments_df <- rbind(comments_df, comments)
  
}


write.csv(comments_df, file = "Data/InputData/youtube_df/comments/comentarios_navia.csv")

#Funciona de manera individual. Con el siguiente có

count_video_df <-data.frame()
video_info_df <-data.frame()

for (video_id in navia_list){
  
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

write.csv(video_details, file = "Data/InputData/youtube_df/video_details/video_details_navia.csv")


#unimos comentarios con detalles del video


navia_df <-merge(video_details,comments_df, by.x ="id", by.y="videoId")


navia_df <-navia_df%>%
  dplyr::select(id, title, date, views,likes,comment_count,textOriginal, authorDisplayName, likeCount, publishedAt)

write.csv(navia_df, file = "Data/InputData/youtube_df/merged_df/navia_final.csv")



## Obtenemos comentarios y 



tabla <-navia_df%>%
  distinct(id, authorDisplayName)%>%
  group_by(authorDisplayName)%>%
  count()%>%
  arrange(desc(n))


print(tabla)
