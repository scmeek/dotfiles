vim.g.rustaceanvim = {
  server = {
    -- Resolve through system rustup beside the buffer, respecting repo toolchains.
    cmd = function()
      local cwd = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
      return function(dispatchers, config)
        cwd = cwd or config.root_dir
        local analyzer = vim.fs.joinpath(
          vim.fs.dirname(vim.fn.exepath("rustup")),
          "rust-analyzer"
        )
        return vim.lsp.rpc.start({ analyzer }, dispatchers, {
          cwd = cwd or config.root_dir,
          env = config.cmd_env,
          detached = config.detached,
        })
      end
    end,
    default_settings = {
      ["rust-analyzer"] = {
        -- Disable check-on-save so it doesn't run cargo check/clippy concurrently with bacon
        checkOnSave = false,
        cachePriming = {
          -- Skip startup cache priming; may make the first requests slower
          enable = false,
        },
        diagnostics = {
          -- Disable native diagnostics so they don't overlap with bacon-ls diagnostics
          enable = false,
          --   -- Prevent macro loops from freezing the editor
          --   disabled = { "unresolved-proc-macro" },
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
