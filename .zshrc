export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.zsh
export VIM_HOME=$HOME/.vim
export TMUX_HOME=$HOME/.tmux

if [ ! -d $ZSH ]; then
    echo "Setting up zsh and vim..."

    # Install oh-my-zsh and plugins
    git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git $ZSH
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting

    # Install vimplug and vim plugins
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +PlugInstall +qall

    # Install tmux plugin stuff
    git clone https://github.com/tmux-plugins/tpm $TMUX_HOME/plugins/tpm

    echo "Finished setup"
fi

ZSH_THEME="agnoster-mod"

plugins=(colored-man-pages git history history-substring-search zsh-syntax-highlighting common-aliases)

# User configuration

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

export HOME_GIT=$HOME'/pg/homedirs/users/tucker'
export EDITOR='vim'
export TERRAFORM_HOME=$HOME'/pg/terraform/'
export VIM_DIST=$HOME'/pg/vim8/dist/trusty/usr/bin/vim8'

export PATH=$PATH:~/bin

function safe_source() {
    echo eval " \
    if [ -r $1 ]; then \
        source $1; \
    else \
        logger -t $0 -p crit \"unable to source $1\";\
        exit 1;
    fi \
"; }

# `safe_source ~/.zsh/functions`

if [ -d '$VIM_DIST' ]; then
    alias vim=$VIM_DIST' -p'
elif type vim8 >/dev/null 2>/dev/null; then
    alias vim='vim8 -p'
else
    alias vim='vim -p'
fi

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

DEFAULT_USER=tucker
