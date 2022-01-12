local cmd = vim.cmd
function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, {...})
  print(unpack(objects))
end

-- TODO: create module for personal lua functions
function _G.lsp_info()
  local diag = vim.lsp.diagnostic.get_line_diagnostics()
  if next(diag) ~= nil then
    vim.cmd('3split new')
    vim.api.nvim_buf_set_lines(0, 0, 0, { diag.message }, nil)
  end
end

require('plugins')
require('plugin-options')
require('options')
require('leader-mappings')
require('other-mappings')
require('lsp')
require('work-related')

cmd('colorscheme sthew')

-- treesitter config
require('nvim-treesitter.configs').setup{
  playground = {
    enable = false,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
  highlight = {
    enable = true,
    custom_captures = {
      ["exclude"] = "PreProc",
      ["tag"] = "Tag",
      ["function"] = "Function",
      ["variable.name"] = "Normal",
      ["object.name"] = "Normal",
      ["variable.declarator"] = "Type",
    }
  },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "vv",
      node_incremental = ".",
      scope_incremental = "gs",
      node_decremental = ",",
    },
  }
}

-- lsp signs
cmd('sign define LspDiagnosticsSignError text=x texthl=LspDiagnosticsSignError linehl= numhl=')
cmd('sign define LspDiagnosticsSignWarning text=! texthl=LspDiagnosticsSignWarning linehl= numhl=')
cmd('sign define LspDiagnosticsSignInformation text=? texthl=LspDiagnosticsSignInformation linehl= numhl=')
cmd('sign define LspDiagnosticsSignHint text=> texthl=LspDiagnosticsSignHint linehl= numhl=')

-- highlight
cmd('hi Delimiter ctermfg=102')

-- A vim.api for creating user command is on its way
-- https://github.com/neovim/neovim/pull/11613
cmd('source ~/.config/nvim/commands.vim')

-- A vim.api for creating autocommand is on its way
-- https://github.com/neovim/neovim/pull/11613
cmd('source ~/.config/nvim/autocommands.vim')

-- some more fancy custom commands (fzf)
cmd('source ~/.config/nvim/docker.vim')
cmd('source ~/.config/nvim/edit-config.vim')
cmd('source ~/.config/nvim/start-queue.vim')
