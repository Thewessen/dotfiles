-- Mapping tabel voor highlight group links
local hl = vim.api.nvim_set_hl

local highlight_links = {
  -- Treesitter highlights
  ["@parameter"] = "Normal",
  ["@property"] = "Normal",
  ["@variable"] = "Normal",
  ["@type"] = "Type",
  ["@constructor"] = "Operator",
  ["@tag.attribute"] = "Normal",
  ["@tag.delimiter"] = "Noise",
  ["@tag.builtin"] = "@tag",
  ["@punctuation.special"] = "Noise",
  ["@punctuation.bracket"] = "Noise",

  -- LSP highlights
  ["@lsp.type.parameter"] = "Normal",
  ["@lsp.type.property"] = "Normal",
  ["@lsp.type.variable"] = "Normal",

  -- TypeScript highlights
  ["typescriptMember"] = "typescriptObjectLabel",
  ["typescriptInterfaceName"] = "Normal",
  ["typescriptArrayMethod"] = "Function",
  ["typescriptVariable"] = "Type",
  ["typescriptImport"] = "PreProc",
  ["typescriptExport"] = "typescriptImport",
  ["typescriptBraces"] = "Noise",
  ["typescriptParens"] = "Noise",
  ["typescriptTemplateSB"] = "Noise",
  ["typescriptTypeReference"] = "Special",

  -- TSX highlights
  ["tsxTagName"] = "Operator",
  ["tsxAttrib"] = "Normal",
  ["tsxTag"] = "Noise",

  -- JSX highlights
  ["jsxAttrib"] = "Normal",
  ["jsxComponentName"] = "Operator",
  ["jsxBraces"] = "Noise",

  -- LSP Diagnostics
  ["LspDiagnosticsDefaultHint"] = "ToDo",
  ["LspDiagnosticsDefaultWarning"] = "ToDo",
  ["LspDiagnosticsDefaultError"] = "Error",

  -- JSON highlights
  ["jsonBraces"] = "Noise",

  -- Diff highlights
  ["diffAdded"] = "Function",

  -- Coc highlights
  ["CocMenuSel"] = "CocListBgWhite",

  -- Render Markdown highlights
  ["RenderMarkdownH1Bg"] = "Title",
  ["RenderMarkdownH2Bg"] = "Title",
  ["RenderMarkdownH3Bg"] = "Title",
  ["RenderMarkdownH4Bg"] = "Title",
  ["RenderMarkdownH5Bg"] = "Title",
  ["RenderMarkdownCode"] = "Visual",

  -- lualine.nvim highlight links
  -- Actieve statusline secties
  ["lualine_a_normal"] = "StatusLine",
  ["lualine_b_normal"] = "StatusLine",
  ["lualine_c_normal"] = "StatusLine",
  ["lualine_x_normal"] = "StatusLine",
  ["lualine_y_normal"] = "StatusLine",
  ["lualine_z_normal"] = "StatusLine",

  ["lualine_a_insert"] = "StatusLine",
  ["lualine_b_insert"] = "StatusLine",
  ["lualine_c_insert"] = "StatusLine",
  ["lualine_x_insert"] = "StatusLine",
  ["lualine_y_insert"] = "StatusLine",
  ["lualine_z_insert"] = "StatusLine",

  ["lualine_a_visual"] = "StatusLine",
  ["lualine_b_visual"] = "StatusLine",
  ["lualine_c_visual"] = "StatusLine",
  ["lualine_x_visual"] = "StatusLine",
  ["lualine_y_visual"] = "StatusLine",
  ["lualine_z_visual"] = "StatusLine",

  ["lualine_a_replace"] = "StatusLine",
  ["lualine_b_replace"] = "StatusLine",
  ["lualine_c_replace"] = "StatusLine",
  ["lualine_x_replace"] = "StatusLine",
  ["lualine_y_replace"] = "StatusLine",
  ["lualine_z_replace"] = "StatusLine",

  ["lualine_a_command"] = "StatusLine",
  ["lualine_b_command"] = "StatusLine",
  ["lualine_c_command"] = "StatusLine",
  ["lualine_x_command"] = "StatusLine",
  ["lualine_y_command"] = "StatusLine",
  ["lualine_z_command"] = "StatusLine",

  -- Inactieve statusline secties
  ["lualine_a_inactive"] = "StatusLineNC",
  ["lualine_b_inactive"] = "StatusLineNC",
  ["lualine_c_inactive"] = "StatusLineNC",
  ["lualine_x_inactive"] = "StatusLineNC",
  ["lualine_y_inactive"] = "StatusLineNC",
  ["lualine_z_inactive"] = "StatusLineNC",
}

-- Pas alle highlight links toe
for source, target in pairs(highlight_links) do
  hl(0, source, { link = target })
end
