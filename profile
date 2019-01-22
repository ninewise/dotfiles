#!/bin/sh

# XDG dirs
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_RUNTIME_DIR="/tmp/runtime-$(whoami)"
mkdir -p "$XDG_RUNTIME_DIR"
chmod 0700 "$XDG_RUNTIME_DIR"

# Local scripts
export CABAL_HOME="$HOME/.cabal"
export CARGO_HOME="$HOME/.cargo"
export RBENV_HOME="$HOME/.rbenv"
export PATH="$HOME/.local/bin:$CABAL_HOME/bin:$RBENV_HOME/shims:$CARGO_HOME/bin:$JAVA_HOME/bin:$PATH"

# Environmental settings
export EDITOR="vis"
export LEDGER_FILE="/data/documents/ledger.dat"
export LESSHISTFILE=-
export FZF_DEFAULT_COMMAND='(git ls-files -co --exclude-standard || rg --files) 2> /dev/null'

#stty -ixon # disable <C-s>

# Start X if we're in tty1
xsession() {
    startx 2>&1 || vlock
    #sudo poweroff
    #sleep infinity
}
if tty | grep -q '/dev/tty1'; then xsession; fi
