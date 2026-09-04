# ---------------------------------------------------------------------------
# Monta o banco de exemplo do livro a partir do SINASC (DATASUS), que é
# aberto e de acesso público. Rode este script UMA vez; ele grava o
# nascimentos.csv que os capítulos usam.
#
#   Fonte: Sistema de Informações sobre Nascidos Vivos (SINASC/DATASUS)
#   https://datasus.saude.gov.br/transferencia-de-arquivos
# ---------------------------------------------------------------------------

# install.packages("microdatasus")  # se necessário
library(microdatasus)
library(dplyr)

UF        <- "MG"
MUNICIPIO <- "Uberaba"   # NULL para manter o estado inteiro
ANO <- 2022

bruto <- fetch_datasus(year_start = ANO, year_end = ANO,
                       uf = UF, information_system = "SINASC")

# process_sinasc() rotula as variáveis categóricas, mas zera a coluna PESO;
# por isso o peso é lido do banco bruto.
rotulado <- process_sinasc(bruto)

if (!is.null(MUNICIPIO)) {
  sel      <- which(rotulado$munResNome == MUNICIPIO)
  bruto    <- bruto[sel, ]
  rotulado <- rotulado[sel, ]
}

nascimentos <- tibble(
  peso_g       = suppressWarnings(as.numeric(bruto$PESO)),
  idade_mae    = suppressWarnings(as.numeric(bruto$IDADEMAE)),
  sem_gestacao = suppressWarnings(as.numeric(bruto$SEMAGESTAC)),
  consultas_pn = suppressWarnings(as.numeric(bruto$CONSPRENAT)),
  apgar5       = suppressWarnings(as.numeric(bruto$APGAR5)),
  sexo         = rotulado$SEXO,
  parto        = rotulado$PARTO,
  escol_mae    = rotulado$ESCMAE,
  raca_mae     = rotulado$RACACOR
) |>
  # limites plausíveis: o SINASC usa 9999 e afins como código de ignorado
  mutate(
    peso_g       = ifelse(peso_g       %in% 250:7000, peso_g, NA),
    idade_mae    = ifelse(idade_mae    %in% 10:60,    idade_mae, NA),
    sem_gestacao = ifelse(sem_gestacao %in% 20:45,    sem_gestacao, NA),
    consultas_pn = ifelse(consultas_pn %in% 0:40,     consultas_pn, NA),
    apgar5       = ifelse(apgar5       %in% 0:10,     apgar5, NA),
    baixo_peso   = factor(ifelse(peso_g < 2500, "Sim", "Não"), levels = c("Não","Sim")),
    escol_mae    = factor(escol_mae,
                          levels = c("Nenhum","1 a 3 anos","4 a 7 anos",
                                     "8 a 11 anos","12 anos ou mais"),
                          ordered = TRUE)
  )

readr::write_csv(nascimentos, "dados/nascimentos.csv")
cat("gravado dados/nascimentos.csv:", nrow(nascimentos), "linhas,",
    ncol(nascimentos), "colunas\n")
