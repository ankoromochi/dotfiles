" for Neobundle {{{
if has('vim_starting')
  if &compatible
    set nocompatible
  endif

  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'fatih/vim-go'
NeoBundle 'vim-perl/vim-perl'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'AtsushiM/search-parent.vim'
"NeoBundle 'AtsushiM/sass-compile.vim'
NeoBundle 'Shougo/vimproc', {
  \ 'build': {
  \   'mac': 'make -f make_mac.mak',
  \   'unix': 'make -f make_unix.mak',
  \ },
  \ }
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'vim-tags'
NeoBundle 'digitaltoad/vim-jade'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck
" }}}

" for golang {{{
let g:gofmt_command = 'goimports'
au BufWritePre *.go GoFmt
au BufNewFile,BufRead *.go set sw=4 noexpandtab ts=4 completeopt=menu,preview
au FileType go compiler go
" }}}

" for sass
""{{{
"let g:sass_compile_auto      = 1
"let g:sass_compile_cdloop    = 5
"let g:sass_compile_cssdir    = ['css', 'stylesheet']
"let g:sass_compile_file      = ['scss', 'sass']
"let g:sass_compile_beforecmd = ''
"let g:sass_compile_aftercmd  = ''
"}}}

" for emmet
""{{{
let g:user_emmet_leader_key='<c-e>'
let g:user_emmet_settings = {
    \   'variables': {
    \       'lang': "ja"
    \   },
    \   'indentation': '  '
    \   }
""}}}

" for ruby
" {{{
let g:rsenseHome = '/usr/local/Cellar/rsense/0.3/libexec/'
let g:rsenseUseOmniFunc = 1
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'
" }}}

" for perl
" {{{
augroup filetypedetect
autocmd! BufNewFile,BufRead *.t setf perl
autocmd! BufNewFile,BufRead *.psgi setf perl
autocmd! BufNewFile,BufRead *.tt setf tt2html
augroup END
" }}}

autocmd BufNewFile,BufRead *.jade setf jade
autocmd BufNewFile,BufRead *.jade set tabstop=2 shiftwidth=2 expandtab

autocmd BufNewFile,BufRead *.scss setf scss
autocmd BufNewFile,BufRead *.scss set tabstop=2 shiftwidth=2 expandtab

set listchars=tab:>-
set list
set encoding=utf-8
set fileformats=unix,dos,mac
syntax enable
set expandtab
filetype plugin indent on
