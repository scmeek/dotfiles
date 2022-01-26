Plug 'karb94/neoscroll.nvim'

function NeoscrollInit()
lua << EOF
require('neoscroll').setup()
EOF
endfunction

augroup NeoscrollInit
	autocmd!
	autocmd User PlugLoaded call NeoscrollInit()
augroup END

