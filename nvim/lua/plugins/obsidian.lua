local notes_path = vim.fn.expand("~") .. [[/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes]]

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = false,
  dependencies = { "ibhagwan/fzf-lua" },
  init = function()
    vim.g.obsidian_default_keymap = false
  end,
  opts = {
    legacy_commands = false,
    workspaces = { { name = "notes", path = notes_path } },
    daily_notes = {
      folder = "journal",
      date_format = "YYYY-MM-DD",
      alias_format = "MMMM D, YYYY",
      default_tags = { "daily-note" },
    },
    completion = { min_chars = 2 },
    new_notes_location = "notes_subdir",
    note = { template = vim.NIL },
    note_id_func = function(title, dir)
      local base = title and title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower() or ""
      if base == "" then
        base = require("obsidian.builtin").zettel_id()
      end
      local candidate, suffix = base, 2
      local Path = require("obsidian.path")
      while dir and (Path.new(dir) / candidate):with_suffix(".md", true):exists() do
        candidate = string.format("%s-%d", base, suffix)
        suffix = suffix + 1
      end
      return candidate
    end,
    link = { style = "wiki" },
    frontmatter = {
      enabled = true,
      func = function(note)
        if note.title then
          note:add_alias(note.title)
        end

        local out = {
          title = note.title,
          aliases = note.aliases,
          tags = note.tags,
          created = os.date("%Y-%m-%dT%H:%M:%S"),
          modified = os.date("%Y-%m-%dT%H:%M:%S"),
        }

        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        out.modified = os.date("%Y-%m-%dT%H:%M:%S")
        return out
      end,
    },
    picker = { name = "fzf-lua" },
    search = { sort_by = "modified", sort_reversed = true, max_lines = 1000 },
    open_notes_in = "current",
    open = {
      func = function(uri)
        if vim.fn.has("macunix") == 1 then
          return vim.ui.open(uri, { cmd = { "open", "-g" } })
        end
        return vim.ui.open(uri)
      end,
    },
    callbacks = {
      enter_note = function()
        vim.keymap.set("n", "gf", function()
          return require("obsidian.api").cursor_link() and "<cmd>Obsidian follow_link<cr>" or "gf"
        end, { buffer = true, expr = true, desc = "Follow note link" })
        vim.keymap.set("n", "<leader>ch", function()
          require("obsidian.actions").toggle_checkbox()
        end, { buffer = true, desc = "Toggle checkbox" })
        vim.keymap.set("n", "<CR>", function()
          return require("obsidian.actions").smart_action()
        end, { buffer = true, expr = true, desc = "Obsidian smart action" })
      end,
    },
    ui = { enable = false },
    footer = { enabled = false },
    statusline = { enabled = false },
    attachments = {
      folder = "assets/imgs",
      img_name_func = function()
        return string.format("%s-", os.time())
      end,
      img_text_func = function(path)
        local Path = require("obsidian.path")
        local image_path = Path.new(path):resolve()
        local ok, relative = pcall(image_path.relative_to, image_path, Obsidian.workspace.path)
        return string.format("![%s](%s)", image_path.name, ok and relative or image_path)
      end,
    },
  },
}
