%% This program is a LaTeX class file for bachelor thesis template
%% of Wuhan University
%%
%% Copyright (c) 2019 -- 2021 WHUTUG <https://github.com/whutug>
%%
%% This project uses the MIT License, see LICENSE for more details.
%% ----------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3 , xparse , l3keys2e}
\ProvidesExplClass{whu-thesis}{2021/05/20}{0.6d}
  {Wuhan University Thesis Template}

\msg_new:nnn { whu-thesis } { 引擎不支持 }
  {
    whu-thesis ~ 不支持 ~ #1 ~ 引擎。\\\\

    请使用 ~ XeLaTeX ~ 或 ~ LuaLaTeX ~ 进行编译！
  }

\sys_if_engine_xetex:F
  {
    \sys_if_engine_luatex:F
      {
        \msg_fatal:nnx { whu-thesis } { 引擎不支持 }
          { \c_sys_engine_str }
      }
  }

% 函数变体声明
\cs_generate_variant:Nn \tl_map_inline:nn { x n }
\cs_generate_variant:Nn \file_input:n { V }

%%% ---- 文档选项 ----- %%%
\tl_new:N \g__whu_option_type_tl
\tl_new:N \g__whu_option_class_tl
\tl_new:N \g__whu_option_punct_tl

\bool_new:N \g__whu_option_draft_bool
\bool_new:N \g__whu_option_twoside_bool

\clist_new:N \g__whu_option_to_class_clist
\clist_gset:Nn \g__whu_option_to_class_clist
  { a4paper , zihao = -4 , fontset = none , sub4section }

\keys_define:nn { whu / option }
  {
    type .value_required:n = true,
    type .choices:nn       =
      { doctor , master , bachelor , opening }
      { \tl_gset_eq:NN \g__whu_option_type_tl \l_keys_choice_tl },
    type .initial:n        = doctor,
    % 学位，默认本科生

    class .value_required:n = true,
    class .choices:nn       =
      { academic , professional , paper , design }
      { \tl_gset_eq:NN \g__whu_option_class_tl \l_keys_choice_tl },
    % 文档类型

    draft         .choice:,
    draft / true  .code:n    =
      {
        \bool_gset_true:N    \g__whu_draft_bool
        \clist_gput_right:Nn \g__whu_option_to_class_clist { draft }
      },
    draft / false .code:n    =
      {
        \bool_gset_false:N   \g__whu_draft_bool
      },
    draft         .default:n = true,
    draft         .initial:n = false,
    % 草稿模式，默认关闭

    oneside .value_forbidden:n = true,
    twoside .value_forbidden:n = true,
    oneside .code:n            =
      {
        \bool_gset_false:N   \g__whu_option_twoside_bool
        \clist_gput_right:Nn \g__whu_option_to_class_clist { oneside }
      },
    twoside .code:n            =
      {
        \bool_gset_true:N    \g__whu_option_twoside_bool
        \clist_gput_right:Nn \g__whu_option_to_class_clist { twoside }
      },
    % 单双页模式

    punct .value_required:n = true,
    punct .choices:nn       =
      { quanjiao , banjiao , kaiming }
      { \tl_gset_eq:NN \g__whu_option_punct_tl \l_keys_choice_tl },
    punct .initial:n        = quanjiao,
    % 标点格式
  }
\ProcessKeysOptions { whu / option }

\tl_if_eq:NnT \g__whu_option_type_tl { master }
  {
    \keys_define:nn { whu / option }
      {
        class .initial:n = academic
      }
  }
\tl_if_eq:NnT \g__whu_option_type_tl { bachelor }
  {
    \keys_define:nn { whu / option }
      {
        class .initial:n = paper
      }
  }

\sys_if_engine_luatex:TF
  {
    \clist_gput_right:Nn \g__whu_option_to_class_clist
      { punct = zh_CN / \g__whu_option_punct_tl }
  }
  {
    \clist_gput_right:Nn \g__whu_option_to_class_clist
      { punct = \g__whu_option_punct_tl }
  }
% 判断是否有 chinese-jfm，若有则使用 chinese-jfm

\sys_if_engine_xetex:T { \RequirePackage { etoolbox } }
% 在载入文档类之前引入 etoolbox

%%% ---- 载入 Class ----- %%%
\PassOptionsToPackage { no-math } { fontspec }

% 开题报告使用 ctexart，论文使用 ctexbook，书脊使用 ltjtarticle
\tl_if_eq:NnTF \g__whu_option_type_tl { opening }
  {
    \PassOptionsToClass { \g__whu_option_to_class_clist } { ctexart }
    \LoadClass { ctexart }
  }
  {
    \PassOptionsToClass { \g__whu_option_to_class_clist } { ctexbook }
    \LoadClass { ctexbook }
    \bool_gset_true:N \g__whu_option_twoside_bool
  }
\ProcessKeysOptions { whu / option }

\sys_if_engine_luatex:T { \RequirePackage { luatexja-adjust } }

\tl_if_eq:NnT \g__whu_option_type_tl { doctor }
  {
    \tl_const:Nn \c__whu_heading_tl
      { \__whu_spread_with:nn { 博士学位论文 } { \quad } }
    \tl_set:Nn \bibname { \zihao { 4 } \textbf { 参考文献 } }
    \tl_set:Nn \bibliographytypesize { \zihao { 5 } }
  }

\tl_if_eq:NnT \g__whu_option_type_tl { master }
  {
    \tl_if_eq:NnT \g__whu_option_class_tl { academic }
      {
        \tl_const:Nn \c__whu_heading_tl
          { \__whu_spread_with:nn { 硕士学位论文 } { \quad } }
      }
    \tl_if_eq:NnT \g__whu_option_class_tl { professional }
      {
        \tl_const:Nn \c__whu_heading_tl
          { \__whu_spread_with:nn { 硕士专业学位论文 } { \enskip } }
      }
    \tl_set:Nn \bibname { \zihao { 4 } \textbf { 参考文献 } }
    \tl_set:Nn \bibliographytypesize { \zihao { 5 } }
  }

\tl_if_eq:NnT \g__whu_option_type_tl { bachelor }
  {
    \tl_if_eq:NnT \g__whu_option_class_tl { paper }
      { \tl_const:Nn \c__whu_heading_tl { 武汉大学本科毕业论文 } }
    \tl_if_eq:NnT \g__whu_option_class_tl { design }
      { \tl_const:Nn \c__whu_heading_tl { 武汉大学本科毕业设计 } }
  }

\tl_if_eq:NnT \g__whu_option_type_tl { opening }
  {
    \tl_const:Nn \c__whu_heading_tl
      { 武汉大学本科毕业论文（设计） \\ 开　题　报　告 }
    \tl_set:Nn \bibname { 参考文献 }
    \RequirePackage { needspace }
  }

%%% ---- 引入宏包 ----- %%%
\RequirePackage { amsmath , amssymb , amsthm , mathtools }

\RequirePackage { tikz, pgfplots } % 绘图
\pgfplotsset { compat = 1.17 }
\RequirePackage [ normalem ] { ulem }

\RequirePackage { physics }
\RequirePackage { siunitx }

\RequirePackage { algorithm2e }     % 算法代码
\tl_set:Nn \algorithmcfname { 算法 }
\SetAlCapSty {}
\SetAlCapFnt {}
\box_new:N \l__whu_space_box
\hbox_set:Nn \l__whu_space_box { \nobreakspace }
\SetAlgoCaptionSeparator
  { \hbox_to_wd:nn { 1 em - \box_wd:N \l__whu_space_box } {} }
% 算法标题后会跟一个不间断空格 ~，这里将其宽度减掉

%%% ---- 定义页面样式 ----- %%%
\RequirePackage { geometry }
\clist_if_in:nVTF { bachelor , opening } \g__whu_option_type_tl
  { \geometry { hmargin = 3 cm , top = 2.5 cm , bottom = 2 cm , ignoreall } }
  { \geometry { margin = 2.5 cm , ignoreall } }
% 本科、开题报告左右边距 3 cm，上边距 2.5 cm，下边距 2 cm
% 硕博边距 2.5 cm。

\bool_if:NT \g__whu_draft_bool
  {
    \sys_if_engine_luatex:T
      { \RequirePackage { lua-visual-debug } }
    \sys_if_engine_xetex:T
      { \geometry { showframe } }
  }
% 草稿模式下，显示边框

\RequirePackage { fancyhdr }        % 页眉页脚宏包
\tl_set:Nn \headrulewidth { \c_zero_dim }  % 页眉线宽
\tl_set:Nn \footrulewidth { \c_zero_dim }  % 页脚线宽

\AtEndPreamble
  {
    \tl_new:N \g__whu_head_odd_tl
    \tl_new:N \g__whu_head_even_tl
    \tl_if_eq:NnT \g__whu_option_type_tl { doctor }
      {
        \tl_gset_eq:NN \g__whu_head_odd_tl \g__whu_info_title_tl
        \tl_gremove_all:Nn \g__whu_head_odd_tl { \\ }
        \tl_gset:Nn \g__whu_head_even_tl { 武汉大学博士学位论文 }
      }
    \tl_if_eq:NnT \g__whu_option_type_tl { master }
      {
        \tl_gset_eq:NN \g__whu_head_odd_tl \g__whu_info_title_tl
        \tl_gremove_all:Nn \g__whu_head_odd_tl { \\ }
        \tl_gset:Nn \g__whu_head_even_tl { 武汉大学硕士学位论文 }
      }

    % 默认页面页眉页脚样式
    \clist_if_in:nVTF { doctor , master } \g__whu_option_type_tl
      {
        \fancypagestyle { plain }
          {
            \fancyhf {}
            \fancyfoot [ C ]   { \zihao { 5 } \thepage }
            \fancyhead [ O C ] { \zihao { 5 } \g__whu_head_odd_tl }
            \fancyhead [ E C ] { \zihao { 5 } \g__whu_head_even_tl }
          }
      }
      {
        \fancypagestyle { plain }
          {
            \fancyhf {}
            \fancyfoot [ C ] { \zihao { 5 } \thepage }
          }
      }
  }

%%% ---- 定义标题和段落样式 ----- %%%
\ctexset
  {
    section        =
      {
        format     = { \heiti \zihao { 4 }       },
        beforeskip = { 0.5 \c__whu_baseline_skip },
        afterskip  = { 0.5 \c__whu_baseline_skip },
      },  % 一级标题 黑体 4 号
    subsection     =
      {
        format     = { \heiti \zihao { -4 }      },
        beforeskip = { 0.5 \c__whu_baseline_skip },
        afterskip  = { 0.5 \c__whu_baseline_skip },
      },  % 二级标题 黑体小 4 号
    subsubsection  =
      {
        format     = { \heiti \zihao { -4 }      },
        beforeskip = { 0.5 \c__whu_baseline_skip },
        afterskip  = { 0.5 \c__whu_baseline_skip },
      },  % 三级标题 黑体小4号
    paragraph      =
      {
        format     = { \heiti \zihao { -4 }       },
        number     = { （ \arabic { paragraph } ）},
        aftername  = { \hbox:n {}                 },
        beforeskip = { 0.5 \c__whu_baseline_skip  },
        afterskip  = { 0.5 \c__whu_baseline_skip  },
      },
    subparagraph   =
      {
        format     = { \heiti \zihao { -4 }                  },
        number     = { \circled { \arabic { subparagraph } } },
        aftername  = { \quad                                 },
        beforeskip = { 0.5 \c__whu_baseline_skip             },
        afterskip  = { 0.5 \c__whu_baseline_skip             },
      },
    tocdepth       = 2,  % 目录层级数
    secnumdepth    = 5,  % 标题层级数
  }
\tl_if_eq:NnF \g__whu_option_type_tl { opening }
  {
    \ctexset
      {
        chapter        =
          {
            format     = { \centering \heiti \zihao { -2 } },
            number     = { \arabic { chapter }             },
            name       = { ,                               },
            beforeskip = { 0.8 \c__whu_baseline_skip       },
            afterskip  = { 0.5 \c__whu_baseline_skip       },
          }  % 各章标题 黑体小 2 号
      }
  }

%%% ---- 目录样式设置 ----- %%%
\RequirePackage { tocloft }
\clist_map_inline:nn { toc , lof , lot }
  {
    \tl_set:cn { cft #1 title font } { \hfil \heiti \zihao { -2 } }
    % 目录标题 黑体小 2 号
    \clist_map_inline:nn { before , after }
      { \skip_zero:c { cft ##1 #1 title skip } }
  }
\skip_set:Nn \cftaftertoctitleskip { 0.5 \baselineskip }

\clist_map_inline:nn { doctor , bachelor }
  {
    \tl_if_eq:NnT \g__whu_option_type_tl {#1}
      { \tocloftpagestyle { empty } }
  }

\tl_set:Nn \contentsname   { 目 \qquad 录 }
\tl_set:Nn \listfigurename { 图片索引     }
\tl_set:Nn \listtablename  { 表格索引     }

\tl_set:Nn \cftdot { \raisebox { 0.3 em } { \normalfont . } }
\tl_set:Nn \cftdotsep { \c_one_int }
% 点间距

\clist_map_inline:nn { sec , subsec , subsubsec }
  {
    \tl_set:cn { cft #1 font } { \zihao { -4 } }

    \tl_if_eq:NnF \g__whu_option_type_tl { doctor }
      { \tl_set:cn  { cft #1 page font } { \zihao { 5 } } }

    \dim_set:cn { cft #1 indent } { \parindent }
  }

\dim_zero:N \cftfigindent
\dim_zero:N \cfttabindent

\tl_if_eq:NnF \g__whu_option_type_tl { opening }
  {
    \tl_set:Nn \cftchapdotsep { \c_one_int }
    \tl_if_eq:NnTF \g__whu_option_type_tl { doctor }
      {
        \tl_set:Nn \cftchapfont { \bfseries \zihao { -4 } }
        \tl_set:Nn \cftchappagefont { \zihao { -4 } }
        \skip_zero:N \cftbeforechapskip
      }
      {
        \tl_set:Nn \cftchapfont { \heiti \zihao { 4 } }
        \tl_set:Nn \cftchappagefont { \zihao { 5 } }
      }
  }

%%% ---- 图表标题 ----- %%%
\RequirePackage { subcaption }
% 图表标题设置
\RequirePackage [ labelsep = quad ] { caption } % 序号之后空一格写标题
% 设置表格标题字体为黑体, 设置图标题字体为宋体
\DeclareCaptionFont { whutablecap  }
  { \heiti \addCJKfontfeatures { BoldFont = * } \bfseries \zihao { -4 } }
\DeclareCaptionFont { whufigurecap }
  { \songti \zihao { -4 } }
\captionsetup [ table ]
  {
    name = 表,
    font = whutablecap
  }
\captionsetup [ figure ]
  {
    name = 图,
    font = whufigurecap
  }

\RequirePackage { graphicx }
\AtEndPreamble
  { \exp_args:NV \graphicspath \g__whu_style_graphics_path_tl }
% 图片文件路径

% 使用 tabularx 创建占满宽度的表格
\RequirePackage { tabularx }
\newcolumntype { L } { > { \raggedright \arraybackslash } X }
\newcolumntype { C } { > { \centering   \arraybackslash } X }
\newcolumntype { R } { > { \raggedleft  \arraybackslash } X }

\ProvideDocumentCommand { \tabularxcolumn } { m }
  { m { #1 } }  % 使表格内容垂向居中

\RequirePackage
  {
    longtable,
    xltabular, % 长表格
    booktabs,  % 三线表
    makecell,
    multirow,  % 跨行表格
    diagbox    % 斜线表头
  }

\cs_new_protected:Npn \__whu_set_table_font:
  {
    \clist_map_inline:nn { tabular , tabularx , longtable , xltabular }
      { \AtBeginEnvironment {##1} { \zihao { 5 } } }
  }
% 将表格内容字体设为五号

% 列表样式
\RequirePackage [ inline ] { enumitem }
\setlist { nosep }

% 修改脚注
\RequirePackage [ perpage ] { footmisc }
% 每面更新序号

\tl_set:Nn \@makefnmark
  {
    \kern \c_zero_dim \textsuperscript { \circled { \@thefnmark } }
  }

\RenewDocumentCommand { \@makefntext } { m }
  {
    \noindent \hangindent 1 em \circled { \@thefnmark } #1 \hangafter 1
  }

\skip_set_eq:NN \headheight \baselineskip
\skip_set_eq:NN \footskip   \baselineskip

\dim_set:Nn \footnotesep { 6 pt }
\setlength { \skip \footins } { \skip_eval:n { 2 \baselineskip } plus 1 fill }
\tl_set:Nn \footnotesize { \songti \zihao { 5 } }
\tl_set:Nn \footnoterule
  { \noindent \rule [ 1 pt ] { 0.3 \columnwidth } { 1 pt } }

\NewDocumentCommand { \circled } { m }
  {
    \resizebox { 1 em } { ! }
      {
        \tikz [ baseline = ( char.base ) ]
          {
            \node [ shape = circle , draw , inner ~ sep = \c_zero_dim ,
              minimum ~ size = 1 em ] ( char ) {#1};
          } % 圆圈数字①
      }
  }

%%% ---- 定义字体 ----- %%%
\RequirePackage { unicode-math }

\cs_new_protected:Npn \__whu_fontset:n #1
  { \cs_gset_eq:Nc \__whu_set_font: { __whu_set_font_ #1 : } }
\cs_new_protected:Npn \__whu_cjk_fontset:n #1
  { \cs_gset_eq:Nc \__whu_set_cjk_font: { __whu_set_cjk_font_ #1 : } }
\cs_new_protected:Npn \__whu_math_fontset:n #1
  { \cs_gset_eq:Nc \__whu_set_math_font: { __whu_set_math_font_ #1 : } }

\keys_define:nn { whu / style }
  {
    font .choices:nn =
      { times , xits , termes , none }
      { \__whu_fontset:n { \l_keys_choice_tl } },
    % 西文字体

    math-font .choices:nn =
      { xits , termes , none }
      { \__whu_math_fontset:n { \l_keys_choice_tl } },
    % 数学字体

    cjk-font .choices:nn =
      { windows , mac , fandol , overleaf , none }
      { \__whu_cjk_fontset:n { \l_keys_choice_tl } },
    % 中文字体
  }

% 西文字体
\cs_new_protected:Npn \__whu_set_font_times:
  { \setmainfont { Times ~ New ~ Roman } [ Ligatures = Rare ] }

% XITS % 字体安装在 TeX 发行版下，必须使用文件名调用
\cs_new_protected:Npn \__whu_set_font_xits:
  {
    \setmainfont { XITS }
      [
        Extension      = .otf,
        UprightFont    = * - Regular,
        BoldFont       = * - Bold,
        ItalicFont     = * - Italic,
        BoldItalicFont = * - BoldItalic
      ]
  }

\cs_new_protected:Npn \__whu_set_font_termes:
  {
    \setmainfont { texgyretermes }
      [
        Extension      = .otf,
        UprightFont    = * - regular,
        BoldFont       = * - bold,
        ItalicFont     = * - italic,
        BoldItalicFont = * - bolditalic
      ]
  }

\cs_new_protected:Npn \__whu_set_font_none: {}

% 中文字体
\cs_new_protected:Npn \__whu_set_cjk_font_song:nn #1#2
  {
    \setCJKmainfont {#1} [#2]
    \newCJKfontfamily { \songti } {#1} [#2]
  }
\cs_new_protected:Npn \__whu_set_cjk_font_hei:nn #1#2
  {
    \setCJKsansfont {#1} [#2]
    \newCJKfontfamily { \heiti } {#1} [#2]
  }
\cs_new_protected:Npn \__whu_set_cjk_font_fang:nn #1#2
  {
    \setCJKmonofont {#1} [#2]
    \newCJKfontfamily { \fangsong } {#1} [#2]
    \cs_new:Npn \__whu_set_spine_font:
      {
        \exp_not:N \setmainjfont {#1}
          [
            #2 , TateFeatures =
              {
                JFM = zh_CN / { \exp_not:o \g__whu_option_punct_tl , vert }
              }
          ]
      }
  }
\cs_new_protected:Npn \__whu_set_cjk_font_kai:nn #1#2
  {
    \newCJKfontfamily { \kaishu } {#1} [#2]
  }

\cs_new_protected:Npn \__whu_set_cjk_font_windows:
  {
    \__whu_set_cjk_font_song:nn { SimSun }
      { AutoFakeBold = 4 , AutoFakeSlant = 0.167 }
    \__whu_set_cjk_font_hei:nn { SimHei }
      { AutoFakeBold = 4 , AutoFakeSlant = 0.167 }
    \__whu_set_cjk_font_fang:nn { FangSong }
      { AutoFakeBold = 4 , AutoFakeSlant = 0.167 }
    \__whu_set_cjk_font_kai:nn { KaiTi }
      { AutoFakeBold = 4 , AutoFakeSlant = 0.167 }
  }

\cs_new_protected:Npn \__whu_set_cjk_font_mac:
  {
    \__whu_set_cjk_font_song:nn { Songti ~ SC ~ Light }
      {
        BoldFont           = Songti ~ SC ~ Bold,
        AutoFakeSlant      = 0.167,
        BoldItalicFont     = Songti ~ SC ~ Bold,
        BoldItalicFeatures = { FakeSlant = 0.167 }
      }
    \__whu_set_cjk_font_hei:nn { Heiti ~ SC ~ Light }
      {
        BoldFont           = Heiti ~ SC ~ Medium,
        AutoFakeSlant      = 0.167,
        BoldItalicFont     = Heiti ~ SC ~ Medium,
        BoldItalicFeatures = { FakeSlant = 0.167 }
      }
    \__whu_set_cjk_font_fang:nn { STFangsong }
      { AutoFakeBold = 4 , AutoFakeSlant = 0.167 }
    \__whu_set_cjk_font_kai:nn { Kaiti ~ SC ~ Regular }
      {
        BoldFont           = Kaiti ~ SC ~ Bold,
        AutoFakeSlant      = 0.167,
        BoldItalicFont     = Kaiti ~ SC ~ Bold,
        BoldItalicFeatures = { FakeSlant = 0.167 }
      }
  }

% fandol 同理
\cs_new_protected:Npn \__whu_set_cjk_font_fandol:
  {
    \__whu_set_cjk_font_song:nn { FandolSong-Regular.otf }
      {
        BoldFont           = FandolSong-Bold.otf,
        AutoFakeSlant      = 0.167,
        BoldItalicFont     = FandolSong-Bold.otf,
        BoldItalicFeatures = { FakeSlant = 0.167 }
      }
    \__whu_set_cjk_font_hei:nn { FandolHei- Regular.otf }
      {
        BoldFont           = FandolHei-Bold.otf,
        AutoFakeSlant      = 0.167,
        BoldItalicFont     = FandolHei-Bold.otf,
        BoldItalicFeatures = { FakeSlant = 0.167 }
      }
    \__whu_set_cjk_font_fang:nn { FandolFang-Regular.otf }
      {
        AutoFakeBold  = 4,
        AutoFakeSlant = 0.167
      }
    \__whu_set_cjk_font_kai:nn { FandolKai-Regular.otf }
      {
        AutoFakeBold  = 4,
        AutoFakeSlant = 0.167
      }
  }

% overleaf 调用目录字体需要使用文件名
\cs_new_protected:Npn \__whu_set_cjk_font_overleaf:
  {
    \__whu_set_cjk_font_song:nn { simsun.ttc }
      { AutoFakeBold = 4 , AutoFakeSlant = 0.167 }
    \__whu_set_cjk_font_hei:nn { simhei.ttf }
      { AutoFakeBold = 4 , AutoFakeSlant = 0.167 }
    \__whu_set_cjk_font_fang:nn { simfang.ttf }
      { AutoFakeBold = 4 , AutoFakeSlant = 0.167 }
    \__whu_set_cjk_font_kai:nn { simkai.ttf }
      { AutoFakeBold = 4 , AutoFakeSlant = 0.167 }
  }

\cs_new_protected:Npn \__whu_set_cjk_font_none: {}

% 数学字体
\cs_new_protected:Npn \__whu_set_math_font_xits:
  {
    \setmathfont { XITSMath-Regular.otf }
      [ BoldFont = XITSMath-Bold.otf ]
  }

\cs_new_protected:Npn \__whu_set_math_font_termes:
  {
    \setmathfont { texgyretermes-math.otf }
  }

\cs_new_protected:Npn \__whu_set_math_font_none: {}

% 根据系统判断调用字体
\sys_if_platform_windows:TF
  {
    \keys_define:nn { whu / style }
      {
        font      .initial:n = times,
        math-font .initial:n = xits,
        cjk-font  .initial:n = windows,
      }
  }
  {
    \file_if_exist:nTF { /System/Library/Fonts/Menlo.ttc }
    % 使用 menlo 判断 mac，来自 ctex
      {
        \keys_define:nn { whu / style }
          {
            font      .initial:n = times,
            math-font .initial:n = xits,
            cjk-font  .initial:n = mac,
          }
      }
      {
        \keys_define:nn { whu / style }
          {
            font      .initial:n = xits,
            math-font .initial:n = xits,
            cjk-font  .initial:n = fandol,
          }
      }
  }

% 在导言区末加载字体，不被用户配置覆盖
\AtEndPreamble
  {
    \__whu_set_font:
    \__whu_set_cjk_font:
    \__whu_set_math_font:
  }

%%% ---- 数学定理样式 ----- %%%
\newtheoremstyle { whu }
  { \c_zero_dim } { \c_zero_dim } % 上下间距
  { \songti }                     % 正文字体
  { 2 em }                        % 缩进距离
  { \heiti }                      % 标题字体
  { \hbox:n {} ： \hbox:n {} }    % 结束标记
  { \c_zero_dim }                 % 结束间隔
  {}
\theoremstyle { whu }

\newtheorem { theorem     } { 定理 } [ section ]
\newtheorem { definition  } { 定义 } [ section ]
\newtheorem { lemma       } { 引理 } [ section ]
\newtheorem { corollary   } { 推论 } [ section ]
\newtheorem { proposition } { 性质 } [ section ]
\newtheorem { example     } { 例   } [ section ]
\newtheorem { remark      } { 注   } [ section ]

\RenewDocumentEnvironment { proof } { O { 证明 } + b }
  { \pushQED { \qed } { \heiti #1： } #2 }
  { \popQED }

\RenewDocumentCommand { \eqref } { m }
  { \textup { { \normalfont （ \ref {#1} ） \normalfont } } }
% 公式引用使用中文括号

% 清除公式上下间距
\skip_set:Nn \abovedisplayskip      { 6 pt }
\skip_set:Nn \belowdisplayskip      { 6 pt }
\skip_set:Nn \abovedisplayshortskip { 0 pt }
\skip_set:Nn \belowdisplayshortskip { 0 pt }

% 最后引入 hyperref 包
\AtEndPreamble
  {
    \RequirePackage { hyperref }
    \hypersetup { hidelinks }
    \urlstyle { rm }

    \hypersetup
      {
        pdftitle  = \g__whu_info_title_tl,
        pdfauthor = \g__whu_info_author_tl
      }

    \tl_set_eq:NN \figureautorefname \figurename
    \tl_set_eq:NN \tableautorefname  \tablename
  }

\cs_new_protected:Npn \__whu_new_chapter_page:
  {
    \bool_if:NTF \g__whu_option_twoside_bool
      { \cleardoublepage }
      { \clearpage }
  }

\cs_new_protected:Npn \__whu_date_parse:n #1
  { \__whu_date_parse_aux:w #1 \q_stop }
\cs_new_protected:Npn \__whu_date_parse_aux:w #1 / #2 \q_stop
  { \zhdigits {#1} 年 \zhnumber {#2} 月 }
\cs_generate_variant:Nn \__whu_date_parse:n { V }

\tl_if_eq:NnTF \g__whu_option_type_tl { bachelor }
  { \skip_const:Nn \c__whu_baseline_skip { 23 pt } }
  {
    \tl_if_eq:NnTF \g__whu_option_type_tl { opening }
      { \skip_const:Nn \c__whu_baseline_skip { 23 pt } }
      { \skip_const:Nn \c__whu_baseline_skip { 20 pt } }
  }
% 本科行距 23 pt，硕博行距 20 pt
\cs_new_protected:Npn \__whu_set_baseline_skip:
  {
    \skip_set_eq:NN \baselineskip \c__whu_baseline_skip
    \skip_zero:N    \parskip
  }

%%% ---- 文档接口 ----- %%%
\NewDocumentCommand { \whusetup } { m }
  { \keys_set:nn { whu } {#1} }

\tl_new:N \g__whu_info_clc_tl
\tl_new:N \g__whu_info_udc_tl
\tl_new:N \g__whu_info_secret_level_tl
\tl_new:N \g__whu_info_school_number_tl
\tl_new:N \g__whu_info_title_tl
\tl_new:N \g__whu_info_title_en_tl
\tl_new:N \g__whu_info_author_tl
\tl_new:N \g__whu_info_author_en_tl
\tl_new:N \g__whu_info_student_number_tl
\tl_new:N \g__whu_info_school_tl
\tl_new:N \g__whu_info_subject_tl
\tl_new:N \g__whu_info_major_tl
\tl_new:N \g__whu_info_direction_tl
\tl_new:N \g__whu_info_date_tl
\clist_new:N \g__whu_info_advisor_clist
\clist_new:N \g__whu_info_keywords_clist
\clist_new:N \g__whu_info_keywords_en_clist

\keys_define:nn { whu / info }
  {
    clc            .tl_gset:N    = \g__whu_info_clc_tl,
    udc            .tl_gset:N    = \g__whu_info_udc_tl,
    secret-level   .tl_gset:N    = \g__whu_info_secret_level_tl,
    school-number  .tl_gset:N    = \g__whu_info_school_number_tl,
    student-number .tl_gset:N    = \g__whu_info_student_number_tl,
    title          .tl_gset:N    = \g__whu_info_title_tl,
    title *        .tl_gset:N    = \g__whu_info_title_en_tl,
    author         .tl_gset:N    = \g__whu_info_author_tl,
    author *       .tl_gset:N    = \g__whu_info_author_en_tl,
    school         .tl_gset:N    = \g__whu_info_school_tl,
    subject        .tl_gset:N    = \g__whu_info_subject_tl,
    major          .tl_gset:N    = \g__whu_info_major_tl,
    direction      .tl_gset:N    = \g__whu_info_direction_tl,
    date           .tl_gset:N    = \g__whu_info_date_tl,
    advisor        .clist_gset:N = \g__whu_info_advisor_clist,
    keywords       .clist_gset:N = \g__whu_info_keywords_clist,
    keywords *     .clist_gset:N = \g__whu_info_keywords_en_clist,

    school-number  .initial:n    = { 10486 },
    date           .initial:n    =
      { \int_use:N \c_sys_year_int / \int_use:N \c_sys_month_int }
  }

\tl_new:N \g__whu_element_innovation_tl
\tl_new:N \g__whu_element_abstract_tl
\tl_new:N \g__whu_element_abstract_en_tl
\tl_new:N \g__whu_element_thanks_tl
\clist_new:N \g__whu_element_bibliography_clist
\clist_new:N \g__whu_element_appendix_clist

\keys_define:nn { whu / element }
  {
    innovation   .tl_gset:N    = \g__whu_element_innovation_tl,
    abstract     .tl_gset:N    = \g__whu_element_abstract_tl,
    abstract *   .tl_gset:N    = \g__whu_element_abstract_en_tl,
    achievements .tl_gset:N    = \g__whu_element_achievements_tl,
    thanks       .tl_gset:N    = \g__whu_element_thanks_tl,
    bibliography .clist_gset:N = \g__whu_element_bibliography_clist,
    appendix     .clist_gset:N = \g__whu_element_appendix_clist,
  }

\tl_new:N \g__whu_style_graphics_path_tl
\tl_new:N \g__whu_style_bib_style_tl
\tl_new:N \g__whu_style_cite_style_tl

\bool_new:N \g__whu_style_bib_backend_bibtex_bool
\bool_new:N \g__whu_style_list_of_figures_bool
\bool_new:N \g__whu_style_list_of_tables_bool

\keys_define:nn { whu / style }
  {
    % 图片文件路径，传给 \graphicspath
    graphics-path .tl_gset:N = \g__whu_style_graphics_path_tl,

    % 参考文献后端
    bib-backend            .value_required:n = true,
    bib-backend            .choice:,
    bib-backend / bibtex   .code:n =
      { \bool_gset_true:N  \g__whu_style_bib_backend_bibtex_bool },
    bib-backend / biblatex .code:n =
      { \bool_gset_false:N \g__whu_style_bib_backend_bibtex_bool },
    bib-backend            .initial:n = bibtex,

    % 参考文献样式
    bib-style .value_required:n = true,
    bib-style .choices:nn =
      { numerical , author-year , author-year-numbered , unknown }
      { \tl_gset_eq:NN \g__whu_style_bib_style_tl \l_keys_choice_tl },

    % 引用样式
    cite-style .value_required:n = true,
    cite-style .choices:nn =
      { numerical-super , numerical-inline , author-year , unknown }
      { \tl_gset_eq:NN \g__whu_style_cite_style_tl \l_keys_choice_tl },

    list-of-figures         .choice:,
    list-of-figures / true  .code:n =
      { \bool_gset_true:N  \g__whu_style_list_of_figures_bool },
    list-of-figures / false .code:n =
      { \bool_gset_false:N \g__whu_style_list_of_figures_bool },
    list-of-figures         .default:n = true,
    list-of-figures         .initial:n = false,

    list-of-tables         .choice:,
    list-of-tables / true  .code:n =
      { \bool_gset_true:N  \g__whu_style_list_of_tables_bool },
    list-of-tables / false .code:n =
      { \bool_gset_false:N \g__whu_style_list_of_tables_bool },
    list-of-tables         .default:n = true,
    list-of-tables         .initial:n = false,

    fullwidth-stop         .choice:,
    fullwidth-stop / true  .code:n =
      {
        \tl_const:Nn \c__whu_fullwidth_full_stop_tl { ． }
        \char_set_catcode_active:n { `。 }
        \char_set_active_eq:nN { `。 } \c__whu_fullwidth_full_stop_tl
      },
    fullwidth-stop / false .code:n = {},
    fullwidth-stop         .default:n = true,
    fullwidth-stop         .initial:n = false
  }

%%% ---- 参考文献设置 ----- %%%
\clist_if_in:nVTF { doctor , master } \g__whu_option_type_tl
  {
    \keys_define:nn { whu / style }
      {
        bib-style  .initial:n = author-year,
        cite-style .initial:n = author-year
      }
  }
  {
    \keys_define:nn { whu / style }
      {
        bib-style  .initial:n = numerical,
        cite-style .initial:n = numerical-super
      }
  }

\BeforeBeginEnvironment { document }
  {
    \bool_if:NTF \g__whu_style_bib_backend_bibtex_bool
      {
        \RequirePackage [ sort & compress ] { natbib }
        \__whu_bibtex_setup:
      }
      {
        \__whu_biblatex_pre_setup:
        \RequirePackage [ backend = biber , doi = false ] { biblatex }
        \__whu_biblatex_post_setup:
      }
  }

\msg_new:nnn { whu-thesis } { cite-style 无效 }
  {
    bib-backend = bibtex 下，\\
    cite-style = #1 不能与 bib-style = #2 搭配使用！\\
    
    请更改 bib-style 或 cite-style，或使用 biblatex！
  }
\cs_new_protected:Npn \__whu_invalid_cite_style:
  {
    \msg_warning:nnxx { whu-thesis } { cite-style 无效 }
      { \g__whu_style_cite_style_tl }
      { \g__whu_style_bib_style_tl }
  }

\cs_new_protected:Npn \__whu_bibtex_setup:
  {
    \skip_zero:N \bibsep % 参考文献间距设为 0
    \tl_if_eq:NnT \g__whu_style_bib_style_tl { numerical }
      {
        \bibliographystyle { data / gbt7714-2005-numerical }
        % \bibliographystyle { data / gbt7714-2005-whu-numerical }

        \NAT@numberstrue
        \clist_if_in:nVTF { numerical-super , numerical-inline }
          \g__whu_style_cite_style_tl
          {
            \tl_if_eq:NnT \g__whu_style_cite_style_tl { numerical-super }
              { \NAT@supertrue }
          }
          { \__whu_invalid_cite_style: }
        \tl_set:Nn \NAT@open  { [ }
        \tl_set:Nn \NAT@close { ] }
        \tl_set:Nn \NAT@sep   { , ~ }
      }

    \clist_if_in:nVT { author-year , author-year-numbered }
      \g__whu_style_bib_style_tl
      {
        \bibliographystyle { data / gbt7714-2005-author-year }
        \tl_if_eq:NnF \g__whu_style_cite_style_tl { author-year }
          { \__whu_invalid_cite_style: }
      }

    \tl_if_eq:NnT \g__whu_option_type_tl { opening }
      { \RequirePackage [ numbib ] { tocbibind } }
  }

\cs_new_protected:Npn \__whu_biblatex_pre_setup:
  {
    \clist_if_in:nVTF { numerical , author-year , author-year-numbered }
      \g__whu_style_bib_style_tl
      {
        \tl_if_eq:NnTF \g__whu_style_bib_style_tl { numerical }
          { \PassOptionsToPackage { bibstyle = gb7714-2015   } { biblatex } }
          { \PassOptionsToPackage { bibstyle = gb7714-2015ay } { biblatex } }
      }
      {
        \PassOptionsToPackage { bibstyle = \g__whu_style_bib_style_tl }
          { biblatex }
      }
    \clist_if_in:nVTF { numerical-super , numerical-inline , author-year }
      \g__whu_style_cite_style_tl
      {
        \tl_if_eq:NnT \g__whu_style_cite_style_tl { numerical-inline }
          { \PassOptionsToPackage { citestyle = numeric-comp  } { biblatex } }
        \tl_if_eq:NnT \g__whu_style_cite_style_tl { numerical-super  }
          { \PassOptionsToPackage { citestyle = gb7714-2015   } { biblatex } }
        \tl_if_eq:NnT \g__whu_style_cite_style_tl { author-year }
          { \PassOptionsToPackage { citestyle = gb7714-2015ay } { biblatex } }
      }
      {
        \PassOptionsToPackage { citestyle = \g__whu_style_cite_style_tl }
          { biblatex }
      }
  }

\cs_new_protected:Npn \__whu_biblatex_post_setup:
  {
    \skip_zero:N \bibitemsep % 参考文献间距设为 0
    \clist_if_empty:NF \g__whu_element_bibliography_clist
      { 
        \clist_map_function:NN \g__whu_element_bibliography_clist 
          \addbibresource
      }
  }

\keys_define:nn { whu }
  {
    info    .meta:nn = { whu / info    } {#1},
    element .meta:nn = { whu / element } {#1},
    style   .meta:nn = { whu / style   } {#1}
  }

% 分散函数
\cs_new_protected:Npn \__whu_spread_with:nn #1#2
  { \tl_map_inline:xn {#1} { ##1 #2 } \unskip }

%%% ---- 论文前言 ----- %%%
% 前言包括中英文封面、郑重声明、摘要与目录
\AtBeginDocument
  {
    \use:c { __whu_make_front_matter_ \g__whu_option_type_tl : }
  }

\cs_new_protected:Npn \__whu_make_front_matter_doctor:
  {
    \__whu_make_cover_master_doctor:
    \__whu_make_title_en:
    \__whu_make_statesment_master_doctor:
    \__whu_make_authorization:
    \__whu_make_innovation:
    \__whu_make_contents:

    \pagestyle { plain }
    \pagenumbering { Roman }
    \__whu_make_abstract:

    \pagenumbering { arabic }
    \__whu_set_baseline_skip:
    \raggedbottom
    \__whu_set_table_font:
  }

\cs_new_protected:Npn \__whu_make_front_matter_master:
  {
    \__whu_make_cover_master_doctor:
    \__whu_make_title_en:
    \__whu_make_statesment_master_doctor:

    \pagestyle { plain }
    \pagenumbering { Roman }
    \__whu_make_abstract:
    \__whu_make_contents:

    \pagenumbering { arabic }
    \__whu_set_baseline_skip:
    \raggedbottom
    \__whu_set_table_font:
  }

\cs_new_protected:Npn \__whu_make_front_matter_bachelor:
  {
    \__whu_make_cover_bachelor:
    \__whu_make_statesment_bachelor:
    \__whu_make_abstract:
    \__whu_make_contents:

    \pagestyle { plain }
    \pagenumbering { arabic }
    \__whu_set_baseline_skip:
    \raggedbottom
    \__whu_set_table_font:
  }

\cs_new_protected:Npn \__whu_make_front_matter_opening:
  {
    \pagestyle { plain }
    \begin { center }
      \zihao { -2 } \heiti \c__whu_heading_tl
    \end { center }

    \__whu_set_baseline_skip:

    \noindent
    \begin { minipage } { \textwidth }
      \__whu_set_baseline_skip:
      毕业论文（设计）题目： \uline { \hfill \g__whu_info_title_tl \hfill } \\
      学院： \uline { \hfill \g__whu_info_school_tl \hfill } \hfill \hfill
      学号： \uline { \hfill \g__whu_info_student_number_tl \hfill } \hfill
      \hfill 姓名： \uline { \hfill \g__whu_info_author_tl \hfill }
    \end { minipage }
    \par \skip_vertical:n { 10 pt }
    \raggedbottom
    \__whu_set_table_font:
  }

%%%% ---- 论文封面 ---- %%%%
\cs_new_protected:Npn \__whu_make_cover_bachelor:
  {
    \pagestyle { empty }
    \__whu_set_baseline_skip:
    \begin { center }
      \group_begin:
        \heiti \zihao { 5 } \hfill
        \begin { minipage } [ t ] { 5 cm }
          \__whu_set_baseline_skip:
          学号 \uline
            {
              \hbox_to_wd:nn { 3 cm }
                { \hfill \g__whu_info_student_number_tl \hfill }
            } \\
          密级 \uline
            {
              \hbox_to_wd:nn { 3 cm }
                { \hfill \g__whu_info_secret_level_tl \hfill }
            }
        \end { minipage }
      \group_end:
      \par \skip_vertical:n { 6 em }
      { \zihao { 1 } \c__whu_heading_tl }
      \par \skip_vertical:n { 6 em }
      \begin { minipage } [ c ] [ 6 cm ] { \textwidth }
        \skip_set:Nn \baselineskip { 32 pt }
        \centering { \heiti \zihao { 2 } \g__whu_info_title_tl }
      \end { minipage }
      \par \skip_vertical:n { 6 em }
      \group_begin:
        \zihao { -3 }
        \begin { tabular } { p { 7 em } @ { ： \hbox:n {} } l }
          \__whu_spread_with:nn
            {
              院 { \hbox_overlap_left:n { （ } 系 \hbox_overlap_right:n { ） } }
              名称
            }
            { \hfill } & \g__whu_info_school_tl \\ [ 0.5 em ]
          \__whu_spread_with:nn { 专业名称 } { \hfill }
            & \g__whu_info_major_tl \\ [ 0.5 em ]
          \__whu_spread_with:nn { 学生姓名 } { \hfill }
            & \g__whu_info_author_tl \\ [ 0.5 em ]
          \__whu_spread_with:nn { 指导教师 } { \hfill } & \clist_use:Nn
            \g__whu_info_advisor_clist { \quad } \\ [ 0.5 em ]
        \end { tabular }
      \group_end:
      \vfill
      { \songti \zihao { -2 } \__whu_date_parse:V { \g__whu_info_date_tl } }
    \end { center }
    \__whu_new_chapter_page:
  }

\cs_new_protected:Npn \__whu_make_cover_master_doctor:
  {
    \pagestyle { empty }
    \__whu_set_baseline_skip:
    \begin { center }
      \begin { minipage } [ c ] [ 2.5 cm ] { \textwidth }
        \fangsong \zihao { 4 } \mode_leave_vertical:
        \hbox_to_wd:nn { 2 cm } { \__whu_spread_with:nn { 分类号 } { \hfill } }
        \uline { \hbox_to_wd:nn { 2 cm } { \hfill \g__whu_info_clc_tl \hfill } }
        \hfill
        \hbox_to_wd:nn { 2 cm } { \__whu_spread_with:nn { 密级 } { \hfill } }
        \uline
          {
            \hbox_to_wd:nn { 2 cm }
              { \hfill \g__whu_info_secret_level_tl \hfill }
          } \par \skip_vertical:n { 1 em } \mode_leave_vertical:
        \hbox_to_wd:nn { 2 cm } { \__whu_spread_with:nn { UDC } { \hfill } }
        \uline { \hbox_to_wd:nn { 2 cm } { \hfill \g__whu_info_udc_tl \hfill } }
        \hfill
        \hbox_to_wd:nn { 2 cm } { \__whu_spread_with:nn { 编号 } { \hfill } }
        \uline
          {
            \hbox_to_wd:nn { 2 cm }
              { \hfill \g__whu_info_school_number_tl \hfill }
          }
      \end { minipage }
      \par \skip_vertical:n { 2 cm }
      \includegraphics [ width = 5.5 cm ] { data / whu.pdf }
      \par \skip_vertical:n { 1 cm }
      { \zihao { 2 } \bfseries \c__whu_heading_tl }
      \par \skip_vertical:n { 2.5 cm }
      \begin { minipage } [ t ] [ 5 cm ] { \textwidth }
        \skip_set:Nn \baselineskip { 40 pt }
        \centering { \kaishu \zihao { 1 } \g__whu_info_title_tl }
      \end { minipage } \par
      \group_begin:
        \zihao { 4 }
        \begin { tabular } { l @ { ： \hbox:n {} } l }
        \tl_if_eq:NnTF \g__whu_option_type_tl { doctor }
          {
            \__whu_spread_with:nn { 研究生姓名 } { \hfill } &
            \__whu_spread_with:nn
              { \g__whu_info_author_tl } { \hfill } \\ [ 0.5 em ]
            \__whu_spread_with:nn { 指导教师姓名、职称 } { \hfill } &
            \__whu_spread_with:nn
              { \clist_use:Nn \g__whu_info_advisor_clist { \quad } }
              { \hfill } \\ [ 0.5 em ]
            \__whu_spread_with:nn { 学科、专业名称 } { \hfill } &
            \__whu_spread_with:nn
              { \g__whu_info_subject_tl 、 \g__whu_info_major_tl }
              { \hfill } \\ [ 0.5 em ]
            \__whu_spread_with:nn { 研究方向 } { \hfill } &
            \__whu_spread_with:nn
              { \g__whu_info_direction_tl } { \hfill } \\ [ 0.5 em ]
          }
          {
            \__whu_spread_with:nn { 研究生姓名 } { \hfill } &
            \g__whu_info_author_tl \\ [ 0.5 em ]
            \__whu_spread_with:nn { 学号 } { \hfill } &
            \g__whu_info_student_number_tl \\ [ 0.5 em ]
            \__whu_spread_with:nn { 指导教师姓名、职称 } { \hfill } &
            \clist_use:Nn \g__whu_info_advisor_clist { \enskip } \\ [ 0.5 em ]
            \tl_if_eq:NnTF \g__whu_option_class_tl { academic }
              {
                \__whu_spread_with:nn { 专业名称 } { \hfill } &
                \g__whu_info_major_tl \\ [ 0.5 em ]
                \__whu_spread_with:nn { 研究方向 } { \hfill } &
                \g__whu_info_direction_tl \\ [ 0.5 em ]
              }
              {
                \__whu_spread_with:nn { 专业类别 { （领 } { 域） } } { \hfill }
                & \g__whu_info_major_tl \\ [ 0.5 em ]
              }
          }
        \end { tabular }
      \group_end:
      \par \vfill
      { \heiti \zihao { 3 } \__whu_date_parse:V { \g__whu_info_date_tl } }
    \end { center }
    \__whu_new_chapter_page:
  }

%%%% ---- 英文标题 ---- %%%%
\cs_new_protected:Npn \__whu_make_title_en:
  {
    \__whu_new_chapter_page:
    \begin { center }
      \zihao { 2 } \g__whu_info_title_en_tl
    \end { center }
    \vfill
    \begin { center }
      \zihao { 4 } \g__whu_info_author_en_tl
    \end { center }
    \__whu_new_chapter_page:
  }

%%%% ---- 郑重声明 ---- %%%%
\cs_new_protected:Npn \__whu_make_statesment_bachelor:
  {
    \__whu_new_chapter_page:
    \mode_leave_vertical: \skip_vertical:n { 44 pt }
    \noindent \hfil { \zihao { 2 } \textbf { \__whu_spread_with:nn
      { 郑重声明 } { \enskip } } }
    \par \skip_vertical:n { 20 pt }
    \group_begin:
      \zihao { 4 }
      本人呈交的学位论文，是在导师的指导下，独立进行研究工作所取得的成果，所有数
      据、图片资料真实可靠。尽我所知，除文中已经注明引用的内容外，本学位论文的研
      究成果不包含他人享有著作权的内容。对本论文所涉及的研究工作做出贡献的其他个
      人和集体，均已在文中以明确的方式标明。本学位论文的知识产权归属于培养单位。
      \par \skip_vertical:n { 88 pt }
      本人签名： \uline { \hbox_to_wd:nn { 4 cm } {} }
      \hfill 日期： \uline { \hbox_to_wd:nn { 4 cm } {} }
    \group_end:
    \__whu_new_chapter_page:
  }

\cs_new_protected:Npn \__whu_make_statesment_master_doctor:
  {
    \__whu_new_chapter_page:
    \mode_leave_vertical: \skip_vertical:n { 2 \baselineskip }
    \noindent \hfil { \zihao { -2 } \heiti 论文原创性声明 }
    \par \skip_vertical:n { 2 \baselineskip }
    \group_begin:
      \zihao { 4 } \skip_set:Nn \baselineskip { 28 pt }
      \tl_if_eq:NnTF \g__whu_option_type_tl { doctor }
        {
          本人郑重声明：所呈交的学位论文，是本人在导师指导下，独立进行研究工作所
          取得的研究成果。除文中已经标明引用的内容外，本论文不包含任何其他个人或
          集体已发表或撰写的研究成果。对本文的研究做出贡献的个人和集体，均已在文
          中以明确方式标明。本声明的法律结果由本人承担。
        }
        {
          本人郑重声明：所呈交的学位论文，是本人在导师指导下，独立进行研究工作所
          取得的研究成果。除文中已经标明引用的内容外，本论文不包含任何其他个人或
          集体已经发表或撰写过的研究成果。对本文的研究做出贡献的个人和集体，均已
          在文中以明确方式标明。本声明的法律结果由本人承担。
        }
      \par \skip_vertical:N \baselineskip
      \hfill 学位论文作者（签名）： \hbox_to_wd:nn { 4 cm } {}
      \par \skip_vertical:N \baselineskip
        \hfill 年 \qquad 月 \qquad 日
    \group_end:
    \__whu_new_chapter_page:
  }

%%%% ---- 使用授权书 ---- %%%%
\cs_new_protected:Npn \__whu_make_authorization:
  {
    \__whu_new_chapter_page:
    \mode_leave_vertical: \skip_vertical:N \baselineskip
    \noindent \hfil
    { \zihao { 4 } \heiti \textbf { 武汉大学学位论文使用授权协议书 } }
    \par \skip_vertical:n { 25 pt }
    \skip_set:Nn \baselineskip { 22 pt }
    本学位论文作者愿意遵守武汉大学关于保存、使用学位论文的管理办法及规定，即：学
    校有权保存学位论文的印刷本和电子版，并提供文献检索与阅览服务；学校可以采用影
    印、缩印、数字化或其它复制手段保存论文；在以教学与科研服务为目的前提下，学校
    可以在校园网内公布部分或全部内容。 \par
    一、在本论文提交当年，同意在校园网内以及中国高等教育文献保障系统（CALIS）、
    高校学位论文系统提供查询及前十六页浏览服务。 \par
    二、在本论文提交 \hbox:n { \textsquare } 当年/ \hbox:n { \textsquare }一年/
    \hbox:n { \textsquare } 两年/ \hbox:n { \textsquare }三年以后，同意在校园网
    内允许读者在线浏览并下载全文，学校可以为存在馆际合作关系的兄弟高校用户提供文
    献传递服务和交换服务。（保密论文解密后遵守此规定）
    \par \skip_vertical:n { 10 pt }
    \begin { minipage } { 20 em }
      \skip_set:Nn \baselineskip { 22 pt }
      论文作者（签名）： \uline { \hfill } \par
      学 \qquad 号： \uline { \hfill } \par
      学 \qquad 院： \uline { \hfill }
      \par \skip_vertical:n { 15.6 pt }
      \hfill 日期： \qquad \qquad 年 \qquad 月 \qquad 日
    \end { minipage }
    \__whu_new_chapter_page:
  }

%%% ---- 创新 ----- %%%
\cs_new_protected:Npn \__whu_make_innovation:
  {
    \tl_if_empty:NF \g__whu_element_innovation_tl
      {
        \chapter * { 博士生自认为的论文创新点 }
        \thispagestyle { empty }
        \file_input:V \g__whu_element_innovation_tl
      }
    \__whu_new_chapter_page:
  }

%%% ---- 目录 ----- %%%
\cs_new_protected:Npn \__whu_make_contents:
  {
    \__whu_new_chapter_page:
    \tableofcontents
    \__whu_new_chapter_page:

    \bool_if:NT \g__whu_style_list_of_figures_bool
      {
        \listoffigures
        \__whu_new_chapter_page:
      }

    \bool_if:NT \g__whu_style_list_of_tables_bool
      {
        \listoftables
        \__whu_new_chapter_page:
      }
  }

%%% ---- 摘要 ----- %%%
% 关键词悬挂
\box_new:N \l__whu_keywords_box
\cs_new_protected:Npn \__whu_put_keywords:nn #1#2
  {
    \hbox_set:Nn \l__whu_keywords_box {#1}
    \noindent \hangindent \box_wd:N \l__whu_keywords_box \hangafter 1
    \box_use_drop:N \l__whu_keywords_box #2 \par
  }

% 生成摘要
\cs_new_protected:Npn \__whu_make_abstract:
  {
    % 中文摘要
    \tl_if_empty:NF \g__whu_element_abstract_tl
      {
        \chapter * { 摘 \qquad 要 }
        \phantomsection
        \clist_map_inline:nn { doctor , master }
          {
            \tl_if_eq:NnT \g__whu_option_type_tl {##1}
              { \addcontentsline { toc } { chapter } { 摘 \qquad 要 } }
          }
        \tl_if_eq:NnT \g__whu_option_type_tl { bachelor }
          { \thispagestyle { empty } }
        \__whu_set_baseline_skip:

        \file_input:V \g__whu_element_abstract_tl

        \skip_vertical:N \c__whu_baseline_skip \par
        \__whu_put_keywords:nn
          { \heiti \zihao { -4 } 关键词：\hbox:n {} }
          { \clist_use:Nn \g__whu_info_keywords_clist { ； } }
      }
    % 英文摘要
    \tl_if_empty:NF \g__whu_element_abstract_en_tl
      {
        \chapter * { \textbf { ABSTRACT } }
        \phantomsection
        \clist_map_inline:nn { doctor , master }
          {
            \tl_if_eq:NnT \g__whu_option_type_tl {##1}
              { \addcontentsline { toc } { chapter } { ABSTRACT } }
          }
        \tl_if_eq:NnT \g__whu_option_type_tl { bachelor }
          { \thispagestyle { empty } }
        \__whu_set_baseline_skip:
        \file_input:V \g__whu_element_abstract_en_tl
        \skip_vertical:N \c__whu_baseline_skip \par
        \__whu_put_keywords:nn
          { \bfseries \zihao { -4 } Key ~ words: ~ }
          { \clist_use:Nn \g__whu_info_keywords_en_clist { ; ~ } }
      }
    \__whu_new_chapter_page:
  }

%%%% ---- 论文结语 ---- %%%%
% 结语包括参考文献、致谢与附录
\AtEndDocument
  {
    \use:c { __whu_make_back_matter_ \g__whu_option_type_tl : }
  }

\cs_new_protected:Npn \__whu_make_back_matter_doctor:
  {
    \__whu_make_bibliography:
    \__whu_make_achievements:
    \__whu_make_thanks:
    \__whu_make_appendix:
    \__whu_make_spine:
  }

\cs_new_protected:Npn \__whu_make_back_matter_master:
  {
    \__whu_make_bibliography:
    \__whu_make_appendix:
    \__whu_make_thanks:
  }

\cs_new_protected:Npn \__whu_make_back_matter_bachelor:
  {
    \__whu_make_bibliography:
    \__whu_make_thanks:
    \__whu_make_appendix:
  }

\cs_new_protected:Npn \__whu_make_back_matter_opening:
  {
    \__whu_make_bibliography:

    \skip_vertical:n { 2 \c__whu_baseline_skip }
    \needspace { 0.3 \textheight }
    指导老师意见：
    \vfill
    \hfill 指导老师（签名）： \hbox_to_wd:nn { 4 cm } {} \par
    \skip_vertical:N \c__whu_baseline_skip
    \hfill 年 \qquad 月 \qquad 日
  }

%%%% ---- 参考文献 ---- %%%%
\cs_new_protected:Npn \__whu_make_bibliography:
  {
    \clist_if_empty:NF \g__whu_element_bibliography_clist
      {
        \tl_if_eq:NnTF \g__whu_option_type_tl { opening }
          {
            \bool_if:NTF \g__whu_style_bib_backend_bibtex_bool
              {
                \tl_if_eq:NnT \g__whu_style_bib_style_tl
                  { author-year-numbered }
                  { \setcitestyle { numbers } }
                \exp_args:NV \bibliography \g__whu_element_bibliography_clist
              }
              {
                \tl_if_eq:NnTF \g__whu_style_bib_style_tl
                  { author-year-numbered }
                  {
                    \printbibliography
                      [ heading = bibnumbered , env = numerical ]
                  }
                  { \printbibliography [ heading = bibnumbered ] }
              }
          }
          {
            \__whu_new_chapter_page:
            \phantomsection
            \addcontentsline { toc } { chapter } { 参考文献 }
            \bool_if:NTF \g__whu_style_bib_backend_bibtex_bool
              {
                \tl_if_eq:NnT \g__whu_style_bib_style_tl
                  { author-year-numbered }
                  { \setcitestyle { numbers } }
                \exp_args:NV \bibliography \g__whu_element_bibliography_clist
              }
              {
                \tl_if_eq:NnTF \g__whu_style_bib_style_tl
                  { author-year-numbered }
                  { \printbibliography [ env = numerical ] }
                  { \printbibliography }
              }
          }
      }
  }

%%%% ---- 攻博期间发表的科研成果目录 ---- %%%%
\cs_new_protected:Npn \__whu_make_achievements:
  {
    \tl_if_empty:NF \g__whu_element_achievements_tl
      {
        \chapter * { 攻博期间发表的科研成果目录 }
        \phantomsection
        \addcontentsline { toc } { chapter } { 攻博期间发表的科研成果目录 }
        \tl_if_eq:NnTF \g__whu_style_bib_style_tl { author-year }
          {
            \begin { enumerate } [ label = {} , left = 0 pt .. 0 pt ]
              \file_input:V \g__whu_element_achievements_tl
            \end { enumerate }
          }
          {
            \begin { enumerate } [ label = { [ } \arabic* { ] } ]
              \file_input:V \g__whu_element_achievements_tl
            \end { enumerate }
          }
      }
  }

%%%% ---- 致谢 ---- %%%%
\cs_new_protected:Npn \__whu_make_thanks:
  {
    \tl_if_empty:NF \g__whu_element_thanks_tl
      {
        \chapter * { 致谢 }
        \phantomsection
        \addcontentsline { toc } { chapter } { 致谢 }
        \file_input:V \g__whu_element_thanks_tl
      }
  }

%%%% ---- 附录 ---- %%%%
\cs_new_protected:Npn \__whu_make_appendix:
  {
    \clist_if_empty:NF \g__whu_element_appendix_clist
      {
        \appendix
        \clist_map_function:NN \g__whu_element_appendix_clist \file_input:n
      }
  }

%%%% ---- 书脊 ---- %%%%
\cs_new_protected:Npn \__whu_make_spine:
  {
    \file_if_exist:nF { \c_sys_jobname_str - spine.pdf }
      {
        \iow_new:N \g__whu_spine_iow
        \iow_open:Nn \g__whu_spine_iow { \c_sys_jobname_str - spine.tex }
        \iow_now:Nx \g__whu_spine_iow
          {
            \tl_to_str:n
              {
                \documentclass { ltjtarticle }
                \usepackage { ctexsize }
                \usepackage { geometry }
                \geometry { margin = 2.5 cm , ignoreall }
                \usepackage { luatexja-fontspec }
                \ExplSyntaxOn
              }
            \__whu_set_spine_font:
            \tl_to_str:n
              {
                \begin { document }
                \pagestyle { empty } 
                \mode_leave_vertical: \vfil \noindent
              }
            \tl_to_str:n { \zihao { 4 } } \exp_not:o \g__whu_head_odd_tl
            \tl_to_str:n { \hfill } \exp_not:o \g__whu_info_author_tl
            \tl_to_str:n { \end { document } }
          }
        \iow_close:N \g__whu_spine_iow
        \__whu_compile_spine:
      }
  }

\cs_new_protected:Npn \__whu_compile_spine:
  {
    \sys_shell_now:x { lualatex ~ \c_sys_jobname_str - spine }
    \sys_shell_now:x { latexmk ~ -c ~ \c_sys_jobname_str - spine }
    \sys_if_platform_windows:TF
      { \sys_shell_now:x { del ~ \c_sys_jobname_str - spine.tex } }
      { \sys_shell_now:x { rm ~ \c_sys_jobname_str - spine.tex } }
  }