local M = {}

-- ======= config =======
M.opts = {
  file = vim.fn.expand("$HOME/.zsh_namedirs"),  -- gedeeld bestand
  -- fallback(s) kun je toevoegen, bv. "$HOME/.named_directories"
  cmd_abbrevs = true,  -- maak command-abbreviations aan voor bookmarks
  debug = false,
}

M.ignore_cmds = { 'B', 'Bcd' }

-- ======= utils =======
local function dbg(...)
  if not M.opts.debug then return end
  local t = {}
  for _, v in ipairs({...}) do t[#t+1] = type(v)=="table" and vim.inspect(v) or tostring(v) end
  vim.notify("[zshbookmarks] " .. table.concat(t, " "))
end

local function readfile(path)
  local fd = vim.loop.fs_open(path, "r", 438) -- 0666
  if not fd then return nil end
  local stat = vim.loop.fs_fstat(fd)
  local data = vim.loop.fs_read(fd, stat.size, 0)
  vim.loop.fs_close(fd)
  return data
end

local function strip_quotes(s)
  -- verwijder omliggende '...' of "..."
  return s:match("^'(.*)'$") or s:match('^"(.*)"$') or s
end

local function normalize_path(raw)
  raw = strip_quotes(raw)

  -- al absoluut? klaar.
  if raw:match("^/") then return raw end

  -- gewone home-tilde (~ of ~user) kan Neovim zelf expanderen
  if raw:match("^~/$") or raw:match("^~[%w._-]+/") then
    local expanded = vim.fn.expand(raw)
    return vim.loop.fs_realpath(expanded) or expanded
  end

  -- jouw zsh-namedirs (~work...) laat je eigen mapping oplossen;
  -- géén :p hierop, anders plakt CWD ervoor
  if raw:match("^~[%w._-]+") then
    return raw
  end

  -- overige relatieve paden: maak absoluut tov CWD
  return vim.fn.fnamemodify(raw, ":p")
end

-- Ondersteunt regels als:
--   hash -d work=/path/to/work
--   work=/path/to/work
--   work /path/to/work
local function parse_namedirs(s)
  local map = {}
  for line in s:gmatch("[^\r\n]+") do
    -- strip comment en trims
    line = line:gsub("#.*$", "")
    line = line:gsub("^%s+", ""):gsub("%s+$", "")
    if line ~= "" then
      local name, path = line:match("^hash%s+%-d%s+([%w_%-.]+)=(.+)$")
      if not name then name, path = line:match("^([%w_%-.]+)=(.+)$") end
      if not name then name, path = line:match("^([%w_%-.]+)%s+(.+)$") end
      if name and path then
        path = path:gsub("%s+$","")              -- trim nogmaals
        map[name] = normalize_path(path)
      end
    end
  end
  return map
end

local cache = { mtime = 0, map = {} }

local function load_map()
  local p = M.opts.file
  local stat = vim.loop.fs_stat(p)
  if not stat then return cache.map end
  if stat.mtime.sec ~= cache.mtime then
    local data = readfile(p) or ""
    cache.map = parse_namedirs(data)
    cache.mtime = stat.mtime.sec
  end
  return cache.map
end

local function expand_tilde(word)  -- "~work/foo" -> "/abs/path/foo"
  if not word:match("^~") then return word end
  local name, rest = word:match("^~([%w_%-.]+)(/.*)?$")
  if not name then
    -- ~, ~user, etc. laat Neovim doen
    return vim.fn.expand(word)
  end
  local map = load_map()
  local base = map[name]
  if not base then return word end
  return base .. (rest or "")
end

-- ======= public API =======
function M.bookmarks()
  local map = load_map()
  local items = {}
  for name, path in pairs(map) do
    table.insert(items, { name = name, path = path })
  end
  table.sort(items, function(a,b) return a.name < b.name end)
  return items
end

function M.expand(word)
  return expand_tilde(word)
end

function M.setup(user_opts)
  M.opts = vim.tbl_deep_extend("force", M.opts, user_opts or {})

  if M.opts.cmd_abbrevs then
    for _, it in ipairs(M.bookmarks()) do
      local name = it.name:gsub("[-_.]", "")  -- verwijder ongeldige karakters
      vim.keymap.set("ca", name, it.path, {
        nowait = true,
        desc = "Zsh bookmark: " .. name .. " -> " .. it.path,
      })
    end
  end
end

-- ======= nvim-cmp source for cmdline =======
-- Vereist hrsh7th/nvim-cmp + hrsh7th/cmp-cmdline
function M.register_cmp_source()
  local cmp_ok, cmp = pcall(require, "cmp")
  if not cmp_ok then return end

  local source = {}
  source.new = function() return setmetatable({}, { __index = source }) end

  function source:is_available()
    return true
  end

  -- Trigger op '/', zodat "~work/<Tab>" direct subpaden laat zien
  function source:get_trigger_characters() return { "/", "~" } end

  function source:complete(params, callback)
    local cl = params.context.cursor_before_line -- bv. "e ~work/sr"
    local cmd, arg = cl:match("^([%a]+)%s+(.*)$")
    dbg("cmd= ", cmd, " arg= ", arg)
    if not cmd then return callback({}) end
    if not ({ e=true, edit=true, cd=true, lcd=true, tcd=true })[cmd] then
      return callback({})
    end
    if not arg:match("^~") then
      -- Geen tilde, dus geen bookmarks
      dbg("Geen tilde, dus geen bookmarks")
      return callback({})
    end

    -- Niets getypt -> lijst bookmarks
    if arg == "~" then
      local items = {}
      for _, it in ipairs(M.bookmarks()) do
        table.insert(items, {
          label = "~" .. it.name .. "/",
          filterText = "~" .. it.name,
          textEdit = {
            newText = it.path .. "/",
            range = {
              start = { line = params.context.cursor.line, character = #cmd },
              ["end"] = { line = params.context.cursor.line, character = #cmd + 1 },
            },
          },
          kind = require("cmp.types.lsp").CompletionItemKind.Folder,
          detail = it.path,
        })
      end
      dbg("Returned bookmarks!")
      return callback(items)
    end

    -- "~name[/partial]"
    local nm, tail = arg:match("^~([%w_%-.]+)/*(.*)$")
    dbg("nm= ", nm, " tail= ", tail)
    if nm then
      local base = load_map()[nm]
      dbg("base= ", base)
      if not base then return callback({}) end
      local dir, part = tail:match("^(.*[/])([^/]*)$")
      dir, part = dir or "", part or tail
      local root = base .. "/" .. dir
      local items = {}
      for entry, t in vim.fs.dir(root) do
        if entry:sub(1, #part) == part then
          local abs = base .. "/" .. dir .. entry           -- absoluut pad
          local show = "~" .. nm .. "/" .. dir .. entry     -- wat je wilt tonen
          table.insert(items, {
            label = show .. "/",
            filterText = show,
            textEdit = {
              newText = abs .. "/",
              range = {
                start = { line = params.context.cursor.line, character = #cmd },
                ["end"] = { line = params.context.cursor.line, character = #cmd + 1 },
              },
            },
            kind = (t == "directory")
              and require("cmp.types.lsp").CompletionItemKind.Folder
              or require("cmp.types.lsp").CompletionItemKind.File,
            -- filterText = show,
            detail = abs,
          })
        end
      end
      return callback(items)
    end

    return callback({})  -- geen match
  end

  cmp.register_source("zshbookmarks", source.new())
end


function M.enable_debug(on)
  M.opts.debug = not not on;
  vim.notify("[zshbookmarks] debug = " .. tostring(M.opts.debug))
end

return M
