require('neoscroll').setup({
    easing_function = 'sine',
})

local t = {}
t['gg'] = { 'scroll', { '-2*vim.api.nvim_buf_line_count(0)', 'true', '1', '5', e } }
t['G'] = { 'scroll', { '2*vim.api.nvim_buf_line_count(0)', 'true', '1', '5', e } }

require('neoscroll.config').set_mappings(t)
