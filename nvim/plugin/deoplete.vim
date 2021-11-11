"let g:python3_host_prog = "/usr/local/bin/python3"
let g:deoplete#enable_at_startup = 1

" Window disappear after auto-completion is done
"autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Navigate through auto-completion list with <Tab>
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

