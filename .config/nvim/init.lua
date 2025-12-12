-- Neovim configuration in Lua

-- Runtime path compatibility with vim
vim.opt.runtimepath:prepend('~/.vim')
vim.opt.runtimepath:append('~/.vim/after')
vim.opt.packpath = vim.opt.runtimepath:get()

-- vim-plug setup
vim.g.neovim_python3_venv = vim.fn.expand('~/.venvs/neovim-python3')
vim.g.python3_host_prog = vim.g.neovim_python3_venv .. '/bin/python3'
vim.g.black_virtualenv = vim.g.neovim_python3_venv

if vim.fn.isdirectory(vim.g.neovim_python3_venv) == 0 then
    print('Creating neovim Python virtualenv...')
    vim.fn.execute('!~/.venv-setup.sh')
end

local data_dir = vim.fn.stdpath('data') .. '/site'
if vim.fn.empty(vim.fn.glob(data_dir .. '/autoload/plug.vim')) > 0 then
    vim.fn.system({
        'curl', '-fLo', data_dir .. '/autoload/plug.vim', '--create-dirs',
        'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    })
    vim.cmd('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC')
end

-- Basic settings
vim.opt.encoding = 'utf8'
vim.opt.hidden = true
vim.opt.visualbell = true
vim.opt.clipboard = 'unnamed'

-- Persistent undo
vim.opt.undofile = true
local undodir = vim.fn.expand('~/.vim/undo')
vim.opt.undodir = undodir
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, 'p')
end

-- Tabs and indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

-- Filetype detection
vim.cmd('filetype on')
vim.cmd('filetype indent on')
vim.cmd('filetype plugin on')

-- UI settings
vim.opt.number = true
vim.opt.lazyredraw = true
vim.opt.linebreak = true
vim.opt.showmatch = true
vim.opt.cursorline = true
vim.opt.showcmd = true

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- Update time for CursorHold events (affects diagnostic popup delay)
vim.opt.updatetime = 300

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- No swap files
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false

-- List chars
vim.opt.list = true
vim.opt.listchars = {
    tab = '→~',
    nbsp = '␣',
    trail = '•',
    precedes = '«',
    extends = '»'
}

vim.opt.termguicolors = true

-- Filetype settings
vim.filetype.add({
    extension = {
        md = 'markdown',
    }
})

-- Filetype-specific indentation
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'yaml', 'lua'},
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
    end
})

-- Abbreviations
vim.cmd([[
abbr istrace import ipdb; ipdb.set_trace()
abbr strace ipdb.set_trace()
]])

-- Leader key
vim.g.mapleader = ','

-- Plugins
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.vim/plugged')

Plug('junegunn/fzf', { ['do'] = vim.fn['fzf#install'] })
Plug('junegunn/fzf.vim')

Plug('nvim-tree/nvim-tree.lua')
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('stevearc/aerial.nvim')
Plug('OXY2DEV/markview.nvim')

Plug('airblade/vim-gitgutter')
Plug('zivyangll/git-blame.vim')
Plug('tpope/vim-fugitive')
Plug('rhysd/committia.vim')

Plug('christoomey/vim-tmux-navigator')

Plug('mg979/vim-visual-multi')
Plug('tpope/vim-commentary')
Plug('tpope/vim-repeat')
Plug('tpope/vim-sleuth')
Plug('tpope/vim-surround')
Plug('tpope/vim-obsession')
Plug('mbbill/undotree')

Plug('folke/which-key.nvim')

Plug('dracula/vim', { as = 'dracula' })

Plug('vim-airline/vim-airline')
Plug('vim-airline/vim-airline-themes')

Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('L3MON4D3/LuaSnip')
Plug('saadparwaiz1/cmp_luasnip')

Plug('neovim/nvim-lspconfig')
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('nvimtools/none-ls.nvim')
Plug('nvim-lua/plenary.nvim')

Plug('psf/black', { branch = 'stable' })

Plug('echasnovski/mini.nvim', { branch = 'stable' })
Plug('nvim-tree/nvim-web-devicons')

Plug('github/copilot.vim')

Plug('arcticicestudio/nord-vim', { branch = 'main' })

vim.call('plug#end')

vim.g.airline_powerline_fonts = 1
vim.g.airline_section_c = '%{pathshorten(expand("%:~:."))}'
vim.g['airline_inactive_collapse'] = 0

vim.cmd([[
  augroup AirlineInactivePath
    autocmd!
    autocmd WinEnter * let w:airline_section_c = '%{pathshorten(expand("%:~:."))}'
    autocmd WinLeave * let w:airline_section_c = '%f'
  augroup END
]])

-- Copilot settings (only if available)
if vim.fn.exists('*copilot#Accept') == 1 then
    vim.keymap.set('i', '<C-y>', 'copilot#Accept("\\<CR>")', { expr = true, silent = true, script = true })
    vim.g.copilot_no_tab_map = true
    vim.keymap.set('i', '<C-]>', '<Plug>(copilot-next)')
    vim.keymap.set('i', '<C-[>', '<Plug>(copilot-previous)')
    vim.keymap.set('i', '<C-\\>', '<Plug>(copilot-dismiss)')
end

-- Keybindings
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- All mode mappings (not just normal mode)
keymap('', '<leader>W', ':w !sudo tee % > /dev/null<CR>', opts)
keymap('', '<F5>', ':w<CR>:!ipython "%"<CR>', { noremap = false })
keymap('n', '<F7>', ':NvimTreeToggle<CR>', opts)
keymap('n', '<F8>', '<cmd>AerialToggle<CR>', opts)
keymap('n', '<F9>', ':Black<CR>', opts)
keymap('n', '<leader>s', ':<C-u>call gitblame#echo()<CR>', opts)
keymap('n', '<space>', 'viw', { noremap = false })
keymap('n', '<F2>', ':set invpaste paste?<CR>', opts)
keymap('n', '<leader>rws', ':%s/\\s\\+$//<CR>:let @/=""<CR>', opts)
keymap('n', '<leader>f', ':FZF<CR>', opts)

-- Visual mode
keymap('v', '//', 'y/<C-R>"<CR>', opts)
keymap('v', '<leader>p', ':w !fpb -<CR>', { noremap = false })

-- Insert mode
keymap('i', 'jk', '<Esc>', opts)

-- Plugin configurations
require('which-key').setup()

require('nvim-tree').setup({
    renderer = {
        group_empty = true,
    },
})

require('aerial').setup({
    backends = { 'lsp', 'treesitter' },
    layout = {
        default_direction = 'prefer_right',
    },
    on_attach = function(bufnr)
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
    end,
})

local has_treesitter, treesitter = pcall(require, 'nvim-treesitter.configs')
if has_treesitter then
    treesitter.setup({
        ensure_installed = { 'python', 'lua', 'vim', 'vimdoc' },
        highlight = { enable = true },
        indent = { enable = true },
    })
end

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = { 'pyright', 'lua_ls' },
    automatic_installation = true,
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config.pyright = {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'setup.py', 'requirements.txt', '.git' },
    capabilities = capabilities,
}

vim.lsp.config.lua_ls = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.git' },
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
        },
    },
    capabilities = capabilities,
}

vim.lsp.enable({ 'pyright', 'lua_ls' })

local null_ls = require('null-ls')
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black.with({
            extra_args = { '--line-length', '131' },
        }),
        null_ls.builtins.formatting.isort,
    },
})

-- Diagnostic configuration
vim.diagnostic.config({
    float = {
        source = 'always',
        border = 'rounded',
    },
})

-- Show diagnostics on hover
vim.api.nvim_create_autocmd('CursorHold', {
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end,
})

-- LSP keybindings
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local bufmap = function(mode, lhs, rhs)
            vim.keymap.set(mode, lhs, rhs, { buffer = args.buf })
        end
        bufmap('n', 'gd', vim.lsp.buf.definition)
        bufmap('n', 'gr', vim.lsp.buf.references)
        bufmap('n', 'K', vim.lsp.buf.hover)
        bufmap('n', '<leader>rn', vim.lsp.buf.rename)
        bufmap('n', '<leader>ca', vim.lsp.buf.code_action)
        bufmap('n', '<leader>F', vim.lsp.buf.format)
    end,
})

-- nvim-cmp setup
local cmp = require('cmp')
local luasnip = require('luasnip')

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
        ['<Esc>'] = cmp.mapping.abort(),
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

-- Colorscheme
vim.cmd('colorscheme nord')
