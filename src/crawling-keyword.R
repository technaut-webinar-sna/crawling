# Install library rtweet
install.packages("rtweet")
install.packages("dplyr")
install.packages("tidyr")

# Aktifkan library terlebih dulu
library("rtweet")
library("dplyr")
library("tidyr")

# Set keword dan jumlah tweet yang akan dicari
keyword <- "masker"
jumlahtweet <- 1000
bahasa <- "id"

# Bila ingin Mengambil Retweet tuliskan "TRUE", bila tidak tuliskan "FALSE"
retweet <- TRUE

# Autentifikasi API
token <- create_token(
  app = "xxxxxxxxxx",
  consumer_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  consumer_secret = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  access_token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  access_secret = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")

# Mencari tweet
crawling <- search_tweets(keyword,
                          n = jumlahtweet,
                          include_rts = retweet,
                          lang = bahasa,
                          retryonratelimit = FALSE)

# Mengambil data dengan kriteria tertentu (jumlah followers)
selected <- filter(crawling, followers_count > 1000)

# Membuat edge list
edgelist <- select(selected, screen_name, mentions_screen_name)

# Memisahkan target
edgelist <- edgelist %>% unnest(mentions_screen_name)

# Menghilangkan baris kosong
edgelist <- na.exclude(edgelist)

#Save sebagai CSV
write.table(edgelist, file = "data/edge_list.csv",
            quote = FALSE, sep = ",",
            col.names = FALSE, row.names = FALSE)