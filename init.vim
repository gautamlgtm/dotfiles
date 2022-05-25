set nocompatible
call plug#begin()

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'danielsiepmann/neotags'
Plug 'tpope/vim-commentary'
Plug 'jameshiew/nvim-magic'

"*****************************************************************************
"" Appearance
"*****************************************************************************
"
" Aesthetics - Colorschemes
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'zaki/zazen'
Plug 'yuttie/hydrangea-vim'

" Aesthetics - Others
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

"ALE func
Plug 'dense-analysis/ale'
Plug 'Yggdroot/indentLine'
Plug 'editor-bootstrap/vim-bootstrap-updater'
Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }

" Sensuble defaults
Plug 'tpope/vim-sensible'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"*****************************************************************************
"" Custom bundles
"*****************************************************************************

" html
"" HTML Bundle
Plug 'hail2u/vim-css3-syntax'
Plug 'gko/vim-coloresque'
Plug 'tpope/vim-haml'
Plug 'mattn/emmet-vim'

"" Python Bundle
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
Plug 'psliwka/vim-smoothie'
Plug 'jmcantrell/vim-virtualenv'
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }


" ruby
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-projectionist'
Plug 'thoughtbot/vim-rspec'
Plug 'racer-rust/vim-racer'
Plug 'prabirshrestha/async.vim'

call plug#end()

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
let g:python3_host_prog = '/home/vagrant/easypost/easypost_hq/bin/python'
filetype plugin indent on
set encoding=UTF-8
set ttyfast
set backspace=indent,eol,start
"" Tabs. May be overridden by autocmd rules
set tabstop=4
set shiftwidth=4
set expandtab
set noswapfile

"" Map leader to ,
let mapleader=','

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrap
set title
set showmatch
set lazyredraw
set cursorline
set autoread

" underline cursor
autocmd VimEnter * hi CursorLine cterm=underline
autocmd VimEnter * hi CursorLine gui=underline

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax enable
set ruler
set number
set wrap
let no_buffers_menu=1
set wildmenu
set mouse=a
set mousemodel=popup
set termguicolors
set gfn=Hack\ 10
let g:vim_bootstrap_langs = "html,python,ruby"


set scrolloff=5

"" Status bar
set laststatus=2
set title
set titlestring=%F

if exists("*fugitive#statusline")
    set statusline+=%{fugitive#statusline()}
endif

" vim-airline
let g:airline_theme = 'base16_material'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

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

"*****************************************************************************
"" Commands
"*****************************************************************************

" Trim Whitespaces
function! TrimWhitespace()
    let l:save = winsaveview()
    %s/\\\@<!\s\+$//e
    call winrestview(l:save)
endfunction

:map <Tab> <C-R>TrimWhitespace()<CR>

nnoremap <leader><Tab> <C-u>call TrimWhiteSpace()<CR>
"*****************************************************************************
"" Commands
"*****************************************************************************
" remove trailing whitespaces
command! FixWhitespace :%s/\s\+$//e

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

"" Tabs
nnoremap <silent> <S-t> :tabnew<CR>
nnoremap <Tab> gt
nnoremap <S-Tab> gT

"" fzf.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

nnoremap <silent> <leader>b :Buffers<CR>
nmap <leader>y :History:<CR>

" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif

"" Copy/Paste/Cut
if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
endif

noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

"" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>

"" Close buffer
noremap <leader>c :bd<CR>

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

" Syntax highlight
let python_highlight_all = 1

" ruby
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

augroup vimrc-ruby
    autocmd!
    autocmd BufNewFile,BufRead *.rb,*.rbw,*.gemspec setlocal filetype=ruby
    autocmd FileType ruby set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2
augroup END

let g:tagbar_type_ruby = {
            \ 'kinds' : [
                \ 'm:modules',
                \ 'c:classes',
                \ 'd:describes',
                \ 'C:contexts',
                \ 'f:methods',
                \ 'F:singleton methods'
                \ ]
                \ }

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" For ruby refactory
if has('nvim')
    runtime! macros/matchit.vim
else
    packadd! matchit
endif

" Ruby refactory
nnoremap <leader>rap  :RAddParameter<cr>
nnoremap <leader>rcpc :RConvertPostConditional<cr>
nnoremap <leader>rel  :RExtractLet<cr>
vnoremap <leader>rec  :RExtractConstant<cr>
vnoremap <leader>relv :RExtractLocalVariable<cr>
nnoremap <leader>rit  :RInlineTemp<cr>
vnoremap <leader>rrlv :RRenameLocalVariable<cr>
vnoremap <leader>rriv :RRenameInstanceVariable<cr>
vnoremap <leader>rem  :RExtractMethod<cr>

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

"" fzf.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

" ripgrep
if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
    set grepprg=rg\ --vimgrep
    command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <C-r> :Rg<CR>
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

"" Copy/Paste/Cut
if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
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

" ale
" flake8 options
let g:ale_python_flake8_options = '--max-line-length=120'
" black options
let g:ale_python_black_options = '--skip-string-normalization'
let g:ale_linters = {
            \   '*': ['remove_trailing_lines', 'trim_whitespace'],
            \   'python': ['flake8', 'pylint'],
            \   'javascript': ['eslint'],
            \   'ruby': ['rubocop'],
            \}

let g:ale_fixers = {
            \   '*': ['remove_trailing_lines', 'trim_whitespace'],
            \   'python': ['autopep8', 'yapf'],
            \   'javascript': ['eslint'],
            \   'ruby': ['rufo'],
            \}

let g:ale_fix_on_save = 1

" vim-airline
let g:airline#extensions#virtualenv#enabled = 1

" Syntax highlight
let python_highlight_all = 1

" ruby
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

augroup vimrc-ruby
    autocmd!
    autocmd BufNewFile,BufRead *.rb,*.rbw,*.gemspec setlocal filetype=ruby
    autocmd FileType ruby set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2
augroup END


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
colorscheme molokai
