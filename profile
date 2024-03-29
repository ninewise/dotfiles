#!/bin/sh

# XDG dirs
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_RUNTIME_DIR="/tmp/runtime-$(whoami)"
mkdir -p "$XDG_RUNTIME_DIR"
chmod 0700 "$XDG_RUNTIME_DIR"
export XDG_DOWNLOAD_DIR="/tmp"

# Local scripts
export CABAL_HOME="/data/homes/cabal"
export STACK_ROOT="/data/homes/stack"
export CARGO_HOME="/data/homes/cargo"
export RUSTUP_HOME="/data/homes/rustup"
export JAVA_HOME="/usr/lib/jvm/openjdk11/"
export TEX_BIN="/opt/texlive/2019/bin/x86_64-linux/"
export PATH="$HOME/.local/bin:$CABAL_HOME/bin:$CARGO_HOME/bin:$JAVA_HOME/bin:$TEX_BIN:$PATH"

# Environmental settings
export ESCDELAY=50 # for dvtm e.a.
export EDITOR="vis"
export LEDGER_FILE="/data/documents/ledger/all.journal"
export LESSHISTFILE=-
export FZF_DEFAULT_COMMAND='(git ls-files -co --exclude-standard || rg --files) 2> /dev/null'
export SKIM_DEFAULT_COMMAND='(git ls-files -co --exclude-standard || rg --files) 2> /dev/null'
export LC_ALL=en_US.utf8
export BOGOFILTER_DIR="$XDG_DATA_HOME/bogofilter"
export TERMINAL=st

# Clean spotify cachedir
if [ -d "$HOME/.cache/ncspot/librespot/files" ]; then
	rm -r "$HOME/.cache/ncspot/librespot/files"
fi

#stty -ixon # disable <C-s>
