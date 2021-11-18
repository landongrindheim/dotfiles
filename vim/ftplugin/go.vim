""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""" GO CONFIG """""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
setlocal encoding=utf-8                  " Use Go's default encoding


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""" INTERFACE """""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
setlocal hidden                          " TextEdit can fail if this is not set
setlocal cmdheight=2                     " More space for displaying messages
setlocal list listchars+=tab:\ \         " Display tabs as two spaces


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""" CUSTOM KEY MAPPINGS """""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
                                         " Use <ctrl>+] to jump to definition
nnoremap <buffer><silent> <c-]> <Plug>(coc-definition)
                                         " Use K to look up documentation
nnoremap <silent> K :call <SID>show_documentation()<cr>
                                         " Tab completion using gopls
inoremap <buffer><silent><expr> <tab>
      \ pumvisible() ? "\<c-n>" :
      \ <SID>check_back_space() ? "\<tab>" :
      \ coc#refresh()
inoremap <buffer><expr><s-tab> pumvisible() ? "\<c-p>" : "\<c-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
