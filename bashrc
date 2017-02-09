
# Get ourselves a nice prompt
keep_status() {
    s="$?"
    $*
    return "$s"
}
git_status() {
    if git status 2>/dev/null 1>&2; then
        echo "$(git branch | grep \*)" \
             "$(git status --porcelain | cat <(echo OK) - | sed 's/\(..\).*/(\1)/' | tail -1)"
    fi
}
exit_status() {
    if [ "$?" = "0" ]
    then echo "$"
    else echo "%"
    fi
}
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
RESET="$(tput sgr0)"
PS1="[\T] $RED\u@\h$RESET $GREEN\w$RESET \$(keep_status git_status)\n \$(exit_status) "
unset RED
unset GREEN
unset RESET

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

