" Vundle Requirements
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" Let Vundle manage itself
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'elixir-lang/vim-elixir'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-ruby/vim-ruby'

" Colors
Plugin 'altercation/vim-colors-solarized'

call vundle#end()
filetype on
filetype plugin on
filetype indent on

let mapleader=","
" Set to auto read when a file is changed from the outside
set autoread

" colors and syntax highlighting
syntax enable
syntax on
set background=dark
set t_Co=256
colorscheme solarized

" Tabs and Spaces
set expandtab       " Use spaces instead of tabs
" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2
set softtabstop=2

set smarttab       " Be smart when using tabs

set linespace=0
set scrolloff=3
set nowrap
set autoindent
set smartindent
set colorcolumn=80,100

" line numbers and length
set number
set ruler       "Always show current position

set showmatch   " Show matching brackets when text indicator is over them
set mat=1       " show matching (,{,[ for 1 ms
" use % to match blocks and conditionals
runtime macros/matchit.vim

" searching
set ignorecase " Ignore case when searching
set smartcase
set hlsearch
nnoremap <leader><leader> :noh<cr>
set incsearch
set path=$PWD/**

" Visual Mode searching
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

" Silver Searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor

  let g:ctrlp_user_command='ag %s -l --nocolor -g ""'

  let g:ctrlp_use_caching=0
endif

" Cycle through buffers as if they were tabs
nnoremap <Tab> :bnext<cr>
nnoremap <S-Tab> :bprevious<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in git anyway...
set nobackup
set nowb
set noswapfile

if has('mouse')
    set mouse=a
endif

if has('cmdline_info')
    set ruler
    set showcmd     " Show incomplete commands
endif

if has('statusline')
    set laststatus=2    " Tell Vim to always put a status line in, even if there is only one window.
endif

" Map other patterns to escape
inoremap jj <esc>
inoremap jk <esc>
inoremap <c-c> <esc>

" move around split screens with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" quit accidentally loading nonexistent man pages
nnoremap K <nop>

" Airline - smart tab line
let g:airline#extensions#tabline#enabled = 0
