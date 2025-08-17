-- nvim-cmp bron voor OneDrive: GEEN 'od:' nodig; gebruikt huidig woord als query
local api = require("onedrive.api")

local CFG = {
  format     = "markdown",  -- "markdown" => [Naam](URL)  |  "url" => https://...
  label      = "name",      -- "name" of "path" als hoofdlabel
  max_items  = 50,
  min_chars  = 3,           -- drempel: vanaf 3 letters zoeken (pas aan)
  debounce   = 200,
  filetypes  = { "markdown", "md" },  -- laat leeg {} om overal toe te staan
  hint       = true,        -- toon hint-item als te kort
  debug      = false,
}

local function dbg(...)
  if not CFG.debug then return end
  local parts = {}
  for _, v in ipairs({...}) do parts[#parts+1] = type(v)=="table" and vim.inspect(v) or tostring(v) end
  vim.notify("[cmp_onedrive] " .. table.concat(parts, " "))
end

-- ===== helpers =====
local function url_decode(s)
  if not s or s=="" then return s end
  return (s:gsub("%%(%x%x)", function(h) return string.char(tonumber(h,16)) end))
end

local function pretty_parent_path(parent)
  local p = (parent and parent.path) or ""
  if p:sub(1,12) == "/drive/root:" then p = p:sub(13) end
  return url_decode(p)
end

-- Bepaal token (woord) vóór de cursor en return ook debug-info
local function current_token()
  local row, col0 = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line() or ""
  local before = (col0 > 0) and line:sub(1, col0) or ""
  -- token = laatste run van [a-zA-Z0-9._/-]
  local s, e = before:find("([%w%._/%-]+)$")
  local token = s and before:sub(s, e) or ""
  return token, row, col0, line
end

local function make_insert_text(item)
  local name = item.name or "<no name>"
  local url  = item.webUrl or ""
  return (CFG.format == "url") and url or string.format("[%s](%s)", name, url)
end

local function to_items(values)
  local items = {}
  for _, it in ipairs(values) do
    local name = it.name or "<no name>"
    local url  = it.webUrl or ""
    local path = pretty_parent_path(it.parentReference)

    local left  = (CFG.label == "path" and path ~= "" and path) or name
    local right = path
    local disp  = (right ~= "" and right ~= left) and (left .. " — " .. right) or left

    items[#items+1] = {
      label = disp,
      filterText = (name .. " " .. right),
      sortText = name,
      detail = url,
      documentation = { kind = "markdown", value = ("**URL:** %s\n\n**Pad:** %s"):format(url, right ~= "" and right or "—") },
      insertText = make_insert_text(it),   -- voor oudere cmp-versies
      -- textEdit   = { newText = make_insert_text(it), range = range }, -- vervang het getypte woord
      dup = 0,
    }
  end
  return items
end

-- ===== nvim-cmp source =====
local Source = {}
Source.__index = Source

function Source:is_available()
  if not CFG.filetypes or #CFG.filetypes == 0 then return true end
  local ft = vim.bo.filetype
  for _, want in ipairs(CFG.filetypes) do if ft == want then return true end end
  return false
end

function Source:get_keyword_pattern()
  return [[\k\+]]  -- laat cmp standaard woordgrenzen bepalen
end

function Source:get_trigger_characters()
  return {}        -- geen speciale triggers
end

function Source:complete(_, callback)
  -- bump request sequence to cancel oudere runs
  self._req_seq = (self._req_seq or 0) + 1
  local my_seq = self._req_seq

  -- (re)start debounce timer
  if self._timer then
    self._timer:stop()
    self._timer:close()
    self._timer = nil
  end
  self._timer = vim.loop.new_timer()
  self._timer:start(CFG.debounce or 180, 0, function()
    -- BELANGRIJK: vanaf hier niets sync met vim.api doen; eerst naar main loop
    vim.schedule(function()
      -- 1) Lees token vóór de cursor via vim.api (nu veilig)
      local token, row, col0, line = current_token()
      dbg("debounced on mainloop: row=", row, " col0=", col0, " len=", #line, " token='", token, "'")

      local minc = CFG.min_chars or 2
      if not token or #token < minc then
        -- nog steeds te kort -> optioneel hint tonen
        if CFG.debug or CFG.hint then
          callback({ { label = ("OneDrive: typ ≥%d tekens om te zoeken"):format(minc), insertText = "" } })
        else
          callback()
        end
        return
      end

      local query = token  -- capture huidige token voor deze run

      -- 2) Start async Graph search (GEEN vim.api hier; alleen in callbacks via schedule)
      api.search_async(query, CFG.max_items or 50, function(err, values)
        -- terug uit libcurl-thread -> weer naar main loop
        vim.schedule(function()
          -- cancel verouderde runs
          if my_seq ~= self._req_seq then
            dbg("drop stale results (seq ", my_seq, " < ", self._req_seq, ")")
            return
          end

          if err then
            dbg("api error: ", err)
            callback({ { label = "[OneDrive] " .. err, insertText = "" } })
            return
          end

          -- (optioneel) check of user intussen het token sterk veranderd heeft
          local cur_token = (function()
            local t = nil
            local ok = pcall(function() t = select(1, current_token()) end)
            return ok and t or query
          end)()
          if not cur_token or #cur_token < minc then
            dbg("results arrived but token now too short; drop")
            return callback()
          end

          local items = to_items(values or {})
          if #items == 0 then
            callback({ { label = ("[Geen OneDrive-resultaten voor '%s']"):format(query), insertText = "" } })
            return
          end
          callback(items)
        end)
      end)
    end)
  end)
end

-- module
local M = {}

function M.setup(opts)
  for k, v in pairs(opts or {}) do if CFG[k] ~= nil then CFG[k] = v end end
end

function M.enable_debug(on)
  CFG.debug = not not on
  vim.notify("[cmp_onedrive] debug = " .. tostring(CFG.debug))
end

function M.new() return setmetatable({}, Source) end

return M
