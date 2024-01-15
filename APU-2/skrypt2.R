
install.packages(c("data.tree", "formattable", "DiagrammeR", "ahp"))

library(data.tree)
library(formattable)
library(DiagrammeR)
library(ahp)

data <- read.csv("cameras.csv")

weights <- c(0.3, 0.2, 0.3, 0.2)

standardized_data <- scale(data[, c("resolution", "rangeSensitivity", "price", "opinions")])

data$score <- rowSums(weights * standardized_data)

best_camera <- data[which.max(data$score), ]

print("Best camera:")
print(best_camera)

decision_tree <- Node$new("Camera Purchase Decision")
decision_tree$AddChild("Criteria", data.frame(criteria_name = c("Resolution", "Range Sensitivity", "Price", "Number of Opinions"), weight = weights))
decision_tree$AddChild("Cameras", data.frame(camera_name = data$names, score = data$score))

# Display decision tree
print(decision_tree)

graph <- DiagrammeR::create_graph() %>%
  DiagrammeR::create_node("Camera Purchase Decision") %>%
  DiagrammeR::create_node("Criteria", shape = "rectangle") %>%
  DiagrammeR::create_node("Cameras", shape = "rectangle") %>%
  DiagrammeR::create_edge(from = "Camera Purchase Decision", to = "Criteria") %>%
  DiagrammeR::create_edge(from = "Camera Purchase Decision", to = "Cameras")

DiagrammeR::render_graph(graph)
