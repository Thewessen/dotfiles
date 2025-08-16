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
    alias_format = "%B %-d, %Y",
    default_tags = nil,
    template = nil,
    workdays_only = false,
  },
  templates = {
    folder = "templates",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M",
    -- A map for custom variables, the key should be the variable and the value a function.
    -- Functions are called with obsidian.TemplateContext objects as their sole parameter.
    -- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#substitutions
    substitutions = {},

    -- A map for configuring unique directories and paths for specific templates
    --- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#customizations
    customizations = {},
  },
  ui = {
    enable = true, -- set to false to disable all additional syntax features
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
})
