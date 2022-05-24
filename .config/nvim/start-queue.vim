" Configs are stored in a bare-repo in the $HOME dir
function! s:custom_list(A,C,P)
  return ['snelberekenen', 'ufo-connect', 'aflosvrij', 'signalmail', 'lifeinsurance', 'hypotheekcheck', 'refinancing', 'risk-class-reduction', 'test-fastlane']
endfunction

command! -nargs=? -complete=customlist,s:custom_list Queue call system('start-queue '.<f-args>)
