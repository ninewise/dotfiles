
# Get ourselves a nice prompt
ks() { s="$?" ; $* ; return "$s" ; }
prompt_git() {
    if git status 2>/dev/null 1>&2; then
        local branch="$(git branch | sed -n 's/^\* (*\(.* \)*\([^ )]*\))*$/\2/p')"
        local behind="$(git status --branch --porcelain=2 | sed -n 's/^# branch\.ab.*-\([^0].*\)$/⇃\1/p')"
        local before="$(git status --branch --porcelain=2 | sed -n 's/^# branch\.ab +\([^0].*\) .*$/↿\1/p')"
        local status="$(git status --porcelain | sed 's/\(..\).*/\1/' | cat <(echo OK) -  | tail -1)"
        
        echo " (${branch}${behind}${before}|${status})"
    fi
}
prompt_pwd() {
    pwd | sed -e "s_${HOME}_~_" -e 's_\(/*\.*.\)[^/]*/_\1/_g'
}
prompt_status() {
    if [ "$?" = "0" ]
    then echo "$"
    else echo "%"
    fi
}
BOLD="\001$(tput bold)\002"
GREEN="\001$(tput setaf 2)\002"
RESET="\001$(tput sgr0)\002"
PS1="$BOLD[\t]$RESET $GREEN\$(ks prompt_pwd)$RESET\$(ks prompt_git) \$(prompt_status) "
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
    COMPREPLY+=( $(git ls-files -coz --exclude-standard "$2*" | tr '\0' '\n' | sed "s?\($2[^/]*\).*?\1?") )

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
alias less="bat"
alias more="bat"

# There is only one vis
alias vim="vis"
alias vi="vis"
alias nano="vis"

# Ready for ssh'ing
alias agent='eval "$(ssh-agent)" && ssh-add'
alias unlock='gpg-connect-agent <<<bye'

alias stop-after-this-song="mpc single && mpc idle && mpc single"

alias morning="maintain && gitfetcher"

alias weechat="ssh -t weechat@Chatmachine abduco -A weechat"
alias bearchat="ssh -f -N -L localhost:9001:localhost:8001 weechat@Chatmachine"

go() {
    dir="$(lr /home /data /etc -t '(name ~~ ".*" && prune || print) && type = d && !(name = ".git")' \
          | fzf --height 10 \
          )"
    [ -n "$dir" ] && cd "$dir" || false
}

run() {
    exec "$@" > /dev/null 2>&1 &
}

terminfo() {
    infocmp -x | ssh $@ 'cat > $TERM.info && tic -x $TERM.info && rm $TERM.info'
}
