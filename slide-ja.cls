\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{slide-ja}[2024/05/21 Style for LuaTeX and Beamer (Genji Ohara)]

\RequirePackage{xkeyval}
\DeclareOptionX{aspectratio}[169]{\def\aspectratio{#1}}
\ProcessOptionsX{}
\LoadClass[aspectratio=\aspectratio,10pt]{beamer}

% LuaTeX in Japanese
\RequirePackage{luatexja}


% -----------------------------------------------------------------------------
% Beamer Theme and Background Color
% -----------------------------------------------------------------------------

\usetheme[block=fill,numbering=fraction]{metropolis}
\setbeamercolor{background canvas}{bg=white}
\RequirePackage{appendixnumberbeamer}


% -----------------------------------------------------------------------------
% Font
% -----------------------------------------------------------------------------

% Package for designating Japanese font
\RequirePackage{luatexja-fontspec}

% Math font
\usefonttheme[onlymath]{serif}

% Japanese font
\setmainjfont{Harano Aji Gothic}[Scale=0.9]
\setsansjfont{Harano Aji Gothic}
% These commands cause "Package fontspec Warning: ..."
% \setmainfont{Harano Aji Mincho}
% \setsansfont{Harano Aji Gothic}

% Caption font (make it smaller and disable reference number)
\RequirePackage[font=scriptsize,labelformat=empty]{caption}

% Footnote font (make it smaller)
\setbeamerfont{footnote}{size=\tiny}


% -----------------------------------------------------------------------------
% Title Page
% -----------------------------------------------------------------------------

% Prevent warning: "Overfull \vbox (15.63992pt too high) detected at line ..."
\let\oldmaketitle\maketitle
\renewcommand{\maketitle}{\vfuzz=15.63992pt\oldmaketitle}

% Automatically create title page
\AtBeginDocument{\maketitle}


% -----------------------------------------------------------------------------
% Section Page
% -----------------------------------------------------------------------------

% Style for section page
\setbeamertemplate{section page}{%
  \begin{beamercolorbox}[sep=10pt,center,rounded=true,shadow=true]{section title}
    \usebeamerfont{section title}\insertsectionnumber\insertsection{}
  \end{beamercolorbox}
}


% -----------------------------------------------------------------------------
% Appendix
% -----------------------------------------------------------------------------

\renewcommand{\appendixname}{Appendix}
\renewcommand{\insertsectionnumber}{\ifbeamer@inappendix\else\thesection.~\fi}


% -----------------------------------------------------------------------------
% Frame Title
% -----------------------------------------------------------------------------

% Set section, subsection and subsubsection as frame title
\newcommand\withslash[1]{\ifx#1\empty\else~/~#1\fi}
\let\oldframetitle\frametitle%
\renewcommand{\frametitle}{
  \oldframetitle{%
    \insertsectionnumber\insertsection\withslash{\insertsubsection}\withslash{\insertsubsubsection}
  }
}


% -----------------------------------------------------------------------------
% Table of Contents
% -----------------------------------------------------------------------------

% Insert [short title] in ToC
\RequirePackage{etoolbox}
\makeatletter
\patchcmd{\beamer@section}{{#2}{\the\c@page}}{{#1}{\the\c@page}}{}{}
\patchcmd{\beamer@subsection}{{#2}{\the\c@page}}{{#1}{\the\c@page}}{}{}
\patchcmd{\beamer@subsubsection}{{#2}{\the\c@page}}{{#1}{\the\c@page}}{}{}
\makeatother


% -----------------------------------------------------------------------------
% Tables
% -----------------------------------------------------------------------------

\RequirePackage{booktabs}


% -----------------------------------------------------------------------------
% Bibliography
% -----------------------------------------------------------------------------

\usepackage[style=numeric, sorting=none, doi=false]{biblatex}

% Avoid giving different numbers to the same citations in different slides.
\DeclareCiteCommand{\cite}{\usebibmacro{prenote}}{\footnotemark[\thefield{labelnumber}]\footnotetext[\thefield{labelnumber}]{\fullcite{\thefield{entrykey}}}}{\multicitedelim}{\usebibmacro{postnote}}
\DeclareCiteCommand{\secondcite}{\usebibmacro{prenote}}{\footnotemark[\thefield{labelnumber}]}{\multicitedelim}{\usebibmacro{postnote}}

% Font size of bibliography
\def\bibsize{\tiny}
\setbeamerfont{bibliography entry author}{size=\bibsize}
\setbeamerfont{bibliography entry title}{size=\bibsize}
\setbeamerfont{bibliography entry note}{size=\bibsize}


% -----------------------------------------------------------------------------
% DateTime
% -----------------------------------------------------------------------------

% For \DTMdisplaydate
\usepackage[useregional]{datetime2}


% -----------------------------------------------------------------------------
% TikZ
% -----------------------------------------------------------------------------

\RequirePackage{tikz}
\usetikzlibrary{shapes.callouts,tikzmark,calc}

% Usage: \COLabel{name#1}{text#2}
% e.g.:  \COLabel{psi1}{$\psi_1$}
\newcommand{\COLabel}[2]{%
  \tikz[%
    remember picture,%
    baseline = (#1.base),%
    every node/.style={inner sep=0,outer sep=0}%
  ]{%
    \node(#1){#2};%
  }
}

% Usage: \CO<page#1>{target name#2}{++(x,y)#3}[opt#4]{text#5}
% e.g.:  \CO<2>{psi1}{++(-4,1.5)}[text width=3cm]{hogehoge fugafuga piyopiyo}
\NewDocumentCommand\CO{d<> m m O{} m}{%
  \begin{tikzpicture}[
      remember picture,
      overlay,
      every text node part/.style={align=center}
    ]
    \IfValueTF{#1}{\path<#1>}{\path} (#2.center) #3 node[%
      anchor=center,%
      rectangle callout,%
      fill=blue!20,%
      callout absolute pointer={(#2.mid)},%
      font=\bfseries\footnotesize,
      rounded corners,
      #4
    ]{#5};
  \end{tikzpicture}
}
\newcommand{\colorrect}[2]
{%
  \tikz[baseline = (x.base),
    every text node part/.style={align=center}
  ]{%
    \node(x)[rectangle, fill=#1, rounded corners]{#2}
  }
}
