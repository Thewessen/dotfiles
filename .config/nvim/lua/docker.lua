local s = {
  containers = 'docker container ls --all --format "%s" | tail +2',
  cmd = ''
}

local function docker_exec(container, ...)
  local cont = string.gsub(container, '^(%S+).*$', '%1')
  local cmd = string.gsub(s.cmd, '$2', #arg > 0 and arg[1] or '/bin/bash')
  if string.find(vim.fn.system('docker container inspect --format="{{.State.Running}}" ' .. cont), "false") == 1 then
    local output = vim.fn.system(string.format('docker container start %s', cont))
    print('docker container started '..output)
  end

  vim.cmd(string.gsub(cmd, '$1', cont, 'g'))
end

local function docker_cmd(name, cmd, ...)
  s.cmd = cmd
  local container = #arg > 0 and arg[1] or ''
  if container == '' then
    require('fzf-lua').files({
      prompt = 'Docker'..name..'> ',
      preview = 'docker container logs --tail=15 {+1}',
      cmd = string.format(s.containers, 'table {{.Names}},{{.Status}}')..' | column -s , -t',
      options = '--prompt="Docker'..name..'> " --preview="docker container logs --tail=15 {+1}"',
      toggle_hidden_flag = '',
    })
  else
    docker_exec(container, table.concat(arg, ' ', 2))
  end
end

local function remove_nhb_prefix(name)
  return string.gsub(name, "^nhb_", "")
end

local function custom_list(A, C, P)
  local args = vim.split(C, ' ')
  if #args == 2 then
    local containers = string.gsub(vim.fn.system(string.format(s.containers, "table {{.Names}}")), "nhb_", "", "g")
    return vim.tbl_filter(function(val) return string.find(val, A) end, vim.split(containers, '\n'))
  end

  return vim.fn.getcompletion(A, 'shellcmd')
end

-- vim.cmd('command! -nargs=* -complete=customlist,custom_list Docker lua docker_cmd("", "Start -title=exec-$1 docker exec -it $1 $2", <f-args>)')
vim.api.nvim_create_user_command(
  'Docker',
  (function (args) docker_cmd("", "Start -title=exec-$1 docker exec -it $1 $2", args) end),
  {
    nargs = '*',
    complete = custom_list
  }
)
-- vim.cmd('command! -nargs=* -complete=customlist,custom_list DockerLogs lua docker_cmd("Logs", "Start -title=logs-$1 docker container logs -f $1 --tail 1000", <f-args>)')
vim.api.nvim_create_user_command(
  'DockerLogs',
  (function (args) docker_cmd("Logs", "Start -title=logs-$1 docker container logs -f $1 --tail 1000", args) end),
  {
    nargs = '*',
    complete = custom_list
  }
)
-- vim.cmd('command! -nargs=* -complete=customlist,custom_list DockerRestart lua docker_cmd("Restart", "Dispatch! docker container restart $1", <f-args>)')
vim.api.nvim_create_user_command(
  'DockerRestart',
  (function (args) docker_cmd("Restart",  "Dispatch! docker container restart $1", args) end),
  {
    nargs = '*',
    complete = custom_list
  }
)
-- vim.cmd('command! -nargs=* -complete=customlist,custom_list DockerStop lua docker_cmd("Stop", "Dispatch! docker container stop $1", <f-args>)')
vim.api.nvim_create_user_command(
  'DockerStop',
  (function (args) docker_cmd("Stop",  "Dispatch! docker container stop $1", args) end),
  {
    nargs = '*',
    complete = custom_list
  }
)
