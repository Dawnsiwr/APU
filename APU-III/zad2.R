
library(neuralnet)

data <- read.csv("cameras2.csv")

data_split <- data.frame(do.call(rbind, strsplit(as.character(data$names.resolution.rangeSensitivity.price.opinions.customerEvalution.opinion_status), ";")))

colnames(data_split) <- c("names", "resolution", "rangeSensitivity", "price", "opinions", "customerEvalution", "opinion_status")

data_split$resolution <- as.integer(data_split$resolution)
data_split$rangeSensitivity <- as.integer(data_split$rangeSensitivity)
data_split$price <- as.integer(data_split$price)
data_split$opinions <- as.integer(data_split$opinions)
data_split$customerEvalution <- as.numeric(data_split$customerEvalution)

data <- cbind(data, data_split)

neural_model <- neuralnet(price ~ resolution + rangeSensitivity + opinions + customerEvalution,
                          data = data, 
                          linear.output = TRUE)

predicted_prices <- predict(neural_model, newdata = data)

error <- sum((predicted_prices - data$price)^2) / length(data$price)

rmse <- sqrt(error)

cat("Root Mean Squared Error (RMSE):", rmse, "\n")

