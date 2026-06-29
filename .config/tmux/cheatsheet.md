# Tmux Cheatsheet

Prefix: **C-a** (Ctrl+a)

## Core

| Key | Action |
|---|---|
| `C-a R` | Reload config |
| `C-a c` | New window (inherits current path) |
| `C-a d` | Detach session |

## Windows (tmux-pain-control)

| Key | Action |
|---|---|
| `C-a \|` | Split vertical |
| `C-a -` | Split horizontal |
| `C-a <` | Move window left |
| `C-a >` | Move window right |
| `C-a n` / `C-a p` | Next / previous window |
| `C-a 1-9` | Go to window N (base index 1) |

## Panes (pain-control + vim-tmux-navigator)

| Key | Action |
|---|---|
| `C-h/j/k/l` | Navigate panes (no prefix, works in vim too) |
| `C-a H/J/K/L` | Resize pane in direction |
| `C-a x` | Kill pane |
| `C-a z` | Zoom/unzoom pane |
| `C-a !` | Break pane into own window |
| `C-a {` | Move pane left |
| `C-a }` | Move pane right |

## Sessions (tmux-sessionist)

| Key | Action |
|---|---|
| `C-a g` | Switch to session (prompted) |
| `C-a C` | Create new session (prompted) |
| `C-a X` | Kill current session |
| `C-a S` | Switch to last session |
| `C-a @` | Promote pane to session |
| `C-a t` | Join pane from another session |

## Copy Mode (vi keys)

| Key | Action |
|---|---|
| `C-a [` | Enter copy mode |
| `v` | Begin selection |
| `y` | Yank selection (tmux-yank, copies to system clipboard) |
| `q` | Exit copy mode |
| `/` | Search forward |
| `?` | Search backward |

## Plugins

| Key / Command | Plugin | Action |
|---|---|---|
| `C-a C-f` | tmux-fingers | Highlight & copy visible text hints |
| `C-a Tab` | extrakto | Fuzzy-find text from pane (paths, urls, words) |
| `C-a F` | tmux-fzf | Fuzzy finder for sessions/windows/panes/commands |
| `C-a o` | tmux-open | Open highlighted selection |
| `C-a S-o` | tmux-open | Open highlighted selection in $EDITOR |
| `C-a m` | tmux-notify | Monitor pane for activity |
| `C-a M` | tmux-notify | Cancel monitor |
| `C-a P` | tmux-logging | Toggle pane logging to file |
| `C-a M-p` | tmux-logging | Save visible pane contents |
| `C-a M-P` | tmux-logging | Save complete pane history |
| `C-a *` | tmux-cowboy | Force-kill unresponsive process in pane |

## Resurrect / Continuum

| Key | Action |
|---|---|
| `C-a C-s` | Save session (also auto-saves every 15 min) |
| `C-a C-r` | Restore session |

Sessions auto-restore on tmux start. Nvim sessions are restored via `:SLoad`.

## Extrakto Settings

- Grab area: full pane history
- Filter order: path > url > word > line > all

## Mouse

Mouse is enabled: click panes, resize by dragging borders, scroll to enter copy mode.
