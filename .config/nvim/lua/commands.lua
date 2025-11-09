local cmd = vim.api.nvim_create_user_command
local f = require'functions'

-- ============================================================================
-- Constants
-- ============================================================================

local QUEUE_NAMES = {
  'snelberekenen',
  'ufo-connect',
  'aflosvrij',
  'mail',
  'signalmail',
  'lifeinsurance',
  'hypotheekcheck',
  'refinancing',
  'risk-class-reduction',
  'test-fastlane',
  'client-deleter',
  'legacy'
}

-- ============================================================================
-- Helper Functions
-- ============================================================================

local function checkout_branch_with_fzf()
  vim.fn['fzf#vim#grep'](
    "git branch --all --sort=-committerdate --no-merged",
    0,
    { sink = f.checkoutBranchFzf },
    0
  )
end

local function format_xml()
  vim.cmd([[%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())]])
end

local function format_json()
  vim.cmd([[%!python3 -m json.tool]])
end

local function run_htop()
  os.execute('tmux split-pane htop')
end

local function start_queue(args)
  local queue_name = args.args ~= '' and args.args or ''
  os.execute('start-queue ' .. queue_name)
end

local function queue_complete()
  return QUEUE_NAMES
end

-- ============================================================================
-- File Operations
-- ============================================================================

cmd('YankFileLineNr', f.yankFileLineNumber, {
  desc = 'Copy current file and line number to clipboard'
})

cmd('DiffSaved', f.diffSaved, {
  desc = 'Diff current buffer with saved file on disk'
})

-- ============================================================================
-- Git Operations
-- ============================================================================

cmd('GCheckout', checkout_branch_with_fzf, {
  nargs = 0,
  bang = true,
  desc = 'Use fzf to find and checkout a branch'
})

-- ============================================================================
-- File Formatting
-- ============================================================================

-- CSV formatting (requires csvkit)
cmd('FormatCSV', [[%!csvlook -I]], {
  desc = 'Create columns from comma-separated rows'
})

cmd('JoinCSV', [[%s/ \{2,\}/,/g]], {
  desc = 'Reverse the CSVColumn command'
})

-- XML formatting
cmd('FormatXML', format_xml, {
  desc = 'Format XML using python'
})

-- JSON formatting
cmd('FormatJSON', format_json, {
  desc = 'Format JSON using python'
})

-- ============================================================================
-- System & External Tools
-- ============================================================================

cmd('Htop', run_htop, {
  desc = 'Display htop in tmux split-pane'
})

cmd('Search', f.searchWeb, {
  nargs = 1,
  desc = 'Browse the web with given query'
})

cmd('Tabnew', [[Start nvim]], {
  desc = 'Open a new tab for nvim using tmux'
})

-- ============================================================================
-- Queue Management
-- ============================================================================

cmd('Queue', start_queue, {
  nargs = '?',
  desc = 'Start queue with optional queue name',
  complete = queue_complete
})
