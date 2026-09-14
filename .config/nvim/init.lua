-- ==================================================================
--       S. Thewessen
--       Neovim on the Pi 5 (Neovim 0.12+, plugins via vim.pack)
--
--       Light on purpose: editing configs and compose files over SSH.
--       Plugins are pinned in nvim-pack-lock.json next to this file.
--       Update them with :lua vim.pack.update(), confirm with :write.
-- ==================================================================

vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- =================================
--             Options
-- =================================

local opt = vim.opt

opt.number = true
opt.signcolumn = 'yes'
opt.updatetime = 300
opt.undofile = true             -- Keep undo history across sessions

opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.textwidth = 79

opt.wrap = false
opt.scrolloff = 5
opt.sidescrolloff = 5
opt.showbreak = '↪'
opt.listchars = { tab = '→ ', eol = '¬', trail = '⋅', extends = '❯', precedes = '❮' }

opt.foldmethod = 'indent'
opt.foldlevelstart = 99         -- Start with all folds open

opt.inccommand = 'split'        -- Preview :s in a split

-- =================================
--             Mappings
-- =================================

local map = vim.keymap.set

map('n', '<leader>,', '<cmd>w<CR>', { desc = 'Write' })
map('n', '<leader>w', '<cmd>x<CR>', { desc = 'Write and close' })
map('n', '<leader>q', '<cmd>qall!<CR>', { desc = 'Quit all, discard changes' })
map('n', '<leader>.', '<C-^>', { desc = 'Alternate buffer' })
map('n', '<leader>t', '<C-w>T', { desc = 'Window to new tab' })
map('n', '<leader><space>', [[<cmd>%s/\s\+$//e<CR>]], { desc = 'Strip trailing whitespace' })
map('n', '<leader>z', '<cmd>botright 10split | terminal<CR>', { desc = 'Terminal below' })

-- Quickfix and location list
map('n', '<leader>c', '<cmd>copen<CR>')
map('n', '<leader>l', '<cmd>lopen<CR>')
map('n', '<leader>0', '<cmd>cbelow<CR>')
map('n', '<leader>9', '<cmd>cabove<CR>')
map('n', '<leader>]', '<cmd>lbelow<CR>')
map('n', '<leader>[', '<cmd>labove<CR>')

-- =================================
--             Plugins
-- =================================

vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = 'https://github.com/ibhagwan/fzf-lua' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
})

-- Treesitter: highlighting for what gets edited on this server. Neovim already
-- ships lua, vim, vimdoc, markdown, query and c. Installing parsers needs the
-- tree-sitter CLI and a C compiler; without the CLI, regex syntax is used.
if vim.fn.executable('tree-sitter') == 1 then
  require('nvim-treesitter').install({ 'bash', 'dockerfile', 'json', 'yaml', 'toml' })
end

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    -- 'yaml.docker-compose' -> 'yaml'
    local ft = vim.bo[args.buf].filetype:match('^[^.]+')
    local lang = vim.treesitter.language.get_lang(ft) or ft
    pcall(vim.treesitter.start, args.buf, lang)
  end,
})

-- fzf-lua: uses the system fzf, ripgrep and fd (fdfind)
local fzf = require('fzf-lua')
fzf.setup({})

map('n', '<C-p>', fzf.files, { desc = 'Files' })
map('n', '<leader>ff', fzf.git_files, { desc = 'Git files' })
map('n', '<leader>fa', fzf.live_grep, { desc = 'Grep' })
map('n', '<leader>f*', fzf.grep_cword, { desc = 'Grep word under cursor' })
map('n', '<leader>/', fzf.lines, { desc = 'Lines in open buffers' })
map('n', '<leader>fl', fzf.blines, { desc = 'Lines in this buffer' })
map('n', '<leader>fb', fzf.buffers, { desc = 'Buffers' })
map('n', '<leader>fg', fzf.git_status, { desc = 'Git status' })
map('n', '<leader>fh', fzf.oldfiles, { desc = 'Recent files' })
map('n', '<leader>f:', fzf.command_history, { desc = 'Command history' })
map('n', '<leader>f/', fzf.search_history, { desc = 'Search history' })

-- gitsigns: also for the dotfiles, which live in a bare repo with $HOME as
-- work tree (see the dot alias)
require('gitsigns').setup({
  worktrees = {
    { toplevel = vim.env.HOME, gitdir = vim.env.HOME .. '/.dotfiles' },
  },
})

local gs = require('gitsigns')
map('n', ']c', function() gs.nav_hunk('next') end, { desc = 'Next hunk' })
map('n', '[c', function() gs.nav_hunk('prev') end, { desc = 'Previous hunk' })
map('n', '<leader>gb', gs.blame_line, { desc = 'Blame line' })
map('n', '<leader>gd', gs.diffthis, { desc = 'Diff against index' })
map('n', '<leader>gp', gs.preview_hunk, { desc = 'Preview hunk' })
map('n', '<leader>gr', gs.reset_hunk, { desc = 'Reset hunk' })
