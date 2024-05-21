# tex-template
TeX template using language server in Docker container.
## Overview
This template uses the following apps:
#### Host
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
#### Container
- [TexLab](https://github.com/latex-lsp/texlab)
- [TeX Live](https://tug.org/texlive/)
  - [latexmk](https://ctan.org/pkg/latexmk)
  - [chktex](https://ctan.org/pkg/chktex)
  - [latexindent](https://ctan.org/pkg/latexindent)

For getting started, you need only Docker (and Docker Compose for ease) installed on your computer.

## Getting Started
### Compilation
Run Docker container and Latexmk in it:
```sh
docker compose run --rm texlab latexmk slide-ja.tex
```
Or if you have not installed Docker Compose:
```sh
docker run --rm -v ./:$PWD -w $PWD genjiohara/texlab latexmk slide-ja.tex
```
