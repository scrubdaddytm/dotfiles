"" Plugins
if !has('nvim')
    set nocompatible " Default in nvim
endif

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
Plug 'christoomey/vim-tmux-navigator'
Plug 'arcticicestudio/nord-vim'
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'rhysd/committia.vim'
Plug 'zivyangll/git-blame.vim'
Plug 'sjl/gundo.vim'
Plug 'scrooloose/syntastic'

if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    " Plug 'neomake/neomake'
    " Plug 'w0rp/ale'
endif

call plug#end()

"" 
set autoread
set backspace=2
set encoding=utf8
set hidden
set visualbell
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
set listchars=tab:→~,nbsp:␣,trail:•,precedes:«,extends:»

"colorscheme solarized
"let g:airline_theme='solarized'
colorscheme nord
let g:airline_powerline_fonts = 1

set number
filetype on
filetype indent on
filetype plugin on
set laststatus=2
set lazyredraw
set linebreak
set showmatch

if !has('nvim') " nvim defaults
    set showcmd
    set wildmenu
endif

"" Searching
set ignorecase
set incsearch
set smartcase

if !has('nvim')
    set hlsearch " Default in nvim
endif

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
abbr istrace import ipdb; ipdb.set_trace()
abbr strace ipdb.set_trace()

if has('nvim')
    " python syntax checking ASYNC ty based nvim
    " let g:neomake_python_enabled_makers = ['flake8', 'pep8']
    " let g:neomake_python_flake8_maker = { 'args': ['--ignore=E501'], }
    " let g:neomake_python_pep8_maker = { 'args': ['--max-line-length=120'], }

    " let g:ale_linters = { 'python': ['flake8', 'pylint'], }
    " let g:ale_fixers = { 'python': ['autopep8', 'yapf', 'add_blank_lines_for_python_control_statements', 'isort', 'remove_trailing_lines'], }
    " let g:airline#extensions#ale#enabled = 1
endif

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['python', 'flake8']

""" Mappings
let mapleader=","

"" All mode mappings
map ; :
noremap <leader>W :w !sudo tee % > /dev/null<CR>
noremap <f12> :!ctags -L <(find . -name '*.py') --fields=+iaS --python-kinds=-i --sort=yes --extra=+q<cr>
map <F5> :w<CR>:!ipython "%"<CR>

nnoremap <leader>s :<C-u>call gitblame#echo()<CR>

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
