let s:containers = 'docker container ls --all --filter name=nhb --format "%s" | tail +2'
let s:cmd = ''

function! s:docker_exec(container, ...)
  let l:cont = substitute(a:container, '^\([^ ]\+\).*$', '\1', '')
  let l:cmd = substitute(s:cmd, '$2', a:0 > 0 && len(a:1) ? a:1 : '/bin/bash', '')
  if match(system('docker container inspect --format="{{.State.Running}}" ' . l:cont), "false") == 0
    let l:output = system(printf('docker container start %s', l:cont))
    echomsg 'docker container started '.l:output
  endif

  exec substitute(l:cmd, '$1', l:cont, 'g')
endfunction

function! s:docker_cmd(name, cmd, ...)
  let s:cmd = a:cmd 
  let l:container = a:0 > 0 ? a:1 : ''
  if empty(l:container)
    call fzf#run(fzf#wrap({
          \ 'source': printf(s:containers, 'table {{.Names}},{{.Status}}').' | column -s , -t | sed "s/nhb_//"',
          \ 'sink': function('s:docker_exec'),
          \ 'options': '--prompt="Docker'.a:name.'> " --preview="docker container logs --tail=15 {+1}"'
          \ }))
  else
    call s:docker_exec(l:container, join(a:000[1:], ' '))
  endif
endfunction

function! s:remove_nhb_prefix(name)
  return substitute(a:name, "^nhb_", "", "")
endfunction

function! s:custom_list(A,C,P)
  let l:args = split(a:C)
  if len(l:args) == 2
    let l:containers = substitute(system(printf(s:containers, "table {{.Names}}")), "nhb_", "", "g")
    return filter(split(l:containers, '\n'), 'v:val =~ "' . a:A . '"')
  endif

  return getcompletion(a:A, 'shellcmd')
endfunction

command! -nargs=* -complete=customlist,s:custom_list Docker call s:docker_cmd('', 'Start -title=exec-$1 docker exec -it nhb_$1 $2', <f-args>)
command! -nargs=* -complete=customlist,s:custom_list DockerLogs call s:docker_cmd('Logs', 'Start -title=logs-$1 docker container logs -f nhb_$1', <f-args>)
command! -nargs=* -complete=customlist,s:custom_list DockerRestart call s:docker_cmd('Restart', 'Dispatch! docker container restart nhb_$1', <f-args>)
command! -nargs=* -complete=customlist,s:custom_list DockerStop call s:docker_cmd('Stop', 'Dispatch! docker container stop nhb_$1', <f-args>)
