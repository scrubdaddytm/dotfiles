set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
let g:python3_host_prog = '~/.venvs/neovim-python3/bin/python3'
let g:black_virtualenv = '~/.venvs/black'

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
    Plug 'sjl/gundo.vim'

    Plug 'folke/which-key.nvim'

    Plug 'dracula/vim', {'as': 'dracula'}

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'deoplete-plugins/deoplete-jedi'
    Plug 'scrooloose/syntastic'

    Plug 'psf/black', { 'branch': 'stable' }

    call plug#end()
endif

""
set encoding=utf8
set hidden
set visualbell
set clipboard=unnamed
" Enable persistent undo so that undo history persists across vim sessions
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

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:deoplete#enable_at_startup = 1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['python', 'flake8']
let g:syntastic_python_python_exec = 'python3'

let g:black_linelength = 131

""" Mappings
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
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <leader>rws :%s/\s\+$//<cr>:let @/=''<CR>

" Pane navigation
noremap <C-J> <C-W>j<C-W>_
noremap <C-K> <C-W>k<C-W>_
noremap <C-H> <C-W>h<C-W>_
noremap <C-L> <C-W>l<C-W>_

" FZF
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
