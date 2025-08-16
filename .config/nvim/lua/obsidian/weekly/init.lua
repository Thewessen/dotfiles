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

local function open_create_for_offset(offset)
  local root = Obsidian.dir
  local opts = Obsidian.opts
  local W    = (opts and opts.weekly_notes) or {}
  local T    = (opts and opts.templates) or {}

  local monday = (function(o)
    local now  = os.time()
    local wday = tonumber(os.date("%w", now))
    local days_since_mon = (wday + 6) % 7
    local mon = now - days_since_mon * 86400 + (o or 0) * 7 * 86400
    local t = os.date("*t", mon); t.hour, t.min, t.sec = 0, 0, 0
    return os.time(t)
  end)(offset)

  local id     = os.date(W.date_format  or "%G-W%V", monday)
  local alias  = os.date(W.alias_format or "Week %V, %G", monday)
  local folder = W.folder or "notes/weeklies"
  local fpath  = string.format("%s/%s/%s.md", root, folder, id)

  vim.fn.mkdir(string.format("%s/%s", root, folder), "p")
  if vim.fn.filereadable(fpath) == 0 then
    local lines = {
      "---",
      ('id: "%s"'):format(id),
      ('aliases: ["%s"]'):format(alias),
      "type: weekly",
      ("week_start: %s"):format(os.date("%Y-%m-%d", monday)),
      (W.default_tags and #W.default_tags > 0)
        and ("tags: [" .. table.concat(W.default_tags, ", ") .. "]")
        or "tags: []",
      "---",
      "",
      "# " .. alias,
      "",
    }
    vim.fn.writefile(lines, fpath)
    if (T and T.folder) and W.template then
      pcall(vim.cmd, ("Obsidian template %s"):format(W.template))
    end
  end

  vim.cmd.edit(vim.fn.fnameescape(fpath))
end

function M.open(offset) return open_create_for_offset(tonumber(offset) or 0) end

function M.run(args)
  -- In de fork is er een globale 'Obsidian' met dir en opts.
  -- (Zie wiki "Scripting") 
  local off = 0
  if args and args.fargs and args.fargs[1] then off = tonumber(args.fargs[1]) or 0 end
  return M.open(off)
end

return M
