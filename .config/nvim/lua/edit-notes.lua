local fzf = require('fzf-lua')

-- Configs are stored in a bare-repo in the $HOME dir
local configs = 'ls $HOME/notes'

function custom_list(A, C, P)
  local configs_str = vim.fn.system(configs)
  return vim.split(configs_str, "\n")
end

function search_config(args)
  local config = args[1]
  if config == nil or config == '' then
    fzf.files({
      prompt = 'Notes> ',
      cmd = configs,
      toggle_hidden_flag = '',
      cwd = '~/notes',
      desc = 'Use fzf to browse through notes taken'
    })
  else
    vim.cmd("edit ~/notes/" .. config)
  end
end

vim.api.nvim_create_user_command(
  'Notes',
  search_config,
  {
    nargs = '?',
    complete = custom_list
  }
)
