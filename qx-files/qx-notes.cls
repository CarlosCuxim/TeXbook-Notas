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
  pagecolor.if = qx@pagecolor
}

\ProcessKeyOptions




% ===============================================================
%
% BASE CLASS LOAD
%
% ===============================================================

% Base document class
\LoadClass{report}



% ===============================================================
%
% PACKAGE LOADING
%
% ===============================================================

% Charge of catpuccin package for color definitions
\ifthenelse{%
  \equal{\qx@themeName}{latte}\or\equal{\qx@themeName}{frappe}\or \equal{\qx@themeName}{macchiato}\or\equal{\qx@themeName}{mocha}%
}{%
  \PassOptionsToPackage{style=\qx@themeName}{catppuccinpalette}%
}{}

\RequirePackage{catppuccinpalette}



% ===============================================================
%
% CLASS DECLARATIONS
%
% ===============================================================


% THEME DECLARATION ---------------------------------------------

% THEME: default
\newcommand*{\qx@theme@default}{%
  \colorlet{qx-page}{white}%
  \colorlet{qx-text}{black}%
}


% THEME: dark
\newcommand*{\qx@theme@dark}{%
  \colorlet{qx-page}{black}%
  \colorlet{qx-text}{white}%
}


% THEME: monokai
\newcommand*{\qx@theme@monokai}{%
  \definecolor{qx-page}{HTML}{2e2e2e}%
  \definecolor{qx-text}{HTML}{d6d6d6}%
}

\newcommand*{\qx@theme@catppuccin}{%
  \colorlet{qx-page}{CtpBase}%
  \colorlet{qx-text}{CtpText}%
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


\endinput
