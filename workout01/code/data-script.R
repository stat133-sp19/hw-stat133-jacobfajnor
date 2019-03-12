setwd("C:/Users/Fajnor/Desktop/workout01")

curry <- read.csv("./data/stephen-curry.csv", stringsAsFactors = FALSE)
igoudala <- read.csv("./data/andre-iguodala.csv", stringsAsFactors = FALSE)
green <- read.csv("./data/draymond-green.csv", stringsAsFactors = FALSE)
durant <- read.csv("./data/kevin-durant.csv", stringsAsFactors = FALSE)
thompson <- read.csv("./data/klay-thompson.csv", stringsAsFactors = FALSE)

# adding a variable name

igoudala$name <- "Andre Igoudala"
curry$name <- "Stephen Curry"
green$name <- "Draymond Green"
durant$name <- "Kevin Durant"
thompson$name <- "Klay Thompson"

# Shot made

igoudala$shot_made_flag <- ifelse(igoudala$shot_made_flag == "n", "shot_no", "shot_yes")
curry$shot_made_flag <- ifelse(curry$shot_made_flag == "n", "shot_no", "shot_yes")
thompson$shot_made_flag <- ifelse(thompson$shot_made_flag == "n", "shot_no", "shot_yes")
durant$shot_made_flag <- ifelse(durant$shot_made_flag == "n", "shot_no", "shot_yes")
green$shot_made_flag <- ifelse(green$shot_made_flag == "n", "shot_no", "shot_yes")

# minutes

# period = 12mins, 4 total periods, = total mins = 48 mins
curry$minute <- 12*curry$period - curry$minutes_remaining
igoudala$minute <- 12*igoudala$period - igoudala$minutes_remaining
thompson$minute <- 12*thompson$period - thompson$minutes_remaining
green$minute <- 12*green$period - green$minutes_remaining
durant$minute <- 12*durant$period - durant$minutes_remaining

# Summaries

# Durant
sink(file = "./output/kevin-durant-summary.txt")
summary(durant)
sink()

# Igoudala
sink(file = "./output/andre-igoudala-summary.txt")
summary(igoudala)
sink()

# Curry
sink(file = "./output/stephen-curry-summary.txt")
summary(curry)
sink()

# Thompson
sink(file = "./output/klay-thompson-summary.txt")
summary(thompson)
sink()

# Green
sink(file = "./output/draymond-green-summary.txt")
summary(green)
sink()

# One data frame

players <- rbind(curry, durant, igoudala, thompson, green)

# Export
write.csv(players, "./data/shots-data.csv")

sink(file = "./output/shots-data-summary.txt")
summary(players)
sink()


