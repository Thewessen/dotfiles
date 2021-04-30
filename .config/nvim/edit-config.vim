" Configs are stored in a bare-repo in the $HOME dir
let s:configs = '(cd $HOME; git ls-tree -r work --name-only)'

function! s:custom_list(A,C,P)
  return system(s:configs)
endfunction

function s:search_config(config)
  if empty(a:config)
    call fzf#run(fzf#wrap({
      \ 'source': s:configs,
      \ 'options': '--prompt="Config> "',
      \ 'dir': '~'
      \ }))
  else
    exec "edit ~/".a:config
  endif
endfunction

command! -nargs=? -complete=custom,s:custom_list Config call s:search_config(<q-args>)
