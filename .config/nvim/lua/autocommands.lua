local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd('FileType', {
  pattern = {'gitcommit'},
  callback = (function()
    if vim.api.nvim_get_current_line() == "" then
      local branch_id = vim.fn['FugitiveHead']():gsub('^([A-Z]+-[1-9][0-9]*).*$', '%1')
      vim.api.nvim_put({
        '['..branch_id..'] '
      }, 'c', false, true)
    end
  end),
})

autocmd('FileType', {
  pattern = {'sjl'},
  callback = (function ()
    vim.b.omnifunc = 'vim_dadbod_completion#omni'
  end),
})

autocmd('FileType', {
  pattern = {'fzf'},
  callback = (function ()
    local opt = vim.api.nvim_set_option
    opt('laststatus', 0)
    opt('showmode', false)
    opt('cmdheight', 1)
    opt('ruler', false)
    vim.api.nvim_create_autocmd('BufLeave', {
      pattern = {'<buffer>'},
      callback = (function ()
        local opt = vim.api.nvim_set_option
        opt('laststatus', 2)
        opt('showmode', true)
        opt('cmdheight', 1)
        opt('ruler', true)
      end)
    })
  end),
})

augroup('source', {clear = true})
autocmd('BufWritePost', {
  pattern = {[[*/nvim/init.lua]], [[*/nvim/lua/*.lua]]},
  command = 'luafile ~/.config/nvim/init.lua',
  group = 'source'
})
autocmd('BufWritePost', {
  pattern = {'.tmux.conf'},
  callback = (function() os.execute('tmux source-file ~/.tmux.conf && tmux display-message "Tmux config sourced"') end),
  group = 'source'
})
autocmd('BufWritePost', {
  pattern = {'.aliases','.aliases_work','.zshrc'},
  callback = (function() vim.cmd('!source ~/.zshrc') end),
  group = 'source'
})

