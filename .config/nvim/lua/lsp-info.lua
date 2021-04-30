local lsp_info = {}

function lsp_info.info()
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

return lsp_info
