
a <- 5 / (4^3)

b <- 2 * a

smallerValue <- min(a, b)

cat("A - ", a, "\n")
cat("B - ", b, "\n")
cat("Smaller value:", smallerValue, "\n")

help(cos)

vector <- 50:75
vectorAVG <- mean(vector^2)
cat("VectorAVG - ", vectorAVG, "\n")

minFunctions <- ls(pattern = "min", envir = .GlobalEnv)

print(minFunctions)

directory <- "C:\\Users\\Sebastian\\Documents\\APU"
setwd(directory)

aVar <- "aparat z wymienną optyką"

save(aVar, file = "aVar.RData")

rm(aVar)

if (exists("aVar")) {
  cat("aVar EXISTS\n")
} else {
  cat("aVar NOT EXISTS\n")
}

load("aVar.RData")

print(aVar)

if (!requireNamespace("gridExtra", quietly = TRUE)) {
  install.packages("gridExtra")
}
library(gridExtra)

data("Seatbelts")
dane <- Seatbelts[1:10, ]

grid.table(dane)
vector2 <- seq(1000, 800, by = -5)

a <- 29:5

b <- 21:33

d <- c(b, a)
print(d)

names <- c("Sony Cyber Shot", "Sony ZV-1", "DSC H-300", "Panasonic Lumix DC-FZ82", "Canon PowerShot G7 X Mark II",
           "Canon PowerShot SX620 HS", " Sony Cyber-shot DSC-W830", "Nikon Coolpix P1000", "Sony Cyber-shot DSC-W830", "Extralink Kids Camera H20")

resolution <- c(20, 18, 20, 18, 20, 20, 20, 16, 20, 8)
rangeSensitivity <- c(12800, 12000, 6400, 6400, 25600, 3200, 3200, 6400, 3200, 0)
price <- c(3199, 2949, 1399, 1519, 2899, 1199, 699, 4899, 699, 59)
opinions <- c(6, 4, 126, 94, 78, 68, 66, 52, 33, 5)

cameras <- data.frame(names, resolution, rangeSensitivity, price, opinions)


print(cameras)

AVGPrice <- mean(cameras$price)
cat("AVG camera price:", AVGPrice, "\n")

newCamera <- c(" Sony Cyber-shot DSC-RX100 III", 20, 12800, 3199, 6)
newCamera[2:5] <- as.numeric(newCamera[2:5])

cameras <- rbind(cameras, newCamera)
print(cameras)
cameras$price <- as.numeric(cameras$price)
AVGPrice2 <- mean(cameras$price, na.rm = TRUE)
cat("AVG camera price:", AVGPrice2, "\n")

cameras$customerEvalution <- seq(0, 5, by = 0.5)
cameras$customerEvalution <- as.factor(cameras$customerEvalution)

print(cameras)
cameras$price <- as.numeric(cameras$price)
AVGByCustomerEvalution <- tapply(cameras$price, cameras$customerEvalution, mean, na.rm = TRUE)
print(AVGByCustomerEvalution)


newestCameras <- data.frame(
  names = c("Kodak PixPro AZ401", "Canon PowerShot SX740 HS", "Extralink Kids Camera H27 Dual", "Ricoh WG-6"),
  resolution = c(16, 20, 20, 20),
  rangeSensitivity = c(3200, 3200, 0, 6400),
  price = c(899, 1809, 139, 1999),
  opinions = c(6, 5, 5, 3),
  customerEvalution = c(4.5, 5, 2, 4.5)
) 

cameras$customerEvalution <- as.numeric(cameras$customerEvalution)
cameras <- rbind(cameras, newestCameras)
print(cameras)
hist(cameras$customerEvalution, main = "Histogram of Customer Ratings", xlab = "Customer Evalution", ylab = "Cameras Count", col = "lightblue")

if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}
library(ggplot2)

ggplot(cameras, aes(x = "", fill = as.factor(customerEvalution))) +
  geom_bar(width = 1, color = "white") +
  coord_polar("y", start = 0) +
  ggtitle("Percentage of customer evaluations (Pie Chart)")

ggplot(cameras, aes(x = as.factor(customerEvalution), fill = as.factor(customerEvalution))) +
  geom_bar(stat = "count") +
  ggtitle("Percentage of customer evaluations (Fan Chart)")

cameras$opinions <- as.numeric(cameras$opinions)
cameras$opinion_status <- cut(cameras$opinions, 
                             breaks = c(-Inf, 0, 50, 100, Inf),
                             labels = c("there isn't any opinions", "less than 50", "50-100 opinions", "more than 100 opinions"))

cameras$opinion_status <- as.factor(cameras$opinion_status)

ggplot(cameras, aes(x = "", fill = opinion_status)) +
  geom_bar(width = 1, color = "white") +
  coord_polar("y", start = 0) +
  ggtitle("Percentage share in different opinion statuses")

for (i in 1:nrow(cameras)) {
  description <- paste(cameras$name[i], "has a customer rating", cameras$customerEvalution[i], "because it has the number of opinions", cameras$opinions[i], ".")
  cat(description, "\n")
}

write.csv(cameras, "cameras.csv", row.names = FALSE)
loadedCameras <- read.csv("cameras.csv")

print(loadedCameras)

