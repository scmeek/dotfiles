"let g:python3_host_prog = "/usr/local/bin/python3"
let g:deoplete#enable_at_startup = 1

" Window disappear after auto-completion is done
"autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Navigate through auto-completion list with <Tab>
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Disable buffer and around source
call deoplete#custom#option('ignore_sources', {'_': ['around', 'buffer']})

" Increase max width of window
call deoplete#custom#source('_', 'max_menu_width', 80)

" Disable the candidates in Comment/String syntaxes
call deoplete#custom#source('_',
            \ 'disabled_syntaxes', ['Comment', 'String'])

" ALE
" Use ALE and also some plugin 'foobar' as completion sources for all code.
call deoplete#custom#option('sources', {
	\ '_': ['ale'],
	\ 'python': ['jedi'],
	\ 'cpp': ['clang'],
	\ 'c': ['clang']
	\})
