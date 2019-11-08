""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""" VUNDLE SETUP """""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible                       " use vim, not vi
filetype off                           " required for vundle
set rtp+=~/.vim/bundle/Vundle.vim      " set vundle path


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""" PLUGINS """""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call vundle#begin()                    " load plugins

Plugin 'altercation/vim-colors-solarized'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'elixir-lang/vim-elixir'
Plugin 'ElmCast/elm-vim'
Plugin 'itchyny/lightline.vim'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
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

set number                             " use absolute numbers in left gutter
set ruler                              " show current position in status bar
set laststatus=2                       " always show status bar
set showcmd                            " Show incomplete commands

set splitbelow                         " open splits below the current buffer
set splitright                         " open splits to the right
set diffopt+=vertical                  " view diffs vertically
autocmd VimResized * :wincmd =         " rebalance windows when vim is resized

set list listchars=trail:·,nbsp:·      " show trailing whitespace

autocmd FileType gitcommit setlocal spell " spell check commit messages


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
let mapleader="\<space>"
                                       " <c-c>, jk, kj  now act just like <esc>
inoremap <c-c> <esc>
inoremap jj <esc>
inoremap jk <esc>
                                       " buffer navigation
nnoremap <Tab> :bnext<cr>
nnoremap <S-Tab> :bprevious<cr>
                                       " split navigation, TmuxNavigate(Dir)
                                       " is used in place of <c-h>, <c-j>, etc
nnoremap <silent><c-j> :TmuxNavigateDown<cr>
nnoremap <silent><c-k> :TmuxNavigateUp<cr>
nnoremap <silent><c-h> :TmuxNavigateLeft<cr>
nnoremap <silent><c-l> :TmuxNavigateRight<cr>
                                       " auto-indent entire file
map <leader>i mmgg=G`m
                                       " convert Ruby hashes to 1.9 syntax
nnoremap <leader>hr :%s/:\([^=,'"]*\) =>/\1:/gc<cr>
                                       " count matches in current file
nnoremap <leader>n :%s///gn<cr>
                                       " use :w!! to save with sudo
cmap w!! %!sudo tee > /dev/null %
                                       " don't let K open man pages
nnoremap K <Nop>
                                       " don't enter Ex mode
nnoremap Q <Nop>
                                       " turn off match highlighting
nnoremap <leader><leader> :nohl<cr>
                                       " source this file
nmap <leader>s :source $MYVIMRC<cr>
                                       " clear all trailing white space
nmap <leader>w :%s/\s\+$//e<cr>
                                       " navigate ctags with left and right
nmap <left> :tprev<cr>
nmap <right> :tnext<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""" REGEXP MATCHING """""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ignorecase                         " ignore case when searching
set smartcase                          " unless you specify case
set hlsearch                           " highlight matches
set incsearch                          " show first match while typing
set iskeyword+=-                       " consider words with dashes one word

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch(cmdtype)        " match objects in visual mode with * & #
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""" FZF CONFIGURATION """""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <C-p> :GFiles <cr>
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""" FILES AND BACKUPS """""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup                           " turn off backups
set nowb                               " don't even backup current file
set noswapfile                         " don't create swapfiles


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""" TAB COMPLETION """""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmenu
set wildmode=list:longest,list:full    " set the completion corpus
set complete=.,w                       " only complete words in open buffers
function! InsertTabWrapper()           " use completion unless at line beginning
  let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

autocmd InsertEnter * set noignorecase " consider case when autocompleting
autocmd InsertLeave * set ignorecase   " ignore case the rest of the time
