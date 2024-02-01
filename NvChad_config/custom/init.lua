vim.loader.enable()
require("custom.commands")
require("custom.options")

-- Allow for undercurl diagnostics
local hl_groups = { "DiagnosticUnderlineError" }
for _, hl in ipairs(hl_groups) do
	vim.cmd.highlight(hl .. " gui=undercurl")
end
