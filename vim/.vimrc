set nocompatible
filetype off
filetype plugin indent on

"""""""""""""""""""""""
" NeoBundle
"""""""""""""""""""""""

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))

if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
endif


"""""""""""""""""""""""
" NeoBundle packages
"""""""""""""""""""""""

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'VimClojure'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tomasr/molokai'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'othree/html5.vim'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'scrooloose/syntastic'

call neobundle#end()

"""""""""""""
" Basic Configuration
"""""""""""""

set encoding=utf-8
scriptencoding utf-8

set t_Co=256

set number
set laststatus=2

set tabstop=4
set expandtab
set shiftwidth=4

set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<

set backspace=indent,eol,start
set showmatch

set hlsearch

" set guifont=Ricty_for_Powerline:h10
" set guifontwide=Ricty:h10

"""""""""""""
" Color scheme
"""""""""""""

colorscheme wombat256mod


"""""""""""""
" Filetypes
"""""""""""""

au BufRead,BufNewFile *.pyx     set filetype=python


"""""""""""""""""""""""
" Neocomplcache
"""""""""""""""""""""""

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()


"""""""""""""""""""""""
" Neocomplcache
"""""""""""""""""""""""

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

let g:syntastic_python_checkers = ['pyflakes', 'pep8']


"""""""""""""""""""""""
" Lightline
"""""""""""""""""""""""

let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename', 'currenttag' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'LightlineModified',
        \   'readonly': 'LightlineReadonly',
        \   'fugitive': 'LightlineFugitive',
        \   'filename': 'LightlineFilename',
        \   'fileformat': 'LightlineFileformat',
        \   'filetype': 'LightlineFiletype',
        \   'fileencoding': 'LightlineFileencoding',
        \   'mode': 'LightlineMode',
        \   'currenttag': 'LighlineCurrentTag',
        \ }
        \ }

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
    return fugitive#head()
  else
    return ''
  endif
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightlineCurrentTag()
  return tagbar#currenttag('%s', '')
endfunction


"""""""""""""""""""""""
" Binary Mode
"""""""""""""""""""""""

augroup BinaryXXD
   autocmd!
   autocmd BufReadPre *.bin let &binary =1
   autocmd BufReadPost * if &binary | silent %!xxd -g 1
   autocmd BufReadPost * set ft=xxd | endif
   autocmd BufWritePre * if &binary | %!xxd -r | endif
   autocmd BufWritePost * if &binary | silent %!xxd -g 1
   autocmd BufWritePost * set nomod | endif
augroup END


"""""""""""""""""""""""
" Misc Settings
"""""""""""""""""""""""

set rtp+=~/.fzf


"""""""""""""
" Shortcuts
"""""""""""""

nmap <F7> :TagbarToggle<CR>

" <Esc><Esc> to toggle highlight
nnoremap <Esc><Esc> :set hlsearch! hlsearch?<CR>

" Python PEP
function! Preserve(command)
    " Save the last search.
    let search = @/
    " Save the current cursor position.
    let cursor_position = getpos('.')
    " Save the current window position.
    normal! H
    let window_position = getpos('.')
    call setpos('.', cursor_position)
    " Execute the command.
    execute a:command
    " Restore the last search.
    let @/ = search
    " Restore the previous window position.
    call setpos('.', window_position)
    normal! zt
    " Restore the previous cursor position.
    call setpos('.', cursor_position)
endfunction
function! Autopep8()
    call Preserve(':silent %!autopep8 -')
endfunction
autocmd FileType python nnoremap <F8> :call Autopep8()<CR>

nmap <F9> :NERDTreeToggle
nmap f :FZF<CR>



filetype plugin indent on
filetype indent on
syntax on
