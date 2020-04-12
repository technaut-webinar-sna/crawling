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
  app = "SMA Workshop 2",
  consumer_key = "8c6g53lSeupE2anReETTs2vys",
  consumer_secret = "OltZDimReEajo9AEBAsAPqf78yyNzfrmH85aJzUzpqjAsH4Nxf",
  access_token = "201094280-dsxUFTbrXldpm8YjkziHqkmFqCkF9aRH4lLvq1oE",
  access_secret = "VBpKAHnNCQjGjRpCLsrHROHufWX8tEbP3EAYblbYKNv5c")

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