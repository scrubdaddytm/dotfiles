#!/bin/sh

echo "[venv-setup] Starting virtualenv setup..."

VENVS="$HOME/.venvs"
mkdir -p "$VENVS"
echo "[venv-setup] Venvs directory: $VENVS"

# Detect Python 3 automatically
if command -v python3 >/dev/null 2>&1; then
    PYTHON_BIN="python3"
    echo "[venv-setup] Found Python: $PYTHON_BIN"
else
    echo "[venv-setup] Error: python3 not found"
    exit 1
fi

make_virtualenv()
{
    venv_name=$1; shift
    venv_dir="$VENVS/$venv_name"

    if [ -d "$venv_dir" ]; then
        echo "[venv-setup] Virtualenv $venv_dir already exists, skipping..."
        return
    fi

    echo "[venv-setup] Creating virtualenv at $venv_dir..."
    "$PYTHON_BIN" -m venv "$venv_dir"

    # shellcheck source=/dev/null
    . "$venv_dir/bin/activate"
    echo "[venv-setup] Installing packages: $*"
    pip install "$@"
    echo "[venv-setup] Installation complete!"
}

make_virtualenv neovim-python3 pynvim jedi black mypy flake8 pyright isort

echo "[venv-setup] Done!"
