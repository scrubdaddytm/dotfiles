"" Plugins
if !has('nvim')
    set nocompatible " Default in nvim
endif

set rtp+=/usr/bin/fzf

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

""" TRYING 'NEW' THINGS
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
"""

"" GIT
Plug 'airblade/vim-gitgutter'
Plug 'zivyangll/git-blame.vim'
Plug 'tpope/vim-fugitive'
Plug 'rhysd/committia.vim'

"" point out syntax problems
Plug 'scrooloose/syntastic'

"" Change the working directory to the project root when you open a file or directory
Plug 'airblade/vim-rooter'
"" seamless navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'

"" Improve editing
Plug 'mg979/vim-visual-multi'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'sjl/gundo.vim'

Plug 'dracula/vim', {'as': 'dracula'}

"" fancy bottomline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" nvim specific plugins.
if has('nvim')
    " Async completion framework
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'deoplete-plugins/deoplete-jedi'

    " Help with the billion keybindings vim has
    Plug 'folke/which-key.nvim'
endif

call plug#end()

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

if !has('nvim') " nvim defaults
    set showcmd
endif

"" Searching
set ignorecase
set smartcase

if !has('nvim')
    set hlsearch " Default in nvim
endif

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
    let g:deoplete#enable_at_startup = 1
endif

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['python', 'flake8']
let g:syntastic_python_python_exec = 'python3'

""" Mappings
let mapleader=","

"" All mode mappings
map ; :
noremap <leader>W :w !sudo tee % > /dev/null<CR>
noremap <f12> :!ctags -L <(find . -name '*.py') --fields=+iaS --python-kinds=-i --sort=yes --extra=+q<cr>
map <F5> :w<CR>:!ipython "%"<CR>

nmap <F7> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>

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

lua << EOF
  require("which-key").setup {
    -- default configuration currently
  }
EOF

"" UI
set list
set listchars=tab:→~,nbsp:␣,trail:•,precedes:«,extends:»

set t_Co=256

let g:airline_powerline_fonts = 1
" let g:nord_cursor_line_number_background = 1
" let g:nord_uniform_diff_background = 1
" let g:nord_uniform_status_lines = 1

" augroup nord-theme-overrides
"   autocmd!
"   " Use 'nord7' as foreground color for Vim comment titles.
"   autocmd ColorScheme nord highlight Comment ctermfg=14 guifg=D8DEE9
" augroup END

" MUST be after all variables are configured
" colorscheme nord
colorscheme dracula
