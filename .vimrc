" Begin Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/vundle'

" Begin Plugins
  Plugin 'junegunn/fzf'
  Plugin 'junegunn/fzf.vim'
  Plugin 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
  Plugin 'tomasr/molokai'
  Plugin 'nvie/vim-flake8'
  Plugin 'ambv/black'
  Plugin 'davidhalter/jedi-vim'
"End Plugins
call vundle#end()
filetype plugin indent on
" End Vundle

" Begin UI
colorscheme monokai
syntax enable

set autoindent
set autoread
set backspace=indent,eol,start
set cursorline
set encoding=utf-8
set laststatus=2
set lazyredraw
set linebreak
set mouse=a " enable mouse support
set number
set pastetoggle=<F5>
set ruler
set showcmd
set showmatch
set showmode
set title
set ttyfast
set visualbell
set wrap

nnoremap gV `[v`]
:let mapleader = ","
nnoremap \ ,

" End UI

" Begin NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$']
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd BufWinEnter * NERDTreeMirror
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" End NERDTree

" Begin Menu
set wildmenu
set wildmode=list:longest,full
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pdf,*.bak,*.beam,*.pyc,*.aux
" End Menu

" Begin Search
set incsearch
set hlsearch
set ignorecase
set smartcase
set scrolloff=5
nnoremap <leader><space> :nohlsearch<CR>
" End Search

" Begin Folding
set foldenable
set foldlevelstart=99
set foldmethod=indent
nnoremap <space> za
" End Folding

" Begin Movement
nnoremap j gj
nnoremap k gk
imap jk <Esc>

" End Movement

" Begin Whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWritePre * :%s/\s\+$//e
" End Whitespace

" Begin Completion
inoremap {<CR> {<CR>}<Esc>ko
" End Completion

" Begin Clipboard
vnoremap <C-C> "+y
" End Clipboard
