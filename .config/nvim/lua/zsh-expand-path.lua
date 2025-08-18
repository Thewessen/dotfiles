-- Deze drop-in voegt zsh's path-expand toe aan standaard commands van neovim.
-- Zorg dat alle named-dirs in ~/.zsh_namedirs staan.

local function zsh_expand(arg)
  local script = [=[
    emulate -L zsh -o extendedglob -o glob_dots -o no_nomatch
    [[ -f ~/.zsh_namedirs ]] && source ~/.zsh_namedirs
    # Expand ~namedirs and globs from $1 safely:
    print -r -- ${(~)1}
  ]=]
  local out = vim.fn.systemlist({ "zsh", "-o", "no_global_rcs", "-c", script, "--", arg })
  if vim.v.shell_error ~= 0 or #out == 0 then return arg end
  return out[1]
end

local function zsh_complete_list(prefix, only_dirs)
  local script = [=[
    emulate -L zsh -o extendedglob -o glob_dots
    [[ -f ~/.zsh_namedirs ]] && source ~/.zsh_namedirs
    # We don't quote $1 because we want pattern behavior; we pass it as $1 and then re-expand:
    prefix=$1
    # Build pattern inside zsh to avoid shellescaping globs from Lua:
    if [[ -n $prefix ]]; then
      pat=${(~)prefix}"*"
    else
      pat="*"
    fi
    if [[ $2 == "dirs" ]]; then
      print -l -- ${^~pat}(/N)
    else
      # return dirs (with /) and files
      for d in ${^~pat}(/N); do print -r -- $d/; done
      print -l -- ${^~pat}(N.)
    fi
  ]=]
  local kind = only_dirs and "dirs" or "all"
  local out = vim.fn.systemlist({ "zsh", "-o", "no_global_rcs", "-c", script, "--", prefix, kind })
  if vim.v.shell_error ~= 0 or not out then return {} end
  return out
end

-- ---- User commands with completion ----
local function zsh_cmd_complete(ArgLead, CmdLine, CursorPos)
  return zsh_complete_list(ArgLead, false)
end

-- :Ezsh {path} -> als :edit, maar met zsh-tilde-expansie
vim.api.nvim_create_user_command('Ezsh', function(opts)
  vim.cmd.edit(zsh_expand(opts.args))
end, { nargs = 1, complete = zsh_cmd_complete })

-- :CDzsh {path} -> als :cd, maar met zsh-tilde-expansie
vim.api.nvim_create_user_command('CDzsh', function(opts)
  vim.cmd.cd(zsh_expand(opts.args))
end, { nargs = 1, complete = zsh_cmd_complete })

-- Slimme abbreviations: type gewoon :e of :cd zoals je gewend bent
vim.cmd([[
  cabbrev <expr> e  (getcmdtype() == ':' && getcmdline() =~# '^e\s')  ? 'Ezsh '  : 'e'
  cabbrev <expr> cd (getcmdtype() == ':' && getcmdline() =~# '^cd\s') ? 'CDzsh ' : 'cd'
]])
