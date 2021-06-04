local map = vim.api.nvim_set_keymap

vim.g.mapleader = ','

-- TODO:
-- add yarn file path and line number
map('n', '<leader>b', '<cmd>Buffers<cr>', { noremap = true, silent = true })
map('n', '<leader>c', '<cmd>copen<cr>', { noremap = true })
map('n', '<leader>d', '<cmd>DiffSaved<cr>', { noremap = true, silent = true })
map('n', '<leader>l', '<cmd>lopen<cr>', { noremap = true })
map('n', '<leader>o', '<cmd>only<cr>', { noremap = true, silent = true })
map('n', '<leader>q', '<cmd>qall<cr>', { noremap = true })
map('n', '<leader>t', '<c-w>T', { noremap = true, silent = true })
map('n', '<leader>w', '<cmd>wq<cr>', { noremap = true, silent = true })
map('n', '<leader>z', [[<cmd>call system('tmux split-pane -p 90')<cr>]], { noremap = true, silent = true })
map('n', '<leader>.', '<c-^>', { noremap = true })
map('n', '<leader>,', '<cmd>w<cr>', { noremap = true, silent = true })
map('n', '<leader>R', '<cmd>luafile ~/.config/nvim/init.lua<cr><cmd>echo "config loaded..."<cr>', { noremap = true })
map('n', '<leader>Y', '<cmd>YankFileLineNr<cr>', { noremap = true })
map('n', '<leader><space>', '<cmd>%s/\\s\\+$<cr>', { noremap = true, silent = true })

-- edit
map('n', '<leader>e', '<cmd>Config<cr>', { noremap = true })
map('n', '<leader>E', '<cmd>NeoSnippetEdit-vertical<cr>', { noremap = true })

-- git
map('n', '<leader>gb', '<cmd>Git blame<cr>', { noremap = true })
map('n', '<leader>gc', '<cmd>Git commit -v<cr>', { noremap = true })
map('n', '<leader>gd', ':Git difftool -y<space>', { noremap = true })
map('n', '<leader>gf', '<cmd>Dispatch git fetch<cr>', { noremap = true })
map('n', '<leader>gg', '<cmd>0Glog<cr>', { noremap = true })
map('n', '<leader>gi', ':Gvdiffsplit<space>', { noremap = true })
map('n', '<leader>gl', '<cmd>Dispatch git pull<cr>', { noremap = true })
map('n', '<leader>gm', ':Dispatch git merge --no-edit<space>', { noremap = true })
map('n', '<leader>gn', ':Git move<space>', { noremap = true })
map('n', '<leader>gp', '<cmd>Dispatch git push<cr>', { noremap = true })
map('n', '<leader>gs', '<cmd>Git<cr>', { noremap = true })
map('n', '<leader>gB', ':Dispatch! git checkout -b<space>', {noremap = true})
map('n', '<leader>gD', '<cmd>GRemove<cr>', { noremap = true })
map('n', '<leader>gL', '<cmd>Glog<cr>', { noremap = true })
map('n', '<leader>g,', '<cmd>Gwrite!<cr>', { noremap = true })
map('n', '<leader>g<space>', ':Git<space>', { noremap = true })

-- fzf
map('n', '<leader>b', '<cmd>Buffers!<cr>', { noremap = true, silent = true })
map('n', '<leader>h', '<cmd>History<cr>', { noremap = true, silent = true })
map('n', '<leader>*', ':Ag <c-r><c-w><cr>', { noremap = true })
map('n', '<leader>/', '<cmd>Lines!<cr>', { noremap = true, silent = true })
map('n', '<leader>fa', '<cmd>Ag!<cr>', { noremap = true, silent = true })
map('n', '<leader>fc', '<cmd>Commits!<cr>', { noremap = true, silent = true })
map('n', '<leader>fd', '<cmd>BCommits!<cr>', { noremap = true, silent = true })
map('n', '<leader>ff', '<cmd>GFiles<cr>', { noremap = true, silent = true })
map('n', '<leader>fg', '<cmd>GCheckout!<cr>', { noremap = true, silent = true })
map('n', '<leader>fm', '<cmd>Marks<cr>', { noremap = true, silent = true })
map('n', '<leader>fw', '<cmd>Windows<cr>', { noremap = true, silent = true })
map('n', '<leader>ft', '<cmd>Tags<cr>', { noremap = true, silent = true })
map('n', '<leader>fT', '<cmd>Filetypes<cr>', { noremap = true, silent = true })
map('n', '<leader>fM', '<cmd>Maps<cr>', { noremap = true, silent = true })
map('n', '<leader>f?', '<cmd>Helptags<cr>', { noremap = true, silent = true })
map('n', '<leader>f,', '<cmd>BLines!<cr>', { noremap = true, silent = true })
map('n', '<leader>f:', '<cmd>History:<cr>', { noremap = true, silent = true })
map('n', '<leader>f/', '<cmd>History/<cr>', { noremap = true, silent = true })
map('n', '<leader>f<space>', ':Ag<space>', { noremap = true })

-- dispatch
map('n', '<leader>yi', '<cmd>Dispatch yarn install<cr>', { noremap = true, silent = true })
map('n', '<leader>yd', '<cmd>Dispatch yarn dev<cr>', { noremap = true, silent = true })
map('n', '<leader>yw', [[:Start! -title=yarn-<c-r>=system('basename '.getcwd())<cr> yarn dev && yarn watch<cr>]], { noremap = true, silent = true })
map('n', '<leader>yl', '<cmd>Dispatch yarn lint<cr>', { noremap = true, silent = true })
map('n', '<leader>ys',
  [[:Start! -title=storybook-<c-r>=system('basename '.getcwd())<cr> yarn start-storybook --port 6006<cr>]],
  { noremap = true, silent = true }
)
map('n', '<leader>yt', '<cmd>Start -title=yarn-test yarn test --watch<cr>', { noremap = true, silent = true })
map('n', '<leader>yT', '<cmd>Dispatch yarn test<cr>', { noremap = true, silent = true })

-- ale
map('n', '<leader>ss', '<cmd>ALEReset<cr>', { noremap = true })
map('n', '<leader>sf', '<cmd>ALEFix<cr>', { noremap = true })
map('n', '<leader>sd', '<cmd>ALEGoToTypeDefinition<cr>', { noremap = true })
map('n', '<leader>sr', '<cmd>ALEFindReferences<cr>', { noremap = true })
map('n', '<leader>sn', '<cmd>ALEDetail<cr>', { noremap = true })
map('n', '<leader>si', '<cmd>ALEInfo<cr>', { noremap = true })
map('n', '<leader>sl', '<cmd>ALELint<cr>', { noremap = true })
map('n', '<leader>st', '<cmd>ALEToggle<cr>', { noremap = true })

