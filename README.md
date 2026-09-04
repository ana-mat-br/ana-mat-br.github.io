# Aula de Estatística usando R

Bem-vindo(a) ao repositório do site **Aula de Estatística usando R**! Este projeto foi desenvolvido para auxiliar nas aulas de estatística das disciplinas de **Estatística**.

O site contém materiais didáticos, exemplos práticos e guias para o uso da linguagem R e do ambiente de desenvolvimento RStudio.

## 📚 Objetivos

-   Servir como guia para disciplinas de estatística nos cursos de **Medicina**, **Educação Física** e **Psicologia**.
-   Oferecer um recurso de consulta para análises de dados utilizando a linguagem R.
-   Disponibilizar materiais e exemplos aplicados para facilitar o aprendizado.

## 📘 Sobre o Livro

O livro foi gerado utilizando o pacote [**Bookdown**](https://bookdown.org/), um pacote do R que permite escrever livros, apostilas, relatórios técnicos e documentos científicos utilizando **R Markdown**. Ele facilita a criação de documentos interativos e publicáveis em diferentes formatos, como HTML, PDF e EPUB.

O comando utilizado para gerar o livro foi:

``` r
bookdown::render_book("index.Rmd", "bookdown::gitbook")
```

## 🌐 Acesse o site

O site é publicado pelo GitHub Pages a partir da pasta `docs/` da branch `main`:

🔗 <https://ana-mat-br.github.io>

> ⚠️ **A publicação é manual.** Não há build automático: depois de editar qualquer `.Rmd`, é preciso regerar o livro e commitar a pasta `docs/` **inteira**.
>
> ```bash
> ./_build.sh          # gera HTML, PDF e EPUB dentro de docs/
> git add docs
> git commit -m "rebuild do livro"
> git push
> ```
>
> Commitar apenas as páginas que mudaram desincroniza o site: o sumário lateral é reescrito em **todas** as páginas a cada build, então páginas novas ficam publicadas mas fora da navegação.

## 🛠️ Estrutura do Projeto

-   **`index.Rmd`**: capa, metadados e configuração do livro\
-   **`01-*.Rmd` … `23-*.Rmd`**: os capítulos, na ordem em que aparecem\
-   **`_bookdown.yml` / `_output.yml`**: configuração do bookdown e dos formatos de saída\
-   **`docs/`**: o site gerado — é esta pasta que o GitHub Pages publica\
-   **`_build.sh`**: script que gera HTML, PDF e EPUB\
-   **`Pokemon.csv`** e as imagens `tela*.png`: dados e figuras usados nos capítulos

### Pacotes necessários

Para regerar o livro é preciso ter instalados:

``` r
install.packages(c(
  "bookdown", "afex", "car", "DescTools", "DiagrammeR", "dplyr",
  "effsize", "emmeans", "epitools", "GGally", "ggplot2", "gtsummary",
  "magick", "moments", "nortest", "pdftools", "PMCMRplus", "pwr",
  "RColorBrewer", "rcompanion", "readr", "rstatix", "samplingbook",
  "tidyr", "tidyverse"
))
```

O `pdftools` é usado pela capa (`index.Rmd`) para converter a ficha catalográfica em SVG.

A geração do PDF exige também uma distribuição LaTeX com `xelatex` (por exemplo, TinyTeX: `tinytex::install_tinytex()`).

## 🚀 Como Contribuir

Sugestões, correções ou melhorias são sempre bem-vindas! Para contribuir:

1.  Faça um fork deste repositório

2.  Crie uma branch para suas alterações:

    ``` bash
    git checkout -b minha-sugestao
    ```

3.  Envie um *pull request* explicando suas mudanças

## 📧 Contato

Em caso de dúvidas ou sugestões, você pode entrar em contato pelo e-mail:\
[**anapaula.fernandes\@uftm.edu.br**](mailto:anapaula.fernandes@uftm.edu.br)

Para mais informações sobre minha trajetória acadêmica, acesse meu [Currículo Lattes](https://lattes.cnpq.br/5582801060910261).

------------------------------------------------------------------------

Desenvolvido por: **Ana Paula Fernandes (DESCO/UFTM)**
