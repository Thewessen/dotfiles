require('zshbookmarks').setup({
  file = vim.fn.expand("$HOME/.zshbookmarks"),
  cmd_abbrevs = false, -- broken
})
