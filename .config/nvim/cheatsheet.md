# Neovim Cheatsheet

Leader key: `,`

## Keybindings

### General

| Key | Mode | Action |
|-----|------|--------|
| `jk` | Insert | Escape to normal mode |
| `<space>` | Normal | Select inner word (`viw`) |
| `,W` | Any | Sudo write |
| `<F2>` | Normal | Toggle paste mode |
| `<F5>` | Any | Save and run current file in ipython |
| `,rws` | Normal | Remove trailing whitespace |

### Navigation & Search

| Key | Mode | Action |
|-----|------|--------|
| `,f` | Normal | Fuzzy file search (FZF) |
| `//` | Visual | Search for selected text |
| `Ctrl+h/j/k/l` | Normal | Navigate between tmux/vim splits |

### File Explorer (nvim-tree)

| Key | Mode | Action |
|-----|------|--------|
| `<F7>` | Normal | Toggle file tree |

### Code Outline (aerial)

| Key | Mode | Action |
|-----|------|--------|
| `<F8>` | Normal | Toggle code outline |
| `{` | Normal | Previous symbol (when outline open) |
| `}` | Normal | Next symbol (when outline open) |

### LSP

| Key | Mode | Action |
|-----|------|--------|
| `gd` | Normal | Go to definition |
| `gr` | Normal | Find references |
| `K` | Normal | Hover documentation |
| `,rn` | Normal | Rename symbol |
| `,ca` | Normal | Code action |
| `,F` | Normal | Format file (black + isort via null-ls) |

### Git

| Key | Mode | Action |
|-----|------|--------|
| `,s` | Normal | Show git blame for current line |

### Autocomplete (nvim-cmp)

| Key | Mode | Action |
|-----|------|--------|
| `<Tab>` | Insert | Next completion item / expand snippet |
| `<S-Tab>` | Insert | Previous completion item |
| `<CR>` | Insert | Confirm selection |
| `<Esc>` | Insert | Abort completion |
| `<C-Space>` | Insert | Trigger completion |
| `<C-b>` / `<C-f>` | Insert | Scroll docs up/down |
| `<C-e>` | Insert | Abort completion |

### Visual Mode

| Key | Mode | Action |
|-----|------|--------|
| `,p` | Visual | Pipe selection to `fpb` (paste buffer) |

### Surround (vim-surround)

| Key | Action |
|-----|--------|
| `cs"'` | Change surrounding `"` to `'` |
| `ds"` | Delete surrounding `"` |
| `ysiw]` | Surround word with `[]` |
| `S"` (visual) | Surround selection with `"` |

### Commentary (vim-commentary)

| Key | Action |
|-----|--------|
| `gcc` | Toggle comment on line |
| `gc` (visual) | Toggle comment on selection |

### Fugitive (vim-fugitive)

| Command | Action |
|---------|--------|
| `:Git` | Open git status |
| `:Git blame` | Inline blame |
| `:Git diff` | Show diff |
| `:Gread` | Checkout file (revert to HEAD) |

### Visual Multi (vim-visual-multi)

| Key | Action |
|-----|--------|
| `Ctrl+n` | Select word under cursor / next occurrence |
| `Ctrl+Down/Up` | Add cursor below/above |
| `n` / `N` | Next / previous occurrence (in VM mode) |
| `q` | Skip current and go to next |

## Abbreviations

| Abbreviation | Expands To |
|-------------|------------|
| `istrace` | `import ipdb; ipdb.set_trace()` |
| `strace` | `ipdb.set_trace()` |

## Plugins

| Plugin | Purpose |
|--------|---------|
| **fzf / fzf.vim** | Fuzzy file finder |
| **nvim-tree** | File explorer sidebar |
| **nvim-treesitter** | Syntax highlighting & indentation (python, lua, vim, vimdoc) |
| **aerial.nvim** | Code outline / symbol browser |
| **markview.nvim** | Markdown preview/rendering |
| **vim-gitgutter** | Git diff signs in the gutter |
| **git-blame.vim** | Git blame echo (`,s`) |
| **vim-fugitive** | Git commands inside nvim |
| **committia.vim** | Better commit message editing |
| **vim-tmux-navigator** | Seamless tmux/nvim split navigation |
| **vim-visual-multi** | Multiple cursors |
| **vim-commentary** | Toggle comments |
| **vim-repeat** | Repeat plugin commands with `.` |
| **vim-sleuth** | Auto-detect indent settings |
| **vim-surround** | Add/change/delete surroundings |
| **vim-obsession** | Session management (`:Obsession`) |
| **undotree** | Visual undo history (`:UndotreeToggle`) |
| **which-key.nvim** | Shows available keybindings as you type |
| **airline** | Status line (with powerline fonts, shortened paths) |
| **nvim-cmp** | Autocompletion (LSP, buffer, path, snippets) |
| **LuaSnip** | Snippet engine |
| **nvim-lspconfig** | LSP client configuration |
| **mason.nvim** | LSP/tool installer (pyright, lua_ls) |
| **none-ls.nvim** | Formatting via black (line-length 131) and isort |
| **nvim-web-devicons** | File icons |
| **nord-vim** | Color scheme |

## LSP Servers

| Server | Language |
|--------|----------|
| pyright | Python |
| lua_ls | Lua |

## Settings

- **Indentation**: 4 spaces (2 for yaml/lua)
- **Clipboard**: System clipboard (`unnamedplus`)
- **Search**: Case-insensitive unless uppercase used (smartcase)
- **Splits**: Open below and to the right
- **Undo**: Persistent undo files in `~/.vim/undo`
- **No swap/backup files**
- **Diagnostics**: Float on cursor hold (300ms)
- **Whitespace**: Visible tabs, trailing spaces, nbsp

## Plugin Management (vim-plug)

| Command | Action |
|---------|--------|
| `:PlugInstall` | Install plugins |
| `:PlugUpdate` | Update plugins |
| `:PlugClean` | Remove unused plugins |
| `:PlugStatus` | Check plugin status |
