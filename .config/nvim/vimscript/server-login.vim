" Configs are stored in a bare-repo in the $HOME dir
function! s:custom_list(A,C,P)
  return ['web', 'util', 'db']
endfunction

command! -nargs=? -complete=customlist,s:custom_list Queue call system('server-login '.<f-args>)
