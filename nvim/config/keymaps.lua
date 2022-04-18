
-- Diff with clipboard
--  https://www.reddit.com/r/neovim/comments/sg919r/diff_with_clipboard/huy72t0/?utm_source=reddit&utm_medium=web2x&context=3
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


