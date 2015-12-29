
" Interactive
nnoremap <buffer> <Leader>i :!irb -Ilib -r ./%<CR><CR>

" Indent
setlocal tabstop=2
setlocal shiftwidth=2

" Folding
function RubyFold(lnum)
    if getline(a:lnum) =~ '^\s*def\s' || getline(a:lnum) =~ '^\s*class\s' || getline(a:lnum) =~ '^\s*module\s'
        return indent(a:lnum) / 2 + 1
    endif
    if getline(a:lnum) =~ '^\s*end'
        return indent(a:lnum) / 2 + 1
    endif
    if getline(a:lnum - 1) =~ '^\s*end'
        return indent(a:lnum - 1) / 2
    endif
    return '='
endfunction

function RubyFoldText()
    return getline(v:foldstart) . ' +'
endfunction

setlocal foldmethod=expr
setlocal foldexpr=RubyFold(v:lnum)
setlocal foldtext=RubyFoldText()

" Use rake as makeprogram
setlocal makeprg=rake

