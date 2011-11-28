%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  UMass Thesis Class
%%
%%    Based on merging a version from Jamie Callan/Carla Brodley 
%%    with the Utah version that has also been floating around.
%%
%%      Makes adjustments to the basic REPORT document style
%%      Size selected in documentstyle must be 12pt
%%              (see thesis.tex in this directory for usage example)
%%
%%  Author: Tony Hosking, 1995
%%  Turned into a class file and rewritten by John Ridgway, 1997
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Identification part
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{umthesis}[1997/08/21 v1.0 U.Mass. dissertation class]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Initial code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Declaration of options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\ifdouble@space
\newif\ifcondensed@frontmatter
\DeclareOption{10pt}{\def\@mysize{10pt}}
\DeclareOption{11pt}{\def\@mysize{11pt}}
\DeclareOption{12pt}{\def\@mysize{12pt}}
\DeclareOption{singlespace}{\double@spacefalse}
\DeclareOption{doublespace}{\double@spacetrue}
\DeclareOption{condensed}{\condensed@frontmattertrue\double@spacefalse}
\DeclareOption{uncondensed}{\condensed@frontmatterfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Execution of options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ExecuteOptions{12pt,doublespace,uncondensed}
\ProcessOptions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Package loading
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\LoadClass[\@mysize]{report}[1995/06/26]

% load case-manipulation commands compatible with hyperref
\usepackage{textcase}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Post-package-loading fixups.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\input{umth\@mysize.clo}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Main code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\toc@section}{Chapter}

\newcounter{count@FrontMatter}
\newcounter{count@Chapter}
\newcounter{count@Appendix}
\newcounter{count@BackMatter}

\AtEndDocument{\immediate\write\@mainaux{\string\setcounter{count@FrontMatter}
    {\arabic{count@FrontMatter}}}}
\AtEndDocument{\immediate\write\@mainaux{\string\setcounter{count@Chapter}
    {\arabic{count@Chapter}}}}
\AtEndDocument{\immediate\write\@mainaux{\string\setcounter{count@Appendix}
    {\arabic{count@Appendix}}}}
\AtEndDocument{\immediate\write\@mainaux{\string\setcounter{count@BackMatter}
    {\arabic{count@BackMatter}}}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Major document structure, \frontmatter, \mainmatter, \appendix, \backmatter

\newcommand{\frontmatter}{
  \setcounter{secnumdepth}{-1}
  \renewcommand{\toc@section}{FrontMatter}
  \setcounter{count@FrontMatter}{0}
  \ifdouble@space\doublespacenormalsize\fi
  }

\newcommand{\mainmatter}{
  \setcounter{secnumdepth}{5}
  \clearpage
  \pagenumbering{arabic}          % Arabic numbers from here on
  \raggedbottom
  \ifdouble@space\doublespacenormalsize\fi
  \renewcommand{\toc@section}{Chapter}
  \setcounter{count@Chapter}{0}
  }

\renewcommand{\appendix}{
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \renewcommand\@chapapp{\appendixname}%
  \renewcommand\thechapter{\@Alph\c@chapter}
  \renewcommand{\toc@section}{Appendix}
  \ifnum\value{count@Appendix}<2
    \let\@chapter\@onlyappendix
  \fi
  \setcounter{count@Appendix}{0}
  }

\newcommand{\backmatter}{
  \setcounter{secnumdepth}{5}
  \renewcommand{\@chapapp}{\chaptername}
  \renewcommand{\toc@section}{BackMatter}
  \let\@chapter\normal@chapter
  \setcounter{count@BackMatter}{0}
  \normalsize
  }

\def\@onlyappendix[#1]#2{
  \@schapter{#2}
  \addcontentsline{toc}{OnlyAppendix}{\MakeTextUppercase{#1}}
  }


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter/Appendix related stuff

\newcommand{\unnumberedchapter}[2][]{
  \def\@tempa{#1}
  \def\@tempb{}
  \ifx\@tempa\@tempb
    \def\@tempc{#2}
  \else
    \def\@tempc{#1}
  \fi
  \chapter*{#2}
  \addcontentsline{toc}{\toc@section}{\MakeTextUppercase{\@tempc}}
}

%% redefine @chapter to change toc entries
\def\@chapter[#1]#2{
  \ifnum \c@secnumdepth >\m@ne
    \refstepcounter{chapter}%
    \typeout{\@chapapp\space\thechapter.}%
    \addcontentsline{toc}{\toc@section}
                         {\protect\numberline{\thechapter}{\MakeTextUppercase{#1}}}%
  \else
    \addcontentsline{toc}{\toc@section}{\MakeTextUppercase{#1}}%
  \fi
  \chaptermark{#1}%
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
  \if@twocolumn
    \@topnewpage[\@makechapterhead{#2}]%
  \else
    \@makechapterhead{#2}%
    \@afterheading
  \fi
  \stepcounter{count@\toc@section}
  }

\renewcommand\chapter{
  \if@openright\cleardoublepage\else\clearpage\fi
  \thispagestyle{plain}%
  \@afterindenttrue
  \global\@topnum\z@
  \secdef\@chapter\@schapter
  }

\renewcommand{\@makechapterhead}[1]{    % Heading for \chapter command
  \vspace*{30\p@}                       % Space at top of text page.
  \begin{center}\large\bfseries
    \ifnum \c@secnumdepth >\m@ne
      \MakeTextUppercase{\@chapapp}\ \thechapter % 'CHAPTER' and number.
      \par\nobreak
    \fi
  \addvspace{\topskip}
  {\MakeTextUppercase{#1}}
  \end{center}
  \par\nobreak                          % TeX penalty to prevent page break.
  \vskip 24\p@                          % Space between title and text.
  }

\let\base@schapter\@schapter
\def\@schapter#1{
  \base@schapter{#1}
  \stepcounter{count@\toc@section}
  }

\renewcommand{\@makeschapterhead}[1]{   % Heading for \chapter* command
  \vspace*{30\p@}                       % Space at top of page.
  \begin{center}
    \large\bfseries                     % Title.
    {\MakeTextUppercase{#1}}\par
  \end{center}
  \nobreak                              % TeX penalty to prevent page break.
  \vskip 24\p@                          % Space between title and text.
  }

\let\normal@chapter\@chapter %% save the chapter


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Tweak penalties
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%\hyphenpenalty=400
%%\exhyphenpenalty=400

\clubpenalty=10000              % 'Club line'  at bottom of page.
\widowpenalty=10000             % 'Widow line' at top of page.
\displaywidowpenalty=3000       % Math display widow line.
\predisplaypenalty=3000         % Breaking before a math display.
\postdisplaypenalty=2000        % Breaking after a math display.

%% Do these need tweaking too?
%%\interlinepenalty               % Breaking at a line within a paragraph.
%%\brokenpenalty                  % Breaking after a hyphenated line.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Tweak table of contents
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\let\base@tableofcontents\tableofcontents
\renewcommand{\tableofcontents}{\normalsize\base@tableofcontents}

\renewcommand{\contentsname}{Table of Contents}

\def\thetocindent{-1}
\newif\if@seenChapter
\newif\if@seenAppendix
\newif\if@seenBackMatter
\@seenChapterfalse
\@seenAppendixfalse
\@seenBackMatterfalse

\newlength{\umthesis@pnumwidth}
\settowidth{\umthesis@pnumwidth}{\textbf{999}}

\newlength{\umthesis@tocrmarg}
\settowidth{\umthesis@tocrmarg}{\textbf{M999}}

\renewcommand{\@pnumwidth}{\umthesis@pnumwidth}
\renewcommand{\@tocrmarg}{\umthesis@tocrmarg}

\newcommand{\l@FrontMatter}[2]{
  \addpenalty{-\@highpenalty}
  \addvspace{\baselineskip}
  \@dottedtocline{0}{0.0em}{1.5em}{\bfseries #1}{\bfseries #2}
  }

\newcommand{\l@Chapter}[2]{
  \addpenalty{-\@highpenalty}
  \addvspace{\baselineskip}
  \if@seenChapter\else
    \addvspace{2\baselineskip}
    \parindent\z@ {\bfseries \chaptername} \par
    \addvspace{\baselineskip}
    \@seenChaptertrue
  \fi
  \@dottedtocline{0}{0.0em}{1.5em}{\bfseries#1}{\bfseries#2}
  }

\newcommand{\l@Appendix}[2]{
  \addpenalty{-\@highpenalty}
  \addvspace{\baselineskip}
  \if@seenAppendix\else
    \addvspace{2\baselineskip}
    \parindent\z@ {\bfseries \appendixname} \par
    \addvspace{\baselineskip}
    \@seenAppendixtrue
  \fi
  \@dottedtocline{0}{0.0em}{1.5em}{\bfseries #1}{\bfseries #2}
  }

\newcommand{\l@OnlyAppendix}[2]{
  \addpenalty{-\@highpenalty}
  \addvspace{2\baselineskip}
  \parindent\z@
  \@dottedtocline{0}{0.0em}{1.5em}{\bfseries
    {\MakeTextUppercase{\appendixname}}: #1}{\bfseries #2}
  }

\newcommand{\l@BackMatter}[2]{
  \addpenalty{-\@highpenalty}
  \addvspace{\baselineskip}
  \if@seenBackMatter\else
    \addvspace{2\baselineskip}
    \@seenBackMattertrue
  \fi
  \@dottedtocline{0}{0.0em}{1.5em}{\bfseries #1}{\bfseries #2}
  }

%\renewcommand{\@pnumwidth}{1.7em}
%\renewcommand{\@tocrmarg}{2.7em}


\let\@basedottedtocline\@dottedtocline
\renewcommand{\@dottedtocline}[5]{
  \ifnum #1>\c@tocdepth
  \else
    \ifnum \thetocindent = #1 \else
      \def\thetocindent{#1}
      \ifdouble@space\addvspace{\topskip}\fi
    \fi
    \@basedottedtocline{#1}{#2}{#3}{#4}{#5}
  \fi
  }


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Tweak lists of tables and figures
%%
\newlength{\tablenumberwidth}
\setlength{\tablenumberwidth}{2.3em}

\ifcondensed@frontmatter
  \renewcommand{\listoffigures}{}
\else
  \renewcommand{\listoffigures}{%
    \normalsize
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter{\listfigurename
      \@mkboth{\MakeTextUppercase{\listfigurename}}%
              {\MakeTextUppercase{\listfigurename}}}%
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    }
\fi
\renewcommand{\l@figure}[2]{
  \vspace{\baselineskip}
  \@basedottedtocline{1}{1.5em}{\tablenumberwidth}{#1}{#2}
  }

\ifcondensed@frontmatter
  \renewcommand{\listoftables}{}
\else
  \renewcommand{\listoftables}{%
    \normalsize
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter{\listtablename
      \@mkboth{%
          \MakeTextUppercase{\listtablename}}{\MakeTextUppercase{\listtablename}}}%
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    }
\fi
\let\l@table\l@figure


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Page layout -- as required
%%

\setlength{\oddsidemargin}{0.5truein}  % binding margin at least 1.5in
\setlength{\evensidemargin}{0.5truein} % same as odd side
\setlength{\textwidth}{6.0truein}      % 6in wide typing area
\setlength{\topmargin}{-0.5truein} % page numbers at top of page 0.5in from top
\setlength{\headheight}{0.2truein} % room for header
\setlength{\headsep}{0.3truein}    % header 0.3in from body, body 1in from top
\setlength{\textheight}{9.0truein} % 9in high typing area
\setlength{\footskip}{0.5truein}   % footer 0.5in from body, 0.5in from bottom


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Added commands and environments for front matter
%%

\def\@degree{Doctor of Philosophy}
\def\@degreeabbrv{Ph.D.}
\newcommand{\degree}[2]{\gdef\@degree{#1} \gdef\@degreeabbrv{#2}}
\def\copyrightyear#1{\gdef\@copyrightyear{#1}}
\def\bachelors#1#2{\gdef\@bachelors{#1, \MakeTextUppercase{#2}}}
\def\masters#1#2{\gdef\@masters{#1, \MakeTextUppercase{#2}}}
\def\committeechair#1{\gdef\@committeechair{#1}}
\def\firstreader#1{\gdef\@firstreader{#1}}
\def\secondreader#1{\gdef\@secondreader{#1}}
\newif\ifthird
\thirdfalse
\def\thirdreader#1{\gdef\@thirdreader{#1}\thirdtrue}
\newif\iffourth
\fourthfalse
\def\fourthreader#1{\gdef\@fourthreader{#1}\fourthtrue}
\newif\iffifth
\fifthfalse
\def\fifthreader#1{\gdef\@fifthreader{#1}\fifthtrue}
\newif\ifsixth
\sixthfalse
\def\sixthreader#1{\gdef\@sixthreader{#1}\sixthtrue}
\def\departmentchair#1{\gdef\@departmentchair{#1}}
\def\departmentname#1{\gdef\@departmentname{#1}}

\ifcondensed@frontmatter
  \input{umthcfm.clo}
\else
  \input{umthstd.clo}
\fi


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Tweak chapter headings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
%% Text heading tweaks
%%

\setcounter{secnumdepth}{5}

\ifcondensed@frontmatter
  \setcounter{tocdepth}{0}
\else
  \setcounter{tocdepth}{3}
\fi


\renewcommand{\section}{
  \@startsection{section}{1}{\z@}
                {4.5ex \@plus 1ex \@minus .2ex}
                {0.001ex \@plus .2ex}
                {\normalfont\doublespacelarge\bfseries}}

\renewcommand{\subsection}{
  \@startsection{subsection}{2}{\z@}%
                {3.25ex \@plus 1ex \@minus .2ex}%
                {0.001ex \@plus .2ex}%
                {\normalfont\doublespacenormalsize\bfseries}}

\renewcommand{\subsubsection}{
  \@startsection{subsubsection}{3}{\z@}%
                {3.25ex \@plus 1ex \@minus .2ex}%
                {0.001ex \@plus .2ex}%
                {\normalfont\doublespacenormalsize\bfseries}}

\renewcommand{\paragraph}{
  \@startsection{paragraph}{4}{\z@}%
                {2.5ex \@plus1ex \@minus.2ex}%
                {-1em}%
                {\normalfont\normalsize\bfseries}}

\renewcommand{\subparagraph}{
  \@startsection{subparagraph}{5}{\parindent}%
                {0.0ex \@plus1ex \@minus .2ex}%
                {-1em}%
                {\normalfont\normalsize\bfseries}}


%%
%% Fix captions
%%

\setlength\abovecaptionskip{\topskip}
\setlength\belowcaptionskip{\topskip}

\long\def\@makecaption#1#2{%
  \addvspace{\abovecaptionskip}
  \sbox\@tempboxa{\textbf{#1.} #2}%
  \ifdim \wd\@tempboxa >\hsize
    \textbf{#1.} #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \par
  \vskip\belowcaptionskip
  \par
  }


%%
%% Default spacing of tabular environment to single
%%
\let\base@tabular\tabular
\renewcommand{\tabular}[2][]{
%  \ls{1}
  \base@tabular[#1]{#2}}

%%
%% Fix quote and quotation environments
%%
\renewenvironment{quotation}{
  \list{}{
    \listparindent 1.5em
    \itemindent    \listparindent
    \rightmargin   \leftmargin
    \parsep        \z@ \@plus\p@
    }
  \item[]
%  \ls{1}
  }
{\endlist}
\renewenvironment{quote}{
  \list{}{\rightmargin\leftmargin}\item[]
%          \ls{1}
          }
         {\endlist}


%%
%% Fix footnotes -- double spacing between footnotes, single spacing within
%%     footnotes is what is required.

\newlength{\umthesis@basefootnotesep}
\newlength{\umthesis@baseskipfootins}

\setlength{\umthesis@basefootnotesep}{\footnotesep}
\setlength{\umthesis@baseskipfootins}{\skip\footins}

\ifdouble@space
  \setlength{\footnotesep}{2\umthesis@basefootnotesep}
  \setlength{\skip\footins}{2\umthesis@baseskipfootins}
\fi

%\let\umthesis@basefootnote\footnote
%\def\footnote{\renewcommand{\baselinestretch}{1}\umthesis@basefootnote}

\let\base@footnotetext\@footnotetext
\long\def\@footnotetext{%
  \renewcommand{\baselinestretch}{1}%
  \base@footnotetext%
}

%%
%% Fix the bibliography

\let\base@thebibliography\thebibliography
\let\endbase@thebibliography\endthebibliography

\renewenvironment{thebibliography}[1]{
  \begin{base@thebibliography}{#1}
  \addcontentsline{toc}{\toc@section}{\MakeTextUppercase{\bibname}}%
    }{\end{base@thebibliography}}

\newcommand{\doublespace}{\doublespacenormalsize}
