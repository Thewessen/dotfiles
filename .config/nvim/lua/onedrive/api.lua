-- Eenvoudige Microsoft Graph helpers voor OneDrive + zoek-cache
local M = {}
local curl = require("plenary.curl")
local auth = require("onedrive.auth")

local BASE = "https://graph.microsoft.com/v1.0"
function M.set_base(url) if type(url)=="string" and url~="" then BASE = url end end

-- ===== Cache config/state =====
local cfg_cache = {
  enabled = true,
  ttl = 300,
  persist = true,
  max_entries = 200,
  path = nil, -- default in init()
}
local cache = { map = {}, lru = {} }  -- map[key] = { ts=number, value=<results> }; lru: array of keys (MRU at end)
local cache_loaded = false

local function jdecode(s)
  local ok, mod = pcall(function() return vim.json end)
  if ok and mod and mod.decode then return mod.decode(s) end
  return vim.fn.json_decode(s)
end
local function jencode(t)
  local ok, mod = pcall(function() return vim.json end)
  if ok and mod and mod.encode then return mod.encode(t) end
  return vim.fn.json_encode(t)
end

local function cache_path_default()
  return (cfg_cache.path and cfg_cache.path ~= "")
    and cfg_cache.path
     or (vim.fn.stdpath("cache") .. "/onedrive_search_cache.json")
end

local function lru_touch(key)
  for i, k in ipairs(cache.lru) do
    if k == key then table.remove(cache.lru, i); break end
  end
  table.insert(cache.lru, key)
  while #cache.lru > cfg_cache.max_entries do
    local old = table.remove(cache.lru, 1)
    cache.map[old] = nil
  end
end

local function sanitize_results(values)
  -- bewaar alleen velden die we tonen/gebruiken
  local out = {}
  for _, it in ipairs(values or {}) do
    table.insert(out, {
      id = it.id,
      name = it.name,
      webUrl = it.webUrl,
      parentReference = { path = it.parentReference and it.parentReference.path or "" },
    })
  end
  return out
end

local function cache_load()
  if cache_loaded or not cfg_cache.persist then return end
  local f = io.open(cache_path_default(), "r"); if not f then cache_loaded = true; return end
  local ok, data = pcall(jdecode, f:read("*a")); f:close()
  if ok and type(data) == "table" and data.map and data.lru then
    cache = data
  end
  cache_loaded = true
end

local function cache_save()
  if not cfg_cache.persist then return end
  local f = io.open(cache_path_default(), "w"); if not f then return end
  f:write(jencode(cache)); f:close()
end

function M.set_cache_config(o)
  if type(o) == "table" then
    for k, v in pairs(o) do if cfg_cache[k] ~= nil then cfg_cache[k] = v end end
  end
  if not cfg_cache.path or cfg_cache.path == "" then
    cfg_cache.path = cache_path_default()
  end
  cache_load()
end

function M.clear_cache()
  cache = { map = {}, lru = {} }
  if cfg_cache.persist then
    os.remove(cache_path_default())
  end
end

-- ===== helpers =====
local function bearer()
  return { Authorization = "Bearer " .. auth.token() }
end

-- RFC3986-ish urlencode (spaties etc. -> %XX)
local function urlencode(s)
  return (s:gsub("([^%w%-%._~])", function(c)
    return string.format("%%%02X", string.byte(c))
  end))
end

local function cache_key(q, top)
  return string.format("q:%s|top:%d|base:%s", q, top or 50, BASE)
end

local function cache_get(key)
  if not cfg_cache.enabled then return nil end
  local ent = cache.map[key]; if not ent then return nil end
  if (os.time() - (ent.ts or 0)) > cfg_cache.ttl then
    cache.map[key] = nil
    return nil
  end
  lru_touch(key)
  return ent.value
end

local function cache_put(key, values)
  if not cfg_cache.enabled then return end
  cache.map[key] = { ts = os.time(), value = sanitize_results(values) }
  lru_touch(key)
  cache_save()
end

-- ===== API =====

-- Zoek in je OneDrive (root) naar items met query q (meerdere woorden OK)
function M.search(q, top)
  q = q or ""
  local safe = q:gsub("'", "''")
  local enc  = urlencode(safe)
  local limit = math.min(top or 50, 200)
  local url = ("%s/me/drive/root/search(q='%s')?$top=%d"):format(BASE, enc, limit)

  -- cache
  cache_load()
  local key = cache_key(q, limit)
  local cached = cache_get(key)
  if cached then return cached end

  -- network
  local r = curl.get(url, { headers = bearer() })
  if r.status ~= 200 then
    return nil, ("Graph search error: %s"):format(r.body or r.status)
  end
  local data = jdecode(r.body or "{}")
  local values = data.value or {}
  cache_put(key, values)
  return sanitize_results(values)
end

-- Async variant: zoek in OneDrive en geef resultaten via callback(err, values)
function M.search_async(q, top, cb)
  q = q or ""
  local safe = q:gsub("'", "''")
  local enc  = (q and q ~= "") and (safe:gsub("([^%w%-%._~])", function(c)
    return string.format("%%%02X", string.byte(c))
  end)) or ""
  local limit = math.min(top or 50, 200)
  local url = ("%s/me/drive/root/search(q='%s')?$top=%d"):format(BASE, enc, limit)

  -- Gebruik plenary.curl async callback
  curl.get(url, {
    headers = bearer(),
    callback = function(res)
      if not res or res.status ~= 200 then
        cb(("Graph search error: %s"):format(res and (res.body or res.status) or "no response"), nil)
        return
      end
      local ok, data = pcall(function()
        local jd = (vim.json and vim.json.decode or vim.fn.json_decode)
        return jd(res.body or "{}")
      end)
      if not ok then
        cb("JSON decode error", nil)
        return
      end
      cb(nil, data.value or {})
    end,
  })
end

-- Haal een item op via pad (bv. Apps/reMarkable/foo.pdf)
function M.item_by_path(path)
  local url = ("%s/me/drive/root:/%s:"):format(BASE, path)
  local r = curl.get(url, { headers = bearer() })
  if r.status ~= 200 then return nil, ("Item not found: %s"):format(r.body or r.status) end
  local o = jdecode(r.body or "{}")
  return {
    id = o.id, name = o.name, webUrl = o.webUrl,
    parentReference = { path = o.parentReference and o.parentReference.path or "" },
  }
end

-- Maak een deelbare link voor een item-id
function M.create_link(item_id, kind, scope)
  local body = jencode({ type = kind or "view", scope = scope or "anonymous" })
  local r = curl.post(("%s/me/drive/items/%s/createLink"):format(BASE, item_id), {
    headers = vim.tbl_extend("force", bearer(), { ["Content-Type"] = "application/json" }),
    body = body,
  })
  if r.status ~= 200 then return nil, ("createLink error: %s"):format(r.body or r.status) end
  local o = jdecode(r.body or "{}")
  return o and o.link and o.link.webUrl
end

-- Convenience: direct via pad
function M.create_link_by_path(path, kind, scope, cb)
  local item, err = M.item_by_path(path)
  if not item then cb(err); return end
  local url, e2 = M.create_link(item.id, kind, scope)
  if not url then cb(e2); return end
  cb(nil, item.name or path, url)
end

return M
