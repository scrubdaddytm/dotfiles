export PATH="$HOME/bin:$PATH"
neofetch

export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.zsh
export VIM_HOME=$HOME/.vim
export TMUX_HOME=$HOME/.tmux
system_type=$(uname -s)

if [[ ! -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
fi
if [[ ! -d "${ZSH_CUSTOM}/themes/powerlevel10k" ]]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k
  git clone https://github.com/dracula/powerlevel10k.git $ZSH_CUSTOM/themes/dracula-powerlevel10k
  cp $ZSH_CUSTOM/themes/dracula-powerlevel10k/files/.p10k.zsh ~/.p10k.zsh
fi

plugins=(
  git
  pip
  history
  common-aliases
  colored-man-pages
  history-substring-search
  zsh-syntax-highlighting
)

files_to_source=(
  "$ZSH/oh-my-zsh.sh"
  "$ZSH_CUSTOM/themes/dracula-zsh-syntax-highlighting/zsh-syntax-highlighting.sh"
  "$HOME/.yelp-zsh-config"
  "$ZSH_CUSTOM/functions"
  "$ZSH_CUSTOM/yelp-functions" 
  "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  "$ZSH_CUSTOM/themes/powerlevel10k/powerlevel10k.zsh-theme"
)

for file in "${files_to_source[@]}"; do
  if [[ -r $file ]]; then
    source $file
  fi
done

autoload -Uz compinit
compinit

autoload bashcompinit
bashcompinit

export LANG=en_US.UTF-8

export EDITOR='nvim'

alias vim=nvim
alias vi=nvim
alias vimdiff='nvim -d'

if [[ -n $TMUX ]]; then
  PROMPT_COMMAND='eval "$(/nail/scripts/tmux-env)"; '"$PROMPT_COMMAND"
fi

alias l='exa --group-directories-first --icons'
alias la='l -a'
alias lt='l -T'
alias lta='l -Ta'
alias lg='l --git --git-ignore'
alias lga='lg -a'
alias lgt='lg -T'
alias lgta='lg -Ta'

alias ll='exa -l --group-directories-first --icons'
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

DEFAULT_USER=tucker

# dracula fzf
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

if [[ "$system_type" = "Darwin" ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

if [[ -f "aactivator" ]]; then
  eval "$(aactivator init)"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh
