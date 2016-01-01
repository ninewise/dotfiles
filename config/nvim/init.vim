

"  General Options {{{
" =====================
let mapleader=';'

syntax enable
set background=dark
colorscheme darkblue

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
nnoremap <Leader>wg <C-w><C-w>
nnoremap <Leader>wh <C-w>h
nnoremap <Leader>wj <C-w>j
nnoremap <Leader>wk <C-w>k
nnoremap <Leader>wl <C-w>l

" Not too much folding
set foldlevelstart=2

" Hmmmm neovim terminals
nnoremap <Leader>s :vsplit +:terminal<CR>
tnoremap <Esc> <C-\><C-n>

" Quickfixing
nnoremap <Leader>co :copen<CR>
nnoremap <Leader>cn :cnext<CR>
nnoremap <Leader>cp :cprevious<CR>

"  General Options }}}

"  Plugins {{{
" =====================

" Plugged
" -------
call plug#begin('~/.config/nvim/plugged')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/vim-easy-align'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'rust-lang/rust.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'chriskempson/base16-vim'
"Plugin 'LaTeX-Box-Team/LaTeX-Box'
"Plugin 'chase/vim-ansible-yaml'

Plug 'junegunn/vim-after-object'
Plug 'junegunn/vim-peekaboo'
Plug 'takac/vim-hardtime'
Plug 'mhinz/vim-grepper'
Plug 'neovimhaskell/haskell-vim'
Plug 'kassio/neoterm'
Plug 'brettanomyces/nvim-editcommand'
call plug#end()

" Plugin configuration
" --------------------
let g:ctrlp_map='<Leader>l'
let g:ctrlp_user_command=['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

let g:airline_powerline_fonts=1

nnoremap <Leader>t :NERDTreeToggle<CR><CR>
let NERDTreeIgnore=[
  \ ".*\\.class$",
  \ ".*\\.o$",
  \ ".*\\.hi$",
  \ ".*\\.pyc$"
  \ ]

xnoremap <Leader>a <Plug>(EasyAlign)
nmap     <Leader>a <Plug>(EasyAlign)

let g:EasyMotion_do_mapping=0
nmap     <Leader>w <Plug>(easymotion-w)
nmap     <Leader>f <Plug>(easymotion-s)
nmap     <Leader>j <Plug>(easymotion-j)
nmap     <Leader>k <Plug>(easymotion-k)

let g:ycm_global_ycm_extra_conf='~/.config/nvim/ycm_extra_conf.py'
"set completeopt=menu

let base16colorspace=256
colorscheme base16-colors
" damn base16's grey linenr background
highlight LineNr ctermfg=08 ctermbg=NONE

autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')

let g:hardtime_default_on=1
let g:hardtime_ignore_quickfix=1
let g:hardtime_maxcount=2

nnoremap <Leader>g :Grepper<CR>

let g:haskell_enable_quantification=1
let g:haskell_enable_recursivedo=1
let g:haskell_enable_arrowsyntax=1
let g:haskell_enable_pattern_synonyms=1
let g:haskell_enable_typeroles=1
let g:haskell_enable_static_pointers=1

let g:editcommand_no_mappings=1
tmap <C-e> <Plug>EditCommand
"  Plugged }}}

" vim: foldmethod=marker
