#!/bin/sh
# Gera as três versões do livro dentro de docs/, que é a pasta publicada
# pelo GitHub Pages (veja output_dir em _bookdown.yml).
#
# Depois de rodar este script, commite a pasta docs/ INTEIRA:
#   git add docs && git commit -m "rebuild do livro"
# Commitar só as páginas alteradas desincroniza o sumário lateral,
# que é reescrito em todas as páginas a cada build.

set -ev

Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"
Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_book')"
Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::epub_book')"

# Confere se os arquivos oferecidos no botão de download existem em docs/
for f in docs/LivroEstatisticaR.pdf docs/LivroEstatisticaR.epub; do
  [ -f "$f" ] || { echo "ERRO: $f nao foi gerado"; exit 1; }
done

echo "Build concluido. Nao esqueca de commitar a pasta docs/ inteira."
