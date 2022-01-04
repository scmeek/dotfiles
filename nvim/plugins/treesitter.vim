Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

function TreeSitterInit()
lua << EOF
require'nvim-treesitter.configs'.setup {
  --ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  --ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    --disable = { "c", "rust" },  -- list of language that will be disabled
  },
}
EOF
endfunction

augroup TreeSitterInit
	autocmd!
	autocmd User PlugLoaded call TreeSitterInit()
augroup END

