
# Lines configured by zsh-newuser-install
HISTFILE=~/.local/share/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/felix/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Get ourselves a nice prompt.
git_status() {
    if git status 2>/dev/null 1>&2; then
        git branch | grep \*
        git status --porcelain | cat <(echo OK) - | sed 's/\(..\).*/(\1)/' | tail -1
    fi
}
autoload -U colors && colors
PS1="[%*] %{$fg[red]%}%n@%m%{$reset_color%} %{$fg[green]%}%~%{$reset_color%} "'$(git_status | xargs echo)'"
 %(?.$.%%) "; setopt promptsubst

# Loading fizsh
source "$HOME/.config/zsh/zsh-history-substring-search.zsh"
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
setopt HIST_FIND_NO_DUPS

# XDG dirs
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_RUNTIME_DIR="/tmp/runtime-noctua"
mkdir -p "/tmp/runtime-noctua"
chmod 0700 /tmp/runtime-noctua

# Color ls
alias ls="ls --color=auto"

# Local scripts
export PATH="$HOME/.local/bin":"$PATH"
export PATH="$HOME/.cabal/bin":"$PATH"
export PATH="$(ruby -rubygems -e "puts Gem.user_dir")/bin":"$PATH"
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"

# For vim
export EDITOR="nvim"
#stty -ixon # turn of <C-s> for vimshell
alias vim="nvim"
alias vi="nvim"
alias nano="nvim"

# Don't type that config location al the time.
alias ncmpcpp="ncmpcpp -c ~/.config/ncmpcpp/config"
alias mbsync="mbsync -c ~/.config/mbsync/config"

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-greenscreen.dark.sh"

BASE16_SHELL="$HOME/.config/base16-shell/base16-3024.dark.sh"
BASE16_SHELL="$HOME/.config/base16-shell/base16-solarized.dark.sh"
BASE16_SHELL="$HOME/.config/base16-shell/base16-shapeshifter.dark.sh"
BASE16_SHELL="$HOME/.config/base16-shell/base16-railscasts.dark.sh"
BASE16_SHELL="$HOME/.config/base16-shell/base16-monokai.dark.sh"
BASE16_SHELL="$HOME/.config/base16-shell/base16-marrakesh.dark.sh"
BASE16_SHELL="$HOME/.config/base16-shell/base16-harmonic16.dark.sh"
BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
BASE16_SHELL="$HOME/.config/base16-shell/base16-colors.dark.sh"
BASE16_SHELL="$HOME/.config/base16-shell/base16-chalk.dark.sh"
BASE16_SHELL="$HOME/.config/base16-shell/base16-atelierseaside.dark.sh"
BASE16_SHELL="$HOME/.config/base16-shell/base16-atelierlakeside.dark.sh"
BASE16_SHELL="$HOME/.config/base16-shell/base16-atelierforest.dark.sh"
BASE16_SHELL="$HOME/.config/base16-shell/base16-atelierdune.dark.sh"
BASE16_SHELL="$HOME/.config/base16-shell/base16-brewer.dark.sh"
# Also modify: https://github.com/chriskempson/base16-xresources

[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

