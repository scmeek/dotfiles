" inoremp == i (insert) + nore (no, recurssive calling IMPORTANT) + map

let mapleader = "\<space>"

map q <Nop>  " Disable macro recording

" Edit configs
nnoremap <leader>ve :edit ~/.config/nvim/init.vim<cr>
nnoremap <leader>vc :edit ~/.config/nvim/coc-settings.json<cr>
nnoremap <leader>vr :source ~/.config/nvim/init.vim<cr>

inoremap kj <Esc>w<CR> " Go to normal mode and save

noremap <leader>s :w<CR>
noremap <leader>S :wa<CR>
noremap <leader>q :q<CR>
noremap <leader>Q :wq<CR>

" Select all
nnoremap <leader>a ggVG

" Close current buffer
noremap <silent> <leader>c :bd<CR>

" Easier split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Allow gf to open non-existent files
map gf :edit <cfile><cr>

" Easier vertical split creation
nnoremap <silent> vv <C-w>v

" Quit window
nnoremap <leader>wq <C-W>q

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

" Move line up
nnoremap <leader>k :m -2<CR>
" Move line down
nnoremap <leader>j :m +1<CR>

" Indent with TAB
nnoremap <TAB> >>
vnoremap <TAB> >gv
" Dedent with S-TAB
vnoremap <S-TAB> <gv
nnoremap <S-TAB> <<

