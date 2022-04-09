" Create file without opening buffer

call plug#begin()
    " Appearance
    Plug 'vim-airline/vim-airline'
    Plug 'ryanoasis/vim-devicons'
    Plug 'bryanmylee/vim-colorscheme-icons'
    Plug 'mhinz/vim-startify'
    Plug 'crusoexia/vim-monokai'
    " Utilities
    Plug 'sheerun/vim-polyglot'
    Plug 'jiangmiao/auto-pairs'
    Plug 'ap/vim-css-color'
    Plug 'preservim/nerdtree'

    "Python Plugs"
    Plug 'psf/black', { 'branch': 'main' }
    Plug 'fisadev/vim-isort'
    Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
    Plug 'psliwka/vim-smoothie'


    " Completion / linters / formatters
    Plug 'plasticboy/vim-markdown'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
call plug#end()

let g:black_linelength = 120
let g:black_skip_string_normalization = 1
let g:python_host_prog = '/Users/gautampappu/easypost/venv/bin/python3' 
syntax enable

set guifont
set autoindent
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
:let mapleader = ","
nnoremap \ ,

let g:airline_powerline_fonts = 1
let g:airline_powerline_fonts = 1
let g:airline_section_z = ' %{strftime("%-I:%M %p")}'
let g:airline_section_warning = ''
"let g:airline#extensions#tabline#enabled = 1 " Uncomment to display buffer tabline above
""
let $BAT_THEME='base16'


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
vnoremap jk <Esc>
inoremap jk <Esc>
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent><C-i> :Isort<CR>
nnoremap <silent><C-b> :Black<CR>
" End Movement

" Begin Whitespace
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=white guibg=white
" End Whitespace

" Begin Completion
inoremap {<CR> {<CR>}<Esc>ko
" End Completion

" Begin Clipboard
vnoremap <C-C> "+y
" End Clipboard

colorscheme monokai
