
function! vimcom#RefreshComm() abort
    " TODO: Use value from &comments
    " if has_key(g:oneline_comments_map, &filetype)
        let g:com = get(g:oneline_comments_map, &filetype, '#')
    " else
        " let g:com = 
    " endif
endfunction

function! vimcom#IsPrefix(str, pref) abort
    return a:str[ 0 : len(a:pref) - 1 ] == a:pref
endfunction

function! vimcom#CountPrefixSpaces(str) abort
    let l:size = len(a:str)
    for i in range(0, l:size - 1)
        if (a:str[i] != " ")
            return i
        endif
    endfor
    return l:size
endfunction

function! vimcom#SpaceStr(size) abort
    let l:str = ""
    for i in range(a:size)
        let l:str .= " "
    endfor
    return l:str
endfunction

function! vimcom#ToggleComments(begin, end) abort
    " Check if all lines are commented
    let l:comment = g:com . " "
    let l:oneline = a:end - a:begin == 0
    let l:all = 1

    let l:spaces = 0xffff
    let l:has_spaces = 0

    for l:i in range(a:begin, a:end)
        let l:line = getline(l:i)
        if len(l:line) > 0
            let l:spaces = min([ l:spaces, vimcom#CountPrefixSpaces(l:line) ])
            let l:has_spaces = 1
        endif
    endfor

    let l:spaces = l:has_spaces ? l:spaces : 0
    let l:ws = vimcom#SpaceStr(l:spaces)
    " echo "ws '" . l:ws . "' has " . string(l:has_spaces) . " spaces " . string(l:spaces)
    let l:ws_com = l:ws . l:comment

    for l:i in range(a:begin, a:end)
        let l:line = getline(l:i)
        if (len(l:line) > 0 || l:oneline) && !vimcom#IsPrefix(l:line, l:ws_com)
            let l:all = 0
        endif
    endfor

    " If they are, remove comment, otherwise add comment
    if l:all == 1
        let l:pat = l:ws_com
        let l:sub = l:ws
    else
        let l:pat = l:ws
        let l:sub = l:ws_com
    endif

    " Get cursor pos before anything is changed
    let l:pos = getpos('.')

    " Do the actual substitutions
    for i in range(a:begin, a:end)
        let l:line = getline(l:i)
        if len(l:line) > 0 || l:oneline
            call setline(l:i, substitute(l:line, pat, sub, ""))
        endif
        let l:i += 1
    endfor

    " Now move the cursor to the expected position
    if l:pos[2] >= l:spaces
        call cursor(l:pos[1], l:pos[2] + len(l:sub) - len(l:pat))
    endif
endfunction


