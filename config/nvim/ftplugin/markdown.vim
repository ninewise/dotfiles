
" Making and showing html
nnoremap <buffer> <Leader>c :terminal markdown '%:p' > '%:p:r.html'<CR>
nnoremap <buffer> <Leader>i :!rifle '%:p:r.html'<CR>

setlocal textwidth=0
setlocal wrapmargin=0
setlocal colorcolumn=0
setlocal wrap
setlocal linebreak
setlocal nolist

nmap <buffer> j gj
nmap <buffer> k gk
