-- Functie die md2pdf uitvoert
local function md2pdf_convert(opts)
  local input = vim.api.nvim_buf_get_name(0)
  local output = opts.args ~= "" and opts.args
               or (input ~= "" and input:gsub("%.md$", ".pdf"))
               or (vim.fn.getcwd() .. "/output.pdf")
  -- commando uitvoeren
  vim.cmd(string.format('!md2pdf -i "%s" -o "%s"', input, output))
  print("PDF gegenereerd: " .. output)
end

-- Het user-command registreren
vim.api.nvim_create_user_command(
  "Md2Pdf",
  md2pdf_convert,
  {
    nargs = "?",
    desc = "Converteer Markdown buffer naar PDF met md2pdf",
  }
)

