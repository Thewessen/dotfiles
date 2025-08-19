---
-- MD to PDF Export Neovim Plugin
-- Exports markdown to PDF using md2pdf command
local M = {}

local default_opts = {
  auto_open = false,
}

M.opts = {}

function md2pdf_convert(opts)
  local input = vim.api.nvim_buf_get_name(0)
  local output = opts.args ~= "" and opts.args
               or (input ~= "" and input:gsub("%.md$", ".pdf"))
               or (vim.fn.getcwd() .. "/output.pdf")

  -- commando uitvoeren
  vim.cmd(string.format('!md2pdf -i "%s" -o "%s"', input, output))
  
  -- auto_open logic
  auto_open(output)
end

function auto_open(output)
  local o = M.opts
  -- auto_open logic
  if not o.auto_open then
    vim.notify("PDF gegenereerd: " .. output)
    return
  end
  if o.auto_open == 'mac' then
    vim.cmd('!open ' .. vim.fn.fnameescape(output))
  end
end

--- Setup the plugin with user options
-- @param opts table: user options
function M.setup(opts)
  M.opts = vim.tbl_deep_extend("force", default_opts, opts or {})
  vim.api.nvim_create_user_command(
    "Md2Pdf",
    md2pdf_convert,
    {
      nargs = "?",
      desc = "Converteer Markdown buffer naar PDF met md2pdf",
    }
  )
end

return M
