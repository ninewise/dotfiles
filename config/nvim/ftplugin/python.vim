
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

function! IndentLevel(lnum)
    return indent(a:lnum) / &shiftwidth
endfunction

function! IsBlankLine(lnum)
    return getline(a:lnum) =~? '\v^\s*$'
endfunction

function! IsDefLine(lnum)
    return getline(a:lnum) =~ '^\s*def\s' || getline(a:lnum) =~ '^\s*class\s'
endfunction

" Folding
function! PythonFold(lnum)
    if IsBlankLine(a:lnum)
        return '-1'
    endif

    let this_indent = IndentLevel(a:lnum)
    if IsDefLine(a:lnum)
        return '>' . (this_indent + 1)
    endif

    let minimum = this_indent
    let current = a:lnum
    while current > 1 && minimum > 0
        let current -= 1
        if IsBlankLine(current)
            continue
        endif
        let current_indent = IndentLevel(current)
        if current_indent < minimum
            if IsDefLine(current)
                return current_indent + 1
            endif
            let minimum = current_indent
        endif
    endwhile
    return minimum
endfunction

function! PythonFoldText()
    return getline(v:foldstart) . ' (' . (v:foldend - v:foldstart) . ' lines) '
endfunction

setlocal foldmethod=expr
setlocal foldexpr=PythonFold(v:lnum)
setlocal foldtext=PythonFoldText()

