function! s:yank_file_line_number()
  let path = join([expand('%'), line('.')], ':')
  call setreg('+', path)
  echo path . " (yanked to clipboard)"
endfunction
command! YankFileLineNr call s:yank_file_line_number()

function! s:open_branch_fzf(line)
  let l:parser = split(a:line)
  let l:branch = l:parser[0]
  if l:branch ==? '*'
    let l:branch = l:parser[1]
  endif
  execute '!git checkout ' . l:branch
endfunction

" checkout a git branch using fzf
command! -bang -nargs=0 GCheckout
  \ call fzf#vim#grep(
  \   "git branch -v --all --sort=-committerdate --no-merged | grep -v HEAD | sed 's#remotes/[^/]*/##'", 0,
  \   {
  \     'sink': function('s:open_branch_fzf')
  \   },
  \   0
  \ )

" diff buffer with local file
function! s:diff_with_saved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
command! DiffSaved call s:diff_with_saved()

" Working with csv files
command! CSVColumn %!column -t -s ','
command! CSVJoin %s/ \{2,\}/,/g

" format xml
command! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"
command! FormatJSON :%!python3 -m json.tool

" command
command! Htop call system('tmux split-pane htop')
