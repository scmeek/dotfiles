require('which-key').register({
  ['<Leader>q'] = { name = 'Persistence', _ = 'which_key_ignore' },
})

return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  keys = {
    { '<leader>qs', function() require('persistence').load() end,                desc = 'Restore [S]ession' },
    { '<leader>ql', function() require('persistence').load({ last = true }) end, desc = 'Restore [L]ast Session' },
    { '<leader>qd', function() require('persistence').stop() end,                desc = "[D]on't Save Current Session" },
  },
  config = function()
    require('persistence').setup({
      options = {
        'buffers',
        'curdir',
        'tabpages',
        'winsize',
        'help',
        'globals',
        'skiprtp'
      },
    })
  end,
}
