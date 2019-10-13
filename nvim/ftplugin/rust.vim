" deopelete-rust: Automatic racer binary and rust source path detection
if executable('racer')
  let g:deoplete#sources#rust#racer_binary = systemlist('which racer')[0]
endif

if executable('rustc')
  let g:rustc_root = systemlist('rustc --print sysroot')[0] "$ rustup component add rust-src
  let g:rustc_src_dir = g:rustc_root . '/lib/rustlib/src/rust/src'
  if isdirectory(g:rustc_src_dir)
    let g:deoplete#sources#rust#rust_source_path = g:rustc_src_dir
  endif
endif
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
