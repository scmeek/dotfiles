Plug 'airblade/vim-gitgutter'

"nmap ]h <Plug>(GitGutterNextHunk) " default ]c
"nmap [h <Plug>(gitGutterPrevHunk) " default [c

" Add current file git changes to status line
"function! GitStatus()
	"let [a,m,r] = GitGutterGetHunkSummary()
	"return printf('+%d ~%d -%d', a, m, r)
"endfunction
"set statusline+=%{GitStatus()}
