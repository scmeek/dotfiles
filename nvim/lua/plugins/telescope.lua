return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  config = function()
    require('telescope').setup({
      pickers = {
        oldfiles = {
          prompt_title = 'Recent Files',
        },
      },
      defaults = {
        mappings = {
          n = {
            ['<C-w>'] = require('telescope.actions').delete_buffer,
          },
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
            ['<C-h>'] = 'which_key',
            ['<C-w>'] = require('telescope.actions').delete_buffer,
          },
        },
      },
    })

    pcall(require('telescope').load_extension, 'fzf')

    vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>/', function()
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files, { desc = 'Search [F]iles' })
    vim.keymap.set('n', '<leader>g', require('telescope.builtin').live_grep, { desc = 'Search by [G]rep' })
    vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
  end,
}
