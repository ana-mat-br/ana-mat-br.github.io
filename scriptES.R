library(rstatix)
library(readr)

# Importe o banco de dados Pokemon
Pokemon <- read_csv("Pokemon.csv")

# Subconjunto com Pokémons verdes ou amarelos
dados_filtrados <- subset(Pokemon, Color %in% c("Green", "Yellow"))


# dados_filtrados$Color <- factor(dados_filtrados$Color, levels = c("Yellow", "Green"))

# Verifique os dados após o filtro
print(table(dados_filtrados$Color))

# Boxplot
boxplot(dados_filtrados$Speed ~ dados_filtrados$Color)

# Teste de Wilcoxon não pareado
wilcox.test(dados_filtrados$Speed ~ dados_filtrados$Color)

# Tamanho do efeito r de Wilcoxon para Green vs Yellow
wilcox_effsize(dados_filtrados, Speed ~ Color)

library(effsize)

# Calcule o Delta de Cliff
cliff.delta(dados_filtrados$Speed ~ dados_filtrados$Color)



library(ggplot2)

ggplot(dados_filtrados, aes(x = Color, y = Speed, fill = Color)) +
  geom_boxplot(alpha = 0.6, outlier.shape = NA) +
  geom_jitter(width = 0.2, alpha = 0.5, color = "black") +
  scale_fill_manual(values = c("Green" = "#66c2a5", "Yellow" = "#ffd92f")) +
  labs(
    title = "Distribuição da Velocidade por Cor",
    x = "Cor",
    y = "Velocidade"
  ) +
  theme_minimal()


ggplot(dados_filtrados, aes(x = Color, y = Speed, fill = Color)) +
  geom_violin(trim = FALSE, alpha = 0.5) +
  geom_boxplot(width = 0.1, outlier.shape = NA, alpha = 0.7) +
  scale_fill_manual(values = c("Green" = "#66c2a5", "Yellow" = "#ffd92f")) +
  labs(
    title = "Comparação da Velocidade por Cor",
    x = "Cor",
    y = "Velocidade"
  ) +
  theme_minimal()


dados_ordenados <- dados_filtrados %>%
  filter(Color %in% c("Green","Yellow")) %>%
  mutate(Color = factor(Color, levels = c("Green","Yellow")))  # Define a ordem

# Calcula o r de Wilcoxon
wilcox_effsize(dados_ordenados, Speed ~ Color)

