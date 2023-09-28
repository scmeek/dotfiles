return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = { options = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp' } },
  keys = {
    { '<leader>qs', function() require('persistence').load() end,                desc = 'Restore [S]ession' },
    { '<leader>ql', function() require('persistence').load({ last = true }) end, desc = 'Restore [L]ast Session' },
    { '<leader>qd', function() require('persistence').stop() end,                desc = "[D]on't Save Current Session" },
  },
}
