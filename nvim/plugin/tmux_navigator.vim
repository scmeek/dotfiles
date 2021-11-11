" Custom mappings
"let g:tmux_navigator_no_mappings = 1

"nnoremap <silent> {Left-Mapping} :TmuxNavigateLeft<cr>
"nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
"nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
"nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
"nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

" Autosave on leave
" 1 = :update (write the current buffer, but only if changed)
" 2 = :wall (write all buffers)
let g:tmux_navigator_save_on_switch = 1

" Disable tmux navigator when zooming the Vim pane
"let g:tmux_navigator_disable_when_zoomed = 1

" If the tmux window is zoomed, keep it zoomed when moving from Vim to another
" pane. (g:tmux_navigator_disable_when_zoomed=1 disables this)
let g:tmux_navigator_preserve_zoom = 1
