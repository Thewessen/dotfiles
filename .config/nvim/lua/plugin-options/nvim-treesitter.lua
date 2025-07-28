-- treesitter config
require'nvim-treesitter.configs'.setup{
  ensure_installed = {
    'bash',
    'blade',
    'css',
    'csv',
    'dockerfile',
    'git_config',
    'git_rebase',
    'gitattributes',
    'gitcommit',
    'gitignore',
    'graphql',
    'html',
    'http',
    'javascript',
    'jsdoc',
    'json',
    'lua',
    'luadoc',
    'markdown',
    'php',
    'phpdoc',
    'python',
    'rust',
    'scss',
    'sql',
    'ssh_config',
    'tmux',
    'tsx',
    'twig',
    'typescript',
    'vim',
    'vimdoc',
    'vue',
    'xml',
    'yaml',
  },
  ignore_install = {},
  auto_install = false,
  sync_install = false,
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
    additional_vim_regex_highlighting = false,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["@parameter"] = "Normal",
    },
  },
  indent = { enable = true },
  textobjects = { enable = true },
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

-- specific blade config
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.blade = {
  install_info = {
    url = "https://github.com/EmranMR/tree-sitter-blade",
    files = {"src/parser.c"},
    branch = "main",
  },
  filetype = "blade"
}
