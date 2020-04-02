%% This program is a LaTeX class file for bachelor thesis template
%% of Wuhan University
%%
%% Copyright \copyright\ 2019 Fing @ WHU
%% $ v0.1, 2019/03/18$
%%
%% This project uses the MIT License, see LICENSE for more details.
%% ----------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{WHUBachelor}[Wuhan University Thesis Template for Bachelor Degree]

%%% ---- 载入Class ----- %%%
\LoadClass[a4paper,openany,oneside]{book} % A4大小，book布局

\RequirePackage[AutoFakeBold=true,AutoFakeSlant=true]{xeCJK}[2017/08/08]
\RequirePackage[zihao=-4,UTF8,heading=true]{ctex}[2016/12/27]


%%% ---- 定义页边距 ----- %%%
\RequirePackage{geometry}
\geometry{left=3cm,right=3cm,top=2.5cm,bottom=2.0cm,includefoot,xetex}

\RequirePackage{fancyhdr}%页眉页脚宏包
\renewcommand{\headrulewidth}{0pt}%页眉线宽
\renewcommand{\footrulewidth}{0pt}%页脚线宽


% 默认页面页眉页脚样式
\fancypagestyle{plain}{
    \fancyhf{}
    \fancyfoot[C]{\zihao{5}\thepage}% 页码位于页脚居中
}
\pagestyle{plain}

%%% ---- 定义标题和段落样式 ----- %%%
% 定义1.5倍行距
\RequirePackage{setspace}
\renewcommand{\baselinestretch}{1.5}
% 设置各个标题样式
\ctexset{chapter={format={\centering \heiti \zihao{-2}}, number={   % 各章标题 黑体小2号 // 修改：标题和数字字号一致 
    \arabic{chapter}},name={,},afterskip={0.5ex},beforeskip={0.8ex}}}
\ctexset{section={format={\raggedright \heiti \zihao{4}}}}          % 一级标题 黑体 4号
\ctexset{subsection={format={\raggedright \heiti \zihao{-4}}}}      % 二级标题 黑体小4号
\ctexset{subsubsection={format={\raggedright \heiti \zihao{-4}}}}   % 三级标题 黑体小4号


% 目录样式设置
\RequirePackage{tocloft}
\setcounter{tocdepth}{2}        % 目录层级数
\setcounter{secnumdepth}{3}     % 标题层级数

\renewcommand{\cfttoctitlefont}{\hfill\heiti\zihao{-2}} % 目录标题 黑体小 2 号
\renewcommand{\contentsname}{目\hspace{2em}录}
\renewcommand{\cftaftertoctitle}{\hfill}
\setlength\cftbeforetoctitleskip{-1cm}
\setlength\cftaftertoctitleskip{0ex}

\renewcommand{\cftdot}{$\cdot$}
\renewcommand{\cftdotsep}{1}%点间距
\renewcommand{\cftchapdotsep}{\cftdotsep}

\renewcommand\cftchapfont{\heiti\zihao{4}} % 目录章标题 黑体 4 号
\renewcommand\cftsecfont{\songti\zihao{-4}}
\renewcommand\cftsubsecfont{\songti\zihao{-4}}
\renewcommand\cftsubsubsecfont{\songti\zihao{-4}}
\renewcommand\cftchappagefont{\heiti\zihao{5}} % 目录页码字体
\renewcommand\cftsecpagefont{\songti\zihao{5}}
\renewcommand\cftsubsecpagefont{\songti\zihao{5}}
\renewcommand\cftsubsubsecpagefont{\songti\zihao{5}}

\renewcommand\cftchapafterpnum{\vskip5pt}
\renewcommand\cftsecafterpnum{\vskip3pt}
\renewcommand\cftsubsecafterpnum{\vskip2pt}
\setlength{\cftsecindent}{1.85em}
\setlength{\cftsubsecindent}{1.85em}
\setlength{\cftsubsubsecindent}{1.85em}

%%% ---- 图表标题设置 ----- %%%
\RequirePackage[labelsep=quad]{caption}     % 序号之后空一格写标题
% 设置表格标题字体为黑体, 设置图片标题字体为黑体
\captionsetup[table]{textfont=bf}           
\captionsetup[figure]{textfont=bf}          
\renewcommand\figurename{\bf\zihao{-4} 图}  
\renewcommand\tablename{\bf\zihao{-4} 表} 

% 使用tabularx创建占满宽度的表格
\RequirePackage{tabularx, makecell}
\newcolumntype{L}{X}
\newcolumntype{C}{>{\centering \arraybackslash}X}
\newcolumntype{R}{>{\raggedleft \arraybackslash}X}

\RequirePackage{longtable} % 做长表格的包
\RequirePackage{booktabs} % 做三线表的包

% 列表样式
\RequirePackage{enumerate, enumitem}
\setlist{noitemsep}

% 修改脚注
\makeatletter%
\long\def\@makefnmark{%
\hbox {{\normalfont \textsuperscript{\circled{\@thefnmark}}}}}%
\makeatother
\makeatletter%
\long\def\@makefntext#1{%
  \parindent 1em\noindent \hb@xt@ 1.8em{\hss \circled{\@thefnmark}}#1}%
\makeatother
\skip\footins=10mm plus 1mm
\footnotesep=6pt
\renewcommand{\footnotesize}{\songti\zihao{5}}
\renewcommand\footnoterule{\vspace*{-3pt}\hrule width 0.3\columnwidth height 1pt \vspace*{2.6pt}}

\newcommand*\circled[1]{\tikz[baseline=(char.base)]{%
\node[shape=circle,draw,inner sep=0.5pt] (char) {#1};}} % 圆圈数字①

%%% ---- 引入宏包 ----- %%%
\RequirePackage{amsmath, amssymb}
\RequirePackage[amsmath,thmmarks]{ntheorem} % 定理
\RequirePackage{graphicx, subcaption}
\RequirePackage{listings}  % 代码段
%\RequirePackage{minted}   % 代码高亮，请先用python安装pygments库
\RequirePackage{algorithm2e, algorithmic} % 算法代码
\RequirePackage{tikz, pgfplots} % 绘图
\RequirePackage{fontspec, color, url, array}

\RequirePackage{txfontsb} % Times 风格（数学）字体
% 或
% \RequirePackage{unicode-math}
% \setmathfont{TeX Gyre Termes Math} % 另一款 Times 风格数学字体，需要单独安装
% 以上两者任选其一

%%% ---- 定义字体 ----- %%%
\renewcommand{\normalsize}{\zihao{-4}} % 正常字号
\setmainfont{Times New Roman}
\setsansfont{Times New Roman}
\setmonofont{Times New Roman}



\renewcommand{\algorithmcfname}{算法} % 算法两字用中文显示

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
\ctexset{bibname={参考文献}}
\bibliographystyle{data/gbt7714-2005-whu}  % 参考文献样式

\RequirePackage{hyperref} % 引用
\hypersetup{citecolor=magenta,linkcolor=black,urlcolor=blue} % 设置引用链接颜色

\newcommand{\upcite}[1]{\textsuperscript{\cite{#1}}} % 自定义新命令\upcite, 使参考文献引用以上标出现

\renewcommand{\eqref}[1]{\textup{{\normalfont（\ref{#1}）\normalfont}}} % 公式引用使用中文括号

% 清除公式上下间距
\AtBeginDocument{
	\setlength{\abovedisplayskip}{6pt}
	\setlength{\belowdisplayskip}{6pt}
	\setlength{\abovedisplayshortskip}{0pt}
	\setlength{\belowdisplayshortskip}{0pt} 
}

\graphicspath{{figures/}} % 图片文件路径

% --------------------------------------

%%% ---- 自定义命令 ----- %%%

%%% ---- 封面 ----- %%%
\makeatletter
\def\stunum#1{\def\@stunum{#1}}\def\@stunum{}         % 学号
\def\ctitle#1{\def\@ctitle{#1}}\def\@ctitle{}         % 题目
\def\cschool#1{\def\@cschool{#1}}\def\@cschool{}      % 院系
\def\cmajor#1{\def\@cmajor{#1}}\def\@cmajor{}         % 专业
\def\cauthor#1{\def\@cauthor{#1}}\def\@cauthor{}      % 作者
\def\cadvisor#1{\def\@cadvisor{#1}}\def\@cadvisor{}   % 老师
\def\cdate#1{\def\@cdate{#1}}\def\@cdate{}            % 日期

% 论文标题页
\def\maketitlepage{
  \thispagestyle{empty}
  \begin{center}
    {\heiti \zihao{5} \hfill 
    \begin{minipage}[t]{4.5cm}
      学号\ ：\uline{\hfill\hspace{3mm}\@stunum\hspace{3mm}\hfill} \\[2mm]
      密级\ ：\uline{\hfill \hfill}
    \end{minipage}}
    \par \vspace*{6em}
    {\songti \zihao{1} 武汉大学本科毕业论文}
    \par \vspace{6em}
    \begin{minipage}[c][6cm]{14cm}
        \setlength{\baselineskip}{32pt} 
        \centering {\heiti \zihao{2} \@ctitle}
    \end{minipage}
    \par \vspace{6em}
    {\songti \zihao{-3}
      \begin{tabular}{cl}
        \makebox[3.5cm][s]{院(系)名\ 称\ ：}   & \@cschool   \\[1ex]
        \makebox[3.5cm][s]{专\ 业\ 名\ 称\ ：} & \@cmajor    \\[1ex]
        \makebox[3.5cm][s]{学\ 生\ 姓\ 名\ ：} & \@cauthor   \\[1ex]
        \makebox[3.5cm][s]{指\ 导\ 教\ 师\ ：} & \@cadvisor  \\[1ex]
      \end{tabular}}
    \par \vspace{6em}
    {\songti \zihao{-2} \@cdate}
  \end{center}
  \clearpage
}

% 论文申明页
\def\makestatement{
  \thispagestyle{empty}
  \vspace*{44pt}
  \begin{center}{\ziju{0.5}\songti \zihao{2} \textbf{郑重声明}}\end{center}
  \par\vspace*{20pt}
  \setlength{\baselineskip}{23pt}
  {\zihao{4}
  本人呈交的学位论文，是在导师的指导下，独立进行研究工作所取得的成果，所有数据、图片资料真实可靠。尽我所知，除文中已经注明引用的内容外，本学位论文的研究成果不包含他人享有著作权的内容。对本论文所涉及的研究工作做出贡献的其他个人和集体，均已在文中以明确的方式标明。本学位论文的知识产权归属于培养单位。
  \par \vspace*{88pt}
  \hspace*{0.5cm}本人签名: \underline{\hspace{3.5cm}}
  \hspace{2cm}日期: \underline{\hspace{3.5cm}}\hfill\par}
}

%%% ---- 摘要 ----- %%%
% 中文摘要
\newenvironment{cnabstract}[1]{
	\def \cnkeyword {#1}
	\clearpage
  \thispagestyle{empty}
	% \addcontentsline{toc}{chapter}{摘要}
  \begin{center} {\heiti \zihao{-2} 摘 \hspace{2em} 要} \end{center}
  \baselineskip=23pt

}{
	\vspace*{2em}
	\par\noindent {\heiti\zihao{-4} 关键词：} \cnkeyword
	\clearpage
}

% 英文摘要
\newenvironment{enabstract}[1]{
	\def \enkeyword {#1}
  \clearpage
  \thispagestyle{empty}  
  \begin{center} {\heiti \zihao{-2} \textbf{ABSTRACT}} \end{center}
  \baselineskip=23pt

}{
	\vspace*{2em}
	\par\noindent {\bfseries\zihao{-4} Key words:} \enkeyword
	\clearpage
}

%%% ---- 目录 ----- %%%
% 生成目录
\newcommand{\contents}{
  \cleardoublepage
  \pagenumbering{gobble} % 去掉目录页码
  \tableofcontents

  \cleardoublepage
  \pagenumbering{arabic} % 重新计数页码
  \setcounter{page}{1}

  \renewcommand{\baselinestretch}{1}\normalsize
  \baselineskip=23pt % 正文行距为 23 磅
}
