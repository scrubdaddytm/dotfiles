set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

if has('macunix')
    let g:python3_host_prog = '/Users/tucker/.pyenv/versions/3.13.0/bin/python'
    let g:black_virtualenv = '/Users/tucker/.pyenv/versions/3.13.0'
else
    let g:python3_host_prog = '~/.venvs/neovim-python3/bin/python3'
    let g:black_virtualenv = '~/.venvs/neovim-python3'
endif

set nocompatible

set rtp+=/usr/bin/fzf

silent if empty(glob('"${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim'))
    silent! execute 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

silent! if plug#begin('~/.vim/plugged')
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    Plug 'preservim/nerdtree'
    Plug 'preservim/tagbar'
    Plug 'OXY2DEV/markview.nvim'

    Plug 'airblade/vim-gitgutter'
    Plug 'zivyangll/git-blame.vim'
    Plug 'tpope/vim-fugitive'
    Plug 'rhysd/committia.vim'

    Plug 'airblade/vim-rooter'
    Plug 'christoomey/vim-tmux-navigator'

    Plug 'mg979/vim-visual-multi'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-sleuth'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-obsession'
    Plug 'mbbill/undotree'

    Plug 'folke/which-key.nvim'

    Plug 'dracula/vim', {'as': 'dracula'}

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'deoplete-plugins/deoplete-jedi'
    Plug 'dense-analysis/ale'

    Plug 'psf/black', { 'branch': 'stable' }

    Plug 'echasnovski/mini.nvim', { 'branch': 'stable' }
    Plug 'nvim-tree/nvim-web-devicons'

    Plug 'github/copilot.vim'

    call plug#end()
endif

""
set encoding=utf8
set hidden
set visualbell
set clipboard=unnamed
"" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.vim/undo

"" Spaces >>>> tabs
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2
autocmd FileType lua setlocal shiftwidth=2 tabstop=2

set number
filetype on
filetype indent on
filetype plugin on
set lazyredraw
set linebreak
set showmatch
set cursorline

set showcmd

"" Searching
set ignorecase
set smartcase

set hlsearch

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

let g:deoplete#enable_at_startup = 1

let g:ale_python_auto_virtualenv = 1
let g:ale_python_auto_poetry = 1
let g:ale_python_flake8_options = '--max-line-length=100'
let g:ale_fix_on_save = 1
let g:ale_linters = {
\   'python': ['flake8', 'mypy', 'pyright'],
\   'zsh': ['shell']
\}

let g:ale_fixers = {
\    'python': ['black', 'autopep8', 'isort'],
\    '*': ['remove_trailing_lines', 'trim_whitespace'],
\}

if has('macunix')
    let g:python_mypy_options = '--python-version 3.11'
    let g:black_target_version = "3.11"
    let g:ale_python_black_options='--line-length=131 --target-version py311'
else
    let g:python_mypy_options = '--python-version 3.10'
    let g:black_target_version = "3.10"
    let g:ale_python_black_options='--line-length=131 --target-version py310'
endif

"" Mappings
let mapleader=","

"" All mode mappings
map ; :
noremap <leader>W :w !sudo tee % > /dev/null<CR>
noremap <f12> :!ctags -L <(find . -name '*.py') --fields=+iaS --python-kinds=-i --sort=yes --extra=+q<cr>
map <F5> :w<CR>:!ipython "%"<CR>

nmap <F7> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>
nmap <F9> :Black<CR>

nnoremap <leader>s :<C-u>call gitblame#echo()<CR>

"" Normal mode mappings
nmap <space> viw
nnoremap <F2> :set invpaste paste?<CR>
"" nnoremap <Tab> :bnext<CR>
"" nnoremap <S-Tab> :bprevious<CR>
nnoremap <leader>rws :%s/\s\+$//<cr>:let @/=''<CR>


"" FZF
nnoremap <leader>f :FZF<cr>

"" Visual mode mappings
vnoremap // y/<C-R>"<CR>

" paste to fluffy
vmap <leader>p :w !fpb -<cr>

"" Insert mode mappings
inoremap jk <esc>
inoremap jj <esc>
inoremap kj <esc>
inoremap ;; <esc>

"" UI
set list
set listchars=tab:→~,nbsp:␣,trail:•,precedes:«,extends:»

set t_Co=256

let g:airline_powerline_fonts = 1

lua << EOF
  require("which-key").setup {
    -- default configuration currently
  }
EOF

"" MUST be after all variables are configured
colorscheme dracula
