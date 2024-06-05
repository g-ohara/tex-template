#!/usr/bin/env perl

# Use LuaLaTeX for PDF output.
$lualatex = 'lualatex -shell-escape -interaction=nonstopmode';
$pdf_mode = 4;

# Prevent latexmk from removing PDF after typeset.
$pvc_view_file_via_temporary = 0;
