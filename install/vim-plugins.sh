#!/usr/bin/env bash

# Install a few vim plugins I can't live without
main () {
  mkdir -p ~/.vim/pack/plugins/start
  cd $_
  local plugins=(
    'justinmk/vim-dirvish'
    'tpope/vim-surround'
    'tpope/vim-commentary'
    'tpope/vim-repeat'
    'tpope/vim-unimpaired'
    'junegunn/fzf.vim'
    'Shougo/neosnippet.vim'
    'nicwest/vim-http'
  )

  for plugin in ${plugins[@]}; do
    git clone --depth=1 "https://github.com/${plugin}"
  done

  cd -
}

main "$@"
