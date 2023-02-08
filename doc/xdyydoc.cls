\NeedsTeXFormat{LaTeX2e}[2020/10/01]
\ProvidesExplClass{xdyydoc}
  {2022-04-26}{0.1a}{Documentation class for CCNUthesis}
\@namedef{ver@thumbpdf.sty}{9999/99/99}
\LoadClass[a4paper, full]{l3doc}
\RequirePackage[heading, sub3section, fontset=none]{ctex}
\RequirePackage{%
  caption,
  geometry,
  graphicx,
  listings,
  makecell,
  siunitx,
  tabularx,
  threeparttable,
  unicode-math,
  xcolor,
  ninecolors,
  xcolor-material,
  xunicode,
  zref-base,
  tikz,
  tikzpagenodes,
  tcolorbox,
  accsupp,       % PDF accessibility support
  MnSymbol,
  lstautogobble
}
\tcbuselibrary{listings}
\tcbuselibrary{hooks, skins, xparse, breakable}
% \tcbuselibrary{hooks, minted, skins, xparse, breakable}
\definecolor{main}{HTML}{5989cf}    % setting main color to be used
\definecolor{sub}{HTML}{cde4ff}     % setting sub color to be used
\def\macro@code{%
  \topsep \MacrocodeTopsep
  \@beginparpenalty \predisplaypenalty
  \partopsep \z@skip
  \trivlist \parskip \z@ \item[]%
  \MacroFont
  \leftskip\@totalleftmargin \advance\leftskip\MacroIndent
  \rightskip\z@ \parindent\z@ \parfillskip\@flushglue
  \blank@linefalse \def\par{\ifblank@line
                            \leavevmode\fi
                            \blank@linetrue\@@par
                            \penalty\interlinepenalty}
  \obeylines
  \let\do\do@noligs \verbatim@nolig@list
  \let\do\@makeother \dospecials
  \global\@newlistfalse
  \global\@minipagefalse
  \init@crossref}
\ExplSyntaxOn
\tl_new:N \l__fdudoc_tmpa_tl
\tl_new:N \l__fdudoc_tmpb_tl
\cs_new_protected:Npn \__fdudoc_patch_cmd:Nnn #1#2#3
  {
    \ctex_patch_cmd_once:NnnnTF #1 { } {#2} {#3}
      { } { \ctex_patch_failure:N #1 }
  }
\cs_new_protected:Npn \__fdudoc_preto_cmd:Nn #1#2
  {
    \ctex_preto_cmd:NnnTF #1 { } {#2}
      { } { \ctex_patch_failure:N #1 }
  }
\cs_new_protected:Npn \__fdudoc_appto_cmd:Nn #1#2
  {
    \ctex_appto_cmd:NnnTF #1 { } {#2}
      { } { \ctex_patch_failure:N #1 }
  }
\cs_set_protected_nopar:Npn \xmacro@code
  { \__fdudoc_marco_code:w }
\cs_set_protected_nopar:Npn \sxmacro@code
  {
    \fontspec_print_visible_spaces:
    \xmacro@code
  }
\cs_new_protected_nopar:Npn \__fdudoc_marco_code:w
  {
    \ifcodeline@index
      \__fdudoc_marco_code_every_par:n { \__fdudoc_code_line_no: }
    \else:
      \__fdudoc_marco_code_every_par:n { }
    \fi:
    \__fdudoc_make_finish_tag:x { \@currenvir }
    \__fdudoc_macro_code_start:w
  }
\cs_new_protected:Npn \__fdudoc_marco_code_every_par:n #1
  {
    \everypar
      {
        \everypar {#1}
        \if@inlabel
          \global \@inlabelfalse \@noparlistfalse
          \llap { \box \@labels \hskip \leftskip }
        \fi
        #1
      }
  }
\group_begin:
  \int_set:Nn \tex_endlinechar:D { -1 }
  \use:n
    {
      \char_set_catcode_active:n { 32 }
      \tl_const:Nn \c__fdudoc_active_space_tl
    }
    { }
\group_end:
\group_begin:
  \char_set_catcode_active:n { 13 }
  \cs_new_protected:Npx \__fdudoc_make_finish_tag:n #1
    {
      \tl_set:Nn \exp_not:N \l__fdudoc_macro_code_finish_tl
        {
          \c_percent_str
          \prg_replicate:nn { 4 }
            { \exp_not:o { \c__fdudoc_active_space_tl } }
          \exp_not:o { \active@escape@char } end
          \c_left_brace_str #1 \c_right_brace_str
          \exp_not:N ^^M
        }
    }
  \cs_generate_variant:Nn \__fdudoc_make_finish_tag:n { x }
  \cs_new_protected:Npn \__fdudoc_macro_code_start:w #1
    {
      \str_if_eq:nnTF {#1} { ^^M }
        { \__fdudoc_macro_code_read_line:w }
        { \__fdudoc_macro_code_read_line:w #1 }
    }
  \cs_new_protected:Npn \__fdudoc_macro_code_read_line:w #1 ^^M
    {
      \tl_set:Nn \l__fdudoc_macro_code_line_tl { #1 ^^M }
      \tl_if_eq:NNTF
        \l__fdudoc_macro_code_line_tl \l__fdudoc_macro_code_finish_tl
        { \exp_args:Nx \end { \@currenvir } }
        {
          \__fdudoc_macro_code_process_line:
          \__fdudoc_macro_code_read_line:w
        }
    }
  \cs_new_protected:Npn \__fdudoc_swap_cr:
    {
      \exp_after:wN
        \__fdudoc_swap_cr_aux:w \l__fdudoc_macro_code_line_tl
    }
  \cs_new_protected:Npn \__fdudoc_swap_cr_aux:w #1 ^^M
    {
      \group_insert_after:N ^^M
      \tl_set:Nn \l__fdudoc_macro_code_line_tl {#1}
    }
  \tl_const:Nn \c__fdudoc_active_cr_tl { ^^M }
\group_end:
\tl_new:N \l__fdudoc_macro_code_line_tl
\tl_new:N \l__fdudoc_macro_code_finish_tl
\tl_new:N \g__fdudoc_macro_code_verbatim_stop_tl
\cs_new_protected_nopar:Npn \__fdudoc_process_normal_line:
  {
    \str_case_e:nnF
      { \str_head:N \l__fdudoc_macro_code_line_tl }
      {
        { \c_percent_str }
        {
          \__fdudoc_check_angle:x
            { \tl_tail:N \l__fdudoc_macro_code_line_tl }
        }
        { \c_hash_str }
        { \__fdudoc_output_comment_line: }
      }
      { \__fdudoc_output_line: }
  }
\cs_new_protected_nopar:Npn \__fdudoc_process_verbatim_line:
  {
    \tl_if_eq:NNTF \l__fdudoc_macro_code_line_tl
        \g__fdudoc_macro_code_verbatim_stop_tl
      {
        \tl_gclear:N \g__fdudoc_macro_code_verbatim_stop_tl
        \cs_gset_eq:NN \__fdudoc_macro_code_process_line:
          \__fdudoc_process_normal_line:
        \__fdudoc_output_module:nn
          { \color { verb@guard } }
          {
            \__fdudoc_swap_cr:
            \__fdudoc_module_pop:n { \l__fdudoc_macro_code_line_tl }
          }
      }
      { \tl_use:N \l__fdudoc_macro_code_line_tl }
  }
\cs_new_eq:NN \__fdudoc_macro_code_process_line:
  \__fdudoc_process_normal_line:
\DeclareDocumentCommand \CheckModules { }
  {
    \cs_set_eq:NN \__fdudoc_macro_code_process_line:
      \__fdudoc_process_normal_line:
  }
\DeclareDocumentCommand \DontCheckModules { }
  {
    \cs_set_eq:NN \__fdudoc_macro_code_process_line:
      \__fdudoc_output_line:
  }
\cs_new_protected:Npn \__fdudoc_check_angle:n #1
  {
    \str_if_eq:eeTF { \str_head:n {#1} } { < }
      { \__fdudoc_check_module:x { \tl_tail:n {#1} } }
      { \__fdudoc_output_comment_line: }
  }
\cs_generate_variant:Nn \__fdudoc_check_angle:n { x }
\cs_new_protected:Npn \__fdudoc_check_module:n #1
  {
    \str_case_e:nnF { \str_head:n {#1} }
      {
        { * } { \__fdudoc_module_star:w }
        { / } { \__fdudoc_module_slash:w }
        { @ } { \__fdudoc_module_at:w }
        { < } { \__fdudoc_module_verb:w }
      }
      { \__fdudoc_module_pm:w }
    #1 \q_stop
  }
\cs_generate_variant:Nn \__fdudoc_check_module:n { x }
\group_begin:
  \char_set_catcode_active:N \>
  \cs_new_protected:Npn \__fdudoc_module_star:w #1 > #2 \q_stop
    {
      \tl_set:Nn \l__fdudoc_tmpa_tl {#2}
      \tl_if_eq:NNTF \l__fdudoc_tmpa_tl \c__fdudoc_active_cr_tl
        {
          \__fdudoc_output_module:nn
            { \__fdudoc_star_color: }
            {
              \__fdudoc_module_push:n
                { \__fdudoc_module_angle:n {#1} }
            }
        }
        {
          \__fdudoc_output_module_left:nn
            { \__fdudoc_star_color: }
            {
              \__fdudoc_module_push:n
                { \__fdudoc_module_angle:n {#1} }
            }
        }
      \__fdudoc_output_line:n {#2}
    }
  \cs_new_protected:Npn \__fdudoc_module_slash:w #1 > #2 \q_stop
    {
      \tl_set:Nn \l__fdudoc_tmpa_tl {#2}
      \tl_if_eq:NNTF \l__fdudoc_tmpa_tl \c__fdudoc_active_cr_tl
        {
          \__fdudoc_output_module:nn
            { \__fdudoc_slash_color: }
            {
              \__fdudoc_module_pop:n
                { \__fdudoc_module_angle:n {#1} }
            }
        }
        {
          \__fdudoc_output_module_left:nn
            { \__fdudoc_slash_color: }
            {
              \__fdudoc_module_pop:n
                { \__fdudoc_module_angle:n {#1} }
            }
        }
      \__fdudoc_output_line:n {#2}
    }
  \cs_new_protected:Npn \__fdudoc_module_at:w @ @ = #1 > #2 \q_stop
    {
      \__fdudoc_output_module:nn
        { \color { at@guard } }
        { \__fdudoc_module_angle:n { @ @ = #1 } }
      \tl_gset:Nn \g__codedoc_module_name_tl {#1}
      \__fdudoc_output_line:n {#2}
    }
  \cs_new_protected:Npn \__fdudoc_module_verb:w #1 \q_stop
    {
      \cs_gset_eq:NN \__fdudoc_macro_code_process_line:
        \__fdudoc_process_verbatim_line:
      \tl_gset:Nx \g__fdudoc_macro_code_verbatim_stop_tl
        { \c_percent_str \tl_tail:n {#1} }
      \__fdudoc_output_module:nn
        { \color { verb@guard } }
        {
          \__fdudoc_swap_cr:
          \__fdudoc_module_push:n { \l__fdudoc_macro_code_line_tl }
        }
    }
  \cs_new_protected:Npn \__fdudoc_module_pm:w #1 > #2 \q_stop
    {
      \__fdudoc_output_module_left:nn
        { \__fdudoc_pm_color: }
        { \__fdudoc_module_angle:n {#1} }
      \__fdudoc_output_line:n {#2}
    }
\group_end:
\cs_new_protected:Npn \__fdudoc_output_line:n #1
  {
    \tl_set:Nn \l__fdudoc_macro_code_line_tl {#1}
    \tl_if_eq:NNTF
      \l__fdudoc_macro_code_line_tl \c__fdudoc_active_cr_tl
      { \tl_use:N \l__fdudoc_macro_code_line_tl }
      {
        \str_if_eq:eeTF
          { \str_head:N \l__fdudoc_macro_code_line_tl } { \c_percent_str }
          { \__fdudoc_output_comment_line: } { \__fdudoc_output_line: }
      }
  }
\cs_new_protected_nopar:Npn \__fdudoc_output_line:
  {
    \tex_noindent:D
    \__fdudoc_replace_at_at:N \l__fdudoc_macro_code_line_tl
    \tl_use:N \l__fdudoc_macro_code_line_tl
  }
\cs_new_protected:Npn \__fdudoc_output_comment_line:
  {
    \tex_noindent:D
    \group_begin:
      \__fdudoc_swap_cr:
      \color { code@gray } \slshape \__fdudoc_output_line:
    \group_end:
  }
\cs_new_protected:Npn \__fdudoc_replace_at_at:N #1
  {
    \tl_if_empty:NF \g__codedoc_module_name_tl
      { \__fdudoc_replace_at_at_aux:No #1 \g__codedoc_module_name_tl }
  }
\cs_new_protected:Npn \__fdudoc_replace_at_at_aux:Nn #1#2
  {
    \tl_replace_all:Nnn #1 { _ @ @ } { _ _ #2 }
    \tl_replace_all:Nnn #1 {   @ @ } { _ _ #2 }
  }
\cs_generate_variant:Nn \__fdudoc_replace_at_at_aux:Nn { No }
\cs_new_protected_nopar:Npn \__fdudoc_module_push:n
  { \__fdudoc_module_push_aux:on { \int_use:N \c@HD@hypercount } }
\cs_new_protected:Npn \__fdudoc_module_push_aux:nn #1
  {
    \seq_gpush:Nn \g__fdudoc_module_dest_seq {#1}
    \hypersetup { hidelinks }
    \exp_args:Nx \hdclindex
      { \zref@extractdefault { HD.#1 } { guard@end } { 1 } } { }
  }
\cs_generate_variant:Nn \__fdudoc_module_push_aux:nn { on }
\cs_new_protected_nopar:Npn \__fdudoc_module_pop:n
  {
    \seq_gpop:NNTF \g__fdudoc_module_dest_seq \l__fdudoc_tmpa_tl
      { \__fdudoc_module_pop_aux:on { \l__fdudoc_tmpa_tl } }
      { \BOOM \use:n }
  }
\cs_new_protected:Npn \__fdudoc_module_pop_aux:nn #1
  {
    \zref@labelbylist { HD.#1 } { fdudoc }
    \hypersetup { hidelinks }
    \hdclindex {#1} { }
  }
\cs_generate_variant:Nn \__fdudoc_module_pop_aux:nn { on }
\seq_new:N \g__fdudoc_module_dest_seq
\zref@newlist { fdudoc }
\zref@newprop { guard@end } [ 1 ]
  { \int_eval:n { \c@HD@hypercount - 1 } }
\zref@addprop { fdudoc } { guard@end }
\cs_set_protected:Npn \MacroFont
  {
    \linespread { 1.05 }
    \small \ttfamily \mdseries \upshape
    \__fdudoc_verb_addon:
  }
\cs_new_protected:Npn \__fdudoc_output_module:nn #1#2
  {
    \tex_noindent:D
    \group_begin:
      #1
      \footnotesize \normalfont \sffamily #2
    \group_end:
  }
\cs_new_protected:Npn \__fdudoc_output_module_left:nn #1#2
  {
    \tex_noindent:D
    \hbox_overlap_left:n
      {
        \__fdudoc_output_module:nn {#1} {#2}
        \skip_horizontal:n { \leftskip + \smallskipamount }
      }
  }
\cs_new_protected_nopar:Npn \__fdudoc_star_color:
  {
    \seq_gpop:NNTF \g__fdudoc_star_color_seq \current@color
      { \set@color }
      { \__fdudoc_select_color: }
    \seq_gpush:No \g__fdudoc_slash_color_seq { \current@color }
  }
\cs_new_protected_nopar:Npn \__fdudoc_slash_color:
  {
    \seq_gpop:NNTF \g__fdudoc_slash_color_seq \current@color
      {
        \set@color
        \seq_gpush:No \g__fdudoc_star_color_seq { \current@color }
      }
      { \BOOM }
  }
\cs_new_protected_nopar:Npn \__fdudoc_pm_color:
  {
    \seq_get:NNTF \g__fdudoc_star_color_seq \current@color
      { \set@color }
      {
        \__fdudoc_select_color:
        \seq_gpush:No \g__fdudoc_star_color_seq { \current@color }
      }
  }
\seq_new:N \g__fdudoc_star_color_seq
\seq_new:N \g__fdudoc_slash_color_seq
\cs_new_protected_nopar:Npn \__fdudoc_select_color:
  { \color { guard@series!!+ } }
\definecolorseries { guard@series }
  { cmyk } { last } { blue } { purple }
\resetcolorseries [ 3 ] { guard@series }
\definecolor { verb@guard } { named } { MaterialLime600 }
\definecolor { at@guard   } { named } { MaterialPink    }
\definecolor { code@gray  } { named } { MaterialGrey    }
\cs_new_protected:Npn \__fdudoc_module_angle:n #1
  { < #1 > }
\cs_new_protected_nopar:Npn \__fdudoc_code_line_no:
  {
    \int_gincr:N \c@CodelineNo
    \hbox_overlap_left:n
      {
        \hbox_to_wd:nn
          { \MacroIndent }
          {
            \HD@target
            \tex_hss:D \__fdudoc_code_line_no_style:
            \theCodelineNo \enspace
          }
        \tex_kern:D \@totalleftmargin
      }
  }
\tl_set:Nn \theCodelineNo { \arabic { CodelineNo } }
\cs_new_protected_nopar:Npn \__fdudoc_code_line_no_style:
  { \color { code@gray } \normalfont \sffamily \tiny }
\cs_set_protected:Npn \HD@SetMacroIndent #1
  {
    \group_begin:
      \settowidth \MacroIndent
        {
          \__fdudoc_code_line_no_style:
          \prg_replicate:nn { \tl_count:n {#1} } { 0 }
          \enspace
        }
      \dim_gset_eq:NN \MacroIndent \MacroIndent
    \group_end:
  }
\sys_if_engine_xetex:TF
  {
    \cs_set_eq:NN \__fdudoc_verb_addon: \xeCJKVerbAddon
    \cs_set:Nn \__fdudoc_plain_punct_style:
      { \xeCJKsetup { PunctStyle = plain } }
    \cs_set:Nn \__fdudoc_disable_ecglue:
      { \xeCJKsetup { CJKecglue } }
    \__fdudoc_appto_cmd:Nn \meta@font@select
      { \mode_if_inner:T { \__fdudoc_disable_ecglue: } }
  }
  {
    \cs_set_eq:NN \__fdudoc_verb_addon:        \prg_do_nothing:
    \cs_set_eq:NN \__fdudoc_plain_punct_style: \prg_do_nothing:
    \cs_set:Nn \__fdudoc_disable_ecglue:
      { \ltjsetparameter { autoxspacing = false } }
    \__fdudoc_appto_cmd:Nn \meta@font@select
      { \__fdudoc_disable_ecglue: }
  }
\BeforeBeginEnvironment { function }
  { \par \nointerlineskip }
\AtEndEnvironment { function }
  {
    \par
    \cs_gset:Nx \__fdudoc_fix_previous_depth:
      { \prevdepth = \the \prevdepth \space }
  }
\AfterEndEnvironment { function }
  { \__fdudoc_fix_previous_depth: }
\AtBeginEnvironment { syntax }
  {
    \linespread { 1.2 }
    \__fdudoc_plain_punct_style:
    \__fdudoc_disable_ecglue:
  }
\AtBeginEnvironment { ccnusyntax }
  {
    \cs_set:Npn \lparen { \textup { ( } }
    \cs_set:Npn \rparen { \textup { ) } }
    \char_set_catcode_active:N |
    \char_set_catcode_active:N <
    \char_set_catcode_active:N (
    \char_set_active_eq:NN | \orbar
    \char_set_active_eq:NN < \syntaxopt@aux
    \char_set_active_eq:NN ( \defaultval@aux
  }
\cs_new_eq:NN \__fdudoc_ltx_changes:nnn \changes@
\cs_set_protected:Npn \changes@ #1#2
  {
    \__fdudoc_save_version_date:nn {#1} {#2}
    \__fdudoc_ltx_changes:nnn {#1} {#2}
  }
\prop_new:N \g__fdudoc_version_date_prop
\cs_new_protected:Npn \__fdudoc_save_version_date:nn #1#2
  {
    \prop_get:NnNTF \g__fdudoc_version_date_prop
      {#1} \l__fdudoc_tmpa_tl
      {
        \exp_after:wN
          \__fdudoc_save_version_date_aux:nnnn \l__fdudoc_tmpa_tl
        {#2} {#1}
      }
      { \__fdudoc_save_version_date_aux:nnn {#1} {#2} {#2} }
  }
\cs_new_protected:Npn \__fdudoc_save_version_date_aux:nnnn #1#2#3#4
  {
    \__fdudoc_if_date_later:nnTF {#1} {#3}
      { \__fdudoc_save_version_date_aux:nnn {#4} {#3} {#2} }
      {
        \__fdudoc_if_date_later:nnT {#3} {#2}
          { \__fdudoc_save_version_date_aux:nnn {#4} {#1} {#3} }
      }
  }
\cs_new_protected:Npn \__fdudoc_save_version_date_aux:nnn #1#2#3
  { \prop_gput:Nnn \g__fdudoc_version_date_prop {#1} { {#2} {#3} } }
\prg_new_conditional:Npnn \__fdudoc_if_date_later:nn #1#2 { TF, T }
  {
    \if_int_compare:w
        \__fdudoc_parse_date:w #1 / / / 0 \q_stop >
        \__fdudoc_parse_date:w #2 / / / 0 \q_stop \exp_stop_f:
      \prg_return_true:
    \else:
      \prg_return_false:
    \fi:
  }
\cs_new:Npn \__fdudoc_parse_date:w #1/#2/#3/ #4 \q_stop
  { #1#2#3 }
\cs_new_protected:Npn \CTEX@versionitem #1 \efill
  {
    \@idxitem
    \prop_get:NnNTF \g__fdudoc_version_date_prop
      {#1} \l__fdudoc_tmpa_tl
      {
        \exp_after:wN
          \__fdudoc_print_version_date:nnn \l__fdudoc_tmpa_tl
        {#1}
      }
      { \BOOM }
  }
\cs_new_protected:Npn \__fdudoc_print_version_date:nnn #1#2#3
  {
    \noindent
    \Hy@raisedlink { \belowpdfbookmark {#3} { HD.#3 } }
    \textbf {#3} \hfill
    \hbox:n
      {
        \footnotesize
        \str_if_eq:nnTF {#1} {#2}
          { ( #1 ) } { ( #1 ~ -- ~ #2 ) }
      }
    \par \nopagebreak
  }
\ctex_patch_cmd:Nnn \HDorg@theglossary
  { \let \item \@idxitem }
  { \let \item \CTEX@versionitem }
\ctex_patch_cmd:Nnn \@wrglossary
  { hdpindex }
  {
    \ifnum \c@HD@hypercount = \z@
      hdpindex
    \else
      hdclindex { \the \c@HD@hypercount }
    \fi
  }
\ctex_patch_cmd:Nnn \@addtocurcol
  { \vskip \intextsep }
  {
    \edef \save@first@penalty { \the \lastpenalty } \unpenalty
    \ifnum \lastpenalty = \@M
      \unpenalty
    \else
      \penalty \save@first@penalty \relax
    \fi
    \ifnum \outputpenalty < -\@Mii
      \addvspace\intextsep
      \vskip\parskip
    \else
      \addvspace\intextsep
    \fi
  }
\ctex_patch_cmd:Nnn \@addtocurcol
  {
    \vskip \intextsep
    \ifnum \outputpenalty < -\@Mii
      \vskip -\parskip
    \fi
  }
  {
    \ifnum \outputpenalty < -\@Mii
      \aftergroup \vskip \aftergroup \intextsep
      \aftergroup \nointerlineskip
    \else
      \vskip \intextsep
    \fi
  }
\ctex_patch_cmd:Nnn \@getpen { \@M } { \@Mi }
\ctex_patch_cmd:Nnn \l@section    { 2.5em } { 1.5em }
\ctex_patch_cmd:Nnn \l@subsection { 2.5em } { 1.5em }
\__fdudoc_preto_cmd:Nn \@thehead
  { \cs_set_eq:cN { MakeUppercase \space } \@iden }
\ctex_patch_cmd:Nnn \HDorg@thebibliography
  { \section* } { \section }
\cs_set_eq:NN \thebibliography \HDorg@thebibliography
\__fdudoc_appto_cmd:Nn \GlossaryParms
  {
    \raggedcolumns
    \cs_set_eq:NN \Hy@writebookmark \HDorg@writebookmark
    \cs_set:Npn \@idxitem   { \par \hangindent 2em }
    \cs_set:Npn \subitem    { \@idxitem \hspace* { 1em } }
    \cs_set:Npn \subsubitem { \@idxitem \hspace* { 2em } }
  }
\ctex_patch_cmd:Nnn \HoLogo@LaTeXe
  { \hbox { \HOLOGO@MathSetup 2 $ _{ \textstyle \varepsilon } $ } }
  {
    \hbox
      {
        \mathsurround 0pt \relax
        2
        \if b \expandafter \@car \f@series \@nil
          $ _{ \textstyle \symbf { \varepsilon } } $
        \else
          $ _{ \textstyle \varepsilon } $
        \fi
      }
  }
\ctex_patch_cmd:Nnn \SpecialMainEnvIndex
  { (environment) } { ~ 环境 }
\ctex_patch_cmd:Nnn \SpecialMainEnvIndex
  { environments: } { 环境： }
\ctex_patch_cmd:Nnn \HDorg@SpecialEnvIndex
  { (environment) } { ~ 环境 }
\ctex_patch_cmd:Nnn \HDorg@SpecialEnvIndex
  { environments: } { 环境： }
\cs_set_eq:NN \list \__codedoc_oldlist:nn
\__fdudoc_patch_cmd:Nnn \__codedoc_function_descr_start:w
  { \noindent }
  { \skip_vertical:n { -\parskip } \noindent }
\__fdudoc_preto_cmd:Nn \__codedoc_function_assemble:
  {
    \box_if_empty:NTF \g__codedoc_syntax_box
      { \skip_zero:N \medskipamount }
      { \skip_add:Nn \medskipamount { \parskip } }
  }
\__fdudoc_patch_cmd:Nnn \__codedoc_typeset_functions:
  { \small \ttfamily } { \footnotesize \ttfamily }
\__fdudoc_preto_cmd:Nn \__codedoc_typeset_functions:
  { \MacroFont }
\__fdudoc_patch_cmd:Nnn \__codedoc_macro_init:
  { \hbox:n } { \MacroFont \hbox:n }
\__fdudoc_patch_cmd:Nnn \__codedoc_macro_dump:
  { \hbox_unpack_drop:N } { \MacroFont \hbox_unpack_drop:N }
\__fdudoc_patch_cmd:Nnn \__codedoc_meta_original:n
  { \ensuremath \langle } { \textlangle }
\__fdudoc_patch_cmd:Nnn \__codedoc_meta_original:n
  { \ensuremath \rangle } { \textrangle }
\cs_set_eq:NN \__codedoc_macro_end_style:n \use_none:n
\cs_set_protected:Npn \__codedoc_typeset_TF:
  {
    \group_begin:
      \exp_args:No \__codedoc_if_macro_internal:nT \l__codedoc_tmpa_tl
        { \color [ gray ] { 0.5 } }
      \itshape TF
      \makebox [ 0 pt ] [ r ]
        {
          \color { red }
          \underline { \phantom { \itshape TF } \kern -0.1 em }
        }
    \group_end:
  }
\cs_set_protected:Npn \__codedoc_macro_typeset_one:nN #1#2
  {
    \vbox_set:Nn \l__codedoc_macro_box
      {
        \MacroFont
        \vbox_unpack_drop:N \l__codedoc_macro_box
        \hbox_set:Nn \l_tmpa_box
          { \__codedoc_print_macroname:nN {#1} #2 }
        \dim_set:Nn \l_tmpa_dim
          { \marginparwidth - \labelsep - \marginparsep }
        \dim_compare:nNnT { \box_wd:N \l_tmpa_box } > \l_tmpa_dim
          {
            \box_resize_to_wd_and_ht:Nnn \l_tmpa_box
              { \l_tmpa_dim } { \box_ht:N \l_tmpa_box }
          }
        \hbox_overlap_left:n
          {
            \box_use:N \l_tmpa_box
            \skip_horizontal:n { \marginparsep - \labelsep }
          }
      }
    \int_incr:N \l__codedoc_macro_int
  }
\cs_set_protected:Npn \__codedoc_print_macroname:nN #1#2
  {
    \strut
    \__codedoc_get_hyper_target:xN
      {
        \exp_not:n {#1}
        \bool_if:NT #2 { \tl_to_str:n {TF} }
      }
      \l__codedoc_tmpa_tl
    \cs_if_exist:cTF { r@ \l__codedoc_tmpa_tl }
      { \exp_args:NNo \label@hyperref [ \l__codedoc_tmpa_tl ] }
      { \use:n }
      {
        \tl_set:Nn \l__codedoc_tmpa_tl {#1}
        \tl_replace_all:Non \l__codedoc_tmpa_tl
          { \c_catcode_other_space_tl }
          { \fontspec_visible_space: }
        \__codedoc_macroname_prefix:o \l__codedoc_tmpa_tl
        \__codedoc_macroname_suffix:N #2
      }
  }
\cs_set_protected:Npn \__codedoc_special_index_module:nnnnN #1#2#3#4#5
  {
    \use:x
      {
        \exp_not:n { \__codedoc_special_index_aux:nnnnnnn {#1} {#2} }
          \tl_if_empty:nTF {#3}
            { { } { } { } { } }
            {
              \str_if_eq:eeTF {#3} { TeX }
                {
                  { TeX~ and~ LaTeX2e }
                  { \string \TeX{}~ 和~ \string \LaTeXe{} }
                }
                { {#3} { \string \pkg {#3} } }
              \bool_if:NTF #5
                { { commands~ internal } { ~ 内部命令： } }
                { { commands           } { ~ 命令：     } }
            }
      }
    {#4}
  }
\cs_new_protected:Npn \__codedoc_special_index_aux:nnnnnnn #1#2#3#4#5#6#7
  {
    \tl_set:Nn \l__codedoc_index_escaped_key_tl {#1}
    \__codedoc_quote_special_char:N \l__codedoc_index_escaped_key_tl
    \__codedoc_special_index_set:Nn
      \l__codedoc_index_escaped_macro_tl {#2}
    \str_if_eq:onTF { \@currenvir } { macrocode }
      { \codeline@wrindex }
      {
        \str_case:nnF {#7}
          {
            { main  } { \codeline@wrindex }
            { usage } { \index }
          }
          { \HD@target \index }
      }
      {
        \tl_if_empty:nF { #3 #4 #5 #6 }
          { #3 #5 \actualchar #4 #6 \levelchar }
        \l__codedoc_index_escaped_key_tl
        \actualchar
        {
          \token_to_str:N \verbatim@font \c_space_tl
          \l__codedoc_index_escaped_macro_tl
        }
        \encapchar
        hdclindex { \the \c@HD@hypercount } {#7}
      }
  }
\DeclareDocumentCommand \StopSpecialIndexModule { }
  {
    \cs_set_eq:NN
      \__codedoc_special_index_module:nnnnN \use_none:nnnnn
  }
\tl_map_inline:nn { \actualchar \encapchar \levelchar }
  { \exp_args:Nx \DoNotIndex { \bslash \tl_to_str:N #1 } }
\RenewDocumentCommand \meta { m }
  {
    \group_begin:
      \sys_if_engine_xetex:T { \xeCJKsetup { CJKecglue = { } } }
      \__codedoc_meta:n {#1}
    \group_end:
  }
\msg_redirect_name:nnn { l3doc } { foreign-internal    } { log }
\msg_redirect_name:nnn { l3doc } { print-changes-howto } { log }
\msg_redirect_name:nnn { l3doc } { print-index-howto   } { log }
\ExplSyntaxOff
\AtBeginDocument{%
  \addtocontents{toc}{\StopSpecialIndexModule}}
\pdfstringdefDisableCommands{%
  \let\path\meta
  \let\opt\@firstofone}
\let\@multitoc@starttoc\@starttoc
\renewcommand*\@starttoc[1]{%
  \begin{multicols}{2}%
    \@multitoc@starttoc{#1}%
  \end{multicols}}
\renewcommand\@makefntext[1]{\parindent 0em\noindent\@makefnmark~#1}
\IndexPrologue{%
  \section{\indexname}%
  \textit{意大利体的数字表示对应索引项出现的页码；
    带下划线的数字表示定义对应索引项的代码行号；
    其他则表示使用对应索引项的代码行号。}}
\def\IndexLayout{%
  \newgeometry{%
    left   = 0.85 in,
    right  = 0.85 in,
    top    = 1.25 in,
    bottom = 1.00 in}%
  \setlength\IndexMin{0.5\textheight}%
  \ctexset{section/numbering=false}%
  \StopSpecialIndexModule}
\def\indexname{代码索引}
\GlossaryPrologue{\section{\glossaryname}}
\def\glossaryname{修订记录}
\setmainfont{LibertinusSerif}[%
  Extension      = .otf,
  UprightFont    = *-Regular,
  BoldFont       = *-Bold,
  ItalicFont     = *-Italic,
  BoldItalicFont = *-BoldItalic,
  Scale          = 1.1]
\setsansfont{IBMPlexSansCondensed}[%
  Extension      = .otf,
  UprightFont    = *-Regular,
  BoldFont       = *-Bold,
  ItalicFont     = *-Italic,
  BoldItalicFont = *-BoldItalic]
% \setmonofont{Iosevka Slab}[%
%   UprightFont    = * Light,
%   BoldFont       = * Semibold,
%   ItalicFont     = * Light Oblique,
%   BoldItalicFont = * Semibold Oblique,
%   Scale          = MatchLowercase]
\setmonofont{cmun}[%
  Extension      = .otf,
  UprightFont    = *btl,
  BoldFont       = *tb,
  ItalicFont     = *bto,
  BoldItalicFont = *tx,
  HyphenChar     = None]
\setmathfont{LibertinusMath-Regular.otf}
\setmathfont {NewCMMath-Book}
  [
    Extension    = .otf,
    StylisticSet = 1,
    range        = { \subsetneqq, \supsetneqq, \checkmark} ,
  ]
\setCJKmainfont{Source Han Serif SC}[%
  ItalicFont     = FZKai-Z03,
  CharacterWidth = Full]
\setCJKsansfont{Source Han Sans SC}[%
  ItalicFont     = *,
  CharacterWidth = Full]
\setCJKmonofont{Source Han Sans SC}[%
  UprightFont    = * Normal,
  BoldFont       = * Bold,
  AutoFakeSlant  = 0.1763,  % = tan(10 deg)
  Scale          = 0.8903,
  CharacterWidth = Full]
\ctexset{%
  section/name        = {第,节},
  section/format+     = \raggedright,
  paragraph/runin     = false,
  paragraph/numbering = false,
  punct               = kaiming}
\xeCJKsetwidth{·}{0.5em}
\setcounter{secnumdepth}{4}
\setcounter{tocdepth}{3}
\pagestyle{plain}
\sisetup{%
  inter-unit-product = \ensuremath{{}\cdot{}},
  range-phrase       = {--},
  uncertainty-mode   = separate}
\hypersetup{%
  bookmarksdepth    = 4,
  bookmarksnumbered = true,
  colorlinks        = true,
  citecolor         = MaterialGreen,
  linkcolor         = MaterialPink,
  urlcolor          = MaterialIndigo}
\captionsetup{labelsep=quad, font+=bf}
\newcolumntype{C}{>{\centering\arraybackslash}X}
\setlist{noitemsep, topsep=\smallskipamount}
\setlist[1]{labelindent=\parindent}
\setlist[enumerate]{leftmargin=*}
\setlist[itemize]{leftmargin=*}
\newlist{optdesc}{description}{3}
\setlist[optdesc]{%
  font          = \mdseries\small\ttfamily,
  align         = right,
  listparindent = \parindent,
  labelsep      = \marginparsep,
  labelindent   = -\marginparsep,
  leftmargin    = *}
\renewlist{tablenotes}{description}{1}
\setlist[tablenotes]{%
  format      = \normalfont\itshape\tnote@item,
  labelwidth  = 0.5em,
  itemindent  = 0pt,
  rightmargin = \tabcolsep,
  leftmargin  = \the\dimexpr\tabcolsep+1em\relax,
  after       = \@noparlisttrue}
\AtBeginEnvironment{tablenotes}{%
  \setlength\parindent{2\ccwd}%
  \normalfont\footnotesize}
\AtBeginEnvironment{threeparttable}{%
  \stepcounter{tpt@id}%
  \edef\curr@tpt@id{tpt@\arabic{tpt@id}}}
\newcounter{tpt@id}
\def\tnote@item#1{%
  \Hy@raisedlink{\hyper@anchor{\curr@tpt@id-#1}}#1}
\def\TPTtagStyle#1{\textit{\hyperlink{\curr@tpt@id-#1}{#1}}}
\def\UrlAlphabet{%
  \do\a\do\b\do\c\do\d\do\e\do\f\do\g\do\h\do\i\do\j%
  \do\k\do\l\do\m\do\n\do\o\do\p\do\q\do\r\do\s\do\t%
  \do\u\do\v\do\w\do\x\do\y\do\z\do\A\do\B\do\C\do\D%
  \do\E\do\F\do\G\do\H\do\I\do\J\do\K\do\L\do\M\do\N%
  \do\O\do\P\do\Q\do\R\do\S\do\T\do\U\do\V\do\W\do\X%
  \do\Y\do\Z}
\def\UrlDigits{%
  \do\1\do\2\do\3\do\4\do\5\do\6\do\7\do\8\do\9\do\0}
\g@addto@macro\UrlBreaks{\UrlOrds}
\g@addto@macro\UrlBreaks{\UrlAlphabet}
\g@addto@macro\UrlBreaks{\UrlDigits}
\DoNotIndex{\begin,\end,
  \a,\b,\c,\d,\e,\f,\g,\h,\i,\j,\k,\l,\m,
  \n,\o,\p,\q,\r,\s,\t,\u,\v,\w,\x,\y,\z,
  \A,\B,\C,\D,\E,\F,\G,\H,\I,\J,\K,\L,\M,
  \N,\O,\P,\Q,\R,\S,\T,\U,\V,\W,\X,\Y,\Z,
  \0,\1,\2,\3,\4,\5,\6,\7,\8,\9}
\EnableCrossrefs
\CodelineIndex
\RecordChanges
\newcommand*\exptarget{\Hy@raisedlink{\hypertarget{expstar}{}}}
\newcommand*\rexptarget{\Hy@raisedlink{\hypertarget{rexpstar}{}}}
\newcommand*\expstar{\hyperlink{expstar}{$^^^^263b$}}
\newcommand*\rexpstar{\hyperlink{rexpstar}{$^^^^263a$}}
\ExplSyntaxOn
\cs_set_eq:NN \__codedoc_typeset_exp:  \expstar
\cs_set_eq:NN \__codedoc_typeset_rexp: \rexpstar
\ExplSyntaxOff
\renewcommand*\marg[1]{\{\meta{#1}\}}
\renewcommand*\oarg[1]{[\meta{#1}]}
\renewcommand*\parg[1]{(\meta{#1})}
\DeclareDocumentCommand\opt{m}{\texttt{#1}}
\DeclareDocumentCommand\kvopt{mm}
  {\texttt{#1\breakablethinspace=\breakablethinspace#2}}
\def\breakablethinspace{\hskip 0.16667em\relax}
\def\syntaxopt#1{\textit{#1}}
\def\defaultval#1{\textbf{\textup{#1}}}
\def\syntaxopt@aux#1>{\syntaxopt{#1}}
\def\defaultval@aux#1){\defaultval{#1}}
\def\orbar{\textup{\textbar}}
\def\TF{true\orbar false}
\def\TTF{\defaultval{true}\orbar false}
\def\TFF{true\orbar\defaultval{false}}
\DeclareDocumentEnvironment{arguments}{}
  {\enumerate[%
    label={\texttt{\#\arabic*:~}}, labelsep=0pt, nolistsep]}%
  {\endenumerate}
\def\TeX{\hologo{TeX}}
\def\LaTeX{\hologo{LaTeX}}
\def\LaTeXe{\hologo{LaTeXe}}
\def\pdfTeX{\hologo{pdfTeX}}
\def\pdfLaTeX{\hologo{pdfLaTeX}}
\def\XeTeX{\hologo{XeTeX}}
\def\XeLaTeX{\hologo{XeLaTeX}}
\def\LuaTeX{\hologo{LuaTeX}}
\def\LuaLaTeX{\hologo{LuaLaTeX}}
\def\AmSLaTeX{\hologo{AmSLaTeX}}
\def\TeXLive{\TeX\ Live}
\def\MiKTeX{\hologo{MiKTeX}}
\def\BibTeX{\hologo{BibTeX}}
\def\BibTeX{\hologo{BibTeX}}
\def\biber{\hologo{biber}}
\def\TikZ{Ti\emph{k}Z}
\renewcommand*\env[1]{\textbf{\texttt{#1}}}
\newcommand*\bashcmd[1]{\texttt{#1}}
\lst@CCPutMacro\lst@ProcessOther {"2D}{\lst@ttfamily{-{}}{-{}}}
\@empty\z@\@empty
\lstdefinestyle{style@base}
  {
    basewidth       = 0.5 em,
    gobble          = 2,
    lineskip        = 2 pt,
    frame           = l,
    framerule       = 1 pt,
    framesep        = 3 pt,
    escapeinside    = {(*}{*)},
    basicstyle      = \small\ttfamily\color{MaterialGrey900},
    keywordstyle    = \bfseries\color{MaterialIndigo},
    commentstyle    = \itshape\color{MaterialGrey600},
    stringstyle     = \color{MaterialRed},
    backgroundcolor = \color{MaterialGrey50}
  }
\lstdefinestyle{style@shell}
  {
    style      = style@base,
    rulecolor  = \color{MaterialPink},
    language   = bash,
    alsoletter = {-},
    emphstyle  = \color{MaterialGreen800}
  }
\lstdefinestyle{style@latex}
  {
    style      = style@base,
    rulecolor  = \color{MaterialIndigo},
    language   = [LaTeX]TeX,
    alsoletter = {*, -},
    texcsstyle = *\color{MaterialDeepOrange},
    emphstyle  = [1]\color{MaterialGreen800},
    emphstyle  = [2]\color{MaterialTeal},
    morekeywords={document},
    autogobble  = true,
    morecomment = [l][\color{gray6}\itshape]{\%},
    breaklines,
    % breakatwhitespace,
    prebreak    = {\mbox{$ \rhookswarrow $}},
    postbreak   = {\mbox{$ \lhookrightarrow $\quad}},
    breakindent = 10pt,
    % linewidth   = \linewidth
  }
\lstdefinestyle{style@syntax}
  {
    basewidth     = 0.5 em,
    gobble        = 4,
    escapeinside  = {(*}{*)},
    language      = [LaTeX]TeX,
    alsoletter    = {*, -},
    basicstyle    = \footnotesize\ttfamily\color{MaterialGrey900},
    keywordstyle  = \bfseries\color{MaterialIndigo},
    commentstyle  = \itshape\color{MaterialGrey600},
    texcsstyle    = *\color{MaterialDeepOrange},
    emphstyle     = [1]\color{MaterialGreen800},
    emphstyle     = [2]\color{MaterialTeal}
  }
\lstnewenvironment{bashcode}[1][]{%
  \lstset{style=style@shell, #1}}{}
\lstnewenvironment{shellcode}[1][]{%
  \lstset{style=style@shell, #1}}{}
\lstnewenvironment{latexcode}[1][]{%
  \lstset{style=style@latex, breaklines = true, #1}}{}
\lstnewenvironment{ccnusyntax}[1][]{%
  \lstset{style=style@syntax, #1}\vspace{-1.8ex}}{}
\lstdefinelanguage{mylatex}{
  language={[LaTeX]TeX},
  texcsstyle  =*\color{azure4}\bfseries,
  keywordstyle=\color{green5}\bfseries,
  morekeywords={document},
  autogobble  = true,
  morecomment = [l][\color{gray6}\itshape]{\%},
}

\newtcblisting{latexexample}[2][]{%
  % breakable,
  skin         = bicolor,
  colbacklower = white,
  fonttitle    = \ttfamily,
  boxrule      = 1pt, 
  toprule      = 1pt, % top rule weight
  bottomrule   = 1pt, % bottom rule weight
  left         = 2mm,
  parbox       = false,
  before upper = \indent,
  title        = {#2}, 
  #1,
  listing options = {
    language = mylatex,
    % style = tcblatex,
    numbers = left,
    % numberfirstline=true,
    stepnumber=1,
    numbersep =0pt,
    numberstyle=\tiny\color{red!75!black},
    basicstyle  = \small\ttfamily,
    breaklines,
    % breakatwhitespace,
    prebreak    = {\mbox{$ \rhookswarrow $}},
    postbreak   = {\mbox{$ \lhookrightarrow $\quad}},
    breakindent = 10pt,
    autogobble  = true,
  }
}



% make line numbers unable to be selected
% ref: https://liam.page/2013/11/04/LaTeX-listings-copy/
\ExplSyntaxOn
\newcommand\emptyaccsupp[1]{
  \BeginAccSupp{ActualText={}} #1 \EndAccSupp{}
}

\renewcommand\theFancyVerbLine{
  \emptyaccsupp{
    \textcolor[rgb]{0.5, 0.5, 1.0}{
      \scriptsize\arabic{FancyVerbLine}
    }
  }
}
\ExplSyntaxOff


% option "minted options app" has been added to tcolorbox,
%   "hooks" library since v4.21, see
%   https://github.com/T-F-S/tcolorbox/issues/73
% \makeatletter
% \tcbset{
%   % see tcbminted.code.tex, def of "minted options"
%   %   minted options/.store in=\kvtcb@minted@options,
%   minted options app/.code=\appto\kvtcb@minted@options{,#1}
% }
% \makeatother

% define new option
\fvset{gobble=0}
\tcbset{
  example options/.style={
    skin=bicolor,
    colbacklower=white,
    fonttitle=\sffamily,
    % minted options app={
    %   % line numbers
    %   linenos,
    %   numberfirstline=true,
    %   stepnumber=1,
    %   numbersep=5pt,
    %   % break point
    %   breakbefore=\\,
    % }
  },
  example title/.style 2 args={
    title=Example\ifblank{#1}{}{ #1}\ifblank{#2}{}{: #2}
  }
}


% % new env: example
% % #1 - <kv list>, tcb-listing options
% % #2 - <token list>, title
% \NewTCBListing[auto counter]{latexexample}{ O{} m }{
%   example options,
%   example title={\thetcbcounter}{#2},
%   #1
% }

% % new env: example*
% % like example, except that it is un-numbered
% \NewTCBListing{latexexample*}{ O{} m }{
%   example options,
%   example title={}{#2},
%   #1
% }
% %%
