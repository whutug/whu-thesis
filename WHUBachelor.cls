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
\LoadClass[a4paper,openany,oneside,fntef]{book} % A4大小，book布局

\RequirePackage[AutoFakeBold=true,AutoFakeSlant=true]{xeCJK}[2017/08/08]
\RequirePackage[zihao=-4,UTF8,heading=true]{ctex}[2016/12/27]

%%% ---- 定义页边距 ----- %%%
\RequirePackage{geometry}
\geometry{left=3cm,right=3cm,top=2.5cm,bottom=2.0cm}

\RequirePackage{fancyhdr}
\newcommand{\footstyle}{\fancyfoot[C]{\songti \zihao{5} \thepage}}  % 设置页脚样式
\pagestyle{fancy}
\fancyhf{} % 清空原有样式
\footstyle
\renewcommand{\headrulewidth}{0pt}

%%% ---- 定义字体 ----- %%%
\renewcommand{\normalsize}{\zihao{-4}} % 正常字号
\setmainfont{Times New Roman}
\setsansfont{Times New Roman}


%%% ---- 定义标题和段落样式 ----- %%%
% 定义1.5倍行距
\renewcommand{\baselinestretch}{1.5}
% 设置各个标题样式
\ctexset{chapter={format={\centering \heiti \zihao{-2}}, number={\zihao{-2} % 各章标题 黑体小2号
    \arabic{chapter}},name={,},afterskip={30pt},beforeskip={20pt}}}
\ctexset{section={format={\raggedright \heiti \zihao{4}}}}          % 一级标题 黑体 4号
\ctexset{subsection={format={\raggedright \heiti \zihao{-4}}}}      % 二级标题 黑体小4号
\ctexset{subsubsection={format={\raggedright \heiti \zihao{-4}}}}   % 三级标题 黑体小4号

\setcounter{tocdepth}{4}        % 目录层级数
\setcounter{secnumdepth}{4}     % 标题层级数

%%% ---- 图表标题设置 ----- %%%
\RequirePackage[labelsep=quad]{caption}     % 序号之后空一格写标题
\captionsetup[table]{textfont=bf}           % 设置表格标题字体为黑体
\renewcommand\figurename{\zihao{-4} 图}
\renewcommand\tablename{\bf\zihao{-4} 表} 

%%% ---- 引入宏包 ----- %%%
\RequirePackage{amsmath, amssymb}
\RequirePackage{array}
\RequirePackage{graphicx}

%%% ---- 参考文献设置 ----- %%%
\RequirePackage{natbib}
\setcitestyle{numbers,square,comma}
\ctexset{bibname={参考文献}}

\bibliographystyle{data/gbt7714-2005}                   % 参考文献样式
\newcommand{\upcite}[1]{\textsuperscript{\cite{#1}}}    %自定义新命令\upcite, 使参考文献引用以上标出现

\graphicspath{{figures/}} % 图片文件路径

\newcommand*\circled[1]{\tikz[baseline=(char.base)]{%
\node[shape=circle,draw,inner sep=0.5pt] (char) {#1};}} %圆圈数字①

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
