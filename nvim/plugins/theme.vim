Plug 'dracula/vim',{'as':'dracula'}

if (has("termguicolors"))
    set termguicolors
endif

augroup DraculaOverrides
	autocmd!
	autocmd ColorScheme dracula highlight DraculaBoundary guibg=none
    autocmd ColorScheme dracula highlight DraculaDiffDelete ctermbg=none guibg=none
    autocmd ColorScheme dracula highlight DraculaComment cterm=italic gui=italic
    autocmd ColorScheme dracula highlight Normal guibg=None
    autocmd User PlugLoaded ++nested colorscheme dracula
augroup end

