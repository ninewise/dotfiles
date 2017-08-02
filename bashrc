
# Get ourselves a nice prompt
ks() { s="$?" ; $* ; return "$s" ; }
prompt_pwd() {
    pwd | sed -e "s_${HOME}_~_" -e 's_\(/*.\)[^/]*/_\1/_g'
}
prompt_status() {
    if [ "$?" = "0" ]
    then echo " $"
    else echo " %"
    fi
}
BOLD="\[$(tput bold)\]"
GREEN="\[$(tput setaf 2)\]"
RESET="\[$(tput sgr0)\]"
source /usr/share/git/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto verbose"
PROMPT_COMMAND="__git_ps1 \"$BOLD[\T]$RESET $GREEN\$(ks prompt_pwd)$RESET\" \"\$(prompt_status) \""
unset BOLD
unset GREEN
unset RESET

# Completion
complete -c man
complete -cf sudo
complete -cf exec

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

alias stop-after-this-song="mpc single && mpc idle && mpc single"

# FZF
go() {
    dir="$(lr /home /data /etc -L -t '(name ~~ ".*" && prune || print) && type = d && !(name = ".git")' \
          | fzf --height 10 \
          )"
    [ -n "$dir" ] && cd "$dir" || false
}

