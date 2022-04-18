" inoremp == i (insert) + nore (no, recurssive calling IMPORTANT) + map
let mapleader = "\<space>"

map q <Nop>  " Disable macro recording

" Edit configs
nnoremap <leader>ve :edit ~/.config/nvim/init.vim<cr>
nnoremap <leader>vc :edit ~/.config/nvim/coc-settings.json<cr>
nnoremap <leader>vr :source ~/.config/nvim/init.vim<cr>

inoremap kj <Esc> " Go to normal mode

noremap <leader>s :w<CR>
noremap <leader>S :wa<CR>
noremap <leader>q :q<CR>
noremap <leader>Q :q!<CR>
noremap <leader>W :wq<CR>

" Select all
nnoremap <leader>a ggVG

" Easier split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Allow gf to open non-existent files
map gf :edit <cfile><cr>

" Easier splits handling
nnoremap <silent> \| <C-w>v
nnoremap <silent> - <C-w>s
nnoremap <silent> qq <C-W>q

" Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

" Maintain the cursor position when yanking a visual selection
" http://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap y myy`y
vnoremap Y myY`y

" When text is wrapped, move by terminal rows, not lines, unless a count is provided
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Make Y behave like the other capitals
nnoremap Y y$

" Add trailling ; or .
nnoremap ;; A;<Esc>
nnoremap ,, A,<Esc>

" Move line up
nnoremap <leader>k :m -2<CR>
" Move line down
nnoremap <leader>j :m +1<CR>

" Diff with clipboard
"  https://www.reddit.com/r/neovim/comments/sg919r/diff_with_clipboard/huy72t0/?utm_source=reddit&utm_medium=web2x&context=3
local function compare_to_clipboard()
  local ftype = vim.api.nvim_eval("&filetype")
  vim.cmd(string.format([[
    vsplit
    enew
    normal! P
    setlocal buftype=nowrite
    set filetype=%s
    diffthis
    bprevious
    execute "normal! \<C-w>\<C-w>"
    diffthis
  ]], ftype))
end
vim.keymap.set('n', 'cp', compare_to_clipboard)

