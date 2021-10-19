shout() { echo "$0: $*" >&2; }
die() { shout "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }

rc=`dirname $0`
scripts="$rc/.."
scripts=$scripts:A


# pipenv config
export PIPENV_VENV_IN_PROJECT=true
export POETRY_VIRTUALENVS_IN_PROJECT="true"

# compiler stuff
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"

[[ $- = *i* ]] && source ~/.liquidprompt/liquidprompt

# openblas environment variables
export LDFLAGS="$LDFLAGS -L/usr/local/opt/openblas/lib"
export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/openblas/include"
export PKG_CONFIG_PATH="/usr/local/opt/openblas/lib/pkgconfig:$PKG_CONFIG_PATH"

export LDFLAGS="$LDFLAGS -L/usr/local/opt/lapack/lib"
export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/lapack/include"
export PKG_CONFIG_PATH="/usr/local/opt/lapack/lib/pkgconfig:$PKG_CONFIG_PATH"


# lapack environment variables
export LDFLAGS="$LDFLAGS -L/usr/local/opt/lapack/lib"
export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/lapack/include"
export PKG_CONFIG_PATH="/usr/local/opt/lapack/lib/pkgconfig:$PKG_CONFIG_PATH"

export EDITOR="code --wait --new-window"

. $rc/.aliasrc

bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word


if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
  autoload -U +X bashcompinit && bashcompinit
  autoload -U +X compinit && compinit
fi

# Add coreutils to path
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# Created by `pipx` on 2021-03-25 17:57:03
export PATH="$PATH:$HOME/.local/bin"
eval "$(register-python-argcomplete pipx)" || echo "Try brew install pipx"
# Poetry
if ! [ -f "$HOME/.poetry/bin/poetry" ]
then
    printf "Install poetry:\nhttps://python-poetry.org/docs/#osx-linux-bashonwindows-install-instructions"
fi

export PATH="$HOME/.poetry/bin:$PATH"

# liquid prompt
if [ -f /usr/local/share/liquidprompt ]; then
    . /usr/local/share/liquidprompt
else
    echo "liquidprompt not installed -- brew install liquidprompt"
fi

export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export LDFLAGS="-L/usr/local/opt/zlib/lib -L/usr/local/opt/bzip2/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/bzip2/include"

# eval "$($HOME/.pyenv/bin/pyenv init --path)"
export PY_PYTHON=$(pyenv exec python -c "import sys; print('.'.join(map(str, sys.version_info[:2])))")
# for the py launcher

# Add starship
eval "$(starship init zsh)"