-- lualine.nvim configuratie
-- Gebaseerd op sthew_custom_statusline.vim

local ok, lualine = pcall(require, 'lualine')
if not ok then
  vim.notify('lualine.nvim kon niet geladen worden', vim.log.levels.WARN)
  return
end

-- Verwijder oude statusline autocommands
pcall(vim.api.nvim_del_augroup_by_name, 'statusline')
pcall(vim.api.nvim_del_augroup_by_name, 'toggle_statusline_windowswap')

-- Reset statusline instellingen
vim.cmd('set statusline=')
vim.o.laststatus = 2

-- Helper functies
local function get_mode_text()
  local mode_map = {
    n = 'NORMAL',
    v = 'VISUAL',
    V = 'V·LINE',
    ['\22'] = 'V·BLOCK',
    i = 'INSERT',
    R = 'REPLACE',
    c = 'COMMAND',
    t = 'TERMINAL',
  }
  local mode = vim.api.nvim_get_mode().mode
  return (mode_map[mode] or string.upper(mode):sub(1, 7)) .. ' |'
end

local function get_mode_color()
  local mode = vim.api.nvim_get_mode().mode
  local is_dark = vim.o.background == 'dark'
  
  if mode == 'c' then
    -- Command mode: geel
    return { fg = 3, bg = 'NONE', gui = 'underline' }
  end
  
  if mode == '\22' or mode:sub(1, 1) == '\22' then
    -- Visual block: grijs achtergrond
    return { fg = 'NONE', bg = (is_dark and 236 or 250), gui = 'underline' }
  end
  
  if mode == 'i' then
    -- Insert mode: rood
    return { fg = is_dark and 197 or 1, bg = 'NONE', gui = 'underline' }
  end
  
  if mode == 'R' or mode == 'Rv' then
    -- Replace mode: paars
    return { fg = is_dark and 99 or 57, bg = 'NONE', gui = 'underline' }
  end
  
  -- Default: StatusLine kleur met underline
  return { fg = 'NONE', bg = 'NONE', gui = 'underline' }
end

local function get_git_status()
  if vim.fn.exists('g:loaded_fugitive') == 1 then
    local ok, status = pcall(function()
      return vim.fn['fugitive#statusline']()
    end)
    if ok and status and status ~= '' then
      return status
    end
  end
  return ''
end

local function has_git_status()
  if vim.fn.exists('g:loaded_fugitive') == 1 then
    local ok, status = pcall(function()
      return vim.fn['fugitive#statusline']()
    end)
    return ok and status and status ~= ''
  end
  return false
end

local function get_file_info()
  local parts = {}
  local ft = vim.bo.filetype
  local ff = vim.bo.fileformat
  local fenc = vim.bo.fileencoding
  
  if ft ~= '' then
    table.insert(parts, ft)
  end
  if ff ~= '' then
    table.insert(parts, '(' .. ff .. ')')
  end
  if fenc ~= '' and fenc ~= 'utf-8' then
    table.insert(parts, fenc)
  end
  
  return table.concat(parts, ' ')
end

local function has_file_info()
  local ft = vim.bo.filetype
  local ff = vim.bo.fileformat
  local fenc = vim.bo.fileencoding
  return ft ~= '' or ff ~= '' or (fenc ~= '' and fenc ~= 'utf-8')
end

local function get_location()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1
  return string.format('%d:%d', line, col)
end

-- Setup lualine
lualine.setup({
  options = {
    theme = 'auto',
    component_separators = '',
    section_separators = '',
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {
      {
        get_mode_text,
        color = get_mode_color,
      },
    },
    lualine_b = { 'filename' },
    lualine_c = {
    },
    lualine_x = {
      {
        get_file_info,
        cond = has_file_info,
      },
    },
    lualine_y = {
      {
        get_git_status,
        cond = has_git_status,
      },
    },
    lualine_z = {
      {
        get_location,
      },
    },
  },
  inactive_sections = {
    lualine_a = {
      {
        function()
          return string.format('#%d', vim.api.nvim_win_get_buf(0))
        end,
      },
    },
    lualine_b = { 'filename' },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {
      {
        get_location,
      },
    },
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})

-- Forceer statusline update
vim.schedule(function()
  vim.o.laststatus = 2
end)
