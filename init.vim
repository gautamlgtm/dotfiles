" Create file without opening buffer
function! CreateInPreview()
  let l:filename = input('please enter filename: ')
  execute 'silent !touch ' . b:netrw_curdir.'/'.l:filename
  redraw!
endfunction

" Netrw: create file using touch instead of opening a buffer
function! Netrw_mappings()
  noremap <buffer>% :call CreateInPreview()<cr>
endfunction

augroup auto_commands
    autocmd filetype netrw call Netrw_mappings()
augroup END

call plug#begin()
    " Appearance
    Plug 'vim-airline/vim-airline'
    Plug 'ryanoasis/vim-devicons'

    " Utilities
    Plug 'sheerun/vim-polyglot'
    Plug 'jiangmiao/auto-pairs'
    Plug 'ap/vim-css-color'
    Plug 'preservim/nerdtree'

    "Python Plugs"
    Plug 'psf/black', { 'branch': 'main' }
    Plug 'fisadev/vim-isort'
    Plug 'neoclide/coc.nvim'

    " Completion / linters / formatters
    Plug 'plasticboy/vim-markdown'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
call plug#end()

let g:black_linelength = 120
let g:black_skip_string_normalization = 1

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
nnoremap <silent> <C-f> :Files<CR>

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
