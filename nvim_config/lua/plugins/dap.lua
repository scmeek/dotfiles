local map = vim.keymap.set

return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    map("n", "<leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "debugger Step into" })
    map("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "debugger Step over" })
    map("n", "<leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "debugger Step out" })
    map("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "debugger Continue" })
    map("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "debugger Toggle breakpoint" })
    map(
      "n",
      "<leader>dd",
      "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
      { desc = "debugger Set conditional breakpoint" }
    )
    map("n", "<leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "debugger Reset" })
    map("n", "<leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "debugger Run last" })
  end,
}
