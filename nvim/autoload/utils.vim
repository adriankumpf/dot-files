function! utils#StripTrailingWhitespaces() abort
  let l:lastSearch = @/
  let l:line = line('.')
  let l:col = col('.')

  execute '%s/\s\+$//e'

  let @/ = l:lastSearch
  call cursor(l:line, l:col)
endfunction
