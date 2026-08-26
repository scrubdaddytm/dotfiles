if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

system_type=$(uname -s)
if [[ $(uname -r) =~ [Mm]icrosoft ]]; then
  system_type="WSL"
fi

typeset -U path
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.npm-prefix/bin:$PATH"
export PATH="$HOME/.yadm-project/:$PATH"



if [[ "$system_type" = "Darwin" ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
fi

export LANG=en_US.UTF-8
export EDITOR='nvim'
export DEFAULT_USER=tucker
export BROWSER="echo"

export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.zsh
export VIM_HOME=$HOME/.vim
export TMUX_HOME=$HOME/.tmux

if [[ -o login ]] && [[ -o interactive ]]; then
  neofetch &!
fi

plugins=(
  fzf
  git
  pip
  sudo
  python
  history
  pre-commit
  virtualenv
  common-aliases
  colored-man-pages
  zsh-syntax-highlighting
  history-substring-search
)

files_to_source=(
  "$ZSH/oh-my-zsh.sh"
  "$HOME/.yelp-zsh-config"
  "$ZSH_CUSTOM/functions"
  "$ZSH_CUSTOM/yelp-functions"
  "$ZSH_CUSTOM/themes/powerlevel10k/powerlevel10k.zsh-theme"
)

for file in "${files_to_source[@]}"; do
  if [[ -r "$file" ]]; then
    source "$file"
  fi
done

autoload bashcompinit
bashcompinit

alias vim=nvim
alias vi=nvim
alias vimdiff='nvim -d'
alias nvimdiff='nvim -d'

command -v eza >/dev/null || alias eza='exa'

alias l='eza --group-directories-first --icons'
alias la='l -a'
alias lt='l -T'
alias lta='l -Ta'
alias lg='l --git --git-ignore'
alias lga='lg -a'
alias lgt='lg -T'
alias lgta='lg -Ta'

alias ll='eza -l --group-directories-first --icons'
alias lla='ll -a'
alias llt='ll -T'
alias llta='ll -Ta'
alias llg='ll --git --git-ignore'
alias llga='llg -a'
alias llgt='llg -T'
alias llgta='llg -Ta'

alias lgg='llga --no-permissions --no-filesize --no-user'
alias lggt='lgg -T'

alias g=git
alias gitgraph='g log --graph --pretty=oneline --abbrev-commit '
alias gs='g status'
alias gpoh='g push origin HEAD'

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

if [[ "$system_type" = "Darwin" ]]; then
  eval "$(pyenv init -)"
elif [[ "$system_type" = "WSL" ]]; then
  eval "$(keychain --eval --agents ssh id_ed25519)"
fi

# --- SSH agent socket resolution ---
# 1. Forwarded-agent case (remote host): ~/.ssh/rc maintains a stable per-user
#    socket so tmux sessions survive autossh reconnects. Prefer it if present.
# 2. Local case (macOS): login shells inherit the launchd agent's socket, whose
#    path changes every boot. Pin it to a stable symlink so tmux panes (which read
#    ~/.ssh/ssh_auth_sock, set in tmux.conf) keep resolving to the live agent.
if [[ -S "$HOME/.agent-sshtmux-$USER.sock" ]]; then
  export SSH_AUTH_SOCK="$HOME/.agent-sshtmux-$USER.sock"
elif [[ -S "$SSH_AUTH_SOCK" && "$SSH_AUTH_SOCK" != "$HOME/.ssh/ssh_auth_sock" ]]; then
  ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh/ssh_auth_sock"
  export SSH_AUTH_SOCK="$HOME/.ssh/ssh_auth_sock"
elif [[ -S "$HOME/.ssh/ssh_auth_sock" ]]; then
  export SSH_AUTH_SOCK="$HOME/.ssh/ssh_auth_sock"
fi

# On macOS, load keys (and their Keychain-stored passphrases) into the agent if
# it's empty — so a fresh terminal after reboot works without re-entering them.
if [[ "$system_type" = "Darwin" ]]; then
  ssh-add -l &>/dev/null || ssh-add --apple-load-keychain 2>/dev/null
fi

if command -v aactivator >/dev/null; then
  eval "$(aactivator init)"
fi

[[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"
