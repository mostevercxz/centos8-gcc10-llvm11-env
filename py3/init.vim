if has('win32') || has('win64')
  let g:plugged_home = '~/AppData/Local/nvim/plugged'
else
  let g:plugged_home = '~/.vim/plugged'
endif
" Plugins List
call plug#begin(g:plugged_home)
  " UI related
  Plug 'chriskempson/base16-vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'NLKNguyen/papercolor-theme'
  " Better Visual Guide
  Plug 'Yggdroot/indentLine'
  " syntax check
  Plug 'w0rp/ale'
  " Autocomplete
  Plug 'ncm2/ncm2'
  Plug 'roxma/nvim-yarp'
  Plug 'ncm2/ncm2-bufword'
  Plug 'ncm2/ncm2-path'
  Plug 'ncm2/ncm2-jedi'
  " Formater
  Plug 'Chiel92/vim-autoformat'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'majutsushi/tagbar'
  Plug 'scrooloose/nerdtree'
  Plug 'rbgrouleff/bclose.vim'
call plug#end()
filetype plugin indent on

" Configurations Part
" UI configuration
syntax on
syntax enable
" colorscheme
"let base16colorspace=256
"colorscheme base16-gruvbox-dark-hard
set background=dark
" True Color Support if it's avaiable in terminal
"if has("termguicolors")
"    set termguicolors
"endif
"if has("gui_running")
"  set guicursor=n-v-c-sm:block,i-ci-ve:block,r-cr-o:blocks
"endif
set number
set relativenumber
set hidden
set mouse=a
set noshowmode
set noshowmatch
set nolazyredraw
" Turn off backup
set nobackup
set noswapfile
set nowritebackup
" Search configuration
set ignorecase                    " ignore case when searching
set smartcase                     " turn on smartcase
" Tab and Indent configuration
set expandtab
set tabstop=4
set shiftwidth=4
" vim-autoformat
noremap <F3> :Autoformat<CR>
" NCM2
augroup NCM2
  autocmd!
  " enable ncm2 for all buffers
  autocmd BufEnter * call ncm2#enable_for_buffer()
  " :help Ncm2PopupOpen for more information
  set completeopt=noinsert,menuone,noselect
  " When the <Enter> key is pressed while the popup menu is visible, it only
  " hides the menu. Use this mapping to close the menu and also start a new line.
  inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
  " uncomment this block if you use vimtex for LaTex
  " autocmd Filetype tex call ncm2#register_source({
  "           \ 'name': 'vimtex',
  "           \ 'priority': 8,
  "           \ 'scope': ['tex'],
  "           \ 'mark': 'tex',
  "           \ 'word_pattern': '\w+',
  "           \ 'complete_pattern': g:vimtex#re#ncm2,
  "           \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
  "           \ })
augroup END
" Ale
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {'python': ['flake8']}
" Airline
let g:airline_left_sep  = ''
let g:airline_right_sep = ''
let g:airline#extensions#ale#enabled = 1
let airline#extensions#ale#error_symbol = 'E:'
let airline#extensions#ale#warning_symbol = 'W:'
let mapleader = ','

"let g:deoplete#_logging = {'level': 'DEBUG', 'logfile': '/tmp/deoplete.log'}
let g:deoplete#sources = {}
let g:deoplete#sources.c = ['LanguageClient', 'neosnippet', 'buffer', 'tag']
let g:deoplete#sources.cpp = ['LanguageClient', 'neosnippet', 'buffer', 'tag']
"let g:deoplete#sources.python = ['LanguageClient', 'neosnippet']
"let g:deoplete#sources.python3 = ['LanguageClient', 'neosnippet']
"let g:deoplete#sources.vim = ['vim']

"----------------------------------------------
" Plugin: scrooloose/nerdtree
"----------------------------------------------
nnoremap <leader>d :NERDTreeToggle<cr>
nnoremap <F2> :NERDTreeToggle<cr>
nnoremap <silent>\d :NERDTreeToggle<cr>

" Files to ignore
let NERDTreeIgnore = [
    \ '\~$',
    \ '\.pyc$',
    \ '^\.DS_Store$',
    \ '^node_modules$',
    \ '^.ropeproject$',
    \ '^__pycache__$'
\]
" tagbar
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds' : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" Close vim if NERDTree is the only opened window.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Show hidden files by default.
let NERDTreeShowHidden = 1

" Allow NERDTree to change session root.
let g:NERDTreeChDirMode = 2

"----------------------------------------------
" Plugin: vim-airline/vim-airline
"----------------------------------------------
" Show status bar by default.
set laststatus=2

" Enable top tabline.
let g:airline#extensions#tabline#enabled = 1

" Disable showing tabs in the tabline. This will ensure that the buffers are
" what is shown in the tabline at all times.
let g:airline#extensions#tabline#show_tabs = 0

" Enable powerline fonts.
let g:airline_powerline_fonts = 0

" Explicitly define some symbols that did not work well for me in Linux.
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.branch = '<U+E0A0>'
let g:airline_symbols.maxlinenr = '<U+E0A1>'

"----------------------------------------------
" Plugin: 'junegunn/fzf.vim'
"----------------------------------------------
nnoremap <c-p> :FZF<cr>

" Plugin: deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 2
let g:deoplete#enable_smart_case = 1 
" deoplete + neosnippet + autopairs changes 
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

"inoremap <silent><expr> <TAB>
    "\ pumvisible() ? "\<C-n>" :
    "\ <SID>check_back_space() ? "\<TAB>" :
    "\ deoplete#mappings#manual_complete()
"function! s:check_back_space() abort "{{{
    "let col = col('.') - 1
    "return !col || getline('.')[col - 1]  =~ '\s'
"endfunction"}}}

imap <expr><TAB> pumvisible() ? "\<C-n>" : (neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>") 
inoremap <expr><C-l>     deoplete#mappings#manual_complete()
"imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
"imap <expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>\<Plug>AutoPairsReturn"
"imap <expr><Tab> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-N>" : "\<Tab>"
"smap <expr><Tab> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<Tab>"

let g:LanguageClient_serverCommands = {
\ 'cpp': ['/home/giant/3party/cquery/build/debug/bin/cquery', '--language-server', '--log-file=/tmp/cq.log'],
\ 'c': ['/home/giant/3party/cquery/build/debug/bin/cquery', '--language-server', '--log-file=/tmp/cq.log'],
\ 'python': ['pyls']
\ }
"\ 'python': ['pyls', '-vv']
let g:LanguageClient_loadSettings = 1
" 暂时关闭语法检测
"let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_settingsPath='/home/giant/.vim/settings.json'


let g:neosnippet#snippets_directory='~/.vim/plugged/neosnippet-snippets/neosnippets/'

"----------------------------------------------
" Plugin: mileszs/ack.vim
"----------------------------------------------
" Open ack
nnoremap <leader>a :Ack! <C-R><C-W><space>
nnoremap <leader>gg :Ack! --type=cpp <C-R><C-W><space>

" Rust tagbar
 let g:tagbar_type_rust = {
    \ 'ctagstype' : 'rust',
    \ 'kinds' : [
        \'T:types,type definitions',
        \'f:functions,function definitions',
        \'g:enum,enumeration names',
        \'s:structure names',
        \'m:modules,module names',
        \'c:consts,static constants',
        \'t:traits',
        \'i:impls,trait implementations',
    \]
    \}


set colorcolumn=81
set cursorline
set expandtab
set number
set relativenumber
set softtabstop=0 noexpandtab
set tabstop=4
set shiftwidth=4
set textwidth=80
set title
set updatetime=100
set autoindent                    " take indent for new line from previous line
set smartindent                   " enable smart indentation

set background=dark
colorscheme PaperColor
nnoremap <F3> :TagbarToggle<cr>

noremap <tab>h <c-w>h
noremap <tab>j <c-w>j
noremap <tab>k <c-w>k
noremap <tab>l <c-w>l
noremap <tab>w <c-w>w
set mouse-=a
noremap <silent><tab> <nop>
noremap <silent>\e :enew<cr>
noremap <silent>\t :tabnew<cr>
" bnext,Move to next buffer
noremap <silent>\2 :bn<cr>
noremap <silent>\1 :bp<cr>
"noremap <silent>\q :bp <BAR> bd #<cr>
"noremap <silent>\bl :ls<cr>
noremap <silent>\c :Bclose<cr>
nnoremap <silent>\q :q<cr>
nnoremap <silent>\w :write<cr>
noremap <silent><F4> :GoReferrers<cr>
noremap <silent><space>= :resize +3<cr>
noremap <silent><space>- :resize -3<cr>
noremap <silent><space>[ :vertical resize +3<cr>
noremap <silent><space>] :vertical resize -3<cr>
let g:ackprg = "rg --no-heading --color=never -n"

" Cargo debug
"let g:LanguageClient_devel = 1 " Use rust debug build
let g:LanguageClient_loggingLevel = 'DEBUG' " Use highest logging level
let g:neosnippet#enable_completed_snippet=1

" ctags
let g:gutentags_ctags_executable = 'ctags'
set tags=./.tags;,.tags
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
 
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'
 
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
 
" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
 
" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif

" 使用 CTRL-W ] 在新窗口中查看定义;用 g] 查看所有的tag列表并按数字选择
" 编译相关
" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6
 
" 任务结束时候响铃提醒
let g:asyncrun_bell = 1
let g:echodoc#enable_at_startup = 1
set cmdheight=2
let g:ycm_extra_conf_globlist = ['~/dev/*','!~/*']

"call deoplete#custom#option({ 
		"\ 'auto_complete_delay': 20,
		"\ 'auto_refresh_delay' : 20,
		"\ 'refresh_always' : v:false,
		"\ 'min_pattern_length' : 2,
		"\ })                         
		"\ 'profile': v:true,
 
" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>
nnoremap <silent> <F9> :AsyncRun clang++ -Wall -g -std=c++1z "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
if filereadable("cscope.out")
	  cs add cscope.out
endif

let g:goto_header_use_find = 1 " By default it's value is 0
let g:goto_header_open_in_new_tab = 1
nnoremap <F12> :GotoHeader <CR>
imap <F12> <Esc>:GotoHeader <CR>
nnoremap gh :GotoHeaderSwitch <CR>