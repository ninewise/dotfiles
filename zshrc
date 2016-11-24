
# Lines configured by zsh-newuser-install
HISTFILE=~/.local/share/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/noctua/.zshrc'

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

# Color ls
alias ls="lr -1FAG"

# No need for less history and more
alias less="LESSHISTFILE=- less"
alias more="less"

# There is only one vim
alias vim="nvim"
alias vi="nvim"
alias nano="nvim"

# Ready for ssh'ing
alias agent='eval "$(ssh-agent)" && ssh-add'

# Cloning my terminal
alias copy='urxvtc'

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

