export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.zsh
export VIM_HOME=$HOME/.vim
export TMUX_HOME=$HOME/.tmux

if [ ! -d $ZSH ]; then
    echo "Setting up zsh and vim..."

    # Install oh-my-zsh and plugins
    git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git $ZSH
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

    # Install vimplug and vim plugins
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ln -sf ~/.vim/autoload/plug.vim ~/.local/share/nvim/site/autoload/plug.vim
    vim +PlugInstall +qall

    # Install tmux plugin stuff
    git clone https://github.com/tmux-plugins/tpm $TMUX_HOME/plugins/tpm
    #git clone https://github.com/powerline/powerline $TMUX_HOME/powerline

    echo "Finished setup"
fi

ZSH_THEME="agnoster-mod"

plugins=(colored-man-pages git history history-substring-search common-aliases zsh-syntax-highlighting)

# User configuration

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

export HOME_GIT=$HOME'/pg/homedirs/users/tucker'
export EDITOR='vim'
export DEV_HOST='comproddev1-uswest1adevc'
export TERRAFORM_HOME=$HOME'/pg/terraform/'
export GOPATH=$HOME'/pg/github'

export PATH=$PATH:~/bin:$GOPATH/bin

function safe_source() {
    echo eval " \
    if [ -r $1 ]; then \
        source $1; \
    else \
        logger -t $0 -p crit \"unable to source $1\";\
        exit 1;
    fi \
"; }

`safe_source ~/.zsh/functions`

alias old-vim=/usr/bin/vim
alias old-vi=/usr/bin/vim
alias vim=nvim
alias vi=nvim

if [[ -n $TMUX ]]; then
    PROMPT_COMMAND='eval "$(/nail/scripts/tmux-env)"; '"$PROMPT_COMMAND"
fi

if [[ $HOME == "/nail/home/tucker" ]]; then
    alias tmux='agenttmux2'
    alias tmux2='agenttmux2'
fi

alias zshrc='vim ~/.zshrc'
alias tmuxconf='vim ~/.tmux.conf'

# because i fucking suck at typing
alias celar='clear'
alias claer='clear'
alias clea='clear'

# git aliases
alias gitgraph='git log --graph --pretty=oneline --abbrev-commit '
alias gp='git push '
alias gs='git status '

alias dev='ssh -A $DEV_HOST'
alias ym='cd ~/pg/yelp-main'

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

DEFAULT_USER=tucker
