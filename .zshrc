export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.zsh
export VIM_HOME=$HOME/.vim
export TMUX_HOME=$HOME/.tmux

function safe_source() {
    echo eval " \
    if [ -r $1 ]; then \
        source $1; \
    else \
        logger -t $0 -p crit \"unable to source $1\";\
        exit 1;
    fi \
"; }

function setup_tuckers_terminal {
  echo "Setting up zsh and vim..."

  # Install oh-my-zsh and plugins
  echo "getting omz and zsh-syntax-highlighting"
  git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git $ZSH
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
  git clone https://github.com/dracula/zsh-syntax-highlighting.git $ZSH_CUSTOM/themes/dracula-zsh-syntax-highlighting

  echo "getting p10k"
  git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
  git clone https://github.com/dracula/powerlevel10k.git $ZSH_CUSTOM/themes/dracula-powerlevel10k
  cp $ZSH_CUSTOM/themes/dracula-powerlevel10k/files/.p10k.zsh ~/.p10k.zsh

  # Install vimplug and vim plugins
  echo "getting plug.vim and installing vimplugs"
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  ln -sf ~/.vim/autoload/plug.vim ~/.local/share/nvim/site/autoload/plug.vim
  vim +PlugInstall +qall

  # Install tmux plugin stuff
  echo "getting tmux tpm"
  git clone https://github.com/tmux-plugins/tpm $TMUX_HOME/plugins/tpm
  #git clone https://github.com/powerline/powerline $TMUX_HOME/powerline

  echo "Finished setup"
}

if [ ! -d $ZSH ]; then
  setup_tuckers_terminal
fi

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


ZSH_THEME="powerlevel10k"

`safe_source $ZSH_CUSTOM/themes/dracula-zsh-syntax-highlighting/zsh-syntax-highlighting.sh`

plugins=(colored-man-pages git history history-substring-search common-aliases zsh-syntax-highlighting)

# User configuration

autoload -Uz compinit
compinit

autoload bashcompinit
bashcompinit

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

export PATH=$PATH:~/bin:$GOPATH/bin

`safe_source ~/.zsh/functions`

alias old-vim=/usr/bin/vim
alias old-vi=/usr/bin/vim
alias vim=nvim
alias vi=nvim

if [[ -n $TMUX ]]; then
    PROMPT_COMMAND='eval "$(/nail/scripts/tmux-env)"; '"$PROMPT_COMMAND"
fi

alias zshrc='vim ~/.zshrc'
alias tmuxconf='vim ~/.tmux.conf'

# because i fucking suck at typing
alias celar='clear'
alias claer='clear'
alias clea='clear'

# git aliases
alias gitgraph='git log --graph --pretty=oneline --abbrev-commit '

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

DEFAULT_USER=tucker

source $ZSH_CUSTOM/themes/powerlevel10k/powerlevel10k.zsh-theme

# dracula fzf
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
