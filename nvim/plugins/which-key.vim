Plug 'folke/which-key.nvim'

set timeoutlen=250

function WhichKeySetup()
lua << EOF
require("which-key").setup {}
EOF
endfunction

augroup WhichKeySetup
    autocmd!
    autocmd User PlugLoaded call WhichKeySetup()
augroup END

