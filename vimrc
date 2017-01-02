""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""" VUNDLE SETUP """""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible                       " use vim, not vi
filetype off                           " required for vundle
set rtp+=~/.vim/bundle/Vundle.vim      " set vundle path


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""" PLUGINS """""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call vundle#rc()                       " load plugins

Plugin 'altercation/vim-colors-solarized'
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
Plugin 'VundleVim/Vundle.vim'

call vundle#end()                      " finish loading


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""" FILE DETECTION """""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on              " detect filetype, handle accordingly
set autoread                           " auto-read file when it has changed


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""" COLORS AND SYNTAX HIGHLIGHTING """""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme solarized                  " use solarized colorscheme
set background=dark                    " dark theme by default
set t_Co=256                           " use screen-256 colors

syntax on                              " turn on syntax highlighting


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""" INTERFACE """""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set scrolloff=3                        " stay three lines from edges of screen
set nowrap                             " don't wrap lines
set colorcolumn=80,100                 " vertical lines at 80 and 100 cols
set winwidth=85                        " current window at least 85 cols wide

set showmatch                          " highlight matching (,{,[
set mat=1                              " highlight match for 1 ms
runtime macros/matchit.vim             " use % to match blocks and conditionals

set number                             " use absolute number for current line
set relativenumber                     " use relative numbers in left gutter
set ruler                              " show current position in status bar
set laststatus=2                       " always show status bar
set showcmd                            " Show incomplete commands

autocmd VimResized * :wincmd=         " rebalance windows when vim is resized


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""" TABS AND SPACES """""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab                          " insert spaces instead of tabs
set tabstop=2                          " hard tab == two spaces
set softtabstop=2                      " soft tab == two spaces
set shiftwidth=2                       " two spaces when indenting
set smarttab                           " from line beginning, go to next indent

set autoindent                         " turn on indenting
set smartindent                        " indent to the right place


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""" CUSTOM KEY MAPPINGS """""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","                      " use comma for custom commands
inoremap <c-c> <esc>                   " ctrl-c escapes insert mode
inoremap jj <esc>                      " jj escapes insert mode
inoremap jk <esc>                      " jk escapes insert mode, seriously

nnoremap K <nop>                       " don't open man pages with K

nnoremap <Tab> :bnext<cr>              " tab opens next buffer
nnoremap <S-Tab> :bprevious<cr>        " shift-tab opens previous buffer

nnoremap <c-j> <c-w>j                  " move to split to the left
nnoremap <c-k> <c-w>k                  " move to split above
nnoremap <c-h> <c-w>h                  " move to split below
nnoremap <c-l> <c-w>l                  " move to split to the right

map <leader>i mmgg=G`m                 " auto-indent entire file


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""" REGEXP MATCHING """""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ignorecase                         " ignore case when searching
set smartcase                          " unless you specify case
set hlsearch                           " highlight matches
nnoremap <leader><leader> :noh<cr>     " turn off match highlighting
set incsearch                          " show first match while typing

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch(cmdtype)        " match objects in visual mode with * & #
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""" CTRL-P CONFIGURATION """""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set path=$PWD/**                       " search from the current directory
if executable('ag')                    " use ag if available
  set grepprg=ag\ --nogroup\ --nocolor

  let g:ctrlp_user_command='ag %s -l --nocolor -g ""'

  let g:ctrlp_use_caching=0
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""" FILES AND BACKUPS """""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup                           " turn off backups
set nowb                               " don't even backup current file
set noswapfile                         " don't create swapfiles


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""" TAB COMPLETION """""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmode=list:longest,list:full    " set the completion corpus
function! InsertTabWrapper()           " use completion unless at line beginning
  let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>                 " use <s-tab> to choose from drop-down


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""" ETC """""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('mouse')                        " allow mouse use if present
  set mouse=a
endif
