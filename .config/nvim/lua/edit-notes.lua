local fzf = require('fzf-lua')

-- Configs are stored in a bare-repo in the $HOME dir
local configs = 'ls $HOME/notes'

function custom_list(A, C, P)
  local configs_str = vim.fn.system(configs)
  return vim.split(configs_str, "\n")
end

function search_config(args)
  local file = args['args']
  if file == nil or file == '' then
    -- Use a custom command that searches both filenames and content
    local cmd = string.format(
      'cd ~/notes && ag --md -u --files-with-matches'
    )
    
    fzf.fzf_exec(cmd, {
      prompt = 'Notes> ',
      desc = 'Browse through notes and search content',
      actions = {
        ['default'] = function(selected)
          if #selected > 0 then
            vim.cmd("edit ~/notes/" .. selected[1])
          end
        end
      },
      fzf_opts = {
        ['--preview-window'] = 'right:50%',
        ['--preview'] = 'bat ~/notes/{}',
        ['--bind'] = [[change:reload:ag --md -u --files-with-matches '{q}']],
      }
    })
  else
    vim.cmd("edit ~/notes/" .. file)
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
