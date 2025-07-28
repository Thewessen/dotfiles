local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('mappings', {clear = true})
local function vim_diff_mapping()
  vim.keymap.set('n', ']]', ']c', {buffer = true})
  vim.keymap.set('n', '[[', '[c', {buffer = true})
  vim.keymap.set('n', '<leader>[', ':diffget //2<CR>:diffupdate<CR>', {buffer = true})
  vim.keymap.set('n', '<leader>]', ':diffget //3<CR>:diffupdate<CR>', {buffer = true})
end

local function npm_mapping()
  vim.keymap.set('n', '<leader>nn', ':Start nvm exec<CR>', {silent = true})
  vim.keymap.set('n', '<leader>nh', ':Start node<CR>', {silent = true})
end

local function shell_mapping()
  vim.keymap.set('n', '<leader>nn', ':!sh %:p<CR>', {buffer = true})
  vim.keymap.set('n', '<leader>nt', ':lcd %:p:h<CR>:exec \':tabe term://BATS_RUN_SKIPPED=true bats \'.expand(\'%:p:r\')..\'_test.sh\'<CR>', {buffer = true})
end

-- PHP artisan commands
local function php_mapping()
  vim.keymap.set('n', '<leader>nn', ':Start psysh<CR>', {buffer = true})
  -- other mappings...
end

local function fugitive_mapping()
  vim.keymap.set('n', '<leader>,', 'call termopen(\'git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"\')', {buffer = true})
end

autocmd('BufWinEnter', {pattern = '*', command = 'if &diff | vim_diff_mapping() | endif', group = 'mappings', nested = true})
autocmd('FileType', {pattern = 'sh', callback = shell_mapping, group = 'mappings', nested = true})
autocmd('FileType', {pattern = 'php', callback = php_mapping, group = 'mappings', nested = true})
autocmd('FileType', {pattern = 'fugitive', callback = fugitive_mapping, group = 'mappings', nested = true})
autocmd('FileType', {pattern = 'js,javascript,ts,typescript,mjs,vue,jsx,tsx,reason,typescriptreact', callback = npm_mapping, group = 'mappings', nested = true})

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
  pattern = {'sql'},
  callback = (function ()
    vim.b.omnifunc = 'vim_dadbod_completion#omni'
  end),
})


autocmd('FileType', {
  pattern = {'fzf'},
  callback = (function ()
    local opt = vim.api.nvim_set_option
    vim.keymap.set('i', '<ESC>', '<C-D>', {buffer = true})
    opt('laststatus', 0)
    opt('showmode', false)
    opt('cmdheight', 1)
    opt('ruler', false)
    autocmd('BufLeave', {
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
  pattern = {'.aliases','.aliases_work','.zshrc','.zshenv'},
  callback = (function() vim.cmd('!source ~/.zshrc; zsh_compile') end),
  group = 'source'
})
autocmd({'BufNewFile', 'BufRead'}, {
  pattern = {'*.blade.php'},
  callback = (function() vim.cmd('set ft=blade') end),
  group = 'source'
})
