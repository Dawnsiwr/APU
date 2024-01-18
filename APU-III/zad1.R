library(neuralnet)
set.seed(123)

x <- seq(-5, 5, 0.1)
y <- x^2 + rnorm(length(x), sd=2)

data <- data.frame(x = x, y = y)
model <- neuralnet(y ~ x, data = data, hidden = c(5, 3), linear.output = TRUE)

print(model)
error <- mean((as.vector(predict(model, data)) - data$y)^2)

if (error < 0.01) {
  print("Model meets the condition.")
} else {
  print("Model does not meet the condition.")
}

cat("Prediction error:", error, "\n")

