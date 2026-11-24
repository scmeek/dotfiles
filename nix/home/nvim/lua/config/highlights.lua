local M = {}

-- The builtin "default" colorscheme intentionally leaves most syntax groups
-- (types, constants, preproc, ...) as plain text. Add a bit more color using
-- its own palette.
local function extend_default()
  local shade = vim.o.background == "dark" and "NvimLight" or "NvimDark"
  local function c(name)
    return shade .. name
  end

  local groups = {
    Constant = { fg = c("Magenta") },
    Type = { fg = c("Yellow") },
    PreProc = { fg = c("Magenta"), italic = true },
    ["@keyword.import"] = { link = "PreProc" },
    ["@module"] = { fg = c("Yellow"), italic = true },
    ["@variable.parameter"] = { italic = true },
    ["@variable.builtin"] = { fg = c("Magenta"), italic = true },
    ["@constant.builtin"] = { link = "Constant" },
    ["@type.builtin"] = { fg = c("Yellow"), italic = true },
    ["@tag"] = { fg = c("Blue"), bold = true },
    ["@tag.attribute"] = { link = "@property" },
  }
  for name, hl in pairs(groups) do
    vim.api.nvim_set_hl(0, name, hl)
  end
end

function M.setup()
  local function apply()
    if vim.g.colors_name == "default" then
      extend_default()
    end
    -- Only clear backgrounds; preserve the colorscheme's other attributes.
    for _, name in ipairs({ "Normal", "EndOfBuffer" }) do
      local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
      hl.bg = nil
      hl.ctermbg = nil
      vim.api.nvim_set_hl(0, name, hl)
    end
    vim.api.nvim_set_hl(0, "MultiCursor", { link = "Visual" })
    vim.api.nvim_set_hl(0, "MultiCursorMain", { link = "IncSearch" })
  end

  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup(
      "dotfiles_highlights",
      { clear = true }
    ),
    callback = apply,
  })
  apply()
end

return M
