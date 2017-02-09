# vim: foldmethod=marker

# Lines configured by zsh-newuser-install {{{
HISTFILE=~/.cache/zhistfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# }}}
#
# The following lines were added by compinstall {{{
zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/noctua/.zshrc'
autoload -Uz compinit
compinit
# }}}

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
alias ls="lr -1FG"

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
alias terminal='st'
alias copy='terminal'

# FZF
function go() {
    dir="$(lr /home /data /etc -L -t '(name ~~ "\.*" && prune || print) && type = d && !(name = ".git")' | fzf)"
    [ -n "$dir" ] && cd "$dir" || false
}

