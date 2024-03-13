local cmd = vim.api.nvim_create_user_command
local f = require'functions'

local bookmark = {
  web = '~/hypotheekbond/monorepo/apps/web',
  devenv = '~/hypotheekbond/devenv',
  ['devenv-docker'] = '~/hypotheekbond/devenv-docker',
  mono = '~/hypotheekbond/monorepo',
  node = '~/hypotheekbond/monorepo/yarn-workspace-packages/node_package',
  smoke = '~/hypotheekbond/monorepo/yarn-workspace-packages/storybook-smoke-test',
  workspaces = '~/hypotheekbond/monorepo/yarn-workspace-packages',
  ['ins-api'] = '~/hypotheekbond/monorepo/apps/insurance-api',
  pdf = '~/hypotheekbond/monorepo/apps/pdf-service',
  duurzaam = '~/hypotheekbond/monorepo/apps/duurzaamheidsprofiel',
  munt = '~/hypotheekbond/monorepo/apps/munt-bespaarcheck',
  veh = '~/hypotheekbond/monorepo/apps/veh',
  tools = '~/hypotheekbond/monorepo/apps/tools',
  ['ufo-con'] = '~/hypotheekbond/monorepo/apps/ufo-consumer',
  ['ufo-api'] = '~/hypotheekbond/monorepo/apps/ufo-api',
  ['ufo-admin'] = '~/hypotheekbond/monorepo/apps/ufo-organization-admin',
  ['ufo-org'] = '~/hypotheekbond/monorepo/apps/ufo-organization',
  force = '~/hypotheekbond/monorepo/apps/workforce',
  rente = '~/hypotheekbond/monorepo/apps/renteadministratie',
}

cmd('Cd', function(a)
  vim.cmd('cd ' .. bookmark[a.args])
end, {
  nargs = 1,
  desc = {'Cd to bookmarked directories'},
  complete = function()
    local bookmarks = {}
    for k, v in pairs(bookmark) do
      bookmarks[#bookmarks + 1] = k
    end
    return bookmarks
  end
});

-- use fzf to browse through notes taken
cmd('Notes', function()
  vim.fn['fzf#vim#grep']('ls $HOME/notes', 0, { sink = {'edit $HOME/notes/'} }, 0)
end, {nargs = 0, desc = {'Use fzf to browse through notes taken'}})

-- copy current file and line number to clipboard
cmd('YankFileLineNr', f.yankFileLineNumber, {desc = {'Copy current file and line number to clipboard'}})

-- use fzf to find and checkout a branch
cmd('GCheckout', function()
  vim.fn['fzf#vim#grep'](
    "git branch --all --sort=-committerdate --no-merged", 0,
    { sink = f.checkoutBranchFzf }, 0)
end, {nargs = 0, bang = true, desc = {'Use fzf to find and checkout a branch'}})

-- diff current buff with saved file on disc
cmd('DiffSaved', f.diffSaved, {desc = {'Diff current buff with saved file on disc'}})

-- working with csv files
cmd('FormatCSV', [[%!column -t -s ',']], {desc = {'Create columns from , seperated rows'}})
cmd('JoinCSV', [[%s/ \{2,\}/,/g]], {desc = {'Reverses the CSVColumn command'}})

-- working with xml
cmd('FormatXML', function()
  vim.cmd([[%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())]])
end, {desc = {'Format XML using python'}})

-- working with json
cmd('FormatJSON', function() vim.cmd([[%!python3 -m json.tool]]) end, {desc = {'Format JSON using python'}})

cmd('Htop', function() os.execute('tmux split-pane htop') end, {desc = {'Display `htop` in tmux split-pane'}})
cmd('Search', f.searchWeb, {nargs = 1, desc = {'Browse the web with given query'}})
