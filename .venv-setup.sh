mkdir -p ~/venvs

mkdir -p ~/venvs/neovim && virtualenv ~/venvs/neovim && . ~/venvs/neovim/bin/activate && pip install pynvim jedi
mkdir -p ~/venvs/neovim-py3 && virtualenv ~/venvs/neovim-py3 -p python3.8 && . ~/venvs/neovim-py3/bin/activate && pip install pynvim jedi
mkdir -p ~/venvs/jedi && virtualenv ~/venvs/jedi -p python3.8 && . ~/venvs/jedi/bin/activate && pip install jedi
mkdir -p ~/venvs/black && virtualenv ~/venvs/black -p python3.8 && . ~/venvs/black/bin/activate && pip install black

mkdir -p ~/venvs/neovim-py311 && virtualenv ~/venvs/neovim-py311 -p python3.11 && . ~/venvs/neovim-py3/bin/activate && pip install pynvim jedi
mkdir -p ~/venvs/jedi311 && virtualenv ~/venvs/jedi311 -p python3.11 && . ~/venvs/jedi/bin/activate && pip install jedi
mkdir -p ~/venvs/black311 && virtualenv ~/venvs/black311 -p python3.11 && . ~/venvs/black/bin/activate && pip install black
