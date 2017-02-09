#!/bin/sh

# XDG dirs
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_RUNTIME_DIR="/tmp/runtime-$(whoami)"
mkdir -p "$XDG_RUNTIME_DIR"
chmod 0700 "$XDG_RUNTIME_DIR"

# Local scripts
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export CABAL_HOME="$HOME/.cabal"
export CARGO_HOME="$HOME/.cargo"
export PATH="$HOME/.local/bin:$CABAL_HOME/bin:$GEM_HOME/bin:$CARGO_HOME/bin:$PATH"

# For vim
export EDITOR="nvim"
#stty -ixon # turn of <C-s> for vimshell

# Start X if we're in tty1
xsession() {
    startx 2>&1 || vlock
    sudo poweroff
    sleep infinity
}
if tty | grep -q '/dev/tty1'; then xsession; fi
