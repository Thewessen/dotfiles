local M = {}

---@class OneDriveConfig
---@field client_id string
---@field tenant string|nil
---@field scope string|nil
---@field link_type string|nil
---@field link_scope string|nil
---@field mappings table|nil
---@field cache table|nil  -- { enabled=true, ttl=300, persist=true, max_entries=200, path=? }

local defaults = {
  tenant = "consumers",
  scope = "openid profile offline_access Files.ReadWrite",
  link_type = "view",
  link_scope = "anonymous",
  mappings = {
    open = { fzf = { "default" }, telescope = { "<CR>" } },
    copy = { fzf = { "ctrl-y" },   telescope = { "<C-y>" } },
  },
  cache = {
    enabled = true,
    ttl = 300,          -- seconden
    persist = true,     -- cache op schijf bewaren
    max_entries = 200,  -- LRU limiet
    -- path wordt in api.lua op stdpath("cache") gezet als deze nil is
  },
}

-- === Auto-registratie voor nvim-cmp ===
function M.register_cmp_source()
  local ok_cmp, cmp = pcall(require, "cmp")
  if not ok_cmp then return false, "cmp not loaded" end
  local src = require("onedrive.cmp")
  -- optioneel: src.enable_debug(true) -- <— zet hier aan voor permanente debug
  src.setup({ -- kies je defaults hier
    format = "markdown",
    label = "name",
    max_items = 50,
    min_chars = 2,
    debounce = 200,
  })
  cmp.register_source("onedrive", src.new())

  -- zorg dat hij ook in de sources-lijst zit
  local cfg = cmp.get_config()
  local has = false
  for _, s in ipairs(cfg.sources or {}) do
    if s.name == "onedrive" then has = true; break end
  end
  if not has then
    local new_sources = vim.deepcopy(cfg.sources or {})
    table.insert(new_sources, { name = "onedrive" })
    cmp.setup({ sources = new_sources })
  end
  return true
end

function M.setup(opts)
  opts = opts or {}
  local cfg = vim.tbl_deep_extend("force", defaults, opts)
  assert(cfg.client_id and cfg.client_id ~= "", "[onedrive] client_id is verplicht.")
  M.cfg = cfg

  require("onedrive.auth")._configure({
    tenant    = cfg.tenant,
    client_id = cfg.client_id,
    scope     = cfg.scope,
  })
  require("onedrive.api").set_cache_config(cfg.cache)

  -- :OneDrive [zoekterm...]
  vim.api.nvim_create_user_command("OneDrive", function(cmd)
    local query = table.concat(cmd.fargs or {}, " ")
    local function run(q)
      if not q or q == "" then return end
      require("onedrive.picker").pick_search(q, cfg)
    end
    if query == "" then
      vim.ui.input({ prompt = "Zoek in OneDrive: " }, run)
    else
      run(query)
    end
  end, { nargs = "*", desc = "Zoek in OneDrive (fzf-lua/Telescope)" })

  -- :OneDriveCacheClear
  vim.api.nvim_create_user_command("OneDriveCacheClear", function()
    require("onedrive.api").clear_cache()
    vim.notify("OneDrive cache geleegd.")
  end, { nargs = 0, desc = "Leeg de OneDrive zoek-cache (in-memory en on-disk)" })

  -- Voeg cmp source toe als nvim-cmp is geladen
  local ok_cmp, cmp = pcall(require, "cmp")
  if ok_cmp then
    local cmp_src = require("onedrive.cmp")
    cmp_src.setup({
      format = "markdown",  -- of "url"
      label  = "name",      -- of "path"
      max_items = 50,
      min_chars = 2,
      debounce = 200,
    })
    cmp.register_source("onedrive", cmp_src.new())
  end
end

-- === Debug tools ===
-- Temporary debug command om de huidige nvim-cmp configuratie te tonen
-- en de OneDrive cmp source instellingen.
vim.api.nvim_create_user_command("OneDriveCmpDebug", function()
  require("onedrive.cmp").enable_debug(true)
  local lines = {}
  local ok_cmp, cmp = pcall(require, "cmp")
  table.insert(lines, "cmp loaded: " .. tostring(ok_cmp))
  if ok_cmp then
    local cfg = cmp.get_config()
    local names = {}
    for _, s in ipairs(cfg.sources or {}) do table.insert(names, s.name) end
    table.insert(lines, "cmp sources: " .. table.concat(names, ", "))
  end
  local ok_src, src = pcall(require, "onedrive.cmp")
  table.insert(lines, "cmp source module: " .. tostring(ok_src))
  if ok_src and src.log_path then table.insert(lines, "log: " .. src.log_path()) end
  vim.notify(table.concat(lines, "\n"))
end, { nargs = 0 })

return M
