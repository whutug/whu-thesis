%% This program is a LaTeX class file for bachelor thesis template
%% of Wuhan University
%%
%% Copyright \copyright\ 2019 Fing @ WHU
%% Revise                2020 List @ WHU
%% $ v0.1, 2019/03/18$
%% $ v0.2, 2020/12/20$
%%
%% This project uses the MIT License, see LICENSE for more details.
%% ----------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesExplClass{whuthesis}{2020/12/10}{0.2}{Wuhan University Thesis Template}
\ExplSyntaxOff

\ExplSyntaxOn
\msg_new:nnn { whuthesis } { 引擎不支持 }
  {
    WhuThesis~暂不支持~#1~引擎。\\\\

    请使用~XeLaTeX~或~LuaLaTeX~进行编译！
  }
\sys_if_engine_xetex:F
  {
    \sys_if_engine_luatex:F
      {
        \msg_fatal:nnx { whuthesis } { 引擎不支持 }
          { \c_sys_engine_str }
      }
  }
\ExplSyntaxOff

%%% ---- 文档选项 ----- %%%
\RequirePackage{kvoptions}
\RequirePackage{etoolbox}
\SetupKeyvalOptions{
  family = whu,
  prefix = whu@,
  setkeys = \kvsetkeys
}
\newcommand{\whu@defkey}[1]{\kvsetkeys{whu}{#1}}

\DeclareStringOption[bachelor]{degree}
\DeclareVoidOption{bachelor}{\whu@defkey{degree=bachelor}}
\DeclareVoidOption{master}{\whu@defkey{degree=master}}
\DeclareVoidOption{doctor}{\whu@defkey{degree=doctor}}

\DeclareStringOption[paper]{class}
\DeclareVoidOption{paper}{\whu@defkey{class=paper}}
\DeclareVoidOption{design}{\whu@defkey{class=design}}
\DeclareVoidOption{manual}{\whu@defkey{class=manual}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions\relax
\ProcessKeyvalOptions*\relax

%%% ---- 载入 Class ----- %%%
\LoadClass[a4paper, zihao=-4, fontset=none, hyperref]{ctexbook} % A4 大小，book 布局
\RequirePackage{ulem}
\hypersetup{hidelinks}

\ExplSyntaxOn
\sys_if_engine_luatex:TF
  {
    \RequirePackage{emoji}
    % \setemojifont{Segoe UI Emoji}
    \providecommand{\emojitest}{如：\emoji{hot-pepper}\emoji{pear}\emoji{four}\emoji{syringe}\emoji{sweat-drops}\emoji{cow-face}\emoji{beer}。}
    \PassOptionsToClass{punct=zh_CN/quanjiao}{ctexbook}
    \RequirePackage{luatexja-adjust}
  }
  {
    \providecommand{\emojitest}{\hologo{XeLaTeX} 等其他引擎则暂不支持。}
  }
\ExplSyntaxOff

\ifdefstring{\whu@class}{paper}{
  \newcommand\whu@heading{武汉大学本科毕业论文}
}{\relax}

\ifdefstring{\whu@class}{design}{
  \newcommand\whu@heading{武汉大学本科毕业设计}
}{\relax}

\ifdefstring{\whu@class}{manual}{
  \newcommand\whu@heading{武汉大学 \LaTeX{} 模板使用手册}
  \newcommand*{\meta}[1]{{%
        \ensuremath{\langle}\rmfamily\itshape#1\/\ensuremath{\rangle}}}
  \newcommand\pkg[1]{\textsf{#1}}
  \newcommand\env[1]{\texttt{#1}}
  \newcommand\app[1]{\textsf{#1}}
  \newcommand\cls[1]{\textsf{#1}}
  \newcommand\fmt[1]{\textsf{#1}}
  \RequirePackage{hologo}
  \newcommand\WhuThesis{\textsc{Whu\-The\-sis}}
  \newenvironment{notice}{\color{red}{{\heiti 注意：}}}{}
  \hypersetup{
    colorlinks=true
  } % 设置引用链接颜色
}{\relax}

%%% ---- 引入宏包 ----- %%%
\RequirePackage{amsmath, amssymb, amsthm}
\RequirePackage{listings}                     % 代码段
% \RequirePackage{minted}                    
%% 代码高亮（需要 python 安装 pygments 库）
\RequirePackage{algorithm2e}     % 算法代码
\renewcommand\algorithmcfname{算法}
\SetAlCapSty{}
\SetAlCapFnt{\heiti}
\SetAlgoCaptionSeparator{\hspace*{0.75em}}

\RequirePackage{tikz, pgfplots}               % 绘图
\pgfplotsset{compat=1.17}
\RequirePackage{xcolor, url, array}
\urlstyle{rm}

\RequirePackage{physics}
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
    },  % 三级标题 黑体小4号
  tocdepth = 2,     % 目录层级数
  secnumdepth = 3   % 标题层级数
}

%%% ---- 目录样式设置 ----- %%%
\RequirePackage{tocloft}
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
\RequirePackage[perpage]{footmisc}
% 每面更新序号

\long\def\@makefnmark{%
  \hbox {{\textsuperscript{\circled{\@thefnmark}}}}}%

\long\def\@makefntext#1{%
  \noindent \hb@xt@ 1em{\circled{\@thefnmark}}#1}%
\skip\footins=10mm plus 1mm
\footnotesep=6pt
\renewcommand{\footnotesize}{\songti\zihao{5}}
\renewcommand\footnoterule{\vspace*{-3pt}\hrule width 0.3\columnwidth height 1pt \vspace*{2.6pt}}

\newcommand*\circled[1]{\makebox[1em][c]{\tikz[baseline=(char.base)]{%
      \node[shape=circle,draw,inner sep=0pt,minimum size=1em] (char) {#1};}}} % 圆圈数字①


%%% ---- 定义字体 ----- %%%
\renewcommand{\normalsize}{\zihao{-4}}         % 正常字号
% 设置英文字体为 Times New Roman
\setmainfont{Times New Roman}[Ligatures = Rare]

\ExplSyntaxOn

\tl_set:Nn \l__whu_setsimfont
  {
    \setCJKmainfont{simsun.ttc}[AutoFakeBold=4, AutoFakeSlant=0.167]
    \setCJKsansfont{simhei.ttf}[AutoFakeBold=4, AutoFakeSlant=0.167]
    \setCJKmonofont{simsun.ttc}[AutoFakeBold=4, AutoFakeSlant=0.167]
    \newCJKfontfamily{\songti}{simsun.ttc}[AutoFakeBold=4, AutoFakeSlant=0.167]
    \newCJKfontfamily{\heiti}{simhei.ttf}[AutoFakeBold=4, AutoFakeSlant=0.167]
  }

\tl_set:Nn \l__whu_setfandolfont
  {
    \setCJKmainfont { FandolSong-Regular }
      [
        Extension = .otf,
        BoldFont = FandolSong-Bold,
        AutoFakeSlant = 0.167
      ] 
    \setCJKsansfont { FandolHei-Regular }
      [
        Extension = .otf,
        BoldFont = FandolHei-Bold,
        AutoFakeSlant = 0.167
      ]
    \newCJKfontfamily{ \songti }{ FandolSong-Regular }
      [
        Extension = .otf,
        BoldFont = FandolSong-Bold,
        AutoFakeSlant = 0.167
      ]
    \newCJKfontfamily { \heiti } { FandolHei-Regular }
      [
        Extension = .otf,
        BoldFont = FandolHei-Bold,
        AutoFakeSlant = 0.167
      ]
  }


\sys_if_platform_windows:TF
  {
    \tl_use:N \l__whu_setsimfont
  }
  {
    \file_if_exist:nTF { /System/Library/Fonts/Menlo.ttc }
    % \ctex_if_platform_macos:TF
      {
        \tl_use:N \l__whu_setsimfont
      }
      {
        \file_if_exist:nTF { simsun.ttc }
          {
            \file_if_exist:nTF { simhei.ttf } 
              {
                \tl_use:N \l__whu_setsimfont
              }
              {
                \tl_use:N \l__whu_setfandolfont
              }
          }
          {
            \tl_use:N \l__whu_setfandolfont
          }
      }
  }

\ExplSyntaxOff

\RequirePackage{unicode-math}
\setmathfont{XITSMath-Regular}
[
  Extension = .otf,
  BoldFont = XITSMath-Bold
]

%%% ---- 数学定理样式 ----- %%%
\newtheoremstyle{whu}
{0pt}{0pt}  % 上下间距
{\songti}   % 正文字体
{2em}       % 缩进距离
{\heiti}    % 标题字体
{：}{0pt}   % 结束标记及间隔
{}
\theoremstyle{whu}
\newtheorem{theorem}{定理}[section]
\newtheorem{definition}{定义}[section]
\newtheorem{lemma}{引理}[section]
\newtheorem{corollary}{推论}[section]
\newtheorem{proposition}{性质}[section]
\newtheorem{example}{例}[section]
\newtheorem{remark}{注}[section]

\renewenvironment{proof}[1][证明]{%
  \pushQED{\qed}%
  {\heiti #1：}
}{%
  \popQED
}


%%% ---- 参考文献设置 ----- %%%
\RequirePackage[sort&compress]{natbib}
\setcitestyle{numbers,square,comma}
\bibliographystyle{data/gbt7714-2005-whu}  % 参考文献样式

\newcommand{\upcite}[1]{\textsuperscript{\cite{#1}}} % 自定义新命令\upcite, 使参考文献引用以上标出现

\renewcommand{\eqref}[1]{\textup{{\normalfont（\ref{#1}）\normalfont}}} % 公式引用使用中文括号

% 清除公式上下间距
\setlength{\abovedisplayskip}{6pt}
\setlength{\belowdisplayskip}{6pt}
\setlength{\abovedisplayshortskip}{0pt}
\setlength{\belowdisplayshortskip}{0pt}

% --------------------------------------

%%% ---- 自定义命令 ----- %%%

%%% ---- 封面 ----- %%%
\def\stunum#1{\def\whu@stunum{#1}}                                              % 学号
\def\whu@stunum{\@latex@error{未给出学号 \noexpand\stunum}\@ehc}
\def\title#1{\def\whu@title{#1}}                                                % 题目
\def\whu@title{\@latex@error{未给出题目 \noexpand\title}\@ehc}
\def\school#1{\def\whu@school{#1}}                                              % 院系
\def\whu@school{\@latex@error{未给出院系 \noexpand\school}\@ehc}
\def\major#1{\def\whu@major{#1}}                                                % 专业
\def\whu@major{\@latex@error{未给出专业 \noexpand\major}\@ehc}
\def\author#1{\def\whu@author{#1}}                                              % 作者
\def\whu@author{\@latex@error{未给出作者 \noexpand\author}\@ehc}
\def\advisor#1{\def\whu@advisor{#1}}                                            % 老师
\def\whu@advisor{\@latex@error{未给出指导教师 \noexpand\advisor}\@ehc}
\def\proftitle#1{\def\whu@proftitle{#1}}                                        % 职称
\def\whu@proftitle{\@latex@error{未给出指导教师职称 \noexpand\proftitle}\@ehc}
\def\date#1{\def\whu@date{#1}}                                                  % 日期
\def\whu@date{\zhdigits{\the\year}年\zhnumber{\the\month}月}

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
        \makebox[8em][s]{院\ \makebox[1em]{\llap{（}系\rlap{）}}\ 名\ 称：} & \whu@school                       \\[1ex]
        \makebox[8em][s]{专\ 业\ 名\ 称：}                                  & \whu@major                        \\[1ex]
        \makebox[8em][s]{学\ 生\ 姓\ 名：}                                  & \whu@author                       \\[1ex]
        \makebox[8em][s]{指\ 导\ 教\ 师：}                                  & \whu@advisor \quad \whu@proftitle \\[1ex]
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
    \hspace*{0.5cm}本人签名：\uline{\makebox[3.5cm]{}}
    \hspace{2cm}日期：\uline{\makebox[3.5cm]{}}
  }
}

%%% ---- 摘要 ----- %%%
% 实验性功能：使用 LaTeX3 的 clist 来分割关键词

\newbox\whu@kw
\newcommand{\whu@put@kw}[2]{%
  \setbox\whu@kw=\hbox{#1}
  \noindent\hangindent\wd\whu@kw\hangafter1
  \box\whu@kw#2\par
}

% 中文摘要
\ExplSyntaxOn
\newenvironment{cnabstract}[1]{
  \clist_set:Nx \l__whu_cnkeyword_clist { #1 }
  \cleardoublepage
  % \addcontentsline{toc}{chapter}{摘要}
  \begin{center}
    \heiti \zihao{-2} 摘\qquad 要
  \end{center}
  \baselineskip=23pt
  \par%
}{%
  \vspace*{2em}
  \par\whu@put@kw{\heiti\zihao{-4} 关键词：\mbox{}}%
  {\clist_use:Nn \l__whu_cnkeyword_clist { ； }}
  \clearpage
}

% 英文摘要
\newenvironment{enabstract}[1]{
  \clist_set:Nx \l__whu_enkeyword_clist { #1 }
  \clearpage
  \begin{center}
    \heiti \zihao{-2} \textbf{ABSTRACT}
  \end{center}
  \baselineskip=23pt
  \par%
}{%
  \vspace*{2em}
  \par\whu@put@kw{\bfseries\zihao{-4} Key words:~ }%
  {\clist_use:Nn \l__whu_enkeyword_clist { ;~ }}
  \cleardoublepage%
}
\ExplSyntaxOff

%%% ---- 目录 ----- %%%
% 生成目录
\newcommand{\contents}{%
  \pagenumbering{gobble} % 去掉目录页码
  \tableofcontents

  \cleardoublepage
  \pagestyle{plain}
  \pagenumbering{arabic} % 重新计数页码

  \renewcommand{\baselinestretch}{1}\normalsize
  \baselineskip=23pt % 正文行距为 23 磅
}
