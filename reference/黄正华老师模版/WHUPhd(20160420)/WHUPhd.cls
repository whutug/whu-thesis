% !Mode:: "TeX:UTF-8"
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{WHUPhd}[2015/11/07 4.0 Wuhan University Thesis Template for PHD -- TeX Live 2015  version]

\newif\iflib\libfalse
\DeclareOption{forlib}{\libtrue}
\newif\ifprint\printfalse
\DeclareOption{forprint}{\printtrue}
\ProcessOptions

 \iflib
 \LoadClass[a4paper,zihao=-4,twoside,openany]{ctexbook}
 \else
 \LoadClass[a4paper,zihao=-4,twoside]{ctexbook}
 \fi

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions
%------------------------ Page layout ----------------------------------
\RequirePackage{fancyhdr,hyperref}
\hypersetup{pdfencoding=auto,citecolor=magenta,% magenta , cyan
            linkcolor=blue}  %%% 邓东升修改
\RequirePackage[top=3truecm,bottom=2.9truecm,left=2.8truecm,right=2.5truecm,
            %includehead,%includefoot,
           xetex]{geometry}    % 页面设置%

\newtoks\fenleihao        %中图分类号
\newtoks\bianhao          %学校编号
\newtoks\UDC               %《国际十进制分类法UDC》的类号
\newtoks\miji                %密级
\newtoks\Cmajor           %学科专业中文名
\newtoks\Emajor           %学科专业英文名
\newtoks\Especiality      %研究方向
\newtoks\Cspeciality      %研究方向
\newtoks\Edate             %英文日期
\newtoks\Etitle              %英文题目
\newtoks\Eauthor          %作者英文名
\newtoks\Esupervisor     %指导教师英文名
\newtoks\Csupervisor     %指导教师中文名
\newtoks\Schoolname    %学院英文名


%===============================================页眉设置=====================================================%
\renewcommand{\headrulewidth}{0.5pt}    %在页眉下画一个0.5pt宽的分隔线
\renewcommand{\footrulewidth}{0pt}      % 在页脚不画分隔线。

\let\ps@oldplain\ps@plain

 \fancyhf{}  %清除以前对页眉页脚的设置
 \fancyhead[CE]{武汉大学博士学位论文}                       %偶数页页眉居中位置的设置. 不填则为空.
 \fancyhead[CO]{\@title}    %L,C,R 是左中右; O,E 是奇偶. 可以自己组合调整.
 \fancyfoot[C]{-\,\thepage\,-}                     %页面下侧的设置. 大括号内置空, 表示什么也不填. 反之, 没有此命令的话, 会在页脚出现页码
 \newcommand{\fancyfancy}{\fancypagestyle{plain}{%
  \fancyhf{}
   \fancyhead[CE]{武汉大学博士学位论文}                       %偶数页页眉居中位置的设置. 不填则为空.
 \fancyhead[CO]{\@title}    %L,C,R 是左中右; O,E 是奇偶. 可以自己组合调整.
 \fancyfoot[C]{-\,\thepage\,-} }}
%%%=== 封面 ===%%%
\def\maketitle{%
  \null
  \thispagestyle{empty}%
  %\vspace*{-2cm}
  \begin{center}\leavevmode
    {\fangsong \zihao{4}%
    \begin{tabular}{lp{2cm}p{5cm}lp{2cm}l}
      \raisebox{-0.5ex}[0pt]{\makebox[1.5cm][s]{分\hfill 类\hfill 号}} & {}\hfill\raisebox{-0.5ex}[0pt]{\the\fenleihao}\hfill{} &  &
      \raisebox{-0.5ex}[0pt]{\makebox[1.5cm][s]{密\hfill 级}} & {}\hfill\raisebox{-0.5ex}[0pt]{\the\miji}\hfill{} & \\ \cline{2-2}\cline{5-5}
      \raisebox{-0.5ex}[0pt]{\makebox[1.5cm][s]{U\hfill D\hfill C} } & {}\hfill\raisebox{-0.5ex}[0pt]{\the\UDC}\hfill{}      &  &
      \raisebox{-0.5ex}[0pt]{\makebox[1.5cm][s]{编\hfill 号}} & {}\hfill\raisebox{-0.5ex}[0pt]{\the\bianhao}\hfill{}   & \\ \cline{2-2}\cline{5-5}
    \end{tabular}
    }
    \par
    \vspace*{15mm} %插入空白
    {\songti \zihao{2} \ziju{1} %武汉大学 
    \includegraphics[width=0.4\textwidth]{wudaname.eps}
    \\[3mm]  博士学位论文}\\
    \vspace{2cm}
    {\kaishu \zihao{1}  \@title \par}%
%    \vspace{4cm}
     \vfill\vfill\vfill
    {\songti\zihao{4}
    \begin{tabular}{cp{5.5cm}c}
      \raisebox{-3ex}[0pt]{\makebox[4.8cm][s]{研\hfill 究\hfill 生\hfill 姓\hfill 名: }} & {\songti {}\raisebox{-3ex}[0pt]{\@author}\hfill{}} & \\[3ex]
      \raisebox{-3ex}[0pt]{\makebox[4.8cm][s]{指\hfill 导\hfill 教\hfill 师\hfill 姓\hfill 名、\hfill 职\hfill 称: }} & {\songti
      {}\raisebox{-3ex}[0pt]{\the\Csupervisor}\hfill{}} & \\[3ex] % \cline{2-2}
      \raisebox{-3ex}[0pt]{\makebox[4.8cm][s]{学\hfill 科、\hfill 专\hfill 业\hfill 名\hfill 称: }} & {\songti {}\raisebox{-3ex}[0pt]{\the\Cmajor}\hfill{}} &
      \\[3ex]
      \raisebox{-3ex}[0pt]{\makebox[4.8cm][s]{研\hfill 究\hfill 方\hfill 向: }} & {\songti{}\raisebox{-3ex}[0pt]{\the\Cspeciality}\hfill{}} & \\[3ex]
     \end{tabular}
    }
    \par
    \vspace{25mm}
    {
%    {\heiti \zihao{3} \the\year~年 ~\the\month~月 ~\the\day~日 \par}%
    {\heiti \zihao{3} \@date \par}%
    }
    %\vspace*{-0.7cm}
  \end{center}%
  \null
  \iflib
  \else
  \newpage
  \thispagestyle{empty}
  \cleardoublepage
  \fi
  }

%------------------------ Abstract & Keywords -------------------------
\newcommand\cnabstractname{摘要}
\newcommand\enabstractname{ABSTRACT}
\newcommand\cnkeywords[1]{ {\heiti\zihao{-4}\cnkeywordsname: }#1}
\newcommand\cnkeywordsname{关键词}
\newcommand\enkeywords[1]{ {\bfseries\zihao{-4}\enkeywordsname: }#1}
\newcommand\enkeywordsname{Key words}

\newenvironment{cnabstract}{
    \newpage
    \chapter[\cnabstractname]{\ziju{2}{\cnabstractname}}   %%%终于解决了书签乱码的问题 2005-04-12.huangzh
    \songti\zihao{-4}
    \@afterheading}
    {\par}

\newenvironment{enabstract}{
    \newpage
    \chapter{\enabstractname}
    \songti\zihao{-4}
    \@afterheading}
    {\par}
%%------------------------常用宏包-----------------------------------
\RequirePackage{amsmath,amssymb}% AMSLaTeX宏包.
\RequirePackage[amsmath,thmmarks]{ntheorem}
\RequirePackage{graphicx}                 % 图形
\RequirePackage{color,xcolor}             %支持彩色
\RequirePackage{cite} % 参考文献引用, 得到形如 [3-7] 的样式.
\RequirePackage{url}
\RequirePackage{enumerate}
%%----------------------- Theorems -----------------------------------
\theoremstyle{plain}
\theoremheaderfont{\heiti}
\theorembodyfont{\songti} \theoremindent0em
\theorempreskip{0pt}
\theorempostskip{0pt}
%\theoremseparator{\hspace{1em}}
\theoremnumbering{arabic}
%\theoremsymbol{} %定理结束时自动添加的标志
\newtheorem{theorem}{\hspace{2em}定理}[section]
\newtheorem{definition}{\hspace{2em}定义}[section]
\newtheorem{lemma}{\hspace{2em}引理}[section]
\newtheorem{corollary}{\hspace{2em}推论}[section]
\newtheorem{proposition}{\hspace{2em}性质}[section]
\newtheorem{example}{\hspace{2em}例}[section]
\newtheorem{remark}{\hspace{2em}注}[section]

\theoremstyle{nonumberplain}
\theoremheaderfont{\heiti}
\theorembodyfont{\normalfont \rm \songti}
\theoremindent0em \theoremseparator{\hspace{1em}}
\theoremsymbol{$\square$}
\newtheorem{proof}{\hspace{2em}证明}

%%%---  Publications -------------------------------
\newenvironment{publications}[1]
  {\renewcommand\bibname{}\begin{thebibliography}{#1}}
  {\end{thebibliography}}

%%%--- \upcite ----------------------------------------
\newcommand{\upcite}[1]{\textsuperscript{\cite{#1}}}  %自定义新命令\upcite, 使参考文献引用以上标出现

%%%%%%%--判断是否需要彩色链接-----------------------------
  \iflib
  \hypersetup{allcolors=black}
  \else
  \fi
%%%%%%%-------------------------------------------------
%%%%%%%--判断是否需要彩色链接-----------------------------
  \ifprint
  \hypersetup{allcolors=black}
  \else
  \fi
%%%%%%%-------------------------------------------------
%%%===  suppress extra inter-line spacing in \list environments
\makeatletter \setlength\partopsep{0pt}
\def\@listI{\leftmargin\leftmargini
            \parsep 0pt
            \topsep \parsep
            \itemsep \parsep}
\@listI
\def\@listii {\leftmargin\leftmarginii
              \labelwidth\leftmarginii
              \advance\labelwidth-\labelsep
              \parsep    \z@ \@plus\z@  \@minus\z@
              \topsep    \parsep
              \itemsep   \parsep}
\def\@listiii{\leftmargin\leftmarginiii
              \labelwidth\leftmarginiii
              \advance\labelwidth-\labelsep
              \parsep    \z@ \@plus\z@  \@minus\z@
              \topsep    \parsep
              \itemsep   \parsep}
\def\@listiv{\leftmargin\leftmarginiv
              \labelwidth\leftmarginiv
              \advance\labelwidth-\labelsep
              \parsep    \z@ \@plus\z@  \@minus\z@
              \topsep    \parsep
              \itemsep   \parsep}
\def\@listv{\leftmargin\leftmarginv
              \labelwidth\leftmarginv
              \advance\labelwidth-\labelsep
              \parsep    \z@ \@plus\z@  \@minus\z@
              \topsep    \parsep
              \itemsep   \parsep}
\def\@listvi{\leftmargin\leftmarginvi
              \labelwidth\leftmarginvi
              \advance\labelwidth-\labelsep
              \parsep    \z@ \@plus\z@  \@minus\z@
              \topsep    \parsep
              \itemsep   \parsep}
%
% Change default margins for \list environments
\setlength\leftmargini   {2\ccwd} \setlength\leftmarginii
{\leftmargini} \setlength\leftmarginiii {\leftmargini}
\setlength\leftmarginiv  {\leftmargini} \setlength\leftmarginv
{\ccwd} \setlength\leftmarginvi  {\ccwd} \setlength\leftmargin
{\leftmargini} \setlength\labelsep      {.5\ccwd}
\setlength\labelwidth    {\leftmargini}
%
\setlength\listparindent{2\ccwd}
% Change \listparindent to 2\ccwd in \list
\def\list#1#2{\ifnum \@listdepth >5\relax \@toodeep
     \else \global\advance\@listdepth\@ne \fi
  \rightmargin \z@ \listparindent2\ccwd \itemindent \z@
  \csname @list\romannumeral\the\@listdepth\endcsname
  \def\@itemlabel{#1}\let\makelabel\@mklab \@nmbrlistfalse #2\relax
  \@trivlist
  \parskip\parsep \parindent\listparindent
  \advance\linewidth -\rightmargin \advance\linewidth -\leftmargin
  \advance\@totalleftmargin \leftmargin
  \parshape \@ne \@totalleftmargin \linewidth
  \ignorespaces}

\makeatother
%---------------------------------------------------
\renewcommand{\contentsname}{目\qquad 录}
\newcommand\acknowledgement{\backmatter\chapter[致谢]{\ziju{2}致谢}}
\newcommand\reseachresult{\backmatter\chapter{攻博期间发表的科研成果目录}}

%%% ---- 章节标题设置 ----- %%%%
\CTEXsetup[nameformat={\zihao{-2}\bfseries\raggedright},titleformat={\zihao{-2}\bfseries\raggedright},%
                 number={\arabic{chapter}},name={,},afterskip={30pt},beforeskip={20pt}]{chapter}
\CTEXsetup[format+={\zihao{3}\raggedright}]{section}
\CTEXsetup[format+={\zihao{4}\raggedright}]{subsection}
\CTEXsetup[format={\zihao{-4}\kaishu\raggedright}]{subsubsection}
\CTEXoptions[bibname={\large 参考文献}]
\setcounter{tocdepth}{4}
\setcounter{secnumdepth}{4}
\RequirePackage[font=small,textfont=it]{caption}

%%%=== 图片路径=== %%%
\graphicspath{{figures/}}        % 图片放在 figures 文件夹.

\allowdisplaybreaks
\endlinechar `\^^M
\endinput
