---
-- Mermaid Export Neovim Plugin
-- Exports Mermaid diagrams to SVG, PNG, or PDF with custom options
local M = {}

local default_opts = {
  width = 2560,
  height = 1440,
  output_type = "png",
  auto_open = false,
}

M.opts = {}

--- Setup the plugin with user options
-- @param opts table: user options
function M.setup(opts)
  M.opts = vim.tbl_deep_extend("force", default_opts, opts or {})
  vim.api.nvim_create_user_command(
    'MermaidExport',
    function(command_opts) M.export(command_opts) end,
    {
      desc = "Convert Mermaid syntax to SVG, PNG, or PDF",
      nargs = '?',
      complete = 'file',
      range = true,
    }
  )
end

--- Export a Mermaid diagram in the current buffer (or selection)
-- @param opts table: options provided from the command
function M.export(opts)
  local o = M.opts
  local start_line = opts.range > 0 and opts.line1 or 1
  local end_line = opts.range > 0 and opts.line2 or vim.fn.line('$')
  local output = opts.fargs[1]
  if not output or output == '' then
    output = vim.fn.expand('%:r') .. '.' .. o.output_type
  end
  local cmd = string.format(
    '%d,%dw !mmdc -i - -o %s -w %d -H %d',
    start_line, end_line, vim.fn.shellescape(output), o.width, o.height
  )
  vim.cmd(cmd)

  -- auto_open logic
  if not o.auto_open then
    vim.notify('Mermaid exported: ' .. output)
    return
  end
  if o.auto_open == 'buffer' then
    vim.cmd('edit ' .. vim.fn.fnameescape(output))
  end
  if o.auto_open == 'mac' then
    vim.cmd('!open ' .. vim.fn.fnameescape(output))
  end
end

return M
