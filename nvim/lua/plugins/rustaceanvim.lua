vim.g.rustaceanvim = {
  server = {
    default_settings = {
      ["rust-analyzer"] = {
        cachePriming = {
          enable = false, -- Stop aggressive background crawling on startup
        },
        diagnostics = {
          disabled = { "unresolved-proc-macro" }, -- Prevent macro loops from freezing the editor
        },
        cargo = {
          buildScripts = {
            enable = true, -- Required for many crates, but keep it on
          },
          targetDir = true, -- Tells RA to use a separate dedicated cache folder
        },
      },
    },
  },
}

return {
  "mrcjkb/rustaceanvim",
  version = "^6", -- Recommended
  lazy = false, -- This plugin is already lazy
}
