Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'

function BufferLineInit()
lua << EOF
require('bufferline').setup()
EOF
endfunction

augroup BufferLineInit
	autocmd!
	autocmd User PlugLoaded call BufferLineInit()
augroup END

