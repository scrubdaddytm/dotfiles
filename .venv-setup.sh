#!/bin/sh

VENVS="$HOME/.venvs"

mkdir -p "$VENVS"

PY_VERSION=$1

if [ ! -f "/usr/bin/$PY_VERSION" ]; then
    echo "invalid python version provided"
    exit
fi

make_virtualenv()
{
    venv_name=$1; shift

    venv_dir="$VENVS/$venv_name-$PY_VERSION"
    mkdir -p "$venv_dir"
    virtualenv "$venv_dir"
    # shellcheck source=/dev/null
    . "$venv_dir/bin/activate"
    pip install "$@"
}

make_virtualenv neovim pynvim jedi black mypy flake8
