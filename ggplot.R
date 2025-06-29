install.packages("ggplot2")
library(ggplot2)

# Exemplo com o dataset iris
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point(size = 3, alpha = 0.7) +
  theme_minimal() +
  labs(title = "Gráfico de Dispersão: iris",
       x = "Comprimento da Sépala",
       y = "Largura da Sépala")
# Contagem das espécies no dataset iris
ggplot(iris, aes(x = Species, fill = Species)) +
  geom_bar() +
  theme_classic() +
  labs(title = "Gráfico de Barras: Contagem de Espécies",
       x = "Espécie",
       y = "Contagem")
# Distribuição do comprimento da sépala
ggplot(iris, aes(x = Sepal.Length, fill = Species)) +
  geom_histogram(binwidth = 0.3, color = "white", alpha = 0.7, position = "identity") +
  theme_light() +
  labs(title = "Histograma: Comprimento da Sépala",
       x = "Comprimento da Sépala",
       y = "Frequência")
ggplot(iris, aes(x = Species, y = Petal.Length, fill = Species)) +
  geom_boxplot(alpha = 0.7) +
  theme_bw() +
  labs(title = "Boxplot: Comprimento da Pétala por Espécie",
       x = "Espécie",
       y = "Comprimento da Pétala")
install.packages("titanic")
library(titanic)
data(package = "titanic")
head(titanic_gender_class_model)
