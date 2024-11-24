\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{qx-files/qx-notes}

% ===============================================================
%
% PRELIMINARY DECLARATIONS ======================================
%
% ===============================================================


\RequirePackage{etoolbox}
\RequirePackage{ifthen}


% ==============================================================
%
% OPTIONS DECLARATION
%
% ==============================================================

\newif\ifqx@pagecolor
\qx@pagecolorfalse



\DeclareKeys[qx-notes]{
  theme.store = \qx@themeName,
  %
  pagecolor.if = qx@pagecolor,
  %
  pagesize.store = \qx@pageSize
}

\ProcessKeyOptions




% ===============================================================
%
% BASE CLASS LOAD
%
% ===============================================================

% Base document class
\LoadClass{article}



% ===============================================================
%
% PACKAGE LOADING
%
% ===============================================================


% Page size control packages
\ifthenelse{\equal{\qx@pageSize}{mobile}}{%
  \PassOptionsToPackage{
    paperwidth  = 3.5in,
    paperheight = 7.5in,
    margin      = 0.1in,
  }{geometry}%
}{%
  \PassOptionsToPackage{\qx@pageSize}{geometry}%
}

\RequirePackage{geometry}


% Charge of catpuccin package for color definitions
\ifthenelse{%
  \equal{\qx@themeName}{latte}\or\equal{\qx@themeName}{frappe}\or \equal{\qx@themeName}{macchiato}\or\equal{\qx@themeName}{mocha}%
}{%
  \PassOptionsToPackage{style=\qx@themeName}{catppuccinpalette}%
}{}

\RequirePackage{catppuccinpalette}


% Box and lintings package

\RequirePackage{tcolorbox}
  \tcbuselibrary{minted}


  \usemintedstyle{catppuccin-mocha}


% ===============================================================
%
% CLASS DECLARATIONS
%mobi
% ===============================================================

% MOBILE PAGE SIZE EMERGENCY STRETCH ---------------------------
\ifthenelse{\equal{\qx@pageSize}{mobile}}{%
  \emergencystretch=2in%
  \hbadness=10000
}{}

% THEME DECLARATION --------------------------------------------

% THEME: default
\newcommand*{\qx@theme@default}{%
  \colorlet{qx-page}{white}%
  \colorlet{qx-text}{black}%
  \colorlet{qx-codebg}{white}%
  \colorlet{qx-codeframe}{black}%
}


% THEME: dark
\newcommand*{\qx@theme@dark}{%
  \colorlet{qx-page}{black}%
  \colorlet{qx-text}{white}%
  \colorlet{qx-codebg}{black}%
  \colorlet{qx-codeframe}{white}%
}


% THEME: monokai
\newcommand*{\qx@theme@monokai}{%
  \definecolor{qx-page}{HTML}{2e2e2e}%
  \definecolor{qx-text}{HTML}{d6d6d6}%
  \definecolor{qx-codebg}{HTML}{2e2e2e}%
  \definecolor{qx-codeframe}{HTML}{d6d6d6}%
}


\newcommand*{\qx@theme@catppuccin}{%
  \colorlet{qx-page}{CtpBase}%
  \colorlet{qx-text}{CtpText}%
  \colorlet{qx-codebg}{CtpBase}
  \colorlet{qx-codeframe}{CtpText}
}

\let\qx@theme@latte=\qx@theme@catppuccin
\let\qx@theme@frappe=\qx@theme@catppuccin
\let\qx@theme@macchiato=\qx@theme@catppuccin
\let\qx@theme@mocha=\qx@theme@catppuccin



% COLOR THEME APLICATION ---------------------------------------

\ifdefvoid{\qx@themeName}{%
    \qx@theme@default
}{% else
    \csname qx@theme@\qx@themeName\endcsname
}


\ifqx@pagecolor
  \pagecolor{qx-page}
  \color{qx-text}
\fi



% LISTINGS BOXES -----------------------------------------------

% Main languaje definition
\newcommand*{\qx@mainLanguage}{latex}
\newcommand*{\qxsetmainlanguage}[1]{%
  \renewcommand*{\qx@mainLanguage}{#1}%
}

\tcbset{qx code block/.style={
    coltext=qx-text,
    colback=qx-codebg,
    colframe=qx-codeframe
  }
}


% Simple code block
\NewTCBListing{codeblock}{ !D<>{\qx@mainLanguage} !O{} }{
  qx code block,
  listing only,
  minted language=#1,
  #2
}


% Simple code block for tex/latex code
\newtcblisting{texcode}{
  qx code block,
  listing only,
}


% code block with latex rendering
\newtcblisting{texexample}{
  qx code block,
  listing and text
}


% LISTING INLINE COMMANDS --------------------------------------

% Basic inline code
\NewDocumentCommand\codeline{ D<>{\qx@mainLanguage} O{} }{%
  \mintinline[#2]{#1}%
}

\newmintinline[texline]{latex}{}

\newcommand*\texcs[1]{%
  \expandafter\texline\expandafter{\string#1}%
}

\newcommand*\texenvname[1]{\Verb|{{#1}}|}

\newcommand*\texpkgname[1]{\textsf{#1}}



\endinput
