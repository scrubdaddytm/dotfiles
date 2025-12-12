set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

let g:neovim_python3_venv = expand('~/.venvs/neovim-python3')
let g:python3_host_prog = g:neovim_python3_venv . '/bin/python3'
let g:black_virtualenv = g:neovim_python3_venv

if !isdirectory(g:neovim_python3_venv)
  echom 'Creating neovim Python virtualenv...'
  execute '!~/.venv-setup.sh'
endif

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
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
    Plug 'tpope/vim-sleuth'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-obsession'
    Plug 'mbbill/undotree'

    Plug 'folke/which-key.nvim'

    Plug 'dracula/vim', {'as': 'dracula'}

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'

    Plug 'dense-analysis/ale'

    Plug 'psf/black', { 'branch': 'stable' }

    Plug 'echasnovski/mini.nvim', { 'branch': 'stable' }
    Plug 'nvim-tree/nvim-web-devicons'

    Plug 'github/copilot.vim'

    Plug 'arcticicestudio/nord-vim', { 'branch': 'main' }

    call plug#end()
endif

""
set encoding=utf8
set hidden
set visualbell
set clipboard=unnamed
"" Enable persistent undo so that undo history persists across vim sessions
set undofile
let &undodir = expand('~/.vim/undo')
if !isdirectory(&undodir)
  call mkdir(&undodir, 'p')
endif

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

let g:ale_python_black_options='--line-length=131'

"" Mappings
let mapleader=","

"" All mode mappings
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
nnoremap <leader>rws :%s/\s\+$//<cr>:let @/=''<CR>


"" FZF
nnoremap <leader>f :FZF<cr>

"" Visual mode mappings
vnoremap // y/<C-R>"<CR>

" paste to fluffy
vmap <leader>p :w !fpb -<cr>

"" Insert mode mappings
inoremap jk <esc>

"" UI
set list
set listchars=tab:→~,nbsp:␣,trail:•,precedes:«,extends:»

set t_Co=256

let g:airline_powerline_fonts = 1

lua << EOF
  require("which-key").setup {
    -- default configuration currently
  }

  -- nvim-cmp setup
  local cmp = require'cmp'
  local luasnip = require'luasnip'

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' },
    })
  })

  -- Command-line completion
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
EOF

"" MUST be after all variables are configured
colorscheme nord
