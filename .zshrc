export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.zsh
export VIM_HOME=$HOME/.vim
export TMUX_HOME=$HOME/.tmux

ZSH_THEME="powerlevel10k"

plugins=(
  git
  pip
  history
  common-aliases
  colored-man-pages
  zsh-syntax-highlighting
  history-substring-search
)

files_to_source=(
  "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  "$ZSH_CUSTOM/themes/dracula-zsh-syntax-highlighting/zsh-syntax-highlighting.sh"
  "$ZSH/oh-my-zsh.sh"
  "$HOME/.yelp-zsh-config"
  "$ZSH_CUSTOM/functions"
  "$ZSH_CUSTOM/yelp-functions" 
  "$ZSH_CUSTOM/themes/powerlevel10k/powerlevel10k.zsh-theme"
)

for file in "${files_to_source[@]}"; do
  if [[ -r $file ]]; then
    source $file
  fi
done

# User configuration

autoload -Uz compinit
compinit

autoload bashcompinit
bashcompinit

export LANG=en_US.UTF-8

export EDITOR='nvim'

alias vim=nvim
alias vi=nvim

if [[ -n $TMUX ]]; then
  PROMPT_COMMAND='eval "$(/nail/scripts/tmux-env)"; '"$PROMPT_COMMAND"
fi

# git aliases
alias gitgraph='git log --graph --pretty=oneline --abbrev-commit '
alias gs='git status'

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

DEFAULT_USER=tucker

# dracula fzf
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

system_type=$(uname -s)

if [[ "$system_type" = "Darwin" ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

eval "$(aactivator init)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh
