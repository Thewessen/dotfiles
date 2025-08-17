-- Device Code Flow auth met token-cache (OneDrive Personal: tenant="consumers")
local M = {}

local cfg = {
  tenant    = "consumers",
  client_id = nil,
  scope     = "openid profile offline_access Files.Read Files.Read.All",
  cache     = vim.fn.stdpath("cache") .. "/onedrive_token.json",
}

local curl = require("plenary.curl")

function M._configure(o)
  cfg.tenant    = o.tenant or cfg.tenant
  cfg.client_id = o.client_id or cfg.client_id
  cfg.scope     = o.scope or cfg.scope
end

-- JSON helpers (Neovim 0.9 compat)
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

local function now() return os.time() end

local function read_cache()
  local f = io.open(cfg.cache, "r"); if not f then return nil end
  local ok, data = pcall(jdecode, f:read("*a")); f:close()
  return ok and data or nil
end

local function write_cache(t)
  local f = assert(io.open(cfg.cache, "w"))
  f:write(jencode(t)); f:close()
end

-- Compat helper: sommige plenary versies willen form=<table>, anderen form=true + body=<table>
local function post_form(url, kv)
  -- Probeer moderne signatuur
  local ok, res = pcall(curl.post, url, { form = kv })
  if ok and res and res.status then return res end
  -- Fallback naar oudere signatuur
  return curl.post(url, { form = true, body = kv })
end

local function device_flow()
  assert(cfg.client_id, "[onedrive] client_id ontbreekt (auth).")
  local dc_res = post_form(
    ("https://login.microsoftonline.com/%s/oauth2/v2.0/devicecode"):format(cfg.tenant),
    { client_id = cfg.client_id, scope = cfg.scope }
  )
  local dcb = jdecode(dc_res.body or "{}")
  if not dcb or not dcb.user_code then
    error("Device code request mislukt: " .. (dc_res.body or ("HTTP " .. tostring(dc_res.status))))
  end
  vim.notify(("Open %s en voer code: %s"):format(dcb.verification_uri, dcb.user_code), vim.log.levels.INFO)

  local token_url = ("https://login.microsoftonline.com/%s/oauth2/v2.0/token"):format(cfg.tenant)
  local interval = tonumber(dcb.interval or 5)
  while true do
    vim.wait(interval * 1000)
    local tr = post_form(token_url, {
      grant_type  = "urn:ietf:params:oauth:grant-type:device_code",
      client_id   = cfg.client_id,
      device_code = dcb.device_code,
    })
    local tb = jdecode(tr.body or "{}")
    if tb and tb.access_token then
      tb.expires_at = now() + (tb.expires_in or 3600)
      write_cache(tb)
      return tb
    elseif tb and tb.error and tb.error ~= "authorization_pending" then
      error("Device flow error: " .. (tb.error_description or tb.error))
    end
  end
end

local function refresh(tok)
  if not tok or not tok.refresh_token then return nil end
  local r = post_form(
    ("https://login.microsoftonline.com/%s/oauth2/v2.0/token"):format(cfg.tenant),
    {
      client_id     = cfg.client_id,
      grant_type    = "refresh_token",
      refresh_token = tok.refresh_token,
      scope         = cfg.scope,
    }
  )
  local tb = jdecode(r.body or "{}")
  if tb and tb.access_token then
    tb.expires_at = now() + (tb.expires_in or 3600)
    write_cache(tb)
    return tb
  end
end

function M.token()
  local t = read_cache()
  if t and t.expires_at and t.expires_at - 60 > now() then return t.access_token end
  if t then
    local nt = refresh(t); if nt then return nt.access_token end
  end
  return device_flow().access_token
end

return M
