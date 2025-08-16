local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local statusline = ''

-- status line active window
local function change_status_line()
    vim.wo.statusline = vim.fn.join({
      -- '%4.4(#%n%) ', -- Buffer number
      [[%{expand('#'.buffer_number('%'))}]], -- File in window (base only)
      '%=', -- Right Side
      '%<☰ %l⋮ %v (%3p%%)' , -- Line/col number (percentage)
    }, ' ')
end

-- status line non-active window
local function change_status_line_nc()
  vim.wo.statusline = vim.fn.join({
    -- '%4.4(#%n%) ', -- Buffer number
    [[%{expand('#'.buffer_number('%'))}]], -- File in window (base only)
  }, ' ')
end

augroup('statusline', {clear = true})
autocmd('WinLeave', {
  pattern = '*',
  callback = change_status_line_nc,
  group = 'statusline',
})
autocmd('WinEnter', {
  pattern = '*',
  callback = change_status_line,
  group = 'statusline',
})
