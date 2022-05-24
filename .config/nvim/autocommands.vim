augroup mappings
  autocmd!
  autocmd BufWinEnter,BufEnter * if &diff | call VimDiffMapping() | endif
  autocmd filetype fzf imap <buffer> <ESC> <C-D>
  autocmd filetype sh call ShellMapping()
  autocmd filetype php call PHPMapping()
  autocmd filetype fugitive call FugitiveMapping()
  autocmd filetype js,javascript,ts,typescript,mjs,vue,jsx,tsx,reason,typescriptreact call NPMMapping()
augroup END

function! VimDiffMapping()
  nno <buffer> ]] ]c
  nno <buffer> [[ [c
  nno <buffer> <leader>[ :diffget //2<CR>:diffupdate<CR>
  nno <buffer> <leader>] :diffget //3<CR>:diffupdate<CR>
endfunction

function! NPMMapping()
  nno <silent> <leader>nn <cmd>Start nvm exec<CR>
  nno <silent> <leader>nh <cmd>Start node<CR>
endfunction

function! ShellMapping()
  nno <buffer> <leader>nn :!sh %:p<CR>
  nno <buffer> <leader>nt :lcd %:p:h<CR>:exec ':tabe term://BATS_RUN_SKIPPED=true bats '.expand('%:p:r').'_test.sh'<CR>
endfunction

" PHP artisan commands
function! PHPMapping()
  " nno <buffer> <leader>nn :bo 20split term://vssh psysh<CR>
  nno <buffer> <leader>nn :Start psysh<CR>
  nno <buffer> <leader>ni :Dispatch dre composer install<CR>
  nno <buffer> <leader>nt :bo 10split term://vendor/bin/phpunit<CR>
  nno <buffer> <leader>ar :!php artisan route:list \| grep<space>
  nno <buffer> <leader>ad :Docker web php artisan dump-server<CR>
  nno <buffer> <leader>am :!php artisan make:
  nno <buffer> <leader>ai :!php artisan migrate
  nno <buffer> <leader>as :!php artisan db:seed<CR>
  nno <buffer> <leader>at :Docker web php artisan tinker<CR>
  nno <buffer> <leader>n, :PhpactorHover<CR>
  nno <buffer> <leader>np :PhpactorContextMenu<CR>
  nno <buffer> <leader>nd :PhpactorGotoDefinition<CR>
  nno <buffer> <leader>nS :PhpactorStatus<CR>
  nno <buffer> <leader>nf :PhpactorFindReferences<CR>
  nno <buffer> <leader>nI :PhpactorImportMissingClasses<CR>
  nno <buffer> <leader>nR :PhpactorCacheClear<CR>
endfunction

function! FugitiveMapping()
  nno <buffer> <leader>, call termopen('git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"')
endfunction
