shout() { echo "$0: $*" >&2; }
die() { shout "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }

# compiler stuff
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"

eval "$(pyenv init -)"

. `dirname $0`/.aliasrc

bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word

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
