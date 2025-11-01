-- MD to PDF Export Neovim Plugin
-- Exporteert Markdown naar PDF met md2pdf (https://github.com/clssck/md2pdf-cli)
-- Flags: --toc, --page-numbers, --strip-obsidian
local M = {}

local default_opts = {
  auto_open = false,         -- false | "mac" | "linux" | "win"
  use_dispatch = true,       -- probeer :Dispatch te gebruiken indien aanwezig
  toc = false,               -- standaard geen TOC
  page_numbers = false,      -- standaard geen paginanummers
  strip_obsidian = false,    -- standaard niet strippen
}

M.opts = {}

-- Kleine helper: check of :Dispatch bestaat (2 = exacte match)
local function has_dispatch()
  return (M.opts.use_dispatch and vim.fn.exists(":Dispatch") == 2) or false
end

-- Helper: simpele arg-parser (flags + optioneel outputpad)
local function parse_args(argstr)
  local flags = { toc = false, page_numbers = false, strip_obsidian = false }
  local raw = argstr or ""

  -- booleans als losse tokens (frontier patterns vermijden substrings)
  if raw:find("%f[%w]%-%-toc%f[%W]") then flags.toc = true end
  if raw:find("%f[%w]%-%-page%-numbers%f[%W]") then flags.page_numbers = true end
  if raw:find("%f[%w]%-%-strip%-obsidian%f[%W]") then flags.strip_obsidian = true end

  -- eerst --output=… proberen (met of zonder quotes)
  local output = raw:match("%-%-output%s*=%s*\"([^\"]+)\"")
              or raw:match("%-%-output%s*=%s*'([^']+)'")
              or raw:match("%-%-output%s*=%s*([^%s]+)")

  -- anders: neem de laatste gequote of ongequote arg die niet met "--" start
  if not output then
    output = raw:match("\"([^\"]+)\"%s*$") or raw:match("'([^']+)'%s*$")
      or (function()
            local last = raw:match("(%S+)%s*$")
            if last and not last:match("^%-%-") then return last end
          end)()
  end

  return flags, output
end

-- YAML frontmatter (Obsidian) strippen als het bovenaan staat
local function strip_frontmatter(lines)
  if #lines == 0 then return lines end
  if lines[1]:match("^%s*%-%-%-%s*$") then
    local end_idx = nil
    for i = 2, #lines do
      if lines[i]:match("^%s*%-%-%-%s*$") then
        end_idx = i
        break
      end
    end
    if end_idx then
      local rest = {}
      for i = end_idx + 1, #lines do table.insert(rest, lines[i]) end
      return rest
    end
  end
  return lines
end

-- Platform open
local function open_file_cmd(path)
  local osname = (vim.loop.os_uname().sysname or ""):lower()
  if osname:find("darwin") then
    return "open " .. vim.fn.fnameescape(path)
  elseif osname:find("linux") then
    return "xdg-open " .. vim.fn.fnameescape(path)
  elseif osname:find("windows") or osname:find("mingw") then
    return "start " .. vim.fn.fnameescape(path)
  end
end

local function shellq(s) return vim.fn.shellescape(s) end

-- Kern: converteren
local function md2pdf_convert(opts, is_preview)
  local input = vim.api.nvim_buf_get_name(0)
  local default_out = (input ~= "" and input:gsub("%.md$", ".pdf")) or (vim.fn.getcwd() .. "/output.pdf")

  local arg_flags, arg_out = parse_args(opts.args)

  local cfg = M.opts
  local use_toc = (arg_flags.toc or cfg.toc) and not (opts.bang) -- bang kan ooit voor "force no flags" gebruikt worden
  local use_pn  = (arg_flags.page_numbers or cfg.page_numbers)
  local strip   = (arg_flags.strip_obsidian or cfg.strip_obsidian)

  local output = arg_out or default_out
  if is_preview then
    output = vim.fn.tempname() .. ".pdf"  -- gebruik altijd een temp bestand voor preview
  end

  -- Bepaal inputbron: ofwel huidige bufferbestand, of tijdelijk zonder frontmatter
  local input_for_cmd = input
  local tmpfile = nil
  if strip then
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    lines = strip_frontmatter(lines)
    tmpfile = vim.fn.tempname() .. ".md"
    vim.fn.writefile(lines, tmpfile)
    input_for_cmd = tmpfile
  end

  -- Stel CLI samen
  local parts = {
    'md2pdf',
    '-i', shellq(input_for_cmd),
    '-o', shellq(output),
    '-c', shellq(vim.fn.expand('$HOME/.config/nvim/lua/md-to-pdf/config.json')),
  }
  if use_toc then table.insert(parts, '--toc') end
  if use_pn  then table.insert(parts, '--page-numbers') end
  if M.opts.auto_open then table.insert(parts, '; ' .. open_file_cmd(output)) end

  -- Opruimen temp bestand
  table.insert(parts, '; rm ' .. shellq(input_for_cmd))
  if is_preview then
    table.insert(parts, '; rm ' .. shellq(output))  -- verwijder preview temp bestand
  end

  -- Als vim-dispatch beschikbaar is, gebruik :Dispatch, anders shell bang
  local cmdline = table.concat(parts, " ")
  if has_dispatch() then
    -- :Dispatch {cmd}
    vim.cmd("silent Dispatch " .. cmdline)
  else
    vim.cmd("silent !" .. cmdline)
  end
end

--- Setup
-- @param opts table
function M.setup(opts)
  M.opts = vim.tbl_deep_extend("force", default_opts, opts or {})
  vim.api.nvim_create_user_command(
    "Md2Pdf",
    function (command_opts)
      md2pdf_convert(command_opts, false)
    end,
    {
      nargs = "*",   -- nu kunnen flags + optioneel pad mee
      bang = true,   -- gereserveerd; bijv. :Md2Pdf! kan later "force" gedrag krijgen
      desc = "Converteer Markdown buffer naar PDF met md2pdf",
    }
  )

  vim.api.nvim_create_user_command(
    "Md2PdfPreview",
    function (command_opts)
      md2pdf_convert(command_opts, true)  -- forceer preview met standaard opties
    end,
    {
      nargs = "*",   -- nu kunnen flags + optioneel pad mee
      bang = true,   -- gereserveerd; bijv. :Md2Pdf! kan later "force" gedrag krijgen
      desc = "PDF preview van Markdown buffer met md2pdf",
    }
  )
end

return M
