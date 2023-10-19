require('which-key').register({
  ['<leader>h'] = { name = '[H]arpoon', _ = 'which_key_ignore' },
})

return {
  'ThePrimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>hm', function() require("harpoon.ui").toggle_quick_menu() end, desc = '[H]arpoon - Show [M]enu' },
    { '<leader>ha', function() require("harpoon.mark").add_file() end,        desc = '[H]arpoon - [A]dd file' },
    { '<leader>hh', function() require("harpoon.ui").nav_file(1) end,         desc = '[H]arpoon - Go to file 1' },
    { '<leader>hj', function() require("harpoon.ui").nav_file(2) end,         desc = '[H]arpoon - Go to file 2' },
    { '<leader>hk', function() require("harpoon.ui").nav_file(3) end,         desc = '[H]arpoon - Go to file 3' },
    { '<leader>hl', function() require("harpoon.ui").nav_file(4) end,         desc = '[H]arpoon - Go to file 4' },
    { '<leader>h;', function() require("harpoon.ui").nav_file(5) end,         desc = '[H]arpoon - Go to file 5' },
    { '<leader>hc', function() require("harpoon.mark").clear_all() end,       desc = '[H]arpoon - [C]lear all marks' },
  },
  config = function()
    require('harpoon').setup({
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      }
    })
    require("telescope").load_extension('harpoon')
  end,
}
