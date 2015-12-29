
" Make a pdf
nnoremap <buffer> <Leader>c :terminal pdflatex -shell-escape '%'<CR><CR>
nnoremap <buffer> <Leader>i :!rifle '%:p:r.pdf'<CR><CR>

" Indent
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

" Folding
setlocal foldmethod=marker

