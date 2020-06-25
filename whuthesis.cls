%% This program is a LaTeX class file for bachelor thesis template
%% of Wuhan University
%%
%% Copyright \copyright\ 2019 Fing @ WHU
%% $ v0.1, 2019/03/18$
%%
%% This project uses the MIT License, see LICENSE for more details.
%% ----------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{whuthesis}[Wuhan University Thesis Template]

%%% ---- 文档选项 ----- %%%
\RequirePackage{kvoptions}
\RequirePackage{etoolbox}
\SetupKeyvalOptions{
  family = whu,
  prefix = whu@,
  setkeys = \kvsetkeys
}
\newcommand{\ekv}[1]{\kvsetkeys{whu}{#1}}

\DeclareStringOption[bachelor]{degree}
\DeclareVoidOption{bachelor}{\ekv{degree=bachelor}}
\DeclareVoidOption{master}{\ekv{degree=master}}
\DeclareVoidOption{doctor}{\ekv{degree=doctor}}

\DeclareStringOption[paper]{class}
\DeclareVoidOption{paper}{\ekv{class=paper}}
\DeclareVoidOption{design}{\ekv{class=design}}
\DeclareVoidOption{manual}{\ekv{class=manual}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions\relax
\ProcessKeyvalOptions*\relax

%%% ---- 载入 Class ----- %%%
\LoadClass[a4paper, zihao=-4, fontset=none, hyperref]{ctexbook} % A4 大小，book 布局
\RequirePackage{xeCJKfntef}
\hypersetup{hidelinks}


\ifdefstring{\whu@class}{paper}{
  \newcommand\whu@heading{武汉大学本科毕业论文}
}{\relax}

\ifdefstring{\whu@class}{design}{
  \newcommand\whu@heading{武汉大学本科毕业设计}
}{\relax}

\ifdefstring{\whu@class}{manual}{
  \newcommand\whu@heading{武汉大学 \LaTeX{} 模板使用手册}
  \newcommand\pkg[1]{\texttt{#1}\textsuperscript{\sffamily PKG}}
  \newcommand\env[1]{\texttt{#1}\textsuperscript{\sffamily ENV}}
  \newcommand\app[1]{\textsf{#1}}
  \newcommand\cls[1]{\texttt{#1}\textsuperscript{\sffamily CLS}}
  \newcommand\fmt[1]{\textsf{#1}}
  \RequirePackage{hologo}
  \newcommand\WhuThesis{{\sc WhuThesis}}
  \newenvironment{notice}{\color{red}{{\sffamily 注意：}}}{}
  \hypersetup{
    colorlinks=true
  } % 设置引用链接颜色
}{\relax}

%%% ---- 引入宏包 ----- %%%
\RequirePackage{amsmath, amssymb}
\RequirePackage[amsmath, thmmarks]{ntheorem}  % 定理
\RequirePackage{listings}                     % 代码段
% \RequirePackage{minted}                    
%% 代码高亮（需要 python 安装 pygments 库）
\RequirePackage{algorithm2e, algorithmic}     % 算法代码
\renewcommand\algorithmcfname{算法}
\SetAlCapSty{}
\SetAlCapFnt{\heiti}
\SetAlgoCaptionSeparator{　}
\RequirePackage{tikz, pgfplots}               % 绘图
\pgfplotsset{compat=1.17}
\RequirePackage{xcolor, url, array}
\urlstyle{rm}

\RequirePackage{siunitx}
\sisetup{
  detect-all,
	group-digits = false
}

%%% ---- 定义页面样式 ----- %%%
\RequirePackage{geometry}
\geometry{left=3cm, right=3cm, top=2.5cm, bottom=2.0cm, includefoot}

\RequirePackage{fancyhdr}           % 页眉页脚宏包
\renewcommand{\headrulewidth}{0pt}  % 页眉线宽
\renewcommand{\footrulewidth}{0pt}  % 页脚线宽

% 默认页面页眉页脚样式
\fancypagestyle{plain}{
  \fancyhf{}
  \fancyfoot[C]{\zihao{5}\thepage}  % 页码位于页脚居中
}
\pagestyle{plain}

%%% ---- 定义标题和段落样式 ----- %%%
% 定义 1.5 倍行距
\RequirePackage{zhlineskip}

% 设置各个标题样式
\ctexset{
  chapter = {
    format = {
      \centering \heiti \zihao{-2}
    },
    number = { 
      \arabic{chapter}
    },
    name = {,},
    afterskip = {0.5ex},
    beforeskip = {0.8ex}
  },  % 各章标题 黑体小 2 号
  section = {
    format = {\heiti \zihao{4}}
  },  % 一级标题 黑体 4 号
  subsection = {
    format = {\heiti \zihao{-4}}
  },  % 二级标题 黑体小 4 号
  subsubsection = {
    format = {\heiti \zihao{-4}}
  }   % 三级标题 黑体小4号
}

%%% ---- 目录样式设置 ----- %%%
\RequirePackage{tocloft}
\setcounter{tocdepth}{2}        % 目录层级数
\setcounter{secnumdepth}{3}     % 标题层级数

\renewcommand{\cfttoctitlefont}{\hfill\heiti\zihao{-2}} % 目录标题 黑体小 2 号
\renewcommand{\contentsname}{目\qquad 录\hfill}
\renewcommand{\cftaftertoctitle}{\hfill}
\setlength\cftbeforetoctitleskip{-1cm}
\setlength\cftaftertoctitleskip{0ex}

\renewcommand{\cftdot}{\(\cdot\)}
\renewcommand{\cftdotsep}{1}  % 点间距
\renewcommand{\cftchapdotsep}{\cftdotsep}

\renewcommand\cftchapfont{\heiti\zihao{4}}      % 目录章标题 黑体 4 号
\renewcommand\cftsecfont{\songti\zihao{-4}}
\renewcommand\cftsubsecfont{\songti\zihao{-4}}
\renewcommand\cftsubsubsecfont{\songti\zihao{-4}}
\renewcommand\cftchappagefont{\heiti\zihao{5}}  % 目录页码字体
\renewcommand\cftsecpagefont{\songti\zihao{5}}
\renewcommand\cftsubsecpagefont{\songti\zihao{5}}
\renewcommand\cftsubsubsecpagefont{\songti\zihao{5}}

\renewcommand\cftchapafterpnum{\vskip5pt}
\renewcommand\cftsecafterpnum{\vskip3pt}
\renewcommand\cftsubsecafterpnum{\vskip2pt}
\setlength{\cftsecindent}{1.85em}
\setlength{\cftsubsecindent}{1.85em}
\setlength{\cftsubsubsecindent}{1.85em}

%%% ---- 图表标题 ----- %%%
% 图表标题设置
\RequirePackage[labelsep=quad]{caption} % 序号之后空一格写标题
% 设置表格标题字体为黑体, 设置图标题字体为宋体
\DeclareCaptionFont{heiti}{\heiti}
\captionsetup[table]{textfont=heiti}
\renewcommand\figurename{\songti\zihao{-4} 图}
\renewcommand\tablename{\heiti\zihao{-4} 表}

\RequirePackage{graphicx, subcaption}
\graphicspath{{figures/}} % 图片文件路径

% 使用 tabularx 创建占满宽度的表格
\RequirePackage{tabularx}
\newcolumntype{L}{X}
\newcolumntype{C}{>{\centering \arraybackslash}X}
\newcolumntype{R}{>{\raggedleft \arraybackslash}X}
\renewcommand{\tabularxcolumn}[1]{m{#1}}  % 使表格内容垂向居中

\RequirePackage{longtable, xltabular}     % 做长表格的包
\RequirePackage{booktabs}                 % 做三线表的包
\RequirePackage{makecell}
\RequirePackage{multirow}                 % 跨行表格
\RequirePackage{diagbox}                  % 斜线表头
% 列表样式
\RequirePackage{enumitem}
\setlist{nosep}

% 修改脚注
\long\def\@makefnmark{%
\hbox {{\normalfont \textsuperscript{\circled{\@thefnmark}}}}}%

\long\def\@makefntext#1{%
  \parindent 1em\noindent \hb@xt@ 1.8em{\hss \circled{\@thefnmark}}#1}%
\skip\footins=10mm plus 1mm
\footnotesep=6pt
\renewcommand{\footnotesize}{\songti\zihao{5}}
\renewcommand\footnoterule{\vspace*{-3pt}\hrule width 0.3\columnwidth height 1pt \vspace*{2.6pt}}

\newcommand*\circled[1]{\tikz[baseline=(char.base)]{%
\node[shape=circle,draw,inner sep=0.5pt] (char) {#1};}} % 圆圈数字①


%%% ---- 定义字体 ----- %%%
\renewcommand{\normalsize}{\zihao{-4}}         % 正常字号
% 设置英文字体为 Times New Roman
\setmainfont{Times New Roman}[Ligatures = Rare]

\setCJKmainfont{simsun.ttc}[AutoFakeBold=4, AutoFakeSlant=0.167]
\setCJKsansfont{simhei.ttf}[AutoFakeBold=4, AutoFakeSlant=0.167]
\setCJKmonofont{simsun.ttc}[AutoFakeBold=4, AutoFakeSlant=0.167]
\setCJKfamilyfont{zhsong}{simsun.ttc}[AutoFakeBold=4, AutoFakeSlant=0.167]
\setCJKfamilyfont{zhhei}{simhei.ttf}[AutoFakeBold=4, AutoFakeSlant=0.167]
\newcommand*{\songti}{\CJKfamily{zhsong}}
\newcommand*{\heiti}{\CJKfamily{zhhei}}

\RequirePackage{unicode-math}
\setmathfont{TeX Gyre Termes Math}

%%% ---- 数学定理样式 ----- %%%
\theoremstyle{plain}
\theoremheaderfont{\heiti}
\theorembodyfont{\songti} \theoremindent0em
\theorempreskip{0pt}
\theorempostskip{0pt}
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


%%% ---- 参考文献设置 ----- %%%
\RequirePackage[sort&compress]{natbib}
\setcitestyle{numbers,square,comma}
\bibliographystyle{data/gbt7714-2005-whu}  % 参考文献样式

\newcommand{\upcite}[1]{\textsuperscript{\cite{#1}}} % 自定义新命令\upcite, 使参考文献引用以上标出现

\renewcommand{\eqref}[1]{\textup{{\normalfont（\ref{#1}）\normalfont}}} % 公式引用使用中文括号

% 清除公式上下间距
\AtBeginDocument{
	\setlength{\abovedisplayskip}{6pt}
	\setlength{\belowdisplayskip}{6pt}
	\setlength{\abovedisplayshortskip}{0pt}
	\setlength{\belowdisplayshortskip}{0pt} 
}

% --------------------------------------

%%% ---- 自定义命令 ----- %%%

%%% ---- 封面 ----- %%%
\makeatletter
\def\stunum#1{\def\whu@stunum{#1}}\def\whu@stunum{}           % 学号
\def\title#1{\def\whu@title{#1}}\def\whu@title{}              % 题目
\def\school#1{\def\whu@school{#1}}\def\whu@school{}           % 院系
\def\major#1{\def\whu@major{#1}}\def\whu@major{}              % 专业
\def\author#1{\def\whu@author{#1}}\def\whu@author{}           % 作者
\def\advisor#1{\def\whu@advisor{#1}}\def\whu@advisor{}        % 老师
\def\proftitle#1{\def\whu@proftitle{#1}}\def\whu@proftitle{}  % 职称
\def\date#1{\def\whu@date{#1}}\def\whu@date{}                 % 日期

%%% ---- 论文标题页 ----- %%%
\def\maketitlepage{
  \pagestyle{empty}
  \begin{center}
    {\heiti \zihao{5} \hfill 
    \begin{minipage}[t]{5cm}
      学号 \uline{\makebox[3cm][c]{\whu@stunum}} \\[2mm]
      密级 \uline{\makebox[3cm][c]{}}
    \end{minipage}}
    \par \vspace*{6em}
    {\songti \zihao{1} \whu@heading}
    \par \vspace{6em}
    \begin{minipage}[c][6cm]{14cm}
        \setlength{\baselineskip}{32pt} 
        \centering {\heiti \zihao{2} \whu@title}
    \end{minipage}
    \par \vspace{6em}
    {\centering \songti \zihao{-3}
      \begin{tabular}{cl}
        \makebox[8em][s]{院\ \hspace{-1em}（系）\hspace{-1em}\ 名\ 称：}   & \whu@school                        \\[1ex]
        \makebox[8em][s]{专\ 业\ 名\ 称：}                                 & \whu@major                         \\[1ex]
        \makebox[8em][s]{学\ 生\ 姓\ 名：}                                 & \whu@author                        \\[1ex]
        \makebox[8em][s]{指\ 导\ 教\ 师：}                                 & \whu@advisor \quad \whu@proftitle  \\[1ex]
      \end{tabular}}
    \par \vspace{6em}
    {\songti \zihao{-2} \whu@date}
  \end{center}
    \clearpage
}

%%% ---- 论文申明页 ----- %%%
\def\makestatement{
  \chapter*{}
  \vspace*{44pt}
  \pagenumbering{gobble}
  \begin{center}
    \ziju{0.5} \zihao{2} \textbf{郑重声明}
  \end{center}
  \par\vspace*{20pt}
  \setlength{\baselineskip}{23pt}
  {\zihao{4}
  本人呈交的学位论文，是在导师的指导下，独立进行研究工作所取得的成果，所有数据、图片资料真实可靠。尽我所知，除文中已经注明引用的内容外，本学位论文的研究成果不包含他人享有著作权的内容。对本论文所涉及的研究工作做出贡献的其他个人和集体，均已在文中以明确的方式标明。本学位论文的知识产权归属于培养单位。
  \par \vspace*{88pt}
  \hspace*{0.5cm}本人签名：\uline{\hspace{3.5cm}}
  \hspace{2cm}日期：\uline{\hspace{3.5cm}}\hfill\par}
}

%%% ---- 摘要 ----- %%%
% 中文摘要
\newenvironment{cnabstract}[1]{
  \def\whu@cnkeyword{#1}
	\cleardoublepage
	% \addcontentsline{toc}{chapter}{摘要}
  \begin{center}
    \heiti \zihao{-2} 摘\qquad 要
  \end{center}
  \baselineskip=23pt
  \par%
}{
	\vspace*{2em}
	\par\noindent {\heiti\zihao{-4} 关键词：} \whu@cnkeyword
	\clearpage
}

% 英文摘要
\newenvironment{enabstract}[1]{
  \def\whu@enkeyword{#1}
  \clearpage
  \begin{center}
    \heiti \zihao{-2} \textbf{ABSTRACT}
  \end{center}
  \baselineskip=23pt
  \par%
}{
	\vspace*{2em}
	\par\noindent {\bfseries\zihao{-4} Key words:} \whu@enkeyword
  \cleardoublepage%
}

%%% ---- 目录 ----- %%%
% 生成目录
\newcommand{\contents}{%
  \pagenumbering{gobble} % 去掉目录页码
  \tableofcontents

  \cleardoublepage
  \pagestyle{plain}
  \pagenumbering{arabic} % 重新计数页码
  \setcounter{page}{1}

  \renewcommand{\baselinestretch}{1}\normalsize
  \baselineskip=23pt % 正文行距为 23 磅
}
