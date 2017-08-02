
# Get ourselves a nice prompt
ks() { s="$?" ; $* ; return "$s" ; }
prompt_gbranch() { git branch | sed -n 's/^\* (*\(.* \)*\([^ )]*\))*$/\2/p' ; }
prompt_gbehind() { git rev-list --left-only  --count @{upstream}...HEAD | sed -n 's/[^0].*/⇃&/p' ; }
prompt_gbefore() { git rev-list --right-only --count @{upstream}...HEAD | sed -n 's/[^0].*/↿&/p' ; }
prompt_gstatus() { git status --porcelain | sed 's/\(..\).*/\1/' | cat <(echo OK) -  | tail -1 ; }
prompt_git() {
    if git status 2>/dev/null 1>&2; then
        echo " ($(prompt_gbranch)$(prompt_gbehind)$(prompt_gbefore) $(prompt_gstatus))"
    fi
}
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
PS1="$BOLD[\T]$RESET $GREEN\$(ks prompt_pwd)$RESET\$(ks prompt_git)\$(prompt_status) "
unset BOLD
unset GREEN
unset RESET

# Completion
complete -c man
complete -cf sudo

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

