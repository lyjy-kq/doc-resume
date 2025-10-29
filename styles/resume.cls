% 指定 LaTeX 格式为 LaTeX2e，确保兼容性
\NeedsTeXFormat{LaTeX2e}

% 定义简历类，命名为 resume，版本为 2015/05/25，描述为优雅的简历类
\ProvidesClass{resume}[2015/05/25 An elegant Résumé class]

% 基于 article 类加载，字体大小为 11pt
\LoadClass[11pt]{article}

% 全局禁用段落缩进，设置段首缩进为 0
\setlength{\parindent}{0pt}

% 加载 xltxtra 包，提供 XeTeX 相关改进，包括 XeTeX 标志定义
\RequirePackage{xltxtra}

% 加载 xifthen 包，提供条件判断功能，用于自定义命令
\RequirePackage{xifthen}

% 加载 progressbar 包，用于创建技能进度条
\RequirePackage{progressbar}

% 加载 hyperref 包，用于支持超链接（如邮箱和 URL）
\RequirePackage{hyperref}
% 配置 hyperref，禁用超链接边框并设置透明颜色，确保无方形边框
\hypersetup{
  pdfborder = {0 0 0}, % 禁用 PDF 边框
  linkbordercolor = {0 0 0}, % 设置内部链接边框颜色为透明
  urlbordercolor = {0 0 0}, % 设置 URL 边框颜色为透明
  citebordercolor = {0 0 0} % 设置引用边框颜色为透明
}

% 加载 url 包，用于格式化 URL 地址
\RequirePackage{url}
% 设置 URL 样式为等宽字体 (tt)
\urlstyle{tt}

% 加载 fontspec 包,用于设置 XeTeX 字体
\RequirePackage{fontspec}

% 直接配置 FontAwesome 字体(不使用系统的 fontawesome 包)
\newfontfamily{\FA}[
  Path = ../../fonts/fontawesome/opentype/,
  Extension = .otf,
  Scale = 0.85
]{FontAwesome}

% 定义 faicon 命令用于显示图标
\newcommand*{\faicon}[1]{{\csname faicon@#1\endcsname}}

% 加载 FontAwesome 通用图标定义
\input{fontawesomesymbols-generic.tex}

% 加载 XeLaTeX 特定的 FontAwesome 图标定义
\input{fontawesomesymbols-xeluatex.tex}

% 设置主字体为 texgyretermes,支持多种字体样式
% 字体文件位于 fonts/Main/ 目录,扩展名为 .otf
\setmainfont[
  Path = ../../fonts/Main/, % 字体文件路径(相对于tex文件)
  Extension = .otf, % 文件扩展名
  UprightFont = *-regular, % 常规字体
  BoldFont = *-bold, % 粗体
  ItalicFont = *-italic, % 斜体
  BoldItalicFont = *-bolditalic, % 粗斜体
  SmallCapsFont = Fontin-SmallCaps % 小型大写字体
]{texgyretermes}

% 设置页面几何参数，定义页面边距和布局
\RequirePackage[
  a4paper, % 使用 A4 纸张
  left=0.6in, % 左边距 0.6 英寸
  right=0.8in, % 右边距 0.8 英寸
  top=0.4in, % 上边距 0.4 英寸
  bottom=0.6in, % 下边距 0.6 英寸
  nohead % 禁用页眉
]{geometry}

% 加载 titlesec 包，用于自定义标题格式
\RequirePackage{titlesec}

% 加载 enumitem 包，用于自定义列表样式（如 itemize）
\RequirePackage{enumitem}
% 设置全局列表样式，移除列表项之间的间距，但保留列表整体周围的间距
\setlist{noitemsep}
% 设置一级和二级 itemize 列表的样式
% topsep=0em：列表顶部间距为 0
% partopsep=0pt：列表与段落间距为 0
% itemsep=0ex：列表项间距为 0
% leftmargin=*：自动设置左边距
% labelindent=0pt：标签缩进为 0
% labelsep=0.5em：标签与内容间距为 0.5em
\setlist[itemize,1]{topsep=0em, partopsep=0pt, itemsep=0ex, leftmargin=*, labelindent=0pt, labelsep=0.5em}
\setlist[itemize,2]{topsep=0em, partopsep=0pt, itemsep=0ex, leftmargin=*, labelindent=0pt, labelsep=0.5em}

% 加载 nth 包，支持上标样式的序数词（如 1st, 2nd）
\RequirePackage[super]{nth}

% 自定义 \section 标题格式
% 使用大号字体 (\Large)，小型大写 (\scshape)，左对齐 (\raggedright)
\titleformat{\section}
{\Large\scshape\raggedright}
{}{0em} % 无标题前缀
{} % 无标题前额外代码
[\titlerule] % 在标题后添加水平线
% 设置 \section 间距
% 左边距 0cm，标题前间距 *1（约 1 倍行高），标题后间距 *1
\titlespacing*{\section}{0cm}{*1}{*1}

% 自定义 \subsection 标题格式
% 使用较大字体 (\large)，左对齐 (\raggedright)
\titleformat{\subsection}
{\large\raggedright}
{}{0em} % 无标题前缀
{} % 无标题前额外代码
% 设置 \subsection 间距
% 左边距 0cm，标题前间距 *1.8，标题后间距 *0.6
\titlespacing*{\subsection}{0cm}{*1}{*0}

% 定义带日期的 \section 命令，标题左侧显示 #1，右侧显示 #2
\newcommand{\datedsection}[2]{%
  \section[#1]{#1 \hfill #2}%
}


% #1: 左侧标题（学校和专业信息）
% #2: 中间学位（本科/硕士）
% #3: 右侧日期（斜体，若为空则留空占位）
\newcommand{\datedsubsection}[3]{%
  \subsection[#1]{%
    \noindent % 消除段落缩进
    \makebox[0.65\textwidth][l]{#1}% 左侧标题
    \hskip 1.4em % 学位前的可调间距，向右偏移
    #2% 学位，直接输出，允许手动调整（如 \qquad）
    \hspace*{\fill}% 填充剩余空间
    \makebox[0.2\textwidth][r]{\itshape\ifx#3\empty\phantom{0000.00 -- 0000.00}\else#3\fi}% 右侧日期，斜体
  }%
}



% 定义带日期的行，左侧显示 #1，右侧显示 #2
\newcommand{\datedline}[2]{%
    {\par #1 \hfill #2 \par}%
}

% 定义姓名命令，居中显示大号小型大写字体，并添加 1ex 垂直间距
\newcommand{\name}[1]{
  \centerline{\Huge\scshape{#1}}
  \vspace{1ex}
}

% 定义测试姓名命令，使用较大字体和小型大写样式
% 用法：\nameTest{<姓名>}
\newcommand{\nameTest}[1]{
    {\large\scshape{#1}}
}

% 定义邮箱命令，显示邮箱图标并创建超链接
% 用法：\email{<邮箱地址>}
\newcommand{\email}[1]{\faEnvelope\ \href{mailto:#1}{#1}}

% 定义电话命令，显示电话图标和号码
% 用法：\phone{<电话号码>}
\newcommand{\phone}[1]{\faPhone\ {#1}}

% 定义 LinkedIn 命令，显示 LinkedIn 图标和链接
% 用法：\linkedin[<显示文本>]{<链接>}
% 如果未提供显示文本，则显示链接本身
\newcommand{\linkedin}[2][]{\faLinkedin\ 
\ifthenelse{\isempty{#1}}%
{\href{#2}{#2}}
{\href{#2}{#1}}}

% 定义 GitHub 命令，显示 GitHub 图标和链接
% 用法：\github[<显示文本>]{<链接>}
% 如果未提供显示文本，则显示链接本身
\newcommand{\github}[2][]{\faGithub\ 
\ifthenelse{\isempty{#1}}%
{\href{#2}{#2}}
{\href{#2}{#1}}}

% 定义主页命令，显示链接图标和 URL
% 用法：\homepage[<显示文本>]{<链接>}
% 如果未提供显示文本，则显示链接本身
\newcommand{\homepage}[2][]{\faLink\ 
\ifthenelse{\isempty{#1}}%
{\href{#2}{#2}}
{\href{#2}{#1}}}

% 定义带文本的进度条命令，用于展示技能水平
% 用法：\pbar[宽度][文本]{百分比}
% 默认宽度为 10em，进度条高度为 1，圆角为 0.45，填充颜色为绿色 (40% 透明)
\newcommand{\pbar}[3][10em]{{#2}\ 
\progressbar[heightr=1, width=#1, borderwidth=0pt, roundnessr=0.45, filledcolor=green!40, subdivisions=1]{#3}
}

% 定义基本信息命令，居中显示较大字体，并添加 1.5ex 垂直间距
% 用法：\basicInfo{<信息内容>}
\newcommand{\basicInfo}[1]{
  \centerline{\sffamily\large{#1}}
}

% 定义角色命令，显示斜体角色名称 (#1) 和描述 (#2)
% 用法：\role{<角色>}{<描述>}
\newcommand{\role}[2]{
    {\par \textit{~#1} ~ \textit{#2} \par}
}