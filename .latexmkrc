#!/usr/bin/env perl

# Generate a pdf version of the document using pdflatex.
# 0: do NOT generate a pdf version of the document
# 1: generate a pdf version of the document using pdflatex,
#    using the command specified by the $pdflatex variable.
# 2: generate a pdf version of the document from the ps file,
#    by using the command specified by the $ps2pdf variable.
# 3: generate a pdf version of the document from the dvi file,
#    by using the command specified by the $dvipdf variable.
# 4: generate a pdf version of the document using lualatex,
#    using the command specified by the $lualatex variable.
# 5: generate a pdf version (and an xdv version) of the document using xelatex,
#    using the commands specified by the $xelatex and xdvipdfmx variables.
$pdf_mode = 1;

# Regenerate BBL file on each build.
$bibtex_use = 2;

