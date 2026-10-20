local notes_path =
  "/mnt/c/Users/SeanMeek/OneDrive - Astroscale/Documents/Notes/Astroscale"
local spec = require("config.obsidian")

spec.opts.workspaces = { { name = "notes", path = notes_path } }
spec.opts.daily_notes.folder = "daily"

return spec
