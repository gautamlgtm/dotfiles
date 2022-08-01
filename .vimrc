" Begin Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/vundle'

" Begin Plugins
  Plugin 'vim-airline/vim-airline'
  Plugin 'vim-airline/vim-airline-themes'

  Plugin 'cespare/vim-toml'
  Plugin 'klen/python-mode'
  Plugin 'yssource/python.vim'
  Plugin 'python_match.vim'
  Plugin 'pythoncomplete'
  Plugin 'mitsushiko/vim-sparkup'
  Plugin 'nvie/vim-flake8'
  Plugin 'ambv/black'
  Plugin 'sbdchd/neoformat'
  Plugin 'jmcantrell/vim-virtualenv'
  Plugin 'fisadev/vim-isort'

  Plugin 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
  Plugin 'scrooloose/nerdcommenter'
  Plugin 'easymotion/vim-easymotion'
  Plugin 'morhetz/gruvbox'
  Plugin 'Lokaltog/powerline'                 " Powerline fonts plugin
  Plugin 'powerline/fonts'
  Plugin 'tpope/vim-fugitive'
  Plugin 'tpope/vim-dotenv'
  Plugin 'tpope/vim-flagship'
  Plugin 'tpope/vim-commentary'
  Plugin 'Valloric/YouCompleteMe'             " Autocomplete plugin
  Plugin 'scrooloose/syntastic'
  Plugin 'junnegun/fzf', {'dir': '~/.fzf', 'do': './install --all'}
  Plugin 'junegunn/fzf.vim'
  Plugin 'editorconfig/editorconfig-vim'
  Plugin 'ryanoasis/vim-devicons'
  Plugin 'neomake/neomake'
"End Plugins
call vundle#end()
" End Vundle
"
" syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs=1
let g:syntastic_check_on_wq=0
let g:syntastic_aggregate_errors=1
let g:syntastic_loc_list_height=5
let g:syntastic_error_symbol='X'
let g:syntastic_python_checkers=['flake8']
" syntastic end
"
" commentary
autocmd FileType apache setLocal commentstring=#\ %s
" commentary end

"shell
set shell=/bin/zsh
"shell end

" airline
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep='|'
let g:airline#extenisions#tabline#formatter = 'molokai'
" airline end
"
filetype plugin indent on

" breakpoint pdb
au FileType python map <silent> <leader>b Oimport ipdb; ipdb.set_trace()<esc>
"breakpoint pdb  end

" syntax highlight
 let g:pymode_syntax=1
 let g:pymode_syntax_slow_sync=1
 let g:pymode_syntax_all=1
 let g:pymode_syntax_print_as_function=g:pymode_syntax_all
 let g:pymode_syntax_highlight_async_await=g:pymode_syntax_all
 let g:pymode_syntax_highlight_equal_operator=g:pymode_syntax_all
 let g:pymode_syntax_highlight_stars_operator=g:pymode_syntax_all
 let g:pymode_syntax_highlight_self=g:pymode_syntax_all
 let g:pymode_syntax_indent_errors=g:pymode_syntax_all
 let g:pymode_syntax_string_formatting=g:pymode_syntax_all
 let g:pymode_syntax_space_errors=g:pymode_syntax_all
 let g:pymode_syntax_string_format=g:pymode_syntax_all
 let g:pymode_syntax_string_templates=g:pymode_syntax_all
 let g:pymode_syntax_doctests=g:pymode_syntax_all
 let g:pymode_syntax_builtin_objs=g:pymode_syntax_all
 let g:pymode_syntax_builtin_types=g:pymode_syntax_all
 let g:pymode_syntax_highlight_exceptions=g:pymode_syntax_all
 let g:pymode_syntax_docstrings=g:pymode_syntax_all
" syntax highlight end

" Begin UI
syntax on
let python_highlight_all=1
set autoindent
set autoread
set backspace=indent,eol,start
set cursorline
set encoding=utf-8
set showtabline=2
set guioptions-=e
set lazyredraw
set linebreak
set mouse=v " enable mouse support
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
set noswapfile
set formatoptions=tcqrn1
set noshiftround

highlight LineNr ctermfg=244
autocmd User Flags call Hoist("buffer", "fugitive#statusline")
autocmd BufWritePost *.py :Isort %
autocmd BufWritePost *.py :Black %
let s:available_short_python = ':py3'
nnoremap gV `[v`]
let mapleader = ","
let maplocalleader = ","
let g:WebDevIconsUnicodeDecorateFolderNodes=1
let g:DevIconsEnableFoldersOpenClose=1
" End UI

" Begin FZF
let $FZF_DEFAULT_COMMAND = 'fd -E .git --hidden --type f'
let g:fzf_preview_window=['right:50%', 'ctrl-/']
nnoremap <C-f> :Files<Cr>
nnoremap <C-b> :Buffers<Cr>
" End FZF

"YouCompleteMe
let g:ycm_collect_identifiers_from_tags_files=1
let g:UltiSnipsExpandTrigger='<C-j>'
let g:UltiSnipsJumpForwardTrigger='<C-j>'
let g:UltiSnipsJumpBackwardTrigger='<C-k>'
"YouCompleteMe end

" Begin NERDTree
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc$', '\~$']
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd BufWinEnter * NERDTreeMirror
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1
let NERDTreeHouseMode=1
let g:nerdtree_tabs_open_on_gui_startup=1
" End NERDTree

" Begin Menu
set wildmenu
set wildmode=list:longest,full
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pdf,*.bak,*.beam,*.pyc,*.aux,__pycache__
" End Menu

" Begin Search
set incsearch
set hlsearch
set ignorecase
set smartcase
set scrolloff=5
nnoremap <CR>:nohlsearch<CR><CR>
" End Search

" tabs/buffers settings
tab sball
set switchbuf=useopen
set laststatus=2
nmap <F9> :bprev<CR>
nmap <F9> :bprev<CR>
" tabs/buffers settings end

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
set clipboard=unnamed
vnoremap <C-C> "+y
" End Clipboard

"set cursor width
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=1\x7"
"set cursor width end
"
"ycm goto
let g:ycm_extra_conf='~/.vim/bundle/YouCompleteMe/ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=0
nmap <C-g> :YcmCompleter GoTo<CR>

"ycm goto end

colorscheme gruvbox
