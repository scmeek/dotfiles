vim.g.rustaceanvim = {
  server = {
    default_settings = {
      ["rust-analyzer"] = {
        cachePriming = {
          enable = false, -- Skip startup cache priming; may make the first requests slower
        },
        -- diagnostics = {
        --   disabled = { "unresolved-proc-macro" }, -- Prevent macro loops from freezing the editor
        -- },
        cargo = {
          buildScripts = {
            enable = true, -- Keep build-script support for crates that require it
          },
          targetDir = true, -- Separate RA build artifacts from regular cargo builds
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
