local map = vim.api.nvim_set_keymap

vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- TODO:
-- add yarn file path and line number
map('n', '<leader>d', '<cmd>tab DBUI<cr>', { noremap = true })
map('n', '<leader>o', '<cmd>only<cr>', { noremap = true, silent = true })
map('n', '<leader>q', '<cmd>qall<cr>', { noremap = true })
map('n', '<leader>t', '<c-w>T', { noremap = true, silent = true })
map('n', '<leader>w', '<cmd>wq<cr>', { noremap = true, silent = true })
map('n', '<leader>z', [[<cmd>call system('tmux-popup')<cr>]], { noremap = true, silent = true })
map('n', '<leader>.', '<c-^>', { noremap = true })
map('n', '<leader>,', '<cmd>w<cr>', { noremap = true, silent = true })
map('n', '<leader>D', '<cmd>DiffSaved<cr>', { noremap = true, silent = true })
map('n', '<leader>N', '<cmd>Obsidian search<cr>', { noremap = true, silent = true })
map('n', '<leader>R', '<cmd>luafile ~/.config/nvim/init.lua<cr><cmd>echo "config loaded..."<cr>', { noremap = true })
map('n', '<leader>Y', '<cmd>YankFileLineNr<cr>', { noremap = true })
map('n', '<leader><space>', ':AvanteChat<cr>', { noremap = true })

-- edit
map('n', '<leader>c', '<cmd>copen<cr>', { noremap = true })
map('n', '<leader>e', '<cmd>Config<cr>', { noremap = true })
map('n', '<leader>E', '<cmd>VsnipOpen<cr>', { noremap = true })

-- avante
map('n', '<leader>aa', '<cmd>AvanteToggle<cr>', { noremap = true, silent = true })
map('n', '<leader>an', '<cmd>AvanteChatNew<cr>', { noremap = true, silent = true })
map('n', '<leader>a,', '<cmd>AvanteHistory<cr>', { noremap = true, silent = true })
map('n', '<leader>am', '<cmd>AvanteModels<cr>', { noremap = true, silent = true })
map('v', '<leader>ae', '<cmd>AvanteEdit<cr>', { noremap = true, silent = true })

-- git
map('n', '<leader>gb', '<cmd>Git blame<cr>', { noremap = true })
map('n', '<leader>gc', '<cmd>Git commit -v<cr>', { noremap = true })
map('n', '<leader>gd', ':Git difftool -y<space>', { noremap = true })
map('n', '<leader>ge', '<cmd>Gedit<cr>', { noremap = true })
map('n', '<leader>gf', '<cmd>Dispatch git fetch<cr>', { noremap = true })
map('n', '<leader>gg', ':Gclog -10 %<cr>', { noremap = true })
map('n', '<leader>gi', ':Gvdiffsplit<space>', { noremap = true })
map('n', '<leader>gl', '<cmd>Dispatch git pull<cr>', { noremap = true })
map('n', '<leader>gm', ':Dispatch git merge --no-edit<space>', { noremap = true })
map('n', '<leader>gn', ':Git move<space>', { noremap = true })
map('n', '<leader>gp', '<cmd>Dispatch git -c push.default=current push<cr>', { noremap = true })
map('n', '<leader>gs', '<cmd>Git<cr>', { noremap = true })
map('n', '<leader>gB', ':Dispatch! git checkout -b<space>', {noremap = true})
map('n', '<leader>gD', '<cmd>GRemove<cr>', { noremap = true })
map('n', '<leader>gL', '<cmd>Glog<cr>', { noremap = true })
map('n', '<leader>g,', '<cmd>Gwrite!<cr>', { noremap = true })
map('n', '<leader>g.', '<cmd>GApply<cr>', { noremap = true })
map('n', '<leader>g<space>', ':Git<space>', { noremap = true })

-- fzf-lua
map('n', '<leader>b', '<cmd>FzfLua buffers<cr>', { noremap = true, silent = true })
map('n', '<leader>l', '<cmd>FzfLua grep_loclist<cr>', { noremap = true })
map('n', '<leader>h', '<cmd>FzfLua history<cr>', { noremap = true, silent = true })
map('n', '<leader>*', '<cmd>FzfLua grep_cword<cr>', { noremap = true })
map('n', '<leader>/', '<cmd>FzfLua lines<cr>', { noremap = true, silent = true })
map('n', '<leader>fc', '<cmd>FzfLua git_commits<cr>', { noremap = true, silent = true })
map('n', '<leader>fd', '<cmd>FzfLua git_bcommits<cr>', { noremap = true, silent = true })
map('n', '<leader>ff', '<cmd>FzfLua git_files<cr>', { noremap = true, silent = true })
map('n', '<leader>fg', '<cmd>FzfLua git_branches<cr>', { noremap = true, silent = true })
map('n', '<leader>fm', '<cmd>FzfLua marks<cr>', { noremap = true, silent = true })
map('n', '<leader>ft', '<cmd>FzfLua tags<cr>', { noremap = true, silent = true })
map('n', '<leader>fT', '<cmd>FzfLua filetypes<cr>', { noremap = true, silent = true })
map('n', '<leader>fM', '<cmd>FzfLua keymaps<cr>', { noremap = true, silent = true })
map('n', '<leader>f?', '<cmd>FzfLua help_tags<cr>', { noremap = true, silent = true })
map('n', '<leader>f,', '<cmd>FzfLua grep_curbuf<cr>', { noremap = true, silent = true })
map('n', '<leader>f:', '<cmd>FzfLua command_history<cr>', { noremap = true, silent = true })
map('n', '<leader>f/', '<cmd>FzfLua search_history<cr>', { noremap = true, silent = true })
map('n', '<leader>f<space>', '<cmd>FzfLua grep<cr>', { noremap = true })

-- telescope
-- map('n', '<leader>b', '<cmd>Telescope buffers<cr>', { noremap = true, silent = true })
-- map('n', '<leader>h', '<cmd>History<cr>', { noremap = true, silent = true })
-- map('n', '<leader>*', ':Ag! <c-r><c-w><cr>', { noremap = true })
-- map('n', '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<cr>', { noremap = true, silent = true })
-- map('n', '<leader>fa', '<cmd>Ag!<cr>', { noremap = true, silent = true })
-- map('n', '<leader>fc', '<cmd>Telescope git_commits<cr>', { noremap = true, silent = true })
-- map('n', '<leader>fd', '<cmd>BCommits!<cr>', { noremap = true, silent = true })
-- map('n', '<leader>ff', '<cmd>Telescope fd<cr>', { noremap = true, silent = true })
-- map('n', '<leader>fg', '<cmd>Telescope git_branches<cr>', { noremap = true, silent = true })
-- map('n', '<leader>fm', '<cmd>Telescope marks<cr>', { noremap = true, silent = true })
-- map('n', '<leader>fw', '<cmd>Windows!<cr>', { noremap = true, silent = true })
-- map('n', '<leader>ft', '<cmd>Telescope tags<cr>', { noremap = true, silent = true })
-- map('n', '<leader>fT', '<cmd>Telescope filetypes<cr>', { noremap = true, silent = true })
-- map('n', '<leader>fM', '<cmd>Telescope keymaps<cr>', { noremap = true, silent = true })
-- map('n', '<leader>fA', '<cmd>Telescope autocommands<cr>', { noremap = true, silent = true })
-- map('n', '<leader>f?', '<cmd>Telescope help_tags<cr>', { noremap = true, silent = true })
-- map('n', '<leader>f,', '<cmd>BLines!<cr>', { noremap = true, silent = true })
-- map('n', '<leader>f:', '<cmd>Telescope command_history<cr>', { noremap = true, silent = true })
-- map('n', '<leader>f/', '<cmd>Telescope search_history<cr>', { noremap = true, silent = true })
-- map('n', '<leader>f<space>', ':Ag!<space>', { noremap = true })

-- dispatch
map('n', '<leader>yi', '<cmd>Dispatch yarn install<cr>', { noremap = true, silent = true })
map('n', '<leader>yd', '<cmd>Dispatch yarn dev<cr>', { noremap = true, silent = true })
map('n', '<leader>yw', [[:Start! -title=watch-<c-r>=system('basename '.getcwd())<cr> yarn watch<cr>]], { noremap = true, silent = true })
map('n', '<leader>yh', [[:Start! -title=hot-<c-r>=system('basename '.getcwd())<cr> yarn hot<cr>]], { noremap = true, silent = true })
map('n', '<leader>yl', '<cmd>Dispatch yarn lint<cr>', { noremap = true, silent = true })
map('n', '<leader>ys',
  [[:Start! -title=storybook-<c-r>=system('basename '.getcwd())<cr> yarn start-storybook --port 6006<cr>]],
  { noremap = true, silent = true }
)
map('n', '<leader>yt', '<cmd>Start -title=yarn-test yarn test --watch<cr>', { noremap = true, silent = true })
map('n', '<leader>yT', '<cmd>Dispatch yarn test<cr>', { noremap = true, silent = true })

-- ale
-- map('n', '<leader>ss', '<cmd>ALEReset<cr>', { noremap = true })
-- map('n', '<leader>sf', '<cmd>ALEFix<cr>', { noremap = true })
-- map('n', '<leader>sd', '<cmd>ALEGoToTypeDefinition<cr>', { noremap = true })
-- map('n', '<leader>sr', '<cmd>ALEFindReferences<cr>', { noremap = true })
-- map('n', '<leader>sn', '<cmd>ALEDetail<cr>', { noremap = true })
-- map('n', '<leader>si', '<cmd>ALEInfo<cr>', { noremap = true })
-- map('n', '<leader>sl', '<cmd>ALELint<cr>', { noremap = true })
-- map('n', '<leader>st', '<cmd>ALEToggle<cr>', { noremap = true })

-- test
map('n', '<leader>nt', '<cmd>TestFile<cr>', { noremap = true })
