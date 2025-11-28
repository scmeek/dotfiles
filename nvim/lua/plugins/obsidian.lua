local notes_path = vim.fn.expand("~") .. [[/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes]]

return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = false,
  event = {
    "BufReadPre '" .. notes_path .. "/*.md'",
    "BufNewFile '" .. notes_path .. "/*.md'",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "ibhagwan/fzf-lua", -- Optional
  },
  opts = {
    workspaces = {
      {
        name = "notes",
        path = notes_path,
      },
    },

    daily_notes = {
      folder = "journal",
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
      default_tags = { "daily-note" },
      template = nil,
    },

    completion = {
      nvim_cmp = false,
      min_chars = 2,
    },

    mappings = {
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      ["<cr>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
    },

    new_notes_location = "notes_subdir",

    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      local dlm = "-"
      local sdlm = "_"

      local suffix = ""
      if title ~= nil then
        suffix = title:gsub(" ", dlm):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end

      return suffix
    end,

    markdown_link_func = function(opts)
      return require("obsidian.util").markdown_link(opts)
    end,

    preferred_link_style = "wiki",
    disable_frontmatter = false,

    note_frontmatter_func = function(note)
      -- Add the title of the note as an alias.
      if note.title then
        note:add_alias(note.title)
      end

      local out = {
        title = note.title,
        aliases = {},
        tags = note.tags,
        created = os.date("%Y-%m-%dT%H:%M:%S"),
        modified = os.date("%Y-%m-%dT%H:%M:%S"),
      }

      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      return out
    end,

    ---@param url string
    follow_url_func = function(url)
      vim.ui.open(url)
    end,

    open_app_foreground = false,
    picker = { name = "fzf-lua" },
    sort_by = "modified",
    sort_reversed = true,
    search_max_lines = 1000,
    open_notes_in = "current",

    callbacks = {
      ---@param client obsidian.Client
      post_setup = function(client) end,

      ---@param client obsidian.Client
      ---@param note obsidian.Note
      enter_note = function(client, note) end,

      ---@param client obsidian.Client
      ---@param note obsidian.Note
      leave_note = function(client, note) end,

      ---@param client obsidian.Client
      ---@param note obsidian.Note
      pre_write_note = function(client, note) end,

      ---@param client obsidian.Client
      ---@param workspace obsidian.Workspace
      post_set_workspace = function(client, workspace) end,
    },

    ui = {
      enable = false,
    },

    attachments = {
      img_folder = "assets/imgs",

      ---@return string
      img_name_func = function()
        return string.format("%s-", os.time())
      end,

      ---@param client obsidian.Client
      ---@param path obsidian.Path the absolute path to the image file
      ---@return string
      img_text_func = function(client, path)
        path = client:vault_relative_path(path) or path
        return string.format("![%s](%s)", path.name, path)
      end,
    },
  },
}
