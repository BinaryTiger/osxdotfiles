set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'airblade/vim-gitgutter'
Plugin 'majutsushi/tagbar'
Plugin 'valloric/youcompleteme'
Plugin 'scrooloose/nerdcommenter'
Plugin 'flazz/vim-colorschemes'
Plugin 'fatih/vim-go'
call vundle#end()            " required
filetype plugin indent on    " required

set number
set showmatch

set showmode
set guifont=Monaco:h14
set lines=50
set columns=200
set ruler
set cursorline
set formatoptions+=o
set expandtab
set shiftwidth=2
set colorcolumn=80,100,120
syntax enable
autocmd filetype go setlocal ts=4 sw=4 sts=0 noexpandtab
colorscheme Monokai
hi colorcolumn ctermbg=0

nmap <f7> :TagbarToggle<cr>
nmap <f6> :NERDTree<cr>

nnoremap ; :

