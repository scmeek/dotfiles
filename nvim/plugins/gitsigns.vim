Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'

function GitSignsInit()
lua << EOF
require('gitsigns').setup()
EOF
endfunction

augroup GitSignsiInit
	autocmd!
	autocmd User PlugLoaded call GitSignsInit()
augroup END

