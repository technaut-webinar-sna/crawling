# Install library rtweet
install.packages("rtweet")
install.packages("dplyr")
install.packages("tidyr")

# Aktifkan library terlebih dulu
library("rtweet")
library("dplyr")
library("tidyr")

# Set keword dan jumlah tweet yang akan dicari
keyword <- "psbb"
jumlahtweet <- 1000
type <- "recent"
bahasa <- "id"

# Bila ingin Mengambil Retweet tuliskan "TRUE", bila tidak tuliskan "FALSE"
retweet <- FALSE

# Autentifikasi API
token <- create_token(
  app = "XXXXXXXX",
  consumer_key = "XXXXXXXXXXXXXXXXXXXXXXXX",
  consumer_secret = "XXXXXXXXXXXXXXXXXXXXXXXX",
  access_token = "XXXXXXXXXXXXXXXXXXXXXXXX",
  access_secret = "XXXXXXXXXXXXXXXXXXXXXXXX")

# Mencari tweet
crawling <- search_tweets(keyword,
                          n = jumlahtweet,
                          include_rts = retweet,
                          type = type,
                          lang = bahasa,
                          retryonratelimit = FALSE)

# Mengambil data dengan kriteria tertentu (jumlah followers)
selected <- filter(crawling, followers_count > 100)

# Membuat edge list
edgelist <- select(selected, screen_name, mentions_screen_name)

# Memisahkan target jika terjadi duplikasi
edgelist <- edgelist %>% unnest(mentions_screen_name)

# Menghilangkan baris kosong
edgelist <- na.exclude(edgelist)

#Save sebagai CSV
write.table(edgelist, file = "data/edge_list_1.csv",
            quote = FALSE, sep = ",",
            col.names = FALSE, row.names = FALSE)