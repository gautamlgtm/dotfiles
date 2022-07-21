set nocompatible

call plug#begin()
*****************************************************************************
"" Theme/UX
"*****************************************************************************

" Aesthetics - Colorschemes
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'zaki/zazen'
Plug 'yuttie/hydrangea-vim'

" Aesthetics - Others
Plug 'easymotion/vim-easymotion'
Plug 'wellle/targets.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'phanviet/vim-monokai-pro'
Plug 'crusoexia/vim-monokai'
Plug 'tomasr/molokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bryanmylee/vim-colorscheme-icons'
Plug 'ryanoasis/vim-devicons'
Plug 'Raimondi/delimitMate'
Plug 'majutsushi/tagbar'


"*****************************************************************************
"" Language Support
"*****************************************************************************
Plug 'sbdchd/neoformat'
Plug 'dense-analysis/ale'
Plug 'preservim/nerdcommenter'
if has ("nvim-0.5")
    Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
endif
Plug 'luochen1990/rainbow'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

******************************************************************************
"" File Nav
"*****************************************************************************
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'laher/fuzzymenu.vim'
Plug 'scrooloose/nerdtree' {'on': 'NerdTreeToggle'}
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'jistr/vim-nerdtree-tabs'

******************************************************************************
"" Others
"*****************************************************************************
Plug 'zef/vim-cycle'
Plug 'romainl/vim-cool'
Plug 'scrooloose/nerdcommenter'
Plug 'danielsiepmann/neotags'
Plug 'rbong/vim-crystalline'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/syntastic'
Plug 'ervandew/supertab'
Plug 'myusuf3/numbers.vim'
Plug 'sjl/gundo.vim'
Plug 'jameshiew/nvim-magic'
Plug 'mhinz/vim-startify'
Plug 'prettier/vim-prettier' , { 'do': 'yarn install' }

"
"
" html
"" HTML Bundle
Plug 'hail2u/vim-css3-syntax'
Plug 'gko/vim-coloresque'
Plug 'tpope/vim-haml'
Plug 'mattn/emmet-vim'

"" Python Bundle
Plug 'Guzzii/python-syntax'
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
Plug 'psliwka/vim-smoothie'
Plug 'jmcantrell/vim-virtualenv'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'heavenshell/vim-pydocstring'
Plug 'brentyi/isort.vim'

" Fuzzy finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Jinja syntax highlighting
Plug 'lepture/vim-jinja'

" editorconfig
Plug 'https://github.com/editorconfig/editorconfig-vim.git'

" multiple cursors
Plug 'terryma/vim-multiple-cursors'
call plug#end()

let g:isort_vim_options = join([
            \ '--multi-line 8',
            \ '--force-grid-wrap 0',
            \ '--use-parentheses',
            \ '--ensure-newline-before-comments',
            \ '--line-length 120',
            \ ], ' ')

"
" For all text files set 'textwidth' to 80
autocmd Filetype text setlocal textwidth=80

nnoremap <silent> ;f <cmd>Telescope find_files<cr>
nnoremap <silent> ;r <cmd>Telescope live_grep<cr>
nnoremap <silent> \\ <cmd>Telescope buffers<cr>
nnoremap <silent> ;; <cmd>Telescope help_tags<cr>

" Neoformat
let g:neomake_python_enabled_markers = ['flake8']
let g:neoformat_enabled_python = ['black', 'isort']
let g:neoformat_try_formatprg = 1
let g:neoformat_node_exe = 1
let g:neoformat_basic_format_align = 1
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1


"neoformat
augroup NeoformatAutoFormat
    autocmd!
    autocmd Filetype javascript setlocal formatprg = prettier
    autocmd Filetype python setlocal formatprg = black
    autocmd BufWritePre *.py Neoformat
    autocmd BufWritePre *js Neoformat
augroup END

nnoremap <silent> <leader>B :Neoformat<CR>


" *****************************************************************************
" Format Options
" *****************************************************************************
set formatoptions=qrn1c

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
filetype plugin indent on
set signcolumn=yes
set number
set softtabstop=4
set tabstop=4
set shiftwidth=4
set ttimeoutlen=0
set expandtab
set cursorline
set shortmess=a
set incsearch
set hlsearch
set ignorecase
set smartcase
set backspace=indent,eol,start
set scrolloff=5
set undofile
set encoding=UTF-8
set showmatch
set ttyfast
set cindent
set showmatch
set autoread
set noswapfile
set completeopt=menu,preview,noinsert
set emoji
set re=1
set autochdir
set cmdheight=1
set wrap
set title
set mouse=v
set hidden


"Auto Whitespace Trimming!"
fun! TrimWhiteSpace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
autocmd BufWritePre * :call TrimWhiteSpace()

set clipboard+=unnamed

"leader key
let mapleader=','

""******************************************************************************
" Custom Mappings
" ***************************************************************************
noremap <leader>H :set hlsearch!<CR>


" useful utilities
nmap <leader>' ysiw'
nmap <leader>" ysiw'

" underline cursor
autocmd VimEnter * hi CursorLine cterm=underline
autocmd VimEnter * hi CursorLine gui=underline

"*****************************************************************************
"" Other Visual Settings
"*****************************************************************************
syntax enable
set showmatch
set cc=120
set ruler
set number
set wrap
let no_buffers_menu=1
set wildmenu
set mousemodel=popup
set termguicolors
set gfn=Hack\ 10
let g:vim_bootstrap_langs = "html,python,ruby"
set fileformat=unix

set scrolloff=5
set infercase

"" Status bar
set laststatus=2
set title
set titlestring=%F

if exists("*fugitive#statusline")
    set statusline+=%{fugitive#statusline()}
endif

"" startify
let g:startify_default_theme = 'dark'
let g:startify_session_peresistence = 1
let g:startify_enable_special = 0
let g:startify_files_number = 8
let g:startify_update_oldfiles= 1

"" semshi settings
let g:semshi#error_sign = v:false


" Deodeplete
let g:deodeplete#enable_at_startup = 1

" multiple cursors
let g:multi_cursor_use_default_bindings = 1
let g:multi_cursor_start_key = '<c-n>'
let g:multi_cursor_next_key = '<tab>'
let g:multi_cursor_prev_key = 'b'
let g:multi_cursor_skip_key = 'x'
let g:multi_cursor_quit_key = 'q'


" select pasted text
nnoremap <expr> gp '`[' , strpart(getregtype(), 0, 1) . ']`'
nnoremap <leader>s :set invspell <CR>

" python folding
set foldmethod=indent
set foldlevel=99
set autoindent
set expandtab
set smarttab

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts

"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeShowHidden=1
let g:NERDTreeIgnore=['node_modules','\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 100
map <C-n> :NERDTreeToggle<CR>
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*node_modules/

nnoremap j gj
nnoremap k gk
vnoremap jk <Esc>
inoremap jk <Esc>
nnoremap <silent> <C-f> :Files <CR>

"*****************************************************************************
""indent unindent with normal bindings
"*****************************************************************************
nmap <Tab> >>
imap <S-Tab> <Esc><<i
nmap <S-tab> <<


"RestoreCursorShapeOnExit
autocmd VimLeave * set guicursor=v-c-sm:block,n-i-ci-ve:ver25,r-cr-o:hor20
"End RestoreCursorShapeOnExit

"" txt
augroup vimrc-wrapping
    autocmd!
    autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

"*****************************************************************************
"" Mappings
"*****************************************************************************

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" ***************************************************************************
" Tabs
" ***************************************************************************
nnoremap <silent> <S-t> :tabnew<CR>
nnoremap <Tab> gt
nnoremap <S-Tab> gT

"" fzf.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_OPTS = '--height=50% --layout=reverse --inline-info --preview="bat --line {}" --preview-window=right:70%'
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
nmap <leader>b :Buffers<CR>
nmap <leader>c :Commands<CR>
nmap <leader>t :BTags<CR>
nmap <leader>F :Rg<CR>
nmap <leader>sh :History:<CR>
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'border': 'sharp' }}
let g:fzf_tags_command = 'ctags -R'

" "******************************************************************************
" Buffer Switching
" ******************************************************************************
nnoremap <leader>1 :1b<CR>
nnoremap <leader>2 :2b<CR>
nnoremap <leader>3 :3b<CR>
nnoremap <leader>4 :4b<CR>

" "******************************************************************************
" Copy/Paste
" ******************************************************************************
nmap <leader>y "+y
nmap <leader>Y "+yq
nmap <leader>p "+p

augroup fzf
    autocmd!
    autocmd! Filetype fzf
    autocmd Filetype fzf set laststatus=0 noshowmode noruler
                \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif

noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"*****************************************************************************
""Custom configs
"*****************************************************************************

" html
" for html files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab

" python
" vim-python
augroup vimrc-python
    autocmd!
    autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 colorcolumn=120
                \ formatoptions+=croq softtabstop=4
                \ smartindent
                \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
                \
    autocmd FileType python set foldmethod=indent foldlevel=99
augroup END

" vim-airline
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#virtualenv#prefix = '🐍'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#tab_nr_type = 1
let g:bufferline_echo = 0
let g:airline#extensions#virtualenv#enabled = 1

"Gundo
nnoremap <F5> :GundoToggle <CR>
" Syntax highlight
let python_highlight_all = 1

"*****************************************************************************
"" Convenience variables
"*****************************************************************************
let g:tagbar_type_r = {
            \ 'ctagstype' : 'r',
            \ 'kinds'     : [
                \ 'f:Functions',
                \ 'g:GlobalVariables',
                \ 'v:FunctionVariables',
                \ ]
                \ }

"*****************************************************************************
"" Mappings
"*****************************************************************************

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" Tabs
nnoremap <silent> <S-t> :tabnew<CR>
nnoremap <Tab> gt
nnoremap <S-Tab> gT


"*****************************************************************************
"" Markdown
"*****************************************************************************
let g:vim_markdown_conceal = 0
let g:vim_markdown_fenced_languages = ['tsx=typescriptreact']
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_folding_frontmatter = 1
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>F :Rg<CR>
nnoremap <silent> <C-f> :FZF -m<CR>

"Recovery commands from history through FZF
nmap <leader>y :History:<CR>

" Tagbar
nmap <silent> <C-t> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif


noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

"" Close buffer
noremap <leader>c :bd<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" Easymotion
hi EasyMotionTarget ctermfg=9 guifg=red
hi EasyMotionTarget2First cterm=underline ctermfg=9 guifg=red
hi EasyMotionTarget2Second cterm=underline ctermfg=9 guifg=lightred
hi link EasyMotionShade Comment

"*****************************************************************************
"" Custom configs
"*****************************************************************************

" html
" for html files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab

" python
" vim-python
augroup vimrc-python
    autocmd!
    autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
                \ formatoptions+=croq softtabstop=4
                \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END


" Syntax highlight
let python_highlight_all = 1

"*****************************************************************************
"" Convenience variables
"*****************************************************************************
let g:tagbar_type_r = {
            \ 'ctagstype' : 'r',
            \ 'kinds'     : [
                \ 'f:Functions',
                \ 'g:GlobalVariables',
                \ 'v:FunctionVariables',
                \ ]
                \ }

autocmd vimenter * hi Comment term=bold cterm=NONE ctermfg=Darkgrey ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
autocmd vimenter * hi Statement term=bold cterm=NONE ctermfg=Darkgrey ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
autocmd vimenter * hi function term=bold cterm=NONE ctermfg=Darkgrey ctermbg=NONE gui=NONE guifg=NONE guibg=NONE

set background=dark
colorscheme monokai
