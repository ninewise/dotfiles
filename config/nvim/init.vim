

"  General Options {{{
" =====================
let mapleader=';'

syntax enable

set mouse=          " fuck you, mouse
set number          " line numbers on the right side
set showcmd         " show the commands while typing
set splitright      " open new splits on the right
set splitbelow      " open new splits below
set autoread        " autoreload file on change
set scrolloff=8     " keep the cursor 8 lines away from the top/bottom
set ruler           " show the lines/% bottomright
"set encoding=utf-8  " set default encoding
set laststatus=2    " always show the status line

" wrap lines at 72 characters
"set formatprg=par\ -w72
set formatoptions=tcrqnlmj
set textwidth=72

" indentation
set tabstop=4       " tab is 4 width
set shiftwidth=4    " for use with > and <
set expandtab       " tab key puts spaces
set list            " show whitespace, configure below
set listchars=tab:·\ ,trail:·
                    " display tabs with a leading \cdot
                    " trailing whitespace looks like \cdot

" Movement keys
nnoremap <Up>       <NOP>
nnoremap <Down>     <NOP>
nnoremap <Left>     <NOP>
nnoremap <Right>    <NOP>

" Not too much folding
set foldlevelstart=3

" Hmmmm neovim terminals
tnoremap <Esc> <C-\><C-n>

" Quickfixing
nnoremap <Leader>d  :split<CR>
nnoremap <Leader>co :copen<CR>
nnoremap <Leader>cn :cnext<CR>
nnoremap <Leader>cp :cprevious<CR>
nnoremap <Leader>cc :cclose<CR>

"  General Options }}}

"  Plugins {{{
" =====================

" Plugged
" -------
call plug#begin('~/.config/nvim/plugged')
" Layout
Plug 'bling/vim-airline'
Plug 'junegunn/vim-peekaboo'
" Files
Plug 'scrooloose/nerdtree',       { 'on': 'NERDTreeToggle' }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-grepper',         { 'on': 'Grepper' }
" Movement
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
" Integration
Plug 'tpope/vim-fugitive'
Plug 'kassio/neoterm',            { 'on': 'T' }
" Formatting
Plug 'junegunn/vim-easy-align',   { 'on': 'EasyAlign' }
" Languages
Plug 'LaTeX-Box-Team/LaTeX-Box',  { 'for': 'tex' }
Plug 'rust-lang/rust.vim',        { 'for': 'rust' }
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
" Completion
Plug 'Valloric/YouCompleteMe'
call plug#end()

" Plugin configuration
" --------------------
let g:airline_powerline_fonts=1

nnoremap <Leader>t :NERDTreeToggle<CR><CR>
nnoremap <Leader>; :wincmd w<CR>
let NERDTreeIgnore=[
  \ ".*\\.class$",
  \ ".*\\.o$",
  \ ".*\\.hi$",
  \ ".*\\.pyc$"
  \ ]

xnoremap <Leader>a :EasyAlign<CR>
nmap     <Leader>a :EasyAlign<CR>

let g:EasyMotion_do_mapping=0
let g:EasyMotion_startofline=0
map      <Leader>f <Plug>(easymotion-s)
map      <Leader>j <Plug>(easymotion-j)
map      <Leader>k <Plug>(easymotion-k)
map      <Leader>w <Plug>(easymotion-bd-w)
nmap     <Leader>w <Plug>(easymotion-overwin-w)

let g:ycm_global_ycm_extra_conf='~/.config/nvim/ycm_extra_conf.py'
let g:ycm_rust_src_path='/data/programming/rustc-1.7.0/src'
let g:ycm_server_python_interpreter='/usr/bin/python2'
set completeopt=menu

nnoremap <Leader>g :Grepper<CR>
let g:grepper={
  \ 'tools': ['rg', 'git', 'grep'],
  \ 'open': 1,
  \ 'jump': 0,
  \ }

let g:gutentags_cache_dir = '~/.cache/gutentag'

nnoremap <Leader>o :Tagbar<CR>
let g:tagbar_autoclose=1
let g:tagbar_autofocus=1
let g:tagbar_sort=0
let g:tagbar_compact=1
let g:tagbar_iconchars=['▸', '▾']
let g:tagbar_type_make={
  \ 'kinds': ['m:macros', 't:targets']
  \ }
let g:tagbar_type_rust={
  \ 'ctagstype': 'rust',
  \ 'kinds': [
    \ 'n:modules',
    \ 's:structs',
    \ 'i:interfaces',
    \ 'c:implementations',
    \ 'f:functions',
    \ 'g:enums',
    \ 't:typedefs',
    \ 'v:variables',
    \ 'M:macros',
    \ 'm:fields',
    \ 'e:enumerators',
    \ 'F:methods',
    \ ]
  \ }

let g:haskell_enable_quantification=1
let g:haskell_enable_recursivedo=1
let g:haskell_enable_arrowsyntax=1
let g:haskell_enable_pattern_synonyms=1
let g:haskell_enable_typeroles=1
let g:haskell_enable_static_pointers=1

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" path for fzf install
set rtp+=/usr/share/vim/vimfiles/
nnoremap <Leader>l :GitFiles<CR>
nnoremap <Leader>s :Tags<CR>
" Plugged }}}

" vim: foldmethod=marker
