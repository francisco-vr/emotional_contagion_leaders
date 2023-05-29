
library(tuber)
library(tidyverse)

## Obtener comentarios e información de videos de AB

AB_list <- c("uS91Ssy7_N8", "4AivK0Fl2dE", "N6S4la08Ch4", "fbLO6uM3CWw", "Kti27R-Dyys", "fE90Wi96o5s", "RlSdEbFS_YU", "vvoQhVuCTBI",
             "FlDILOnPCTg", "c_YbjS5tN8U", "6-KXybOgq3s", "ih8rmrMyPH8", "EtFZmwHf3ts", "_-pnFUJ0ddk", "NVpJefyVksA", "UhX40Jdua-A",
             "fksb-CVadKA", "sG8fZYVRph0", "NAPllkkr2No", "S00xaieFXaU", "JBiECiGyTzo", "_vdp2JgpshY", "qjMVnI_jN4A", "nJNNKXxe0Js",
             "PLlNvhD72zY", "MR3qxImj-lU", "JyRP41QGGnk", "xIVOtjfAkAc", "-qMdSLixJRM", "R5ymtU0cVqA", "qDZhINDMC1k", "zHytfcfarfI",
             "M6g7meh387g", "Xax3PbW6GKY", "vCI6cKP3uU4", "EhTEy3Nr-h0", "06QWoAxqaaw", "01Rxf49fWTw", "n6Nd_WPanvU", "2_yQ8Oju6ZE",
             "X3qqn8dwDYM", "tnq0HtcWmVY", "jIyKm6snljw", "beKddVBrK4U", "WDQwbbXZ2Vg", "W5_K0BgCEn4", "RN_LdSRfT6o", "LvTkXssLTiE",
             "xF31_Dj7Pkk", "LCN3bcQPpvc", "uZt-CyuZe3E", "WjfypWyCFK8", "odYFKNlmRWg", "-EEvNie_xxg", "veZ-j19NtfM", "cNaGanUZNP4",
             "7kZXJzXM4BU", "qaVGHNwITKE", "JQGunWi77fY", "lLLHYu5X0vY", "eyjyGMfdM7k", "fCDA0rgjiIw", "0aZQYF3xAXw", "UJ93fUXdNvY",
             "n6UOeuTv7fo", "ycXSe8XSK1I", "Z5mCkcGNE0I", "lVFykPmuGY4", "oh_I0gxl6V0", "QxCI0satRLI", "CZKbHOhe8ec", "aD19FLhu-Ms",
             "UPS-v8GHUNk", "mWDtq6H_RMo", "ypzWn5ZEYT4", "WmOWwq2dHJc", "sv0NqgBvGwE", "6W0vfADAP_Y", "OEJTIPob0GY", "Dxx1C9s65pM",
             "XfaHCh_m6ms", "0GkdCxqrEjo", "5gYS4VwnluI", "VvkOnOE4UJQ", "9tQ7Vv7-4oc", "Av16qChuqN0", "7y5UMJ7ZYEs", "HPL-8d_7Q4o",
             "QXT1N3_mHFw", "mSVGVj_3llI", "zdAHPXt908o", "2c8m0SndRKk", "zHSVAAGAEdE", "OqfhMbRgAx0", "JEWhnCpUVGs", "97oeH6NRK-I",
             "vU-FFBUyC7I", "GGAgks3vlCg", "BTlN-Pt0w2s", "7JVC-sxv-hU", "-HITHHNR-W8", "mx9cxhsajsw", "PUO3b8D8-oA", "rJ_Q48fALBo",
             "RCa2cx0JU1Y", "qf7LoocJVAE", "eKJbmKMRODE", "rnS4kyQqkTI", "2MiXKwc1NXs", "VUaYdyrregs", "gZYUJ76-lXg", "LI8b2HsewDY",
             "eT6nXyBTBpQ", "ihQGRVc2pEE", "TSehteMemto", "T1vC50Y4WZ0", "u1KNic1SKZk")

comments_df <- data.frame() # data frame vacío donde se almacenarán los comentarios

for (video_id in AB_list){
  app_id <- "712498211952-94759t4ijodnt4t2dnl1sf0st30abfhj.apps.googleusercontent.com"
  app_secret <- "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"
  yt_oauth(app_id, app_secret, token = '')
  comments <- get_all_comments(video_id = video_id)
  comments_df <- rbind(comments_df, comments)
  
}


write.csv(comments_df, file = "Data/InputData/youtube_df/comments/comentarios_AB.csv")

#Funciona de manera individual. Con el siguiente có

count_video_df <-data.frame()
video_info_df <-data.frame()

for (video_id in AB_list){
  
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

write.csv(video_details, file = "Data/InputData/youtube_df/video_details/video_details_AB.csv")


#unimos comentarios con detalles del video


AB_df <-merge(video_details,comments_df, by.x ="id", by.y="videoId")



AB_df <-AB_df%>%
  dplyr::select(id, title, date, views,likes,comment_count,textOriginal, authorDisplayName, likeCount, publishedAt)

write.csv(AB_df, file = "Data/InputData/youtube_df/merged_df/AB_final.csv")



## Obtenemos comentarios y 


tabla <-AB_df%>%
  distinct(id, authorDisplayName)%>%
  group_by(authorDisplayName)%>%
  count()%>%
  arrange(desc(n))


print(tabla)
