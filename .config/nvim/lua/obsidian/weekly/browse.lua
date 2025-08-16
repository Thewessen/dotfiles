-- lua/obsidian/weekly/browse.lua
local M = {}

local function monday_of_week(offset_weeks)
  local now  = os.time()
  local wday = tonumber(os.date("%w", now)) -- 0=zo..6=za
  local days_since_mon = (wday + 6) % 7
  local monday = now - days_since_mon * 86400 + (offset_weeks or 0) * 7 * 86400
  local t = os.date("*t", monday); t.hour, t.min, t.sec = 0, 0, 0
  return os.time(t)
end

local function week_entry(offset, root, W)
  local ts    = monday_of_week(offset)
  local id    = os.date(W.date_format  or "%G-W%V", ts)
  local alias = os.date(W.alias_format or "Week %V, %G", ts)
  local folder = W.folder or "notes/weeklies"
  local path   = string.format("%s/%s/%s.md", root, folder, id)
  local exists = (vim.fn.filereadable(path) == 1)
  return {
    offset   = offset,
    id       = id,
    alias    = alias,
    path     = path,
    exists   = exists,
    display  = string.format("%s  —  %s%s",
                 id, alias, exists and "" or "  [NEW]"),
    ordinal  = string.format("%s %s %s", id, alias, exists and "1" or "0"),
  }
end

local function build_entries(root, W, from_o, to_o)
  local lo, hi = tonumber(from_o) or 0, tonumber(to_o or from_o) or 0
  if lo > hi then lo, hi = hi, lo end
  local items = {}
  for o = hi, lo, -1 do -- nieuwste boven
    table.insert(items, week_entry(o, root, W))
  end
  return items
end

local function open_week_at_offset(offset)
  -- hergebruik je bestaande open/create uit weekly module
  local ok, weekly = pcall(require, "obsidian.weekly")
  if ok and weekly and weekly.open then
    return weekly.open(offset)
  end
  -- noodgreep: roep subcommand aan (werkt ook)
  vim.cmd(("Obsidian weekly %d"):format(offset))
end

-- Telescope-variant met preview
local function telescope_pick(items)
  local ok, telescope = pcall(require, "telescope")
  if not ok then return false end

  local pickers     = require("telescope.pickers")
  local finders     = require("telescope.finders")
  local conf        = require("telescope.config").values
  local actions     = require("telescope.actions")
  local action_state= require("telescope.actions.state")

  pickers.new({}, {
    prompt_title = "Weeklies",
    finder = finders.new_table {
      results = items,
      entry_maker = function(it)
        return {
          value    = it,
          display  = it.display,
          ordinal  = it.ordinal,
          filename = it.exists and it.path or nil, -- preview alleen als 'ie bestaat
        }
      end
    },
    sorter   = conf.generic_sorter({}),
    previewer= conf.file_previewer({}),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if entry and entry.value then open_week_at_offset(entry.value.offset) end
      end)
      return true
    end,
  }):find()

  return true
end

-- Fallback: eenvoudige select zonder preview
local function ui_select(items)
  local choices = vim.tbl_map(function(it) return it.display end, items)
  vim.ui.select(choices, { prompt = "Weeklies" }, function(choice, idx)
    if not choice or not idx then return end
    local it = items[idx]
    open_week_at_offset(it.offset)
  end)
  return true
end

function M.run(args)
  local root = Obsidian.dir
  local W    = (Obsidian.opts and Obsidian.opts.weekly_notes) or {}

  local fargs = (args and args.fargs) or {}
  local from_o, to_o = fargs[1], fargs[2]
  local items = build_entries(root, W, from_o or -12, to_o or 4) -- standaard venster: ~Q-jaar

  if telescope_pick(items) then return end
  -- eventueel kun je hier fzf-lua/mini.pick/snacks toevoegen
  ui_select(items)
end

return M
