" Format on save
au BufWrite * :Autoformat

" Disable fallback to vim's indent file
let g:autoformat_autoindent = 0
" Disable retabbing
let g:autoformat_retab = 0
" Disable removing trailing whitespace
let g:autoformat_remove_trailing_spaces = 0

" Specific file types
"autocmd FileType vim,tex let b:autoformat_autoindent=0

