" ==================================================================
" ================= Custom Tabline VimScript =======================
" ==================================================================

set showtabline=2

function! CustomTablabel(n)
  " Get the correct buffers corresponding tabnr (n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let bufnr = buflist[winnr - 1]

  " Show only basefilename
  let tabname = expand('#' . bufnr . ':t')

  " Add '/' for directories
  if getbufvar(bufnr,'&filetype') == 'netrw'
      let tabname .= '/'
  endif
  " Append the number of windows in the tab page if more than one
  let wincount = tabpagewinnr(bufnr, '$')
  if wincount > 1
    let tabname .= ' [' . wincount . ']'
  endif

  return tabname
endfunction

function! CustomTabline()
    let s = ''

    " Add is modified sign
    let label = '%4('
    if getbufvar('%', "&modified")
      let label .= '%3* [+]'
    elseif getbufvar('%', "&readonly")
      let label .= '%2* [-]'
    endif
    let s .= label . '%) '

    " Add seperator
    let s .= '%#TabLineFill#|'

    for i in range(tabpagenr('$'))
        " select the highlighting
        if i + 1 == tabpagenr()
          let s .= '%#TabLineSel# @ '
        else
          let s .= '%#TabLine# '
          " set the tab page number
          let s .= (i + 1) . ' '
        endif

        " the label is made by CustomTablabel()
        let s .= '%{CustomTablabel(' . (i + 1) . ')}'

        let s .= ' '

        " Add seperator
        let s .= '%#TabLineFill#|'
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#'

    " Show fullpathname on the right-side
    let s .= '%='
    let s .= '%<%F'

    return s
endfunction

set tabline=%!CustomTabline()
