call plug#begin()
    " Appearance
 Plug 'vwxyutarooo/nerdtree-devicons-syntax'
	Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'ryanoasis/vim-devicons'
    Plug 'bryanmylee/vim-colorscheme-icons'
    Plug 'mhinz/vim-startify'
    Plug 'tanvirtin/monokai.nvim'
    " Utilities
    Plug 'sheerun/vim-polyglot'
    Plug 'jiangmiao/auto-pairs'
    Plug 'ap/vim-css-color'
    Plug 'preservim/nerdtree'

    "Python Plugs"
    Plug 'Glench/Vim-Jinja2-Syntax'
    Plug 'fisadev/vim-isort'
    Plug 'ambv/black', { 'branch': 'main' }
    Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
    Plug 'psliwka/vim-smoothie'

    " Completion / linters / formatters
    Plug 'plasticboy/vim-markdown'
    Plug 'dense-analysis/ale'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
call plug#end()

syntax enable
:let mapleader = ","

"python options
let g:black_linelength = 120
let g:black_skip_string_normalization = 1
let g:python_host_prog = '/Users/gautampappu/easypost/venv/bin/python3' 


filetype plugin indent on 
syntax enable 
set colorcolumn=120
set guifont=Hack
set autoindent
set tabstop=4
set shiftwidth=4
set autoread
set backspace=indent,eol,start
set cursorline
autocmd VimEnter * hi CursorLine cterm=underline
autocmd VimEnter * hi CursorLine gui=underline
set laststatus=2
set encoding=UTF-8
set lazyredraw
set linebreak
set mouse=a " enable mouse support
set number
set pastetoggle=<F5>
set ruler
set showcmd
set showmode
set title
set ttyfast
set visualbell
set wrap

nnoremap gV `[v`]
nnoremap \ ,

"" --- Statusbar ---
" Airline settings
let g:airline_theme= 'base16_monokai'
set laststatus=2
let g:airline_powerline_fonts             = 1
let g:airline#extensions#tabline#enabled  = 1
let g:airline_section_c = '%t'
let g:airline_section_z = " %l:%c"
call airline#parts#define_accent('mode', 'red')

" End UI

" Begin NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$']
map <C-n> :NERDTreeToggle<CR>
autocmd BufWinEnter * NERDTreeMirror
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" End NERDTree
"
" ALE settings
let g:ale_linters = {
\  'python': ['flake8', 'darker', 'isort', 'mypy', 'prospector', 'pyls', 'pycodestyle'],
\  'cfn_yaml': ['cfn-python-lint'],
\}
let g:ale_fixers = ['autopep8', 'yapf']
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
nnoremap <C-l> :nohl<CR><C-l>:echo "Search Cleared"<CR>
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
vnoremap jk <Esc>
inoremap jk <Esc>
" End Movement

""Python Keybindings
nnoremap <silent> <C-f> :Files<CR>
" End Python Keybindings


" Begin Whitespace
autocmd colorscheme * highlight ExtraWhitespace ctermbg=white guibg=white
" End Whitespace

" Begin Clipboard
vnoremap <C-C> "+y
" End Clipboard
"
"RestoreCursorShapeOnExit
augroup RestoreCursorShapeOnExit
    autocmd!
    autocmd VimLeave * set guicursor=v-c-sm:block,n-i-ci-ve:ver25,r-cr-o:hor20
augroup END
"End RestoreCursorShapeOnExit

"Begin Buffer Management
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <c-S-Right> gt
noremap <c-S-Left> gT
"End Buffer Management

autocmd vimenter * hi Comment term=bold cterm=NONE ctermfg=Darkgrey ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
autocmd vimenter * hi Statement term=bold cterm=NONE ctermfg=Darkgrey ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
autocmd vimenter * hi function term=bold cterm=NONE ctermfg=Darkgrey ctermbg=NONE gui=NONE guifg=NONE guibg=NONE

set background=dark
colorscheme monokai
