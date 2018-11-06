"" Plugins
set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'christoomey/vim-tmux-navigator'
Plug 'arcticicestudio/nord-vim'

call plug#end()

"" 
set autoread
set backspace=2
set encoding=utf8
set hidden
set clipboard=unnamed
" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.vim/undo

"" Spaces >>>> tabs
syntax enable
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

"" UI
set list
set listchars=tab:→\ ,nbsp:␣,trail:•,precedes:«,extends:»

"colorscheme solarized
"let g:airline_theme='solarized'
colorscheme nord
let g:airline_powerline_fonts = 1

set number
filetype indent on
filetype plugin on
set laststatus=2
set lazyredraw
set linebreak
set showcmd
set showmatch
set wildmenu



"" Searching
set hlsearch
set ignorecase
set incsearch
set smartcase

set tags=./tags;/

set showmode

set splitbelow
set splitright

"" No swap files
set nobackup
set noswapfile
set nowb

"" Extra file types
autocmd BufNewFile,BufRead *.md set filetype=markdown

"" Abbreviations
abbr ipdb import ipdb; ipdb.set_trace()
abbr strace ipdb.set_trace()

""" Mappings
let mapleader=","

"" All mode mappings
map ; :
noremap <f12> :!ctags -L <(find . -name '*.py') --fields=+iaS --python-kinds=-i --sort=yes --extra=+q<cr>
noremap <leader>W :w !sudo tee % > /dev/null<CR>

"" Normal mode mappings
nmap <space> viw
nnoremap <F2> :set invpaste paste?<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <leader>rws :%s/\s\+$//<cr>:let @/=''<CR>

" Pane navigation
noremap <C-J> <C-W>j<C-W>_
noremap <C-K> <C-W>k<C-W>_
noremap <C-H> <C-W>h<C-W>_
noremap <C-L> <C-W>l<C-W>_

"" Visual mode mappings
vnoremap // y/<C-R>"<CR>

" paste to fluffy
vmap <leader>p :w !fpb -<cr>

"" Insert mode mappings
inoremap jk <esc>
inoremap jj <esc>
inoremap kj <esc>
inoremap ;; <esc>
