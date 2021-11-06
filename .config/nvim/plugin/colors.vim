" Custom color tweaks

function! s:setup_colors() abort
  hi vertsplit ctermbg=235 ctermfg=245 guifg=#3c3836 guibg=bg
  hi NonText ctermbg=235 ctermfg=245 guifg=#3c3836 guibg=bg

  hi TabLineFill cterm=None ctermfg=15 ctermbg=242 gui=None guibg=bg
  hi TabLineSel ctermfg=142 ctermbg=237 guifg=#b8bb26 guibg=bg

  hi cursorline cterm=none guibg=none
  hi cursorlinenr ctermfg=red guifg=red

  hi link Searchlight Incsearch

  call sign_define("LspDiagnosticsErrorSign", {"text" : "E", "texthl" : "LspDiagnosticsError"})
  call sign_define("LspDiagnosticsWarningSign", {"text" : "W", "texthl" : "LspDiagnosticsWarning"})
  call sign_define("LspDiagnosticsInformationSign", {"text" : "I", "texthl" : "LspDiagnosticsInformation"})
  call sign_define("LspDiagnosticsHintSign", {"text" : "H", "texthl" : "LspDiagnosticsHint"})
endfunction

augroup colors_customization
  au!
  au ColorScheme * call s:setup_colors()
augroup END

call s:setup_colors()
