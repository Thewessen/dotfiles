local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local map = vim.keymap.set

augroup('mappings', {clear = true})
local function vim_diff_mapping()
  map('n', ']]', ']c', {buffer = true})
  map('n', '[[', '[c', {buffer = true})
  map('n', '<leader>[', ':diffget //2<CR>:diffupdate<CR>', {buffer = true})
  map('n', '<leader>]', ':diffget //3<CR>:diffupdate<CR>', {buffer = true})
end

local function npm_mapping()
  map('n', '<leader>nn', ':Start nvm exec<CR>', {silent = true})
  map('n', '<leader>nh', ':Start node<CR>', {silent = true})
end

local function shell_mapping()
  map('n', '<leader>nn', ':!sh %:p<CR>', {buffer = true})
  map('n', '<leader>nt', ':lcd %:p:h<CR>:exec \':tabe term://BATS_RUN_SKIPPED=true bats \'.expand(\'%:p:r\')..\'_test.sh\'<CR>', {buffer = true})
end

-- PHP artisan commands
local function php_mapping()
  map('n', '<leader>nn', ':Start psysh<CR>', {buffer = true})
  -- other mappings...
end

local function fugitive_mapping()
  map('n', '<leader>,', 'call termopen(\'git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"\')', {buffer = true})
end

local function md_mapping()
  map('n', '<leader>nn', ':Md2PdfPreview<CR>', {buffer = true})
  map('n', '<leader>nt', ':Obsidian template<CR>', {buffer = true})
  map('n', '<leader>nb', ':Obsidian backlinks<CR>', {buffer = true})
  map('n', '<leader>ne', ':Obsidian new<CR>', {buffer = true})
  map('v', '<leader>ne', ':Obsidian extract_note<CR>', {buffer = true})
  map('n', '<leader>ns', ':Obsidian save<CR>', {buffer = true})
  map('n', '<leader>na', ':ObsidianFilteredTags<CR>', {buffer = true})
end

autocmd('BufWinEnter', {pattern = '*', command = 'if &diff | vim_diff_mapping() | endif', group = 'mappings', nested = true})
autocmd('FileType', {pattern = 'sh', callback = shell_mapping, group = 'mappings', nested = true})
autocmd('FileType', {pattern = 'php', callback = php_mapping, group = 'mappings', nested = true})
autocmd('FileType', {pattern = 'fugitive', callback = fugitive_mapping, group = 'mappings', nested = true})
autocmd('FileType', {pattern = 'md,markdown', callback = md_mapping, group = 'mappings', nested = true})
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


-- autocmd('FileType', {
--   pattern = {'fzf'},
--   callback = (function ()
--     local opt = vim.api.nvim_set_option
--     map('i', '<ESC>', '<C-D>', {buffer = true})
--     opt('laststatus', 0)
--     opt('showmode', false)
--     opt('cmdheight', 1)
--     opt('ruler', false)
--     autocmd('BufLeave', {
--       pattern = {'<buffer>'},
--       callback = (function ()
--         local opt = vim.api.nvim_set_option
--         opt('laststatus', 2)
--         opt('showmode', true)
--         opt('cmdheight', 1)
--         opt('ruler', true)
--       end)
--     })
--   end),
-- })

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

-- Auto-start LSP servers when opening files
-- Neovim 0.10+ with vim.lsp.config() should auto-start, but we ensure it happens
augroup('lsp', {clear = true})
autocmd('FileType', {
  pattern = {'php', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'python', 'lua', 'json', 'css', 'scss', 'less', 'markdown', 'md', 'vim'},
  callback = function()
    -- Skip if buffer is not a file
    if vim.bo.buftype ~= '' or vim.fn.expand('%') == '' then
      return
    end
    
    local filetype = vim.bo.filetype
    if filetype == '' then
      return
    end
    
    -- Use buffer-local variable to prevent multiple starts
    if vim.b.lsp_started then
      return
    end
    vim.b.lsp_started = true
    
    -- Find matching servers for this filetype and enable them
    vim.schedule(function()
      local servers = {}
      if vim.lsp.config._configs then
        for name, config in pairs(vim.lsp.config._configs) do
          local filetypes = config.filetypes
          if filetypes and vim.tbl_contains(filetypes, filetype) then
            -- Check if server is already attached to this buffer
            local clients = vim.lsp.get_clients({ bufnr = 0, name = name })
            if #clients == 0 then
              table.insert(servers, name)
            end
          end
        end
      end
      
      -- Start servers if any found
      if #servers > 0 then
        local bufname = vim.api.nvim_buf_get_name(0)
        -- Ensure buffer has a valid file name and URI
        if bufname and bufname ~= '' then
          -- Verify the buffer URI is valid
          local uri = vim.uri_from_bufnr(0)
          if uri and uri ~= '' then
            -- Use pcall to catch any errors during enable
            local ok, err = pcall(function()
              vim.lsp.enable(servers)
            end)
            if not ok then
              -- Silently fail if there's an error (e.g., no valid root_dir)
              -- This can happen when switching between files quickly
            end
          end
        end
      end
    end)
  end,
  group = 'lsp'
})
