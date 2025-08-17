-- Picker met voorkeur voor fzf-lua, fallback op Telescope, dan vim.ui.select
local M = {}
local api = require("onedrive.api")

-- decodeer %xx → karakter
local function url_decode(s)
  if not s or s == "" then return s end
  return (s:gsub("%%(%x%x)", function(h) return string.char(tonumber(h, 16)) end))
end

-- strip "/drive/root:" en decodeer
local function pretty_parent_path(parent)
  local p = (parent and parent.path) or ""
  if p:sub(1, 12) == "/drive/root:" then
    p = p:sub(13)
  end
  p = url_decode(p)
  -- als je ook het leidende "/" wilt weghalen, uncomment:
  -- if p:sub(1,1) == "/" then p = p:sub(2) end
  return p
end

local function to_entries(items)
  local out = {}
  for _, it in ipairs(items) do
    local name = it.name or "<no name>"
    local url  = it.webUrl or ""
    local path = pretty_parent_path(it.parentReference)
    local right = (path ~= "" and path) or url or ""
    table.insert(out, {
      id      = it.id,
      name    = name,
      url     = url,
      path    = path,
      display = ("%s  —  %s"):format(name, right),
    })
  end
  return out
end

local function copy_to_clipboard(text)
  vim.fn.setreg("+", text or "")
  vim.notify("Gekopieerd naar clipboard (+)", vim.log.levels.INFO)
end

-- ===== fzf-lua backend (zonder preview) =====
local function fzf_pick(items, cfg)
  local ok, fzf = pcall(require, "fzf-lua")
  if not ok then return false end

  -- Bouw regels: 1=display, 2=url, 3=id, 4=name
  local lines = {}
  for _, it in ipairs(items) do
    table.insert(lines, table.concat({ it.display, it.url or "", it.id or "", it.name or "" }, "\t"))
  end

  -- Acties obv configureerbare mappings
  local open_fn = function(selected)
    if not selected or not selected[1] then return end
    local _, url = selected[1]:match("^(.-)\t(.-)\t")
    if url and url ~= "" then vim.ui.open(url) else vim.notify("Geen webUrl.", vim.log.levels.WARN) end
  end
  local copy_fn = function(selected)
    if not selected or not selected[1] then return end
    local _, url = selected[1]:match("^(.-)\t(.-)\t")
    if url and url ~= "" then copy_to_clipboard(url) end
  end

  local actions = {}
  local map = (cfg.mappings or {}).open
  if map and map.fzf then
    for _, key in ipairs(map.fzf) do actions[key] = open_fn end
  else
    actions["default"] = open_fn
  end
  local mapc = (cfg.mappings or {}).copy
  if mapc and mapc.fzf then
    for _, key in ipairs(mapc.fzf) do actions[key] = copy_fn end
  else
    actions["ctrl-y"] = copy_fn
  end

  fzf.fzf_exec(lines, {
    prompt   = "OneDrive> ",
    fzf_opts = {
      ["--delimiter"] = "\t",
      ["--with-nth"]  = "1",
      -- geen preview
    },
    actions = actions,
  })
  return true
end

-- ===== Telescope backend =====
local function telescope_pick(items, cfg)
  local ok, telescope = pcall(require, "telescope")
  if not ok then return false end
  local pickers      = require("telescope.pickers")
  local finders      = require("telescope.finders")
  local conf         = require("telescope.config").values
  local actions      = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local function open_current(buf)
    local e = action_state.get_selected_entry()
    actions.close(buf)
    if e and e.value and e.value.url then vim.ui.open(e.value.url) end
  end

  local function copy_current(_buf)
    local e = action_state.get_selected_entry()
    if e and e.value and e.value.url then copy_to_clipboard(e.value.url) end
  end

  pickers.new({}, {
    prompt_title = "OneDrive",
    finder = finders.new_table {
      results = items,
      entry_maker = function(it)
        return { value = it, display = it.display, ordinal = it.display }
      end
    },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(buf, _)
      -- Default: Enter opent in browser
      actions.select_default:replace(function() open_current(buf) end)

      -- Extra open-mappings uit config (naast <CR>)
      local opens = (cfg.mappings and cfg.mappings.open and cfg.mappings.open.telescope) or { "<CR>" }
      for _, lhs in ipairs(opens) do
        if lhs ~= "<CR>" then
          vim.keymap.set({ "i", "n" }, lhs, function() open_current(buf) end, { buffer = buf })
        end
      end

      -- Copy mappings uit config
      local copies = (cfg.mappings and cfg.mappings.copy and cfg.mappings.copy.telescope) or { "<C-y>" }
      for _, lhs in ipairs(copies) do
        vim.keymap.set({ "i", "n" }, lhs, function() copy_current(buf) end, { buffer = buf })
      end

      return true
    end,
  }):find()

  return true
end

-- ===== Fallback =====
local function ui_select(items, _cfg)
  local choices = vim.tbl_map(function(it) return it.display end, items)
  vim.ui.select(choices, { prompt = "OneDrive" }, function(choice, idx)
    if not choice or not idx then return end
    local it = items[idx]
    if it.url and it.url ~= "" then vim.ui.open(it.url) end
  end)
  return true
end

function M.pick_search(query, cfg)
  vim.schedule(function()
    local results, err = api.search(query, 75)
    if not results then
      vim.notify(err or "Zoekopdracht mislukt.", vim.log.levels.ERROR)
      return
    end
    local items = to_entries(results)
    if #items == 0 then
      vim.notify("Geen resultaten.", vim.log.levels.INFO)
      return
    end
    if fzf_pick(items, cfg) then return end
    if telescope_pick(items, cfg) then return end
    ui_select(items, cfg)
  end)
end

return M
