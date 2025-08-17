-- Één bron voor zowel weekly- als daily-substitutions, context-afhankelijk:
-- - In een WEEKLY buffer: weekstart afgeleid uit bestandsnaam (bv. "2025-W33.md")
-- - In een DAILY buffer: datum afgeleid uit bestandsnaam (bv. "2025-08-18.md")
-- - Links forceren altijd het pad naar de juiste map via jouw obsidian.nvim config:
--     daily_notes.folder (+ optionele daily_notes.path_resolver)
--     weekly_notes.folder (+ optionele weekly_notes.path_resolver)

local M = {}

local DAY  = 24 * 60 * 60

-- =============== helpers: buffer & config =================

local function bufname_no_ext()
  return vim.fn.expand("%:t:r") or ""   -- bv. "2025-08-18" of "2025-W33"
end

local function bufnr_path_no_ext()
  -- volledige pad zonder extensie; handig als iemand submappen gebruikt
  local p = vim.fn.expand("%:r")
  return (p ~= nil and p ~= "") and p or ""
end

local function get_opts()
  -- gebruik live Obsidian.opts als die er is
  if _G.Obsidian and _G.Obsidian.opts then
    return _G.Obsidian.opts
  end
  return {}
end

-- =============== helpers: datum/ISO-week ===================

-- Maandag 00:00 van een gegeven timestamp ts (lokale tijd)
local function monday_from_ts(ts)
  local w = tonumber(os.date("%w", ts)) -- 0=zo..6=za
  local days_since_mon = (w + 6) % 7    -- ma=0, di=1, ...
  local mt = os.date("*t", ts - days_since_mon * DAY)
  mt.hour, mt.min, mt.sec = 0, 0, 0
  return os.time(mt)
end

-- ISO week → maandag (00:00). ISO-week 1 is week met 4 jan.
local function iso_week_monday(year, week)
  local jan4 = os.time({ year = year, month = 1, day = 4, hour = 0, min = 0, sec = 0 })
  local w = tonumber(os.date("%w", jan4))
  local week1_mon = jan4 - ((w + 6) % 7) * DAY
  return week1_mon + (week - 1) * 7 * DAY
end

-- Probeer YYYY-WWW uit buffernaam te parsen
local function parse_week_from_buf()
  local name = bufname_no_ext()
  -- match "2025-W33" of "2025-W-33" of "2025W33"
  local y, w = name:match("^(%d%d%d%d)%s*%-?W%-?(%d%d)$")
  if not y then y, w = name:match("^(%d%d%d%d)%s*W(%d%d)$") end
  if y and w then
    return iso_week_monday(tonumber(y), tonumber(w))
  end
  return nil
end

-- Probeer YYYY-MM-DD (of met / .) uit buffernaam te parsen
local function parse_date_from_buf()
  local name = bufname_no_ext()
  local y, m, d = name:match("^(%d%d%d%d)[%-%./](%d%d)[%-%./](%d%d)$")
  if not y then y, m, d = name:match("(%d%d%d%d)[%-%./](%d%d)[%-%./](%d%d)") end
  if y then
    return os.time({ year = tonumber(y), month = tonumber(m), day = tonumber(d), hour = 0, min = 0, sec = 0 })
  end
  return nil
end

-- =============== helpers: id/paths =========================

-- Bouw DAILY id en (vault-relatief) pad o.b.v. config + timestamp
local function daily_id_and_path(ts, opts)
  opts = opts or get_opts()
  local dn = opts.daily_notes or {}
  local fmt = dn.date_format or "%Y-%m-%d"
  local id  = os.date(fmt, ts)
  local folder = dn.folder or ""
  local path = (folder ~= "" and (folder .. "/" .. id) or id)

  if type(dn.path_resolver) == "function" then
    local ok, custom = pcall(dn.path_resolver, { id = id, ts = ts, folder = folder })
    if ok and custom and custom ~= "" then path = custom end
  end
  return id, path
end

-- Bouw WEEKLY id/title en pad o.b.v. config + maandag-ts
local function weekly_id_title_and_path(mon_ts, opts)
  opts = opts or get_opts()
  local W = opts.weekly_notes or {}
  local id     = os.date(W.id_format    or "%G-W%V", mon_ts)      -- bv. 2025-W33
  local title  = os.date(W.alias_format or "Week %V, %G", mon_ts) -- bv. Week 33, 2025
  local folder = W.folder or "notes/weeklies"
  local path   = folder .. "/" .. id
  if type(W.path_resolver) == "function" then
    local ok, custom = pcall(W.path_resolver, { id = id, ts = mon_ts, folder = folder })
    if ok and custom and custom ~= "" then path = custom end
  end
  return id, title, path
end

-- =============== context: bepaal week-start =================

-- Geeft maandag-ts van de "actieve" week, afhankelijk van de buffer:
-- - in weekly: parse uit buffernaam
-- - in daily:  maandag van die dag
-- - anders:    huidige week
local function current_week_monday()
  -- weekly?
  local wk = parse_week_from_buf()
  if wk then return wk end
  -- daily?
  local dt = parse_date_from_buf()
  if dt then return monday_from_ts(dt) end
  -- fallback: nu
  return monday_from_ts(os.time())
end

-- =============== link helpers ==============================

local function wikilink(target, label, heading)
  if heading and heading ~= "" then
    return string.format("[[%s#%s|%s]]", target, heading, label or target)
  else
    return string.format("[[%s|%s]]", target, label or target)
  end
end

-- =============== public API =================================

function M.make()
  -- ‘Big 3’-heading instelbaar via config (weekly_notes.big3_heading)
  local opts = get_opts()
  local W = opts.weekly_notes or {}
  local BIG3 = W.big3_heading or "Big 3"

  local function week_start_ts()
    return current_week_monday()
  end

  local function day_target(day_offset)
    local ts = week_start_ts() + (day_offset or 0) * DAY
    local _, path = daily_id_and_path(ts, opts)
    return path, ts
  end

  local function weekly_target_from_ts(ts)
    local mon = monday_from_ts(ts)
    local _, title, path = weekly_id_title_and_path(mon, opts)
    return path, title, mon
  end

  local function weekly_target_for_current_week()
    local mon = week_start_ts()
    local _, title, path = weekly_id_title_and_path(mon, opts)
    return path, title, mon
  end

  -- Substitutions die werken in BOTH weekly & daily context
  local subs = {

    -- ====== Kop/metadata rond de week ======
    week_start = function()
      return os.date("%Y-%m-%d", week_start_ts())
    end,
    title = function()
      return os.date("Week %V, %G", week_start_ts())
    end,

    -- ====== Links naar dailies (top) ======
    mon_link = function() return wikilink(day_target(0), "Maandag") end,
    tue_link = function() return wikilink(day_target(1), "Dinsdag") end,
    wed_link = function() return wikilink(day_target(2), "Woensdag") end,
    thu_link = function() return wikilink(day_target(3), "Donderdag") end,
    fri_link = function() return wikilink(day_target(4), "Vrijdag") end,
    sat_link = function() return wikilink(day_target(5), "Zaterdag") end,
    sun_link = function() return wikilink(day_target(6), "Zondag") end,

    -- ====== Big-3 deeplinks naar dailies ======
    mon_big3 = function() local t=day_target(0); return wikilink(t, "Big 3 (ma)", BIG3) end,
    tue_big3 = function() local t=day_target(1); return wikilink(t, "Big 3 (di)", BIG3) end,
    wed_big3 = function() local t=day_target(2); return wikilink(t, "Big 3 (wo)", BIG3) end,
    thu_big3 = function() local t=day_target(3); return wikilink(t, "Big 3 (do)", BIG3) end,
    fri_big3 = function() local t=day_target(4); return wikilink(t, "Big 3 (vr)", BIG3) end,
    sat_big3 = function() local t=day_target(5); return wikilink(t, "Big 3 (za)", BIG3) end,
    sun_big3 = function() local t=day_target(6); return wikilink(t, "Big 3 (zo)", BIG3) end,

    -- ====== Daily → Weekly backlink ======
    weekly_link = function()
      -- bepaal dag-ts uit huidige buffernaam (daily of anders nu)
      local ts = parse_date_from_buf() or os.time()
      local path, title = weekly_target_from_ts(ts)
      return string.format("[[%s|%s]]", path, title)
    end,

    weekly_id = function()
      local ts = parse_date_from_buf() or os.time()
      local mon = monday_from_ts(ts)
      return os.date(W.id_format or "%G-W%V", mon)
    end,

    weekly_title = function()
      local ts = parse_date_from_buf() or os.time()
      local mon = monday_from_ts(ts)
      return os.date(W.alias_format or "Week %V, %G", mon)
    end,

    weekly_big_rocks = function()
      local ts = parse_date_from_buf() or os.time()
      local path, title = weekly_target_from_ts(ts)
      return string.format("[[%s#Grote Stenen|%s – Grote Stenen]]", path, title)
    end,

    -- ====== (optioneel) Weekly → pad/id helpers ======
    weekly_path = function()
      local path = weekly_target_for_current_week()
      return type(path) == "table" and path[1] or path
    end,

    google_calendar_link = function()
      local ts = parse_date_from_buf() or os.time()
      local mon = monday_from_ts(ts)
      local path = os.date("%Y/%m/%d", mon)
      return string.format("[Google Calendar](https://calendar.google.com/calendar/r/week/%s)", path)
    end,
  }

  return subs
end

return M
