return {
  {
    "LazyVim/LazyVim",
    init = function()
      require("config.highlights").setup()
    end,
    opts = {
      colorscheme = "tokyonight-moon",
    },
  },
}
