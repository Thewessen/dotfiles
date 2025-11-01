-- Na de setup wordt custom commando's gedefinieerd:
--   - `Obsidian weekly` om een weeknote te maken
--      zie: lua/obsidian/commands/weekly.lua

local subs = require("obsidian.templates.substitutions").make()
local helpers = require("obsidian.helpers")

require("obsidian").setup({
  workspaces = {
    {
      name = "notes",
      path = "~/notes",
    },
  },
  picker = {
    name = "fzf-lua",
  },
  legacy_commands = false,
  completion = {
    nvim_cmp = true, -- if you use nvim-cmp, set this to true
  },
  daily_notes = {
    folder = "daily",
    date_format = "%Y-%m-%d",
    alias_format = "%d-%m-%Y",
    default_tags = { "todo" },
    template = 'daily.md',
    workdays_only = false,
  },
  weekly_notes = {
    -- Same folder for easier note creation
    folder = "daily",
    date_format = "%G-W%V",
    alias_format = "Week %V, %G",
    default_tags = { "weekly" },
    template = 'covey_weekplanner.md', -- Laat de template leeg om de standaard te gebruiken
  },
  templates = {
    folder = "templates",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M",
    -- A map for custom variables, the key should be the variable and the value a function.
    -- Functions are called with obsidian.TemplateContext objects as their sole parameter.
    -- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#substitutions
    substitutions = subs,
    -- A map for configuring unique directories and paths for specific templates
    --- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#customizations
    customizations = {
      daily = {
        notes_subdir = "daily",
      },
      weekly = {
        notes_subdir = "daily",
      },
    },
  },
  ui = {
    enable = false, -- set to false to disable all additional syntax features
    ignore_conceal_warn = false, -- set to true to disable conceallevel specific warning
    update_debounce = 200, -- update delay after a text change (in milliseconds)
    max_file_length = 5000, -- disable UI features for files with more than this many lines
    -- Use bullet marks for non-checkbox lists.
    bullets = { char = "•", hl_group = "ObsidianBullet" },
    external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
    -- Replace the above with this if you don't have a patched font:
    -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
    reference_text = { hl_group = "ObsidianRefText" },
    highlight_text = { hl_group = "ObsidianHighlightText" },
    tags = { hl_group = "ObsidianTag" },
    block_ids = { hl_group = "ObsidianBlockID" },
    hl_groups = {
      -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
      ObsidianTodo = { bold = true, fg = "#f78c6c" },
      ObsidianDone = { bold = true, fg = "#89ddff" },
      ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
      ObsidianTilde = { bold = true, fg = "#ff5370" },
      ObsidianImportant = { bold = true, fg = "#d73128" },
      ObsidianBullet = { bold = true, fg = "#89ddff" },
      ObsidianRefText = { underline = true, fg = "#c792ea" },
      ObsidianExtLinkIcon = { fg = "#c792ea" },
      ObsidianTag = { italic = true, fg = "#89ddff" },
      ObsidianBlockID = { italic = true, fg = "#89ddff" },
      ObsidianHighlightText = { bg = "#75662e" },
    },
  },
  footer = {
    enabled = false,
    format = "{{backlinks}} backlinks  {{properties}} properties  {{words}} words  {{chars}} chars",
    hl_group = "Comment",
    separator = string.rep("-", 80),
  },
  checkbox = {
    -- order = { " ", "~", "!", ">", "x" },
    order = { " ", "x" },
  },
  frontmatter = {
    func = function(note)
      -- Add the title of the note as an alias.
      if note.title then
        note:add_alias(note.title)
      end

      local out = { id = note.id, aliases = note.aliases, tags = note.tags }

      -- For daily notes: parse date from note.id and add various date formats
      local date_ts = helpers.parse_date_from_string(note.id)
      if date_ts then
        -- It's likely a daily note (date format in ID)
        local date_formats = helpers.generate_date_formats(date_ts)

        -- Date format keys that contain full date (day, month, year)
        local full_date_keys = {
          "date_iso",
          "date_dd_mm_yyyy",
          "date_dd_mm_yy",
          "date_yyyy_mm_dd",
          "date_dd_mm_yyyy_dots",
        }

        -- Add full date formats as aliases
        for _, key in ipairs(full_date_keys) do
          local alias_value = date_formats[key]
          if alias_value then
            note:add_alias(alias_value)
          end
        end
      end

      if not note.tags or #note.tags == 0 then
        -- If there are no tags, add a default "unlinked" tag.
        out.tags = { "unlinked" }
      end

      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      return out
    end,
  }
})

require("obsidian").register_command("weekly", {
  nargs = "?",
  desc = "Create a weekly note",
  complete = function() return { "-1", "0", "1", "2" } end,
})

require("obsidian").register_command("weeklies", {
  nargs = "?",
  desc = "Browse weekly notes",
  complete = function() return { "-12 0", "-8 0", "-4 4", "-26 0", "0 12" } end,
})

require("obsidian").register_command("save", {
  nargs = "?",
  desc = "Save current buffer to Obsidian vault",
  complete = function() return {} end,
})
