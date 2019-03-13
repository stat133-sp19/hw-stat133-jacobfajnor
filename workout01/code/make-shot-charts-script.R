######################################
## Project: GSW Shot Charts
## Script Purpose: Generate Shot Charts for 5 GSW players
## Inputs: shots-data.csv
## Outputs: Shot charts
##Date: 3/5/2019
## Author: Jacob Fajnor
######################################

# Preliminary matters
setwd("C:/Users/Fajnor/Desktop/workout01")
library(ggplot2)
library(dplyr)
library(jpeg)
library(grid)
# load data into enviornment
data <- read.csv("./data/shots-data.csv", stringsAsFactors = FALSE)

# Stephen Curry shot-chart
curry <- filter(data, name == "Stephen Curry")
# test plot
ggplot(data = curry, aes(x = x, y = y)) + geom_point(aes(x = x, y = y, color = shot_made_flag))
# court background image
court_file <- "./images/nba-court.jpg"
court_image <- rasterGrob(
  readJPEG(court_file),
  width = unit(1, "npc"),
  height = unit(1, "npc"))
# Curry Shot Chart with background image
curry_shot_chart <- ggplot(data = curry) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Stephen Curry (2016 season)') +
  theme_minimal()
curry_shot_chart

# Klay Thompson Shot Chart with background image
thompson <- filter(data, name == "Klay Thompson")
thompson_shot_chart <- ggplot(data = thompson) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') +
  theme_minimal()
thompson_shot_chart

# Andre Iguodala Shot Chart with background image
iguodala <- filter(data, name == "Andre Igoudala")
iguodala_shot_chart <- ggplot(data = iguodala) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Andre Iguodala (2016 season)') +
  theme_minimal()
iguodala_shot_chart

# Draymond Green Shot Chart with background image
green <- filter(data, name == "Draymond Green")
green_shot_chart <- ggplot(data = green) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Draymond Green (2016 season)') +
  theme_minimal()
green_shot_chart

# Kevin Durant Shot Chart with background image
durant <- filter(data, name == "Kevin Durant")
durant_shot_chart <- ggplot(data = durant) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Kevin Durant (2016 season)') +
  theme_minimal()
durant_shot_chart

# make PDF's 
pdf("./images/klay-thompson-shot-chart.pdf", height = 5, width = 6.5)
thompson_shot_chart
dev.off()

pdf("./images/stephan-curry-shot-chart.pdf", height = 5, width = 6.5)
curry_shot_chart
dev.off()

pdf("./images/kevin-durant-shot-chart.pdf", height = 5, width = 6.5)
durant_shot_chart
dev.off()

pdf("./images/draymond-greene-shot-chart.pdf", height = 5, width = 6.5)
green_shot_chart
dev.off()

pdf("./images/andre-iguodala-shot-chart.pdf", height = 5, width = 6.5)
iguodala_shot_chart
dev.off()

png("./images/stephan-curry-shot-chart.png", res = 72, units = "in", height = 7, width = 8)
curry_shot_chart
dev.off()

# Faceted Shot Chart
gsw_shot_chart <- ggplot(data = data) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Charts: Golden State Warriors (2016 season)') +
  facet_grid(name ~ .) +
  theme_minimal()
gsw_shot_chart

pdf("./images/gsw-shot-chart.pdf", height = 7, width = 8)
gsw_shot_chart
dev.off()

## OR
library(gridExtra)
gsw_shotcharts <- grid.arrange(curry_shot_chart,
                               thompson_shot_chart, 
                               durant_shot_chart, 
                               green_shot_chart, 
                               iguodala_shot_chart, 
                               nrow = 2, ncol = 3,
                               top = textGrob("Golden State Warriors Shot Charts: 2016 Season"))
pdf("./images/gsw-shotcharts.pdf", height = 7, width = 8)
gsw_shotcharts
dev.off()

# as a PNG
png("./images/gsw-shot-chart.png", res = 72, units = "in", height = 7, width = 8)
gsw_shot_chart
dev.off()

ggsave("./images/gsw-shotchart.png", plot = gsw_shotcharts, units = "in", height = 7, width = 8, scale = 3.)

# Effective Shooting Percentage
# Tables of Effective shooting Percentage.
shot_data$made <- ifelse(shot_data$shot_made_flag == "shot_yes", 1, 0)
shot_data$taken <- ifelse(shot_data$shot_made_flag == "shot_yes", 1, 1)

two_point_percent <- shot_data %>% group_by(name) %>% filter(shot_type == "2PT Field Goal") %>% summarize(total = sum(taken), made = sum(made), perc_made = (sum(made)/sum(taken))*100)

three_point_percent <- shot_data %>% group_by(name) %>% filter(shot_type == "3PT Field Goal") %>% summarize(total = sum(taken), made = sum(made), perc_made = (sum(made)/sum(taken))*100)

total_point_percent <- shot_data %>% group_by(name) %>% filter(shot_type == "2PT Field Goal" | shot_type == "3PT Field Goal") %>% summarize(total = sum(taken), made = sum(made), perc_made = (sum(made)/sum(taken))*100)
two_point_percent
three_point_percent
total_point_percent