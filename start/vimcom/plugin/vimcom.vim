scriptencoding utf-8

if exists('g:loaded_com')
  finish
endif
let g:loaded_com = 1


" Apparently needed for nvim, otherwise it doesn't work
filetype detect

let g:oneline_comments_map = {
    \ 'c':          '//',
    \ 'cpp':        '//',
    \ 'cuda':       '//',
    \ 'groovy':     '//',
    \ 'vim':        '"',
    \ 'sql':        '--',
    \ 'haskell':    '--',
    \ 'autohotkey': ';',
    \ 'asm':        ';',
    \ 'tex':        '%',
    \ 'bib':        '%',
    \ 'dosbatch':   '::',
    \ 'php':   '//',
    \}

augroup RefreshCommGroup
    autocmd!
    autocmd WinEnter,BufEnter * call vimcom#RefreshComm()
augroup end

call vimcom#RefreshComm()

" Command to change the comment string
command -nargs=1 SetComment let g:com = string(<args>)

" execute 'command -range=1 CmdComm :call vimcom#ToggleComments(<line1>, <line2>)'
command -range=1 CmdComm :call vimcom#ToggleComments(<line1>, <line2>)

" Comment/uncomment using ^/
vnoremap <silent> <C-_> :CmdComm<CR>
nnoremap <silent> <C-_> :CmdComm<CR>
inoremap <silent> <C-_> <ESC>:CmdComm<CR>a

" Apparently some neovim versions understand <C-/> as <C-_>, but
" some don't and accept <C-_>
if has('nvim')
    vnoremap <silent> <C-/> :CmdComm<CR>
    nnoremap <silent> <C-/> :CmdComm<CR>
    inoremap <silent> <C-/> <ESC>:CmdComm<CR>a
endif

