if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

system_type=$(uname -s)
if [[ $(uname -r) =~ [Mm]icrosoft ]]; then
  system_type="WSL"
fi

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

if [[ "$system_type" = "Darwin" ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
fi

export LANG=en_US.UTF-8
export EDITOR='nvim'
export DEFAULT_USER=tucker

export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.zsh
export VIM_HOME=$HOME/.vim
export TMUX_HOME=$HOME/.tmux

if [[ -o login ]] && [[ -o interactive ]]; then
  neofetch
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
  "$ZSH_CUSTOM/themes/dracula-zsh-syntax-highlighting/zsh-syntax-highlighting.sh"
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

autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

autoload bashcompinit
bashcompinit

alias vim=nvim
alias vi=nvim
alias vimdiff='nvim -d'

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

# git aliases
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

if [ -n "$SSH_AUTH_SOCK" ] && [ "$SSH_AUTH_SOCK" != "$HOME/.ssh/ssh_auth_sock" ]; then
    ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh/ssh_auth_sock"
    export SSH_AUTH_SOCK="$HOME/.ssh/ssh_auth_sock"
fi

if command -v aactivator >/dev/null; then
  eval "$(aactivator init)"
fi

[[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"
