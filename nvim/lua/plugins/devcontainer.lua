return {
  "erichlf/devcontainer-cli.nvim",
  dependencies = { "akinsho/toggleterm.nvim" },
  init = function()
    require("devcontainer-cli").setup({
      -- only the most useful options shown; see full config below
      interactive = false,
      toplevel = true,
      remove_existing_container = false,
      dotfiles_repository = "https://github.com/scmeek/dotfiles.git",
      dotfiles_branch = "main",
      dotfiles_targetPath = "~/.dotfiles",
      dotfiles_installCommand = "./install -c install_linux.conf.yaml",
      shell = "bash",
      nvim_binary = "nvim",
      log_level = "debug",
      console_level = "info",
    })
  end,
}
