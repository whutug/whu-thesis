%% This program is a LaTeX class file for bachelor thesis template
%% of Wuhan University
%%
%% Copyright \copyright\ 2019 Fing @ WHU
%% $ v0.1, 2019/03/18$
%%
%% This library is free software; you can redistribute it and/or
%% modify it under the terms of the GNU Lesser General Public
%% License as published by the Free Software Foundation; either
%% version 2.1 of the License, or (at your option) any later version.
%% 
%% This library is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%% Lesser General Public License for more details.
%% 
%% You should have received a copy of the GNU Lesser General Public
%% License along with this library; if not, write to the Free Software
%% Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
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

%%% ---- 定义字体 ----- %%%
\renewcommand{\normalsize}{\zihao{-4}} % 正常字号
\setmainfont{Times New Roman}
\setsansfont{Times New Roman}
\setmonofont{Times New Roman}

%%% ---- 定义标题和段落样式 ----- %%%
% 定义1.5倍行距
\RequirePackage{setspace}
\renewcommand{\baselinestretch}{1.5}
% 设置各个标题样式
\ctexset{chapter={format={\centering \heiti \zihao{-2}}, number={\zihao{-2} % 各章标题 黑体小2号
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
\renewcommand\cftchappagefont{\heiti\zihao{4}} % 目录页码字体
\renewcommand\cftsecpagefont{\songti\zihao{5}}
\renewcommand\cftsubsecpagefont{\songti\zihao{5}}
\renewcommand\cftsubsubsecpagefont{\songti\zihao{5}}

\renewcommand\cftchapafterpnum{\vskip5pt}
\renewcommand\cftsecafterpnum{\vskip3pt}
\renewcommand\cftsubsecafterpnum{\vskip2pt}
\setlength{\cftsecindent}{0em}
\setlength{\cftsubsecindent}{0em}
\setlength{\cftsubsubsecindent}{1.85em}

%%% ---- 图表标题设置 ----- %%%
\RequirePackage[labelsep=quad]{caption}     % 序号之后空一格写标题
\captionsetup[table]{textfont=bf}           % 设置表格标题字体为黑体
\renewcommand\figurename{\zihao{-4} 图}
\renewcommand\tablename{\bf\zihao{-4} 表} 

% 使用tabularx创建占满宽度的表格
\RequirePackage{tabularx, makecell}
\newcolumntype{L}{X}
\newcolumntype{C}{>{\centering \arraybackslash}X}
\newcolumntype{R}{>{\raggedleft \arraybackslash}X}

\RequirePackage{booktabs}

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


%%% ---- 引入宏包 ----- %%%
\RequirePackage{amsmath, amssymb, amsthm}
\RequirePackage{array}
\RequirePackage{graphicx, subcaption}
\RequirePackage{fontspec}
\RequirePackage{minted} % 代码高亮
\RequirePackage{algorithm2e, algorithmic} % 算法代码
\RequirePackage{tikz, pgfplots} % 绘图


%%% ---- 参考文献设置 ----- %%%
\RequirePackage{natbib}
\setcitestyle{numbers,square,comma}
\ctexset{bibname={参考文献}}

\bibliographystyle{data/gbt7714-2005}                   % 参考文献样式
\newcommand{\upcite}[1]{\textsuperscript{\cite{#1}}}    %自定义新命令\upcite, 使参考文献引用以上标出现

\RequirePackage{hyperref}%引用链接颜色设置
\hypersetup{citecolor=magenta,linkcolor=black,urlcolor=blue}

\graphicspath{{figures/}} % 图片文件路径

\newcommand*\circled[1]{\tikz[baseline=(char.base)]{%
\node[shape=circle,draw,inner sep=0.5pt] (char) {#1};}} %圆圈数字①
\renewcommand{\eqref}[1]{\textup{{\normalfont（\ref{#1}）\normalfont}}}

% 定义toks
\newtoks\stunum             % 学号
\newtoks\miji               % 密级
\newtoks\cmajor             % 学科专业中文
\newtoks\ctitle             % 题目
\newtoks\cauthor            % 作者名字
\newtoks\cadvisor           % 指导教师
\newtoks\cschool            % 学院
\newtoks\cdate              % 日期

\newtoks\CNabstract         % 中文摘要
\newtoks\CNkeywords         % 中文关键词
\newtoks\ENabstract         % 英文摘要
\newtoks\ENkeywords         % 英文关键词
