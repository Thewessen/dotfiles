-- OneDrive nvim-cmp source: async, debug, en 2 modi: "word" of "od" (zonder vim.api reads in complete())
local api = require("onedrive.api")

local CFG = {
  -- Gedrag
  mode       = "od",      -- "word" (algemeen) of "od" (alleen binnen [od: ...] in Markdown)
  filetypes  = { "markdown", "md" },          -- leeg = overal; bijv. { "markdown", "md" }
  min_chars  = 2,           -- drempel voor een zoekopdracht
  debounce   = 200,         -- ms

  -- Rendering
  format     = "markdown",  -- "markdown" => [Naam](URL), "url" => https://...
  label      = "name",      -- "name" of "path" als hoofdlabel
  replace_strategy = "insert", -- "insert" (veilig) of "textEdit" (vervang segment/range)

  -- Debug
  debug      = false,
}

local function dbg(...)
  if not CFG.debug then return end
  local t = {}
  for _, v in ipairs({...}) do t[#t+1] = type(v)=="table" and vim.inspect(v) or tostring(v) end
  vim.notify("[cmp_onedrive] " .. table.concat(t, " "))
end

-- ===== Helpers =====
local function url_decode(s)
  if not s or s=="" then return s end
  return (s:gsub("%%(%x%x)", function(h) return string.char(tonumber(h,16)) end))
end

local function pretty_parent_path(parent)
  local p = (parent and parent.path) or ""
  if p:sub(1,12) == "/drive/root:" then p = p:sub(13) end
  return url_decode(p)
end

local function make_insert_text(item)
  local name = item.name or "<no name>"
  local url  = item.webUrl or ""
  return (CFG.format == "url") and url or string.format("[%s](%s)", name, url)
end

local function to_items(values, replace_range)
  local kinds = require('cmp.types').lsp.CompletionItemKind
  local items = {}
  for _, it in ipairs(values or {}) do
    local name = it.name or "<no name>"
    local url  = it.webUrl or ""
    local path = pretty_parent_path(it.parentReference)

    local left  = (CFG.label == "path" and path ~= "" and path) or name
    local right = path
    local disp  = (right ~= "" and right ~= left) and (left .. " — " .. right) or left
    local new_text = make_insert_text(it)

    local entry = {
      label = disp,
      filterText = name .. " " .. right,
      sortText = name,
      detail = url,
      documentation = { kind = "markdown", value = ("**URL:** %s\n\n**Pad:** %s"):format(url, right ~= "" and right or "—") },
      insertText = new_text,           -- fallback + compat
      kind = kinds.File,               -- i.p.v. "Text"
      dup = 0,
    }
    if replace_range and CFG.replace_strategy == "textEdit" then
      entry.textEdit = { newText = new_text, range = replace_range }
    end
    items[#items+1] = entry
  end
  return items
end

-- ===== Query/Range uit params =====

-- MODE = "word"
-- Gebruik het "woord" dat cmp al detecteert:
--  - params.context.cursor_before_line : string vóór de cursor
--  - params.offset : 1-based kolom waar het keyword begint
--  - params.context.cursor.col : 1-based cursor kolom
local function from_params_word(params)
  local ctx = params.context or {}
  local before = ctx.cursor_before_line or ""
  local cur_col = (ctx.cursor and ctx.cursor.col) or #before + 1

  -- Als cmp een offset heeft bepaald op basis van get_keyword_pattern(), gebruik die range.
  local start_col = params.offset or (cur_col - #before:match("([%w_]+)$") or 0)
  -- query is het stuk van offset t/m cursor
  local query = ""
  if start_col and start_col >= 1 and start_col <= #before + 1 then
    query = before:sub(start_col, #before)
  end

  -- LSP 0-based range
  local range
  if CFG.replace_strategy == "textEdit" and start_col then
    local row = (ctx.cursor and ctx.cursor.row) or (vim.api and vim.api.nvim_win_get_cursor and select(1, vim.api.nvim_win_get_cursor(0)) or 1)
    range = {
      start = { line = row - 1, character = start_col - 1 },
      ["end"] = { line = row - 1, character = cur_col - 1 },
    }
  end

  return query, range
end

-- MODE = "od"
-- Alleen triggeren binnen "[od: ...|" en vervang het hele segment.
local function from_params_od(params)
  local ctx = params.context or {}
  local before = ctx.cursor_before_line or ""
  local cur_col = (ctx.cursor and ctx.cursor.col) or (#before + 1)

  local lower = before:lower()
  local last_s
  for s in lower:gmatch("()%[od:%s*") do
    last_s = s
  end
  if not last_s then
    return nil, nil
  end

  -- query start: na ":" + eventuele spaties
  local qstart = last_s + 4
  while qstart <= #before and before:sub(qstart, qstart):match("%s") do
    qstart = qstart + 1
  end
  local query = (qstart <= #before) and before:sub(qstart) or ""

  local range = nil
  if CFG.replace_strategy == "textEdit" then
    local row = (ctx.cursor and ctx.cursor.row) or 1
    range = {
      start = { line = row - 1, character = last_s - 1 },  -- '[' positie
      ["end"] = { line = row - 1, character = cur_col - 1 },
    }
  end

  return query, range
end

-- ===== nvim-cmp Source =====
local Source = {}
Source.__index = Source

function Source:is_available()
  if not CFG.filetypes or #CFG.filetypes == 0 then return true end
  local ft = vim.bo.filetype
  for _, want in ipairs(CFG.filetypes) do if ft == want then return true end end
  return false
end

-- laat cmp z’n eigen woordgrenzen bepalen (we gebruiken params.offset & cursor_before_line)
function Source:get_keyword_pattern()
  if CFG.mode == "od" then
    return [[\k\+]]  -- we gebruiken params voor [od:], pattern maakt minder uit
  else
    -- \k of / . - herhaald: bestandsnaam-vriendelijk
    return [[\%(\k\|[\/\.\-]\)\+]]
  end
end

function Source:get_trigger_characters() return {} end

function Source:complete(params, callback)
  -- cancel oudere runs
  self._req_seq = (self._req_seq or 0) + 1
  local my_seq = self._req_seq

  -- Bepaal query & replace-range UIT params (geen vim.api)
  local query, replace_range
  if CFG.mode == "od" then
    query, replace_range = from_params_od(params)
    dbg("mode=od q='", query, "' (offset=", params.offset, ")")
    if query == nil then
      return callback({ items = {}, isIncomplete = true })
    end
  else
    query, replace_range = from_params_word(params)
    dbg("mode=word q='", query, "' (offset=", params.offset, ")")
    if not query or query == "" then
      return callback({ items = {}, isIncomplete = true })
    end
  end

  local minc = CFG.min_chars or 2
  if #query < minc then
    return callback({
      items = { { label = ("OneDrive: typ ≥%d tekens om te zoeken"):format(minc), insertText = "" } },
      isIncomplete = true,
    })
  end

  -- Debounce
  if self._timer then self._timer:stop(); self._timer:close(); self._timer = nil end
  self._timer = vim.loop.new_timer()
  self._timer:start(CFG.debounce or 180, 0, function()
    -- async Graph query
    api.search_async(query, CFG.max_items or 50, function(err, values)
      vim.schedule(function()
        if my_seq ~= self._req_seq then
          dbg("drop stale (seq ", my_seq, " < ", self._req_seq, ")")
          return
        end

        if err then
          dbg("api error: ", err)
          return callback({
            items = { { label = "[OneDrive] " .. err, insertText = "" } },
            isIncomplete = true,
          })
        end

        local items = to_items(values, replace_range)
        if #items == 0 then
          return callback({
            items = { { label = ("[Geen OneDrive-resultaten voor '%s']"):format(query), insertText = "" } },
            isIncomplete = true,
          })
        end

        callback({ items = items, isIncomplete = true })
      end)
    end)
  end)
end

-- ===== module =====
local M = {}
function M.setup(opts) for k, v in pairs(opts or {}) do if CFG[k] ~= nil then CFG[k] = v end end end
function M.enable_debug(on) CFG.debug = not not on; vim.notify("[cmp_onedrive] debug = " .. tostring(CFG.debug)) end
function M.new() return setmetatable({}, Source) end
return M
