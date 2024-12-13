\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{qx-files/qx-notes}[2024-11-24 Qx package for notes creation]

% ==============================================================================
%
% PRELIMINARY DECLARATIONS =====================================================
%
% ==============================================================================


\RequirePackage{etoolbox}
\RequirePackage{ifthen}


% ==============================================================================
%
% OPTIONS DECLARATION
%
% ==============================================================================

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




% ==============================================================================
%
% BASE CLASS LOAD
%
% ==============================================================================

% Base document class
\LoadClass{article}



% ==============================================================================
%
% PACKAGE LOADING
%
% ==============================================================================


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
  \tcbuselibrary{skins}
  \tcbuselibrary{breakable}

  \usetikzlibrary{babel}
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




% ==============================================================================
%
% CLASS DECLARATIONS
%
% ==============================================================================

% Stretch Mode -----------------------------------------------------------------
\ifqx@stretchmode
  \emergencystretch=1in%
  \hbadness=10000
\fi


% Theme Declaration ------------------------------------------------------------

% THEME: default
\newcommand*{\qx@theme@default}{%
  \colorlet{qx-page}{white}%
  \colorlet{qx-text}{black}%
  \colorlet{qx-codebg}{white}%
  \colorlet{qx-codeframe}{darkgray}%
  \colorlet{qx-buttonbg}{black!5}%
  \colorlet{qx-buttontext}{black!80}%
  \colorlet{qx-buttonframe}{gray}%
  \colorlet{qx-note}{blue}%
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
  \colorlet{qx-note}{blue}%
}


% THEME: monokai
\newcommand*{\qx@theme@monokai}{%
  \definecolor{qx-page}{HTML}{2e2e2e}%
  \definecolor{qx-text}{HTML}{d6d6d6}%
  \colorlet{qx-codebg}{qx-page}
  \colorlet{qx-codeframe}{qx-text}
  \colorlet{qx-buttonbg}{qx-page!90}%
  \colorlet{qx-buttontext}{qx-text!90!qx-page}%
  \colorlet{qx-buttonframe}{qx-text!30!qx-page}%
  \definecolor{qx-note}{HTML}{6c99bb}%
}


\newcommand*{\qx@theme@catppuccin}{%
  \colorlet{qx-page}{CtpBase}%
  \colorlet{qx-text}{CtpText}%
  \colorlet{qx-codebg}{CtpBase}
  \colorlet{qx-codeframe}{CtpOverlay2}
  \colorlet{qx-buttonbg}{CtpCrust}%
  \colorlet{qx-buttontext}{CtpSubtext1}%
  \colorlet{qx-buttonframe}{CtpOverlay0}%
  \colorlet{qx-note}{CtpBlue}
}


\let\qx@theme@latte=\qx@theme@catppuccin
\let\qx@theme@frappe=\qx@theme@catppuccin
\let\qx@theme@macchiato=\qx@theme@catppuccin
\let\qx@theme@mocha=\qx@theme@catppuccin



% Color Theme Aplication -------------------------------------------------------

\csname qx@theme@\qx@themeName\endcsname

\ifqx@pagecolor
  \pagecolor{qx-page}
  \color{qx-text}
\fi



% Listings Boxes ---------------------------------------------------------------

% Main languaje definition
\newcommand*{\qx@mainLanguage}{text}
\newcommand*{\qxsetmainlanguage}[1]{%
  \renewcommand*{\qx@mainLanguage}{#1}%
}

\tcbset{qx code block/.style={
    coltext=qx-text,
    colback=qx-codebg,
    colframe=qx-codeframe,
    left=2mm, right=2mm,
  }
}


% Simple code block
\NewTCBListing{codeblock}{ !O{\qx@mainLanguage} !O{} !D<>{} }{
  qx code block,
  listing only,
  minted language=#1,
  #2,
  minted options={
    tabsize=2, fontsize=\small, breaklines, autogobble, #3
  }
}


% Simple code block for tex/latex code
\NewTCBListing{texcode}{ !O{} !D<>{} }{
  qx code block,
  listing only,
  #1,
  minted options={
    tabsize=2, fontsize=\small, breaklines, autogobble, #2
  }
}


% code block with latex rendering
\NewTCBListing{texexample}{ !O{} !D<>{} }{
  qx code block,
  listing and text,
  #1,
  minted options={
    tabsize=2, fontsize=\small, breaklines, autogobble, #2
  }
}



% Listing Inline Commands ------------------------------------------------------

% Basic inline code
\NewDocumentCommand\codeline{ !O{\qx@mainLanguage} !D<>{} }{%
  \mintinline[#2]{#1}%
}

% TeX auxiliar commands
\NewDocumentCommand\texline{ D<>{} }{%
  \mintinline[#1]{latex}%
}

% Chante a command to string with highlight
\newcommand*\texcs[1]{%
  \expandafter\texline\expandafter{\string#1}%
}

% Change a string to represent a package
\newcommand*\texenvname[1]{\Verb|{{#1}}|}

% Set the formar for package naming
\newcommand*\texpkgname[1]{\textsf{#1}}

% Input parameter
\newcommand*\inputparameter[1]{%
  $\langle$\normalfont{\textit{#1}}$\rangle$%
}

\newcommand*\inputkey[1]{%
  $\langle$\normalfont{#1}$\rangle$%
}


% Key symbol
\newcommand*\qx@btn@txtsample{[j]}
\newcommand*\qx@btn@txtbase{[]}

\newcommand*\keybutton[1]{%
  \begin{tikzpicture}[
    button name/.style = {
      font=\sffamily\scriptsize, text=qx-buttontext
    },
    no frame/.style = {inner sep=0pt},
    button/.style = {
      button name, inner xsep=2.5pt, inner ysep=1.5pt, 
      rounded corners=1pt,
      fill=qx-buttonbg, minimum width=1em,
      draw=qx-buttonframe
    },
    baseline = (box.base)
]
  % Nodo de alineación con el texto
  \node[no frame] (box) {\vphantom{\qx@btn@txtsample}};
  % Nodo de la caja
  \node[button] (front) {\hphantom{#1}\vphantom{\qx@btn@txtsample}};
  % Nodo del texto
  \node[button name, no frame] at (front) {#1\vphantom{\qx@btn@txtbase}};
\end{tikzpicture}%
}



% New Tcolorbox Definitions ----------------------------------------------------

\colorlet{qx-note-title}{qx-note!50!qx-text}
\colorlet{qx-note-bg}{qx-note!15!qx-page}

\NewTColorBox{notebox}{ !O{Nota} !D<>{} }{
  title = #1.,
  coltitle = qx-note-title,
  fonttitle = \sffamily\bfseries,
  colbacktitle = qx-note-bg,
  coltext = qx-text,
  colback = qx-note-bg,
  fontupper = \sffamily,
  colframe = qx-note-bg,
  boxrule=0pt, boxsep=1mm, left=1mm, top=1mm, bottom=1mm, right=1mm,
  bottomtitle=0mm, toptitle=1mm,
  breakable,
  #2
}

\endinput
