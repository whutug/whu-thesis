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
\RequirePackage{expl3, xparse, l3keys2e}
\ProvidesExplClass{whuthesis}{2020/12/10}{0.2}{Wuhan University Thesis Template}

\msg_new:nnn { whuthesis } { 引擎不支持 }
  {
    WhuThesis ~ 暂不支持 ~ #1 ~ 引擎。\\\\

    请使用 ~ XeLaTeX ~ 或 ~ LuaLaTeX ~ 进行编译！
  }
\sys_if_engine_xetex:F
  {
    \sys_if_engine_luatex:F
      {
        \msg_fatal:nnx { whuthesis } { 引擎不支持 }
          { \c_sys_engine_str }
      }
  }

%%% ---- 文档选项 ----- %%%
\keys_define:nn { whu / option }
  {
    degree .choice:,
    degree .value_required:n = true,
    degree .choices:nn       =
      { master , doctor , bachelor }
      { \tl_set_eq:NN \l__whu_degree_tl \l_keys_choice_tl },
    degree .initial:n        = bachelor,

    class .choice:,
    class .value_required:n  = true,
    class .choices:nn        =
      { paper , design , manual , opening }
      { \tl_set_eq:NN  \l__whu_class_tl   \l_keys_choice_tl },
    class .initial:n         = paper
  }
\ProcessKeysOptions{whu/option}

%%% ---- 载入 Class ----- %%%
% 开题报告使用 ctexart，论文使用 ctexbook
\tl_if_eq:NnTF \l__whu_class_tl { opening }
  {
    \LoadClass [ a4paper , zihao = -4 , fontset = none ] { ctexart }
    \DeclareOption * { \PassOptionsToClass { \CurrentOption } { ctexart } }
  }
  {
    \LoadClass [ a4paper , zihao = -4 , fontset = none ] { ctexbook }
    \DeclareOption * { \PassOptionsToClass { \CurrentOption } { ctexbook } }
  }
\ProcessOptions\relax

\tl_if_eq:NnT \l__whu_class_tl { paper }
  { \tl_set:Nn \c__whu_heading_tl { 武汉大学本科毕业论文 } }
\tl_if_eq:NnT \l__whu_class_tl { design }
  { \tl_set:Nn \c__whu_heading_tl { 武汉大学本科毕业设计 } }
\tl_if_eq:NnT \l__whu_class_tl { manual }
  {
    \tl_set:Nn \c__whu_heading_tl { 武汉大学~\LaTeX{}~模板使用手册 }
    \NewDocumentCommand { \meta } { m }
      { \ensuremath { \langle } \textit {#1} \ensuremath { \rangle } }
    \NewDocumentCommand { \pkg } { m } { \textsf {#1} }
    \NewDocumentCommand { \env } { m } { \texttt {#1} }
    \NewDocumentCommand { \app } { m } { \textsf {#1} }
    \NewDocumentCommand { \cls } { m } { \textsf {#1} }
    \NewDocumentCommand { \fmt } { m } { \textsf {#1} }
    \RequirePackage{ hologo }
    \NewDocumentCommand { \WhuThesis } {} { \textsc { Whu\-The\-sis } }
    \NewDocumentEnvironment {notice} {}
      { \color {red} { { \heiti 注意： } } }
      {}
  }
\tl_if_eq:NnT \l__whu_class_tl { opening }
  {
    \tl_set:Nn \c__whu_heading_tl
      { 武汉大学本科毕业论文（设计）\\ 开　题　报　告 }
    \tl_set:Nn \refname { 论文的主要参考文献 }
    \RequirePackage [ numbib ] { tocbibind }
  }

\sys_if_engine_luatex:TF
  {
    \RequirePackage { emoji }
    % \setemojifont{Segoe UI Emoji}
    \ProvideDocumentCommand { \emojitest } {}
      {
        如： \emoji { hot-pepper } \emoji { pear } \emoji { four }
        \emoji { syringe } \emoji { sweat-drops } \emoji { cow-face }
        \emoji { beer } 。
      }
    \tl_if_eq:NnTF \l__whu_class_tl { opening }
      {
        \PassOptionsToClass { punct=zh_CN/quanjiao } { ctexart }
      }
      {
        \PassOptionsToClass { punct=zh_CN/quanjiao } { ctexbook }
      }
    \RequirePackage { luatexja-adjust }
  }
  {
    \ProvideDocumentCommand { \emojitest } {}
      { \hologo{XeLaTeX} 等其他引擎则暂不支持。 }
  }

%%% ---- 引入宏包 ----- %%%
\RequirePackage { amsmath , amssymb , amsthm , mathtools }
\RequirePackage { listings }                     % 代码段
% \RequirePackage { minted }                    
%% 代码高亮（需要 python 安装 pygments 库）
\RequirePackage { algorithm2e }     % 算法代码
\tl_set:Nn \algorithmcfname { 算法 }
\SetAlCapSty {}
\SetAlCapFnt { \heiti }
\box_new:N \l__tmpa_box
\hbox_set:Nn \l__tmpa_box { \nobreakspace }
\SetAlgoCaptionSeparator
  { \hspace * { \dim_eval:n { 1em - \box_wd:N \l__tmpa_box } } } 
% 算法标题后会跟一个不间断空格 ~，这里将其宽度减掉

\RequirePackage { tikz, pgfplots }               % 绘图
\pgfplotsset { compat = 1.17 }
\RequirePackage { xcolor, array }
\RequirePackage { ulem }

\RequirePackage { physics }
\RequirePackage { siunitx }
\sisetup
  {
    detect-all,
    group-digits = false
  }

%%% ---- 定义页面样式 ----- %%%
\RequirePackage { geometry }
\geometry
  { left = 3 cm , right = 3 cm , top = 2.5 cm , bottom = 2 cm , includefoot }

\RequirePackage { fancyhdr }       % 页眉页脚宏包
\tl_set:Nn \headrulewidth { 0 pt }  % 页眉线宽
\tl_set:Nn \footrulewidth { 0 pt }  % 页脚线宽

% 默认页面页眉页脚样式
\fancypagestyle { plain }
  {
    \fancyhf {}
    \fancyfoot [ C ]
      { \zihao { 5 } \thepage }  % 页码位于页脚居中
  }
\pagestyle{plain}

%%% ---- 定义标题和段落样式 ----- %%%
\ctexset
  {
    section        =
      {
        format     = { \heiti \zihao { 4 } },
        beforeskip = { 0.5 \baselineskip   },
        afterskip  = { 0.5 \baselineskip   },
        fixskip    = true
      },  % 一级标题 黑体 4 号
    subsection     =
      {
        format     = { \heiti \zihao { -4 } },
        beforeskip = { 0.5 \baselineskip    },
        afterskip  = { 0.5 \baselineskip    },
        fixskip    = true
      },  % 二级标题 黑体小 4 号
    subsubsection  =
      {
        format     = { \heiti \zihao { -4 } },
        beforeskip = { 0.5 \baselineskip    },
        afterskip  = { 0.5 \baselineskip    },
        fixskip    = true
      },  % 三级标题 黑体小4号
    tocdepth       = 2,     % 目录层级数
    secnumdepth    = 3,  % 标题层级数
  }

\tl_if_eq:NnF \l__whu_class_tl { opening }
  {
    \ctexset
      {
        chapter        =
          {
            format     = { \centering \heiti \zihao { -2 } },
            number     = { \arabic{chapter}                },
            name       = { , },
            beforeskip = { 0.8 \baselineskip               },
            afterskip  = { 0.5 \baselineskip               },
            fixskip    = true
          }  % 各章标题 黑体小 2 号
      }
  }

%%% ---- 目录样式设置 ----- %%%
\RequirePackage { tocloft }
\tl_set:Nn \cfttoctitlefont      { \hfil \heiti \zihao { -2 } }
% 目录标题 黑体小 2 号
\tl_set:Nn \contentsname         { 目 \qquad 录               }
\tl_set:Nn \cftaftertoctitle     {                            }
\tl_set:Nn \cftdot               { $ \cdot $                  }
\tl_set:Nn \cftdotsep            { 1                          }
% 点间距
\tl_set:Nn \cftsecfont           { \songti \zihao { -4 }      }
\tl_set:Nn \cftsubsecfont        { \songti \zihao { -4 }      }
\tl_set:Nn \cftsubsubsecfont     { \songti \zihao { -4 }      }
\tl_set:Nn \cftsecpagefont       { \songti \zihao { 5 }       }
\tl_set:Nn \cftsubsecpagefont    { \songti \zihao { 5 }       }
\tl_set:Nn \cftsubsubsecpagefont { \songti \zihao { 5 }       }
\tl_set:Nn \cftsecafterpnum      { \skip_vertical:n { 3pt }   }
\tl_set:Nn \cftsubsecafterpnum   { \skip_vertical:n { 2pt }   }

\dim_set:Nn \cftbeforetoctitleskip { 0 pt    }
\dim_set:Nn \cftaftertoctitleskip  { 0 pt    }
\dim_set:Nn \cftsecindent          { 1.85 em }
\dim_set:Nn \cftsubsecindent       { 1.85 em }
\dim_set:Nn \cftsubsubsecindent    { 1.85 em }

\tl_if_eq:NnF \l__whu_class_tl { opening }
  {
    \tl_set:Nn \cftchapdotsep    { \cftdotsep                }
    \tl_set:Nn \cftchapfont      { \heiti \zihao { 4 }       }
    % 目录章标题 黑体 4 号
    \tl_set:Nn \cftchappagefont  { \heiti \zihao { 5 }       }
    % 目录页码字体
    \tl_set:Nn \cftchapafterpnum { \skip_vertical:n { 5 pt } }
  }

%%% ---- 图表标题 ----- %%%
% 图表标题设置
\RequirePackage [ labelsep=quad ] { caption } % 序号之后空一格写标题
% 设置表格标题字体为黑体, 设置图标题字体为宋体
\DeclareCaptionFont { heiti } { \heiti }
\captionsetup [ table ] { textfont = heiti }
\tl_set:Nn \figurename { \songti \zihao { -4 } 图 }
\tl_set:Nn \tablename  { \heiti  \zihao { -4 } 表 }

\RequirePackage { graphicx, subcaption }
\graphicspath { { figures / } } % 图片文件路径

% 使用 tabularx 创建占满宽度的表格
\RequirePackage{ array , tabularx }
\newcolumntype{ L } { X }
\newcolumntype{ C } { > { \centering \arraybackslash  } X }
\newcolumntype{ R } { > { \raggedleft \arraybackslash } X }

\ProvideDocumentCommand { \tabularxcolumn } { m }
  { m { #1 } }  % 使表格内容垂向居中

\RequirePackage { longtable , xltabular }    % 做长表格的包
\RequirePackage { booktabs }                 % 做三线表的包
\RequirePackage { makecell }
\RequirePackage { multirow }                 % 跨行表格
\RequirePackage { diagbox  }                  % 斜线表头
% 列表样式
\RequirePackage { enumitem }
\setlist { nosep }

% 修改脚注
\RequirePackage [ perpage ] { footmisc }
% 每面更新序号

\tl_set:Nn \@makefnmark
  {
    \hbox:n { { \textsuperscript { \circled { \@thefnmark } } } }
  }

\RenewDocumentCommand { \@makefntext } { m }
  {
    \noindent \hbox_to_wd:nn { 1 em } { \circled { \@thefnmark } } #1
  }

\setlength { \skip\footins } { 10 mm plus 1 mm }
\dim_set:Nn \footnotesep { 6 pt }
\tl_set:Nn \footnotesize { \songti \zihao { 5 } }
\tl_set:Nn \footnoterule
  { \noindent \rule [ 1 pt ] { 0.3 \columnwidth } {1 pt} }

\NewDocumentCommand { \circled } { m }
  {
    \hbox_to_wd:nn { 1 em }
      {
        \tikz [ baseline = ( char.base ) ]
          {
            \node [ shape = circle , draw , inner ~ sep = 0 pt , minimum ~ size = 1 em ]
              ( char ) { #1 };
          } % 圆圈数字①
      }
  }

%%% ---- 定义字体 ----- %%%

% 设置英文字体为 Times New Roman
\setmainfont { Times ~ New ~ Roman }
  [ Ligatures = Rare ]

\tl_set:Nn \c__whu_setsimfont
  {
    \setCJKmainfont { simsun.ttc } 
      [ AutoFakeBold = 4 , AutoFakeSlant = 0.167 ]
    \setCJKsansfont { simhei.ttf }
      [ AutoFakeBold = 4 , AutoFakeSlant = 0.167 ]
    \setCJKmonofont { simsun.ttc }
      [ AutoFakeBold = 4 , AutoFakeSlant = 0.167 ]
    \newCJKfontfamily { \songti } {simsun.ttc}
      [ AutoFakeBold = 4 , AutoFakeSlant = 0.167 ]
    \newCJKfontfamily { \heiti } {simhei.ttf}
      [ AutoFakeBold = 4 , AutoFakeSlant = 0.167 ]
  }

\tl_set:Nn \c__whu_setfandolfont
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
    \tl_use:N \c__whu_setsimfont
  }
  {
    \file_if_exist:nTF { /System/Library/Fonts/Menlo.ttc }
    % \ctex_if_platform_macos:TF
      {
        \tl_use:N \c__whu_setsimfont
      }
      {
        \file_if_exist:nTF { simsun.ttc }
          {
            \file_if_exist:nTF { simhei.ttf } 
              {
                \tl_use:N \c__whu_setsimfont
              }
              {
                \tl_use:N \c__whu_setfandolfont
              }
          }
          {
            \tl_use:N \c__whu_setfandolfont
          }
      }
  }


\RequirePackage { unicode-math }
\setmathfont { XITSMath-Regular }
  [
    Extension = .otf,
    BoldFont = XITSMath-Bold
  ]

%%% ---- 数学定理样式 ----- %%%
\newtheoremstyle { whu }
  { 0 pt } { 0 pt } % 上下间距
  { \songti }       % 正文字体
  { 2 em }          % 缩进距离
  { \heiti }        % 标题字体
  { ： }{ 0 pt }    % 结束标记及间隔
  {}
\theoremstyle { whu }
\newtheorem { theorem }     { 定理 } [ section ]
\newtheorem { definition }  { 定义 } [ section ]
\newtheorem { lemma }       { 引理 } [ section ]
\newtheorem { corollary}    { 推论 } [ section ]
\newtheorem { proposition } { 性质 } [ section ]
\newtheorem { example }     { 例 }   [ section ]
\newtheorem { remark }      { 注 }   [ section ]

\RenewDocumentEnvironment { proof } { O {证明} }
  { \pushQED { \qed } { \heiti #1： } }
  { \popQED }

%%% ---- 参考文献设置 ----- %%%
\RequirePackage [ sort & compress ] { natbib }
\setcitestyle { numbers , square , comma }
\bibliographystyle { data / gbt7714-2005-whu }  % 参考文献样式
\dim_set:Nn \bibsep {0pt} % 参考文献间距设为 0

\NewDocumentCommand { \upcite } { m }
  { \textsuperscript { \cite {#1} } }
% 自定义新命令 \upcite, 使参考文献引用以上标出现

\RenewDocumentCommand { \eqref } { m }
  { \textup { { \normalfont （ \ref {#1} ） \normalfont } } }
% 公式引用使用中文括号

% 清除公式上下间距
\dim_set:Nn \abovedisplayskip      { 6 pt }
\dim_set:Nn \belowdisplayskip      { 6 pt }
\dim_set:Nn \abovedisplayshortskip { 0 pt }
\dim_set:Nn \belowdisplayshortskip { 0 pt }

% 最后引入 hyperref 包
\RequirePackage { hyperref }
\hypersetup { hidelinks }
\urlstyle { rm }

\tl_if_eq:NnT \l__whu_class_tl { manual }
  {
    \hypersetup { colorlinks = true }
  }
% --------------------------------------

%%% ---- 文档接口 ----- %%%
\NewDocumentCommand { \whusetup } { m }
  { \keys_set:nn { whu } {#1} }

\keys_define:nn { whu / info }
  {
    title          .tl_set:N    = \l__whu_info_title_tl,
    author         .tl_set:N    = \l__whu_info_author_tl,
    student-number .tl_set:N    = \l__whu_info_student_number_tl,
    school         .tl_set:N    = \l__whu_info_school_tl,
    major          .tl_set:N    = \l__whu_info_major_tl,
    date           .tl_set:N    = \l__whu_info_date_tl,
    advisor        .clist_set:N = \l__whu_info_advisor_clist,
    cnkeywords     .clist_set:N = \l__whu_info_cnkeywords_clist,
    enkeywords     .clist_set:N = \l__whu_info_enkeywords_clist,

    date .initial:n =
      { \zhdigits { \the\year } 年 \zhnumber { \the \month } 月 }
  }

\keys_define:nn { whu }
  {
    info  .meta:nn = { whu / info } {#1}
  }

%%% ---- 论文标题页 ----- %%%
\tl_if_eq:NnTF \l__whu_class_tl { opening }
  {
    \AtBeginDocument
      {
        \begin { center }
          \zihao { -2 } \heiti \c__whu_heading_tl
        \end { center }

        \tl_set:Nn \baselinestretch { 1 }
        \normalsize
        \dim_set:Nn \baselineskip { 23 pt }
        % 正文行距为 23 磅

        \noindent
        毕业论文（设计）题目： \uline { \hfill \l__whu_info_title_tl \hfill } \\
        学院： \uline { \hfill \l__whu_info_school_tl \hfill } \hfill \hfill
        学号： \uline { \hfill \l__whu_info_student_number_tl \hfill } \hfill \hfill
        姓名： \uline { \hfill \l__whu_info_author_tl \hfill }
      }

    \AtEndDocument
      {
        \skip_vertical:n { 2\baselineskip }
          指导老师意见：
          \vfill
          \hfill 指导老师（签名）： \hbox_to_wd:nn { 4 cm } {} \par
          \skip_vertical:N \baselineskip
          \hfill 年 \qquad 月 \qquad 日
      }
  }
  {
    \ProvideDocumentCommand \maketitlepage {}
      {
        \pagestyle { empty }
        \begin { center }
          {
            \heiti \zihao{5} \hfill
            \begin { minipage } [ t ] { 5 cm }
              学号 \uline{ \makebox [ 3 cm ] [ c ]
                { \l__whu_info_student_number_tl } } \\ [ 2 mm ]
              密级 \uline{ \makebox [ 3 cm ] [ c ] {} }
            \end { minipage }
          }
          \par \skip_vertical:n { 6 em }
          { \songti \zihao{1} \c__whu_heading_tl }
          \par \skip_vertical:n { 6 em }
          \begin { minipage } [c] [ 6 cm ] { 14 cm }
            \dim_set:Nn \baselineskip {32 pt}
            \centering { \heiti \zihao { 2 } \l__whu_info_title_tl }
          \end { minipage }
          \par \skip_vertical:n { 6 em }
          {
            \centering \songti \zihao { -3 }
            \begin {tabular} { cl }
              \makebox [ 8 em ] [ s ] {院 \  \makebox [ 1 em ] { \llap { （ } 系 \rlap { ） } } \  名 \  称： } &
                \l__whu_info_school_tl \\ [ 0.5 em ]
              \makebox [ 8 em ] [ s ] {专 \  业 \  名 \  称：} & \l__whu_info_major_tl                              \\ [ 0.5 em ]
              \makebox [ 8 em ] [ s ] {学 \  生 \  姓 \  名：} & \l__whu_info_author_tl                             \\ [ 0.5 em ]
              \makebox [ 8 em ] [ s ] {指 \  导 \  教 \  师：} & \clist_use:Nn \l__whu_info_advisor_clist { \quad } \\ [ 0.5 em ]
            \end { tabular }
          }
          \par \skip_vertical:n { 6 em }
          { \songti \zihao { -2 } \l__whu_info_date_tl }
        \end { center }
        \clearpage
      }
  }


%%% ---- 论文申明页 ----- %%%
\NewDocumentCommand { \makestatement } {}
  {
    \chapter * {}
    \skip_vertical:n { 44 pt }
    \pagenumbering { gobble }
    \begin { center }
      \ziju { 0.5 } \zihao { 2 } \textbf { 郑重声明 }
    \end { center }
    \par \skip_vertical:n { 20 pt }
    \dim_set:Nn \baselineskip { 23 pt }
    {
      \zihao { 4 }
      本人呈交的学位论文，是在导师的指导下，独立进行研究工作所取得的成果，所有数据、图片资料真实可靠。尽我所知，除文中已经注明引用的内容外，本学位论文的研究成果不包含他人享有著作权的内容。对本论文所涉及的研究工作做出贡献的其他个人和集体，均已在文中以明确的方式标明。本学位论文的知识产权归属于培养单位。
      \par \skip_vertical:n { 88 pt }
      本人签名： \uline { \makebox [ 4 cm ] {} }
      \hfill 日期： \uline { \makebox [ 4 cm ] {} }
    }
  }

%%% ---- 摘要 ----- %%%
\box_new:N \l__whu_kw_box
\cs_set:Npn \__whu_put_kw:nn #1#2
  {
    \hbox_set:Nn \l__whu_kw_box {#1}
    \noindent \hangindent \box_wd:N \l__whu_kw_box \hangafter 1
    \box_use_drop:N \l__whu_kw_box #2 \par
  }

% 中文摘要
\NewDocumentEnvironment { cnabstract } {}
  {
    \chapter * {摘 \qquad 要}
    \dim_set:Nn \baselineskip { 23pt }
    \par
  }
  {
    \skip_vertical:N \baselineskip \par
    \__whu_put_kw:nn
      { \heiti\zihao{-4} 关键词：\mbox{} }
      { \clist_use:Nn \l__whu_info_cnkeywords_clist { ； } }
    \clearpage
  }

% 英文摘要
\NewDocumentEnvironment { enabstract } {}
  {
    \clearpage
    \begin{center}
      \heiti \zihao{-2} \textbf{ABSTRACT}
    \end{center}
    \dim_set:Nn \baselineskip { 23pt } \par
  }
  {
    \skip_vertical:N \baselineskip \par
    \__whu_put_kw:nn
      { \bfseries\zihao{-4} Key words:~ }
      { \clist_use:Nn \l__whu_info_enkeywords_clist { ;~ } }
    \cleardoublepage%
  }

%%% ---- 目录 ----- %%%
% 生成目录
\NewDocumentCommand {\contents} {}
{
  \pagenumbering { gobble } % 去掉目录页码
  \tableofcontents

  \cleardoublepage
  \pagestyle { plain }
  \pagenumbering { arabic } % 重新计数页码

  \tl_set:Nn \baselinestretch { 1 } 
  \normalsize
  \dim_set:Nn \baselineskip { 23pt } % 正文行距为 23 磅
}
