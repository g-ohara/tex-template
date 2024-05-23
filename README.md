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
### Manual Compilation
Run Docker container and Latexmk in it:
```sh
docker compose run --rm texlab latexmk slide-ja.tex
```
Or if you have not installed Docker Compose:
```sh
docker run --rm -v ./:$PWD -w $PWD genjiohara/texlab latexmk slide-ja.tex
```

### Environment Setup
If you use [Neovim](https://neovim.io/) as your TeX editor:
1. Install [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/texlab.lua).
1. Add the following code to your `~/.config/nvim/init.lua`:
   
   ```lua
   local lspconfig = require("lspconfig")

   -- "Running language servers in docker containers"
   -- https://github.com/neovim/nvim-lspconfig/wiki/Running-language-servers-in-containers#running-language-servers-in-containers
   local root_pattern = lspconfig.util.root_pattern('.git')
   local function project_name_to_container_name()
     local bufname = vim.api.nvim_buf_get_name(0)
     local filename = lspconfig.util.path.is_absolute(bufname) and bufname
         or lspconfig.util.path.join(vim.loop.cwd(), bufname)
     local project_dirname = root_pattern(filename) or lspconfig.util.path.dirname(filename)
     return vim.fn.fnamemodify(lspconfig.util.find_git_ancestor(project_dirname), ':t')
   end
   
   lspconfig.texlab.setup {
     cmd = {
       'docker',
       'exec',
       '-i',
       project_name_to_container_name(),
       'texlab',
     },
     settings = {
       texlab = {
         build = {
           args = {},
           onSave = true,
         },
         chktex = {
           onEdit = true,
           onOpenAndSave = true,
         },
         latexindent = {
           args = { '-l' },
         },
       },
     },
   }
   ```
1. Run the container in this repo:
   ```sh
   docker compose up -d
   ```
1. Open `slide-ja.tex` by Neovim, then your editor accesses TexLab in your container and provides its some features. For example, TexLab automatically generates a PDF file by latexmk following your `latexmkrc`, when you save changes on your TeX file.
