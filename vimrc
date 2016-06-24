" Vundle Requirements
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" Let Vundle manage itself
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'scrooloose/nerdtree'
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
" set mat=2       " show matching (,{,[ for 2 ms

" searching
set ignorecase " Ignore case when searching
set hlsearch
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

" NERDTree Directory Visual
" autocmd vimenter * NERDTree " NERDTree open by default
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" move around split screens with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" break arrow habbit
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" Airline - smart tab line
let g:airline#extensions#tabline#enabled = 0
