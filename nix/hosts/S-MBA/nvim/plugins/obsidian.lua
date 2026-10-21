local notes_path = vim.fn.expand("~")
  .. [[/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes]]
local spec = require("config.obsidian")

spec.opts.workspaces = { { name = "notes", path = notes_path } }

return spec
