vim.g.rustaceanvim = {
  server = {
    -- Root detection is asynchronous: the current buffer may belong to another
    -- project by the time this runs. Resolve rustup from the LSP's project root.
    cmd = function()
      return function(dispatchers, config)
        local analyzer = vim.fs.joinpath(
          vim.fs.dirname(vim.fn.exepath("rustup")),
          "rust-analyzer"
        )
        return vim.lsp.rpc.start({ analyzer }, dispatchers, {
          cwd = config.root_dir,
          env = config.cmd_env,
          detached = config.detached,
        })
      end
    end,
    default_settings = {
      ["rust-analyzer"] = {
        checkOnSave = true,
        cachePriming = {
          -- Skip startup cache priming; may make the first requests slower
          enable = false,
        },
        diagnostics = {
          enable = true,
        },
        cargo = {
          buildScripts = {
            -- Keep build-script support for crates that require it
            enable = true,
          },
          -- Separate RA build artifacts from regular cargo builds
          targetDir = true,
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
