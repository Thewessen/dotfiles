let s:containers = 'docker container ls --all --filter name=nhb --format "%s" | tail +2'
let s:cmd = ''

function! s:docker_exec(container)
  let l:cont = substitute(a:container, '^\([^ ]\+\).*$', '\1', '')
  if match(system('docker container inspect --format="{{.State.Running}}" ' . l:cont), "false") == 0
    let l:output = system(printf('docker container start %s', l:cont))
    echomsg 'docker container started '.l:output
  endif

  exec substitute(s:cmd, '$1', l:cont, 'g')
endfunction

function! s:docker_cmd(name, cmd, container)
  let s:cmd = a:cmd 
  if empty(a:container)
    call fzf#run(fzf#wrap({
          \ 'source': printf(s:containers, 'table {{.Names}},{{.Status}}').' | column -s , -t',
          \ 'sink': function('s:docker_exec'),
          \ 'options': '--prompt="Docker'.a:name.'> " --preview="docker container logs --tail=15 {+1}"'
          \ }))
  else
    call s:docker_exec(a:container)
  endif
endfunction

function! s:custom_list(A,C,P)
  return system(printf(s:containers, "table {{.Names}}"))
endfunction

command! -nargs=? -complete=custom,s:custom_list Docker call s:docker_cmd('', 'Start -title=exec-$1 docker exec -it $1 /bin/bash', <q-args>)
command! -nargs=? -complete=custom,s:custom_list DockerLogs call s:docker_cmd('Logs', 'Start -title=logs-$1 docker container logs -f $1', <q-args>)
command! -nargs=? -complete=custom,s:custom_list DockerRestart call s:docker_cmd('Restart', 'Dispatch! docker container restart $1', <q-args>)
command! -nargs=? -complete=custom,s:custom_list DockerStop call s:docker_cmd('Stop', 'Dispatch! docker container stop $1', <q-args>)
