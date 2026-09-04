# ---------------------------------------------------------------------------
# Gera os dois bancos SIMULADOS usados nos exemplos de Psicologia e de
# Educação Física.
#
# ATENÇÃO: estes dados NÃO são reais. Os parâmetros (médias, desvios e
# correlações) foram escolhidos em faixas plausíveis para universitários
# brasileiros. Antes de publicar, ancore cada parâmetro em um artigo de
# validação que você queira citar e ajuste os números abaixo.
#
# O banco de Medicina (nascimentos.csv) NÃO é simulado: vem do SINASC.
# ---------------------------------------------------------------------------

library(dplyr)

set.seed(2026)   # reprodutível, como todo o resto do livro

# --- Psicologia: escalas aplicadas em universitários ------------------------
# PSS-10 (estresse percebido, 0-40), GAD-7 (ansiedade, 0-21),
# WHO-5 (bem-estar, 0-100). Os três aparecem na tabela do Capítulo 3.

n <- 320

curso  <- sample(c("Medicina","Psicologia","Educação Física"), n, TRUE, c(.4,.35,.25))
sexo   <- sample(c("Feminino","Masculino"), n, TRUE, c(.62,.38))
idade  <- round(rnorm(n, 22, 3.5)); idade <- pmax(18, pmin(40, idade))
sono   <- round(rnorm(n, 6.8, 1.3), 1); sono <- pmax(3, pmin(11, sono))

# estresse depende de curso, sexo e sono; ansiedade é fortemente ligada ao
# estresse; bem-estar é o inverso dos dois.
lat <- 0.9*scale(as.numeric(factor(curso, levels=c("Educação Física","Psicologia","Medicina")))) +
       0.5*(sexo=="Feminino") - 0.45*scale(sono) + rnorm(n)

pss10 <- round(18 + 5.2*as.numeric(lat) + rnorm(n, 0, 2.5))
pss10 <- pmax(0, pmin(40, pss10))

# GAD-7 é assimétrico à direita: a maioria pontua baixo.
gad7  <- round(pmax(0, pmin(21, rgamma(n, shape = 2.1, scale = 2.4) + 0.28*pss10 - 3)))

who5  <- round(pmax(0, pmin(100, 78 - 1.35*pss10 - 0.9*gad7 + rnorm(n, 0, 9))))

saude_mental <- tibble(
  id = sprintf("P%03d", 1:n),
  curso = factor(curso), sexo = factor(sexo), idade,
  horas_sono = sono, pss10, gad7, who5,
  ansiedade = factor(ifelse(gad7 >= 10, "Alta", "Baixa"), levels = c("Baixa","Alta"))
)

# dados faltantes, como em qualquer coleta real
for (v in c("horas_sono","who5","gad7")) {
  idx <- sample(n, round(n * runif(1, .03, .07)))
  saude_mental[[v]][idx] <- NA
}

# --- Educação Física: aptidão física e atividade semanal --------------------

m <- 280

modalidade <- sample(c("Musculação","Corrida","Coletivos","Nenhuma"), m, TRUE, c(.32,.24,.24,.20))
sexo2 <- sample(c("Feminino","Masculino"), m, TRUE, c(.48,.52))
idade2 <- round(rnorm(m, 23, 4)); idade2 <- pmax(18, pmin(45, idade2))

# minutos semanais de atividade (IPAQ): fortemente assimétrico à direita,
# com um grupo de sedentários perto de zero.
base_min <- ifelse(modalidade == "Nenhuma",
                   rgamma(m, shape = 1.1, scale = 40),
                   rgamma(m, shape = 3.2, scale = 65))
min_af <- round(pmin(1200, base_min))

imc <- round(rnorm(m, 24.2, 3.6) - 0.0018*min_af, 1); imc <- pmax(16, pmin(42, imc))
gordura <- round(ifelse(sexo2=="Feminino", 26, 17) + 0.75*(imc-24) - 0.004*min_af + rnorm(m,0,3.2), 1)
gordura <- pmax(4, pmin(48, gordura))
vo2 <- round(42 + 0.017*min_af - 0.55*(imc-24) - 0.25*(idade2-23) +
             ifelse(sexo2=="Masculino", 5.5, 0) + rnorm(m, 0, 4), 1)

aptidao <- tibble(
  id = sprintf("E%03d", 1:m),
  sexo = factor(sexo2), idade = idade2, modalidade = factor(modalidade),
  min_af_semana = min_af, imc, perc_gordura = gordura, vo2max = vo2,
  ativo = factor(ifelse(min_af >= 150, "Sim", "Não"), levels = c("Não","Sim"))
)

for (v in c("perc_gordura","vo2max")) {
  idx <- sample(m, round(m * runif(1, .03, .06)))
  aptidao[[v]][idx] <- NA
}

readr::write_csv(saude_mental, "dados/saude-mental.csv")
readr::write_csv(aptidao,      "dados/aptidao-fisica.csv")
cat("saude-mental.csv  :", nrow(saude_mental), "linhas\n")
cat("aptidao-fisica.csv:", nrow(aptidao), "linhas\n")
