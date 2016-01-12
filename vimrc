set nocompatible
execute pathogen#infect()
execute pathogen#helptags()

" 自动语法高亮
if has("syntax")
    syntax on
endif

filetype plugin indent on      " 开启插件，自动匹配对应的, “文件类型Plugin.vim”文件，使用缩进定义文件

" 重新打开文件时自动跳转到上次离开位置
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

syntax enable

" set background=dark
" colorscheme solarized
colorscheme cobalt

set autowrite           " 自动写，转入shell或使用：n编辑其他文件时，当前的缓冲区被写入
" set flash             " 在出错处闪烁但不呜叫(缺省)

" set ignorecase          " 在查询及模式匹配时忽赂大小写
set smartcase           " 有一个或以上大写字母时仍保持对大小写敏感

set nu                  " 屏幕左边显示行号
set mouse=a             " Enable mouse usage (all modes)
set showmatch           " 显示括号配对，当键入“]”“)”时，高亮度显示匹配的括号
set showmode            " 处于文本输入方式时加亮按钮条中的模式指示器
set showcmd             " 在状态栏显示目前所执行的指令，未完成的指令片段亦会显示出来

set autoindent          " 设置自动缩进：即每行的缩进值与上一行相等；使用 noautoindent 取消设置
set cindent             " 以C/C++的模式缩进
set noignorecase        " 默认区分大小写
set ruler               " 打开状态栏标尺
set scrolloff=5         " 设定光标离窗口上下边界 5 行时窗口自动滚动

set shiftwidth=4        " 设定 << 和 >> 命令移动时的宽度为 4
set softtabstop=4       " 使得按退格键时可以一次删掉 4 个空格,不足 4 个时删掉所有剩下的空格）
set tabstop=4           " 设定 tab 长度为 4
set expandtab           " 设置成 expandtab 时，缩进用空格来表示，noexpandtab 则是用制表符表示一个缩进

set foldmethod=indent
set backspace=indent,eol,start
" set colorcolumn=80

set wrap                " 自动换行显示
set hlsearch            " 搜索时高亮显示被找到的文本
set foldenable          " 开始折叠
set foldmethod=syntax   " 设置语法折叠
set foldcolumn=0        " 设置折叠区域的宽度
setlocal foldlevel=1    " 设置折叠层数为
set foldclose=all       " 设置为自动关闭折叠                            
nnoremap <c-F> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
" 用空格键来开关折叠

" === NERDTree setting =====
nmap <F3> :NERDTreeToggle<CR>
" autocmd vimenter * NERDTree   " 自动加载NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif 
let NERDTreeIgnore=['\.swp', '\~'] " ignore *.swp and *~
" ======== end =============

" different highlighting for different file types 不同文件显示高亮
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
    exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
    exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('sql', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('java', 'Red', 'none', 'red', '#151515')

" === tagbar setting =======
nmap <F4> :TagbarToggle<CR>
let g:tagbar_width = 25      " tagbar's width, default 35
autocmd VimEnter * nested :call tagbar#autoopen(1)  "automate to open tagbar
" let g:tagbar_left = 1       " on the left side
let g:tagbar_right = 1     " on the right side
" =======end================

" switch window
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" ===== brace autocompletion (括号自动补全) =========
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {<CR>}<Esc>O
autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

function CloseBracket()
    if match(getline(line('.') + 1), '\s*}') < 0
        return "\<CR>}"
    else
        return "\<Esc>j0f}a"
    endif
endf

function QuoteDelim(char)
    let line = getline('.')
    let col = col('.')
    if line[col - 2] == "\\"
        "Inserting a quoted quotation mark into the string
        return a:char
    elseif line[col - 1] == a:char
        "Escaping out of the string
        return "\<Right>"
    else
        "Starting a string
        return a:char.a:char."\<Esc>i"
    endif
endf
