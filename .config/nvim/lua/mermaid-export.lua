-- Place this in your init.lua or a plugin file
local function mermaid_to_svg(opts)
  local start_line = opts.range > 0 and opts.line1 or 1
  local end_line   = opts.range > 0 and opts.line2 or vim.fn.line('$')

  -- Determine output path: use first argument or default to buffer name.svg
  local output = opts.fargs[1]
  if not output or output == '' then
    output = vim.fn.expand('%:r') .. '.svg'
  end

  -- Pipe selected text into mmdc
  vim.cmd(string.format('%d,%dw !mmdc -i - -o %s -w 2560 -H 1440', start_line, end_line, vim.fn.shellescape(output)))
  vim.notify('Mermaid exported: ' .. output)
end

-- Map it: <leader>ms converts visual selection or full buffer
vim.api.nvim_create_user_command(
  'MermaidExport',
  mermaid_to_svg,
  {
    desc = "Convert Mermaid syntax to SVG, PNG, or PDF",
    nargs = '?',
    complete = 'file',
    range = true
  }
)
