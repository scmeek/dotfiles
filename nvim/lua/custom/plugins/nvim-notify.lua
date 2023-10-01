local icons = require('icons')

return {
  'rcarriga/nvim-notify',
  config = function()
    local stages_util = require('notify.stages.util')

    require('notify').setup({
      fps = 120,
      icons = {
        DEBUG = icons.dap.log_point,
        ERROR = icons.diagnostics.Error,
        INFO = icons.diagnostics.Info,
        TRACE = icons.git.Modified,
        WARN = icons.diagnostics.Warn,
      },
      render = 'minimal',
      stages = 'static',
      timeout = 2000,
    })
    vim.notify = require('notify')
  end,
}
