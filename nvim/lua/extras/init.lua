local extras = {
  { import = "lazyvim.plugins.extras.editor.dial" },
  { import = "lazyvim.plugins.extras.editor.inc-rename" },

  { import = "lazyvim.plugins.extras.lang.ansible" },
  { import = "lazyvim.plugins.extras.lang.clangd" },
  { import = "lazyvim.plugins.extras.lang.cmake" },
  { import = "lazyvim.plugins.extras.lang.docker" },
  { import = "lazyvim.plugins.extras.lang.git" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.rust" },
  { import = "lazyvim.plugins.extras.lang.terraform" },
  { import = "lazyvim.plugins.extras.lang.toml" },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.yaml" },

  { import = "lazyvim.plugins.extras.util.dot" },
  { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
}

local enable_copilot = os.getenv("NVIM_ENABLE_COPILOT") == "1"
if enable_copilot then
  table.insert(extras, { import = "lazyvim.plugins.extras.ai.copilot" })
  vim.notify("GitHub Copilot enabled", nil, { id = "github_copilot", style = "minimal" })
end

local enable_avante = os.getenv("NVIM_ENABLE_AVANTE") == "1"
if enable_avante then
  table.insert(extras, { import = "lazyvim.plugins.extras.ai.avante" })
  vim.notify("avante.nvim enabled", nil, { id = "avante", style = "minimal" })
end

return extras
