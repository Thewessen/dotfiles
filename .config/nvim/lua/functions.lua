-- This file is mostly used for defining user commands and autocommands --

local module = {}
local f = vim.fn
local _ = vim.api

-- copy current file and line number to clipboard
function module.yankFileLineNumber()
  local fname = f.expand('%:p')
  local root = require'lspconfig'.util.find_git_ancestor(fname)
  local row, column = unpack(_.nvim_win_get_cursor(0))
  local path = table.concat({fname:gsub((root .. "/"):gsub([[([^%w])]], "%%%1"), ""), row, column}, ':')
  f.setreg('+', path)
  print(path .. ' (yanked to clipboard)')
end

-- use fzf to find and checkout a branch
function module.checkoutBranchFzf(line)
  -- get branch from gmatch iterator function (first entry)
  local branch = line:gmatch('(%S+)')()
  os.execute('git checkout ' .. branch)
end

-- diff current buff with saved file on disc
function module.diffSaved()
  local ft = vim.bo.filetype
  vim.cmd('diffthis')

  -- read file from disc
  io.input(f.expand('%'))
  local lines = {}
  for line in io.lines() do
    table.insert(lines, line)
  end

  -- create vertical split
  vim.cmd('vnew')
  local win = _.nvim_get_current_win()
  local buf = _.nvim_create_buf(false, true)
  _.nvim_win_set_buf(win, buf)
  _.nvim_put(lines, 'b', false, false)
  vim.bo.filetype = ft

  vim.cmd('diffthis')
end

-- Quick search the web with given query
function module.searchWeb(a)
  local url = [[https://duckduckgo.com/?q=]] .. f.join(f.split(a.args), '%+')
  local command = [[terminal w3m -o confirm_qq=0 ']] .. url .. [[']]
  vim.cmd(command)
  vim.cmd('startinsert')
end

-- Better navigation for all lsp info/warning messages
function module.lsp_info()
  -- get diagnostics
  local messages = vim.tbl_map(function(v) return v.message end, vim.lsp.diagnostic.get_line_diagnostics())
  -- create a new info window
  vim.cmd('10split LSP-INFO')
  -- clear the info window from any previous lines
  vim.cmd('1,$d')
  -- set all the messages as newlines
  vim.api.nvim_buf_set_lines(0, 0, 0, true, messages)
  -- buffer can be closed without warnings
  vim.bo.buftype = 'nowrite'
end

return module
