\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{qx-files/qx-notes}[2024-11-24 Qx package for notes creation]

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

\newif\ifqx@stretchmode
\qx@stretchmodefalse


\DeclareKeys[qx-notes]{
  theme.store = \qx@themeName,
  %
  pagecolor.if = qx@pagecolor,
  %
  pagesize.store = \qx@pageSize,
  %
  stretchmode.if = qx@stretchmode
}

\ProcessKeyOptions


\ifdefvoid{\qx@themeName}{\renewcommand*\qx@themeName{default}}{}
\ifdefvoid{\qx@pageSize}{\renewcommand*\qx@pageSize{letterpaper}}{}




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
  \equal{\qx@themeName}{latte}\or\equal{\qx@themeName}{frappe}\or%
  \equal{\qx@themeName}{macchiato}\or\equal{\qx@themeName}{mocha}%
}{%
  \PassOptionsToPackage{style=\qx@themeName}{catppuccinpalette}%
}{}

\RequirePackage{catppuccinpalette}



% Box and listings package
\RequirePackage{tcolorbox}
  \tcbuselibrary{minted}

  \usetikzlibrary{calc}
  \usetikzlibrary{backgrounds}
  \usetikzlibrary{arrows.meta}

  \ifdefstring{\qx@themeName}{default}
    {\usemintedstyle{default}}{}
  \ifdefstring{\qx@themeName}{dark}
    {\usemintedstyle{rrt}}{}
  \ifdefstring{\qx@themeName}{monokai}
    {\usemintedstyle{monokai}}{}
  \ifdefstring{\qx@themeName}{latte}
    {\usemintedstyle{catppuccin-latte}}{}
  \ifdefstring{\qx@themeName}{frappe}
    {\usemintedstyle{catppuccin-frappe}}{}
  \ifdefstring{\qx@themeName}{macchiato}
    {\usemintedstyle{catppuccin-macchiato}}{}
  \ifdefstring{\qx@themeName}{mocha}
    {\usemintedstyle{catppuccin-mocha}}{}




% ===============================================================
%
% CLASS DECLARATIONS
%
% ===============================================================

% STRETCH MODE --------------------------------------------------
\ifqx@stretchmode
  \emergencystretch=1in%
  \hbadness=5000
\fi


% THEME DECLARATION --------------------------------------------

% THEME: default
\newcommand*{\qx@theme@default}{%
  \colorlet{qx-page}{white}%
  \colorlet{qx-text}{black}%
  \colorlet{qx-codebg}{white}%
  \colorlet{qx-codeframe}{darkgray}%
  \colorlet{qx-buttonbg}{black!5}%
  \colorlet{qx-buttontext}{black!80}%
  \colorlet{qx-buttonframe}{gray}%
}


% THEME: dark
\newcommand*{\qx@theme@dark}{%
  \colorlet{qx-page}{black}%
  \colorlet{qx-text}{white}%
  \colorlet{qx-codebg}{black}%
  \colorlet{qx-codeframe}{gray}%
  \colorlet{qx-buttonbg}{black!90}%
  \colorlet{qx-buttontext}{white!75}%
  \colorlet{qx-buttonframe}{darkgray}%
}


% THEME: monokai
\newcommand*{\qx@theme@monokai}{%
  \definecolor{qx-page}{HTML}{2e2e2e}%
  \definecolor{qx-text}{HTML}{d6d6d6}%
  \definecolor{qx-codebg}{HTML}{2e2e2e}%
  \definecolor{qx-codeframe}{HTML}{d6d6d6}%
  \colorlet{qx-buttonbg}{qx-page!90}%
  \colorlet{qx-buttontext}{qx-text!90!qx-page}%
  \colorlet{qx-buttonframe}{qx-text!30!qx-page}%
}


\newcommand*{\qx@theme@catppuccin}{%
  \colorlet{qx-page}{CtpBase}%
  \colorlet{qx-text}{CtpText}%
  \colorlet{qx-codebg}{CtpBase}
  \colorlet{qx-codeframe}{CtpOverlay2}
  \colorlet{qx-buttonbg}{CtpCrust}%
  \colorlet{qx-buttontext}{CtpSubtext1}%
  \colorlet{qx-buttonframe}{CtpOverlay0}%
}

\let\qx@theme@latte=\qx@theme@catppuccin
\let\qx@theme@frappe=\qx@theme@catppuccin
\let\qx@theme@macchiato=\qx@theme@catppuccin
\let\qx@theme@mocha=\qx@theme@catppuccin



% COLOR THEME APLICATION ---------------------------------------

\csname qx@theme@\qx@themeName\endcsname

\ifqx@pagecolor
  \pagecolor{qx-page}
  \color{qx-text}
\fi



% LISTINGS BOXES -----------------------------------------------

% Main languaje definition
\newcommand*{\qx@mainLanguage}{text}
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

% TeX auxiliar commands
\newmintinline[texline]{latex}{}

\newcommand*\texcs[1]{%
  \expandafter\texline\expandafter{\string#1}%
}

\newcommand*\texenvname[1]{\Verb|{{#1}}|}

\newcommand*\texpkgname[1]{\textsf{#1}}

% Input parameter
\newcommand*\inputparameter[1]{$\langle$\textit{#1}$\rangle$}

% Key symbol
\newcommand*\qx@btn@txtsample{[j]}
\newcommand*\qx@btn@txtbase{[]}

\newcommand*\keybutton[1]{%
  \begin{tikzpicture}[
    button name/.style = {
      font=\sffamily\scriptsize, text=qx-buttontext
    },
    no frame/.style = {inner sep=0pt},
    button back/.style = {
      button name, fill=qx-buttonframe, inner xsep=3pt,
      inner ysep=2pt, rounded corners=1.5pt,
      minimum width=1em+2pt
    },
    button front/.style = {
      button name, inner xsep=2pt, inner ysep=1pt, 
      rounded corners=1pt, xshift=-0.5pt, yshift=0.5pt,
      top color=qx-buttonbg, bottom color=qx-page,
      minimum width=1em
    },
    baseline = (box.base)
]
  % Nodo de alineación con el texto
  \node[no frame] (box) {\vphantom{\qx@btn@txtsample}};
  % Nodo de frame
  \node[button back] {\hphantom{#1}\vphantom{\qx@btn@txtsample}};
  % Nodo de la caja
  \node[button front] (front) {\hphantom{#1}\vphantom{\qx@btn@txtsample}};
  % Nodo del texto
  \node[button name, no frame] at (front) {#1\vphantom{\qx@btn@txtbase}};
\end{tikzpicture}%
}



\endinput
