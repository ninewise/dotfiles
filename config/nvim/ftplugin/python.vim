
" Interactive
nnoremap <buffer> <Leader>i :terminal python3 -i %<CR>

" Lint
function! Pylint()
    silent !pylint --reports=n --output-format=parseable '%' > /tmp/errors.err 2> /dev/null
    cfile
    silent !rm /tmp/errors.err
    redraw!
    copen
endfunction

nnoremap <buffer> <Leader>x :call Pylint()<CR>

" Folding
function! PythonFold(lnum)
    if getline(a:lnum-1) =~ '^\s*def\s' || getline(a:lnum-1) =~ '^\s*class\s'
        return indent(a:lnum-1) / 4 + 1
    endif
    if getline(a:lnum) =~ '^\s*def\s' || getline(a:lnum) =~ '^\s*class\s'
        return indent(a:lnum) / 4
    endif
    if getline(a:lnum+1) =~ '^\s*def\s' || getline(a:lnum+1) =~ '^\s*class\s'
        return indent(a:lnum + 1) / 4
    endif
    if getline(a:lnum+1) =~ '^\S.*$'
        return '0'
    endif
    return '='
endfunction

function! PythonFoldText()
    return repeat(' ', indent(v:foldstart - 1) + 4) . '+'
endfunction

setlocal foldmethod=expr
setlocal foldexpr=PythonFold(v:lnum)
setlocal foldtext=PythonFoldText()

