set nocompatible              " be iMproved, required
filetype off                  " required

" Vim Plug
call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'flazz/vim-colorschemes'
Plug 'w0rp/ale' " Linting engine
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Completion
Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }

Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'elixir-lang/vim-elixir', { 'for': ['elixir', 'eelixir'] }
Plug 'tpope/vim-endwise', { 'for': ['ruby', 'elixir'] }

call plug#end()

filetype on
filetype indent on
filetype plugin indent on

set number
set showmatch
set showmode
set guifont=Monaco:h14
set ruler
set cursorline
set formatoptions+=o
set expandtab " Use spaces instead of tabs
set shiftwidth=2
set colorcolumn=80,100,120 " Display char culumns
set showcmd " Display the command as we type it
set ignorecase " Ignore case when searching
set smartcase " Smart-case search mode
set incsearch " Start to search as soon as we type
set gdefault " Always search/replace globally
set shell=zsh
set mouse= "No Mouse

set isk+=- " Treat “-” like a word separator (for auto-completion!)
set isk+=? " Treat “?” like a word separator (for auto-completion!)
set isk+=! " Treat “!” like a word separator (for auto-completion!)
set isk+=! " Treat “_” like a word separator (for auto-completion!)

syntax enable
autocmd filetype go setlocal ts=4 sw=4 sts=0 noexpandtab
colorscheme Monokai
hi colorcolumn ctermbg=0
match Todo /\(\(\t\|\s\)\+$\)/ " Mark trailing whitespace

" Mappings
nmap <f6> :NERDTree<cr>
nnoremap ; :
nmap > :bnext<CR>
nmap < :bprevious<CR>

vnoremap <Tab> >gv|
vnoremap <S-Tab> <gv
nnoremap <Tab> mzV>`zl
nnoremap <S-Tab> mzV<`zh
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Rename files
command! -nargs=* -complete=file -bang Rename call Rename(<q-args>, '<bang>')
command! -nargs=* -complete=file -bang RenameFile call Rename(expand('%:p:h') . '/' . <q-args>, '<bang>')

" Shift Override
command! -nargs=* -bang -complete=file Q q <args>
command! -nargs=* -bang -complete=file W w <args>
command! -nargs=* -bang -complete=file Wq wq <args>
command! -nargs=* -bang -complete=file WQ wq <args>
command! -nargs=* -bang -complete=file E e <args>
command! -nargs=* -complete=file Cd cd <args>
command! -nargs=* -complete=file CD cd <args>

" Statusline
" ----------------------------------------------------------------------------------------------------
function! IsHelp()
  return &buftype=='help'?' (help) ':''
endfunction

function! GetName()
  return expand("%:t")==''?'<none>':substitute(expand("%:p"), getcwd() . "/", "", "g")
endfunction

set statusline=%1*\ %{GetName()}\ %3*
set statusline+=%7*%{&modified?'\ (modified)':'\ '}%3*
set statusline+=%5*%{IsHelp()}%3*
set statusline+=%6*%{&readonly?'\ (read-only)\ ':'\ '}%3*
set statusline+=%3*fenc:%4*%{strlen(&fenc)?&fenc:'none'}%3*\ \
set statusline+=%3*ff:%4*%{&ff}%3*\ \
set statusline+=%3*ft:%4*%{strlen(&ft)?&ft:'<none>'}\ \
set statusline+=%3*tab:%4*%{&ts}
set statusline+=%3*,%4*%{&sts}
set statusline+=%3*,%4*%{&sw}
set statusline+=%3*,%4*%{&et?'et':'noet'}\ \
set statusline+=%<%3*pwd:%4*%{getcwd()}\ \
set statusline+=%3*%=
set statusline+=%3*col:%4*%c\ \
set statusline+=%3*line:%4*%l\ \
set statusline+=%3*total:%4*%L\

" ALE settings
" ----------------------------------------------------------------------------------------------------
highlight clear ALEWarning
highlight ALEErrorSign ctermfg=1
highlight ALEWarningSign ctermfg=3
let g:ale_sign_error = '→'
let g:ale_sign_warning = '→'
let g:ale_linters = {
\   'elixir': ['credo'],
\   'javascript': ['eslint'],
\   'ruby': ['rubocop'],
\   'scss': ['stylelint'],
\}


" Rename current file
" ----------------------------------------------------------------------------------------------------
" Copyright June 2007-2011 by Christian J. Robinson <heptite@gmail.com>
" Distributed under the terms of the Vim license.  See ":help license".
function! Rename(name, bang)
  let l:name    = a:name
  let l:oldfile = expand('%:p')

  if bufexists(fnamemodify(l:name, ':p'))
    if (a:bang ==# '!')
      silent exe bufnr(fnamemodify(l:name, ':p')) . 'bwipe!'
    else
      echohl ErrorMsg
      echomsg 'A buffer with that name already exists (use ! to override).'
      echohl None
      return 0
    endif
  endif

  let l:status = 1

  let v:errmsg = ''
  silent! exe 'saveas' . a:bang . ' ' . l:name

  if v:errmsg =~# '^$\|^E329'
    let l:lastbufnr = bufnr('$')

    if expand('%:p') !=# l:oldfile && filewritable(expand('%:p'))
      if fnamemodify(bufname(l:lastbufnr), ':p') ==# l:oldfile
        silent exe l:lastbufnr . 'bwipe!'
      else
        echohl ErrorMsg
        echomsg 'Could not wipe out the old buffer for some reason.'
        echohl None
        let l:status = 0
      endif

      if delete(l:oldfile) != 0
        echohl ErrorMsg
        echomsg 'Could not delete the old file: ' . l:oldfile
        echohl None
        let l:status = 0
      endif
    else
      echohl ErrorMsg
      echomsg 'Rename failed for some reason.'
      echohl None
      let l:status = 0
    endif
  else
    echoerr v:errmsg
    let l:status = 0
  endif

  return l:status
endfunction

