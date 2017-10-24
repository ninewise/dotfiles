
# Get ourselves a nice prompt
ks() { s="$?" ; $* ; return "$s" ; }
prompt_gbranch() { git branch | sed -n 's/^\* (*\(.* \)*\([^ )]*\))*$/\2/p' ; }
prompt_gbehind() { git status --branch --porcelain=2 | sed -n 's/^# branch\.ab.*-\([^0].*\)$/⇃\1/p' ; }
prompt_gbefore() { git status --branch --porcelain=2 | sed -n 's/^# branch\.ab +\([^0].*\) .*$/↿\1/p' ; }
prompt_gstatus() { git status --porcelain | sed 's/\(..\).*/\1/' | cat <(echo OK) -  | tail -1 ; }
prompt_git() {
    if git status 2>/dev/null 1>&2; then
        echo " ($(prompt_gbranch)$(prompt_gbehind)$(prompt_gbefore)|$(prompt_gstatus))"
    fi
}
prompt_pwd() {
    pwd | sed -e "s_${HOME}_~_" -e 's_\(/*\.*.\)[^/]*/_\1/_g'
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
_comp_git() {
    local IFS=$'\n'
    # $1 is the name of the command whose arguments are being completed
    # $2 is the word being completed
    # $3 is the word preceding the word being completed

    # branch names
    COMPREPLY=( $(git branch -a --format "%(refname:short)" | grep "^$2") )

    # remotes
    COMPREPLY+=( $(git remote | grep "^$2") )

    # files
    COMPREPLY+=( $(git ls-files -co --exclude-standard "$2*" | sed "s?\($2[^/]*\).*?\1?") )

    # subcommands
    if [ "$3" = "git" ]; then
        COMPREPLY+=( $({ compgen -c "git-"; command ls /usr/libexec/git-core; } | sed -n 's/^git-//p' | grep "^$2") )
    fi
}

complete -c man
complete -cf sudo
complete -cf exec
complete -cf run
complete -o filenames -F _comp_git git

# history
export HISTCONTROL=ignorespace:erasedups

# Color ls
alias ls="exa -aF"

# No need for less history and more
alias less="LESSHISTFILE=- less"
alias more="less"

# There is only one vim
alias vim="nvim"
alias vi="nvim"
alias nano="nvim"

# Ready for ssh'ing
alias agent='eval "$(ssh-agent)" && ssh-add'
alias unlock='gpg-connect-agent <<<bye'

alias stop-after-this-song="mpc single && mpc idle && mpc single"

alias morning="maintain && gitfetcher"

go() {
    dir="$(lr /home /data /etc -L -t '(name ~~ ".*" && prune || print) && type = d && !(name = ".git")' \
          | fzf --height 10 \
          )"
    [ -n "$dir" ] && cd "$dir" || false
}

run() {
    exec "$@" > /dev/null 2>&1 &
}

