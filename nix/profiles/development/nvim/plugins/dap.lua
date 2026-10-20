return {
  "mfussenegger/nvim-dap",
  dependencies = { "rcarriga/nvim-dap-ui" },
  keys = {
    {
      "<leader>dl",
      function()
        require("dap").step_into()
      end,
      desc = "Debugger Step into",
    },
    {
      "<leader>dj",
      function()
        require("dap").step_over()
      end,
      desc = "Debugger Step over",
    },
    {
      "<leader>dk",
      function()
        require("dap").step_out()
      end,
      desc = "Debugger Step out",
    },
    {
      "<leader>dc",
      function()
        require("dap").continue()
      end,
      desc = "Debugger Continue",
    },
    {
      "<leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Debugger Toggle breakpoint",
    },
    {
      "<leader>dd",
      function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end,
      desc = "Debugger Set conditional breakpoint",
    },
    {
      "<leader>de",
      function()
        require("dap").terminate()
      end,
      desc = "Debugger Reset",
    },
    {
      "<leader>dr",
      function()
        require("dap").run_last()
      end,
      desc = "Debugger Run last",
    },
  },
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
  end,
}
