call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'mhinz/vim-grepper'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-vinegar'
Plug 'neomake/neomake'
Plug 'ervandew/supertab'
Plug 'itchyny/lightline.vim'
Plug 'mkalinski/vim-lightline_neomake'
Plug 'airblade/vim-rooter'
Plug 'Roguelazer/neovim-fuzzy', { 'branch': 'prompt' }
Plug 'markonm/traces.vim'
Plug 'rodjek/vim-puppet'
Plug 'cespare/vim-toml'
Plug 'haishanh/night-owl.vim'
Plug 'jeffkreeftmeijer/vim-dim'
call plug#end()

" relative line numbers are far more useful than absolute line numbers
" with vi motions
set relativenumber

" use , as the leader
let mapleader = ","

" how often do you type these sequences anyway?
inoremap jk <ESC>
inoremap jj <ESC>
inoremap kj <ESC>

" faster buffer access
nnoremap <leader>n :bp<cr>
nnoremap <leader>m :bn<cr>
nnoremap <up> :buffers<cr>:buffer
nnoremap <down> :b#<cr>
nnoremap <left> :bp<cr>
nnoremap <right> :bn<cr>

" indentation settings -- unless otherwise specified by a filetype, use 4-space tab and expanded tabs
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent
set expandtab

" show special characters
set list
set listchars=tab:»_,extends:>,precedes:<
highlight Whitespace ctermfg=darkgrey guifg=#777777
set backspace=indent,eol,start

" themes
if has("gui_vimr")
    set background=dark
    colorscheme night-owl
else
    colorscheme dim
endif

let g:lightline = {
\   'colorscheme': 'jellybeans',
\   'active': {
\       'right': [
\           ['neomake'],
\           ['lineinfo'],
\           ['percent'],
\           ['fileformat', 'fileencoding', 'filetype'],
\       ],
\   },
\   'component_expand': {
\       'neomake': 'lightline_neomake#component',
\   },
\   'component_type': {
\       'neomake': 'error',
\   },
\}

" handy function for copying a single file remotely without involving netrw
function! ScpTo(hostname)
    if (a:hostname =~ ":")
        let target=a:hostname
    else
        let target=(a:hostname . ":")
    endif
    exe ("!scp % " . target)
endfunction

command! -nargs=1 Scpto call ScpTo("<args>")
noremap <leader>S :Scpto

nnoremap <C-f> :FuzzyOpen<CR>
nnoremap <C-g> :FuzzyGrep<CR>
nnoremap <C-n> :Lex<CR>

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" plugin configs
let g:puppet_align_hashes = 0
let g:grepper = {'tools': ['rg', 'git', 'grep'] }
set noshowmode
let g:netrw_liststyle = 3
autocmd FileType netrw setl bufhidden=wipe

autocmd BufRead,BufNewFile LICENSE setlocal spell
autocmd FileType mkd,markdown setlocal spell nolist columns=120 tw=120 wrap linebreak showbreak=+++ colorcolumn=0
autocmd FileType ruby setlocal shiftwidth=2 sts=2 ts=2 expandtab

augroup RestoreCursorShapeOnExit
    autocmd!
    autocmd VimLeave * set guicursor=a:ver25
augroup END

