local M = {}

function M.setup()
  local function apply()
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
    group = vim.api.nvim_create_augroup("dotfiles_highlights", { clear = true }),
    callback = apply,
  })
  apply()
end

return M
