return {
  "mikavilpas/yazi.nvim",
  version = "*", -- use the latest stable version
  event = "VeryLazy",
  init = function()
    local function set_highlights()
      vim.api.nvim_set_hl(0, "YaziFloat", { link = "NormalFloat" })
    end

    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("YaziHighlights", { clear = true }),
      callback = set_highlights,
    })
    set_highlights()
  end,
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  keys = {
    {
      "<leader>y",
      mode = { "n", "v" },
      "<cmd>Yazi<cr>",
      desc = "Open yazi at the current file",
    },
    {
      "<leader>cw",
      "<cmd>Yazi cwd<cr>",
      desc = "Open the file manager in nvim's working directory",
    },
    {
      "<c-up>",
      "<cmd>Yazi toggle<cr>",
      desc = "Resume the last yazi session",
    },
  },
  opts = {
    open_for_directories = false,

    integrations = {
      grep_in_directory = function(directory)
        require("fzf-lua").live_grep({
          search_paths = { directory },
          rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden --no-ignore -e",
        })
      end,
      grep_in_selected_files = function(_, relative_paths)
        require("fzf-lua").live_grep({
          search_paths = relative_paths,
          rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden --no-ignore -e",
        })
      end,
    },

    hooks = {
      on_yazi_ready = function(_, _, api)
        api:emit_to_yazi({ "hidden", "show" })
      end,
      yazi_opened = function(_, buffer, config)
        vim.keymap.set(
          "t",
          "<c-_>",
          config.keymaps.open_file_in_horizontal_split,
          {
            buffer = buffer,
            remap = true,
            desc = "Open file in horizontal split",
          }
        )
      end,
    },

    keymaps = {
      show_help = "<f1>",
      open_file_in_horizontal_split = "<c-->",
      open_file_in_vertical_split = "<c-\\>",
      change_working_directory = "<c-x>",
    },
  },
}
