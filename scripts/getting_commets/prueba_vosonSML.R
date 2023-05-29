install.packages(c("vosonSML", "tidyverse"))
library(vosonSML)
library(tidyverse)


#autenticamos

apikey <- "AIzaSyCILmokZRH6TLwkas4r1Ob7Sw-O3TaFVXw"
key <- vosonSML::Authenticate("youtube", 
                    apiKey=apikey)


# or supply it "manually": 
videos <- c("UfF8DwLCjlg")

# Either way works. If you want to download comments for multiple values, just add them to the vector of videoIDS like so: 
# videos <- c("ID1","ID2","etc")

# This will use the key and download the data
yt_data <-key %>%   
  vosonSML::Collect(videos)
