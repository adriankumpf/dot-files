function! utils#StripTrailingWhitespaces() abort
  let l:lastSearch = @/
  let l:line = line('.')
  let l:col = col('.')

  execute '%s/\s\+$//e'

  let @/ = l:lastSearch
  call cursor(l:line, l:col)
endfunction

function! utils#InsertTabWrapper()
    let l:col = col('.') - 1
    if !l:col || getline('.')[l:col - 1] !~# '\k'
        return "\<Tab>"
    else
        return "\<C-n>"
    endif
  endfunction
