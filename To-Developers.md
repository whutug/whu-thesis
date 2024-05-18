## 开发者备忘录

### 开发细节问题

1. `whu-thesis.cls` 中的 `%tag`、`%region`、`%endregion` 是为了配合 VS Code 插件 [Outline Map](https://github.com/Gerrnperl/outline-map) 生成代码大纲，使得光标可以快速跳转至特定位置。

2. 每次发布新的 Release，不要忘了更新 `CHANGELOG.md` 日志，也不要忘了更新 `whu-thesis.cls` 和 `whuthesis.dtx` 中的版本号和版本日期。

3. 若一个 commit 是为了解决一个特定的 issue 或者 discussion，则最好在该 commit 信息的最后加入形如 `(#15)` 的字符串，例如 `fix font bug (#15)`，github 会自动将 `#15` 转化为相应的链接。


### 开发者需要的技能

1. 需要系统学习 LaTeX3 语法，资料为 
    + [`interface3.pdf`](http://mirrors.ctan.org/macros/latex/required/l3kernel/interface3.pdf)
    + [`expl3.pdf`](http://mirrors.ctan.org/macros/latex/required/l3kernel/expl3.pdf)
2. 需要掌握常用宏包的基本用法，包括但不限于： 
    + `fancyhdr`
    + `geometry`
    + `ctex`
    + `xeCJK`
    + `enumitem`
    + `caption`
    + `fontspec`
    + `tocloft`
    + `amsmath`
    + `amsthm`
    + `hyperref`
    + `gbt7714`
    + `natbib`
    + `biblatex`
3. 需要掌握 LaTeX 的钩子机制及用法，资料为 `texdoc lthooks`
4. 需要熟悉国标 GB/T 7714-2015《信息与文献 参考文献著录规则》
5. 需要熟悉用户接口 [`usrguide.pdf`](http://mirrors.ctan.org/macros/latex/base/usrguide.pdf)
6. 需要熟悉 Git 的基本用法（科学上网工具必不可少）
7. 需要了解基本的命令行工具和指令，会写简单的自动化脚本