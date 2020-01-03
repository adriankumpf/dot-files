function! utils#StripTrailingWhitespaces() abort
  let l:lastSearch = @/
  let l:line = line('.')
  let l:col = col('.')

  execute '%s/\s\+$//e'

  let @/ = l:lastSearch
  call cursor(l:line, l:col)
endfunction

function! utils#RipgrepFzf(query, fullscreen) " Delegate FZFs search responsibliity to ripgrep
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
