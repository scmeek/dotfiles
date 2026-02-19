return {
  "erichlf/devcontainer-cli.nvim",
  dependencies = { "akinsho/toggleterm.nvim" },
  init = function()
    require("devcontainer-cli").setup({
      interactive = true,
      toplevel = true,
      remove_existing_container = false,
      dotfiles_repository = "https://github.com/scmeek/dotfiles.git",
      dotfiles_branch = "main",
      dotfiles_targetPath = "~/.dotfiles",
      dotfiles_installCommand = "./install -c install_linux.conf.yaml",
      shell = "zsh",
      nvim_binary = "nvim",
      log_level = "debug",
      console_level = "info",
    })
  end,
  keys = {
    { "<leader>Du", ":DevcontainerUp<CR>", desc = "DevContainer: up" },
    { "<leader>Dc", ":DevcontainerConnect<CR>", desc = "DevContainer: connect" },
    { "<leader>Dd", ":DevcontainerDown<CR>", desc = "DevContainer: down" },
    { "<leader>De", ":DevcontainerExec direction='vertical' size='40'<CR>", desc = "DevContainer: exec (vsplit)" },
    { "<leader>Db", ":DevcontainerExec cmd='cd build && make'<CR>", desc = "DevContainer: build" },
    {
      "<leader>Dt",
      ":DevcontainerExec cmd='cd build && make test' direction='horizontal'<CR>",
      desc = "DevContainer: test",
    },
    { "<leader>DT", "<CMD>DevContainerToggle<CR>", desc = "DevContainer: toggle term" },
  },
}
