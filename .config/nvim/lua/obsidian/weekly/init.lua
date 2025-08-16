-- ~/.config/nvim/lua/obsidian/commands/weekly.lua
local M = {}

-- Helper: bereken maandag voor week met offset (in weken, mag negatief)
local function monday_of_week(offset_weeks)
  local now = os.time()
  local wday = tonumber(os.date("%w", now)) -- 0=zo..6=za
  local days_since_mon = (wday + 6) % 7
  local monday = now - days_since_mon * 86400 + (offset_weeks or 0) * 7 * 86400
  return monday
end

function M.run(args)
  -- In de fork is er een globale 'Obsidian' met dir en opts.
  -- (Zie wiki "Scripting") 
  local root = Obsidian.dir
  local opts = Obsidian.opts
  local W = (opts and opts.weekly_notes) or {}
  local T = (opts and opts.templates) or {}

  local offset = 0
  if args and args.fargs and args.fargs[1] then
    offset = tonumber(args.fargs[1]) or 0
  end

  local monday = monday_of_week(offset)
  local id = os.date(W.date_format or "%G-W%V", monday)
  local alias = os.date(W.alias_format or "Week %V, %G", monday)

  local folder = W.folder or "notes/weeklies"
  local fpath = string.format("%s/%s/%s.md", root, folder, id)

  -- Zorg dat map bestaat
  vim.fn.mkdir(string.format("%s/%s", root, folder), "p")

  -- Als bestand nog niet bestaat: init met frontmatter
  if vim.fn.filereadable(fpath) == 0 then
    local lines = {
      "---",
      string.format('id: "%s"', id),
      string.format('aliases: ["%s"]', alias),
      (W.default_tags and #W.default_tags > 0) and ("tags: [" .. table.concat(W.default_tags, ", ") .. "]") or "tags: []",
      "date: " .. os.date(opts.weekly_notes.date_format),
      "---",
      "", -- lege regel voor content
      "# " .. alias,
      "",
    }
    vim.fn.writefile(lines, fpath)
  end

  -- Open de weeknote
  vim.cmd.edit(vim.fn.fnameescape(fpath))

  -- Optioneel: template invoegen via de ingebouwde subcommand
  if T.folder and W.template then
    -- Cursor onder de frontmatter zetten (regel 8 in bovenstaande scaffold)
    pcall(vim.api.nvim_win_set_cursor, 0, { 8, 0 })
    -- Laat obsidian.nvim de template + substitutions afhandelen
    pcall(vim.cmd, ("Obsidian template %s"):format(W.template))
  end
end

return M
