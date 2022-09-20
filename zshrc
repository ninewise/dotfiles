# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored
zstyle :compinstall filename '/home/ninewise/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install

setopt SH_WORD_SPLIT
unsetopt NOMATCH

# Get ourselves a nice prompt
ks() { s="$?" ; $* ; return "$s" ; }
prompt_git() {
    local porcelain branch behind ahead gstatus
    porcelain="$(git status --branch --porcelain 2>/dev/null)"
    if test "$?" = 0; then
        branch="$(printf '%s' "$porcelain" | sed -n 's/\.\.\..*//;1s/## //p')"
        if [ ${#branch} -gt 30 ]; then
            branch="$(printf '%.27s...' "$branch")"
        fi
        behind="$(printf '%s' "$porcelain" | sed -n '1s/## .*behind \([0-9]*\).*/-\1/p')"
        ahead="$(printf '%s' "$porcelain" | sed -n '1s/## .*ahead \([0-9]*\).*/+\1/p')"
        gstatus="$({ echo OK; printf '%s' "$porcelain" | sed '/##/d;s/\(..\).*/\1/'; } | tail -1)"
        
        echo " (${branch}${behind}${ahead}|${gstatus})"
    fi
}
prompt_pwd() {
    pwd | sed -e "s_${HOME}_~_" -e 's_\(/*\.*.\)[^/]*/_\1/_g'
}
prompt_agent() {
    [ -z "$SSH_AGENT_PID" ] || echo " (A)"
}
prompt_status() {
    if [ "$?" = "0" ]
    then echo "$"
    else echo "%"
    fi
}
prompt_date() {
	date +%H:%M:%S
}
prompt_mail() {
	unread="$(mlist -nds $(mdirs /data/mail) | wc -l)"
	[ "$unread" -eq 1 ] && printf ' (1 mail)'
	[ "$unread" -gt 1 ] && printf ' (%s mails)' "$unread"
}
setopt PROMPT_SUBST
PS1='%B[$(ks prompt_date)]%b %F{red}$(ks prompt_pwd)%f$(ks prompt_git)$(ks prompt_agent)$(ks prompt_mail) %(0?.$.%%) '

# Color ls
alias ls="ls --color=auto"

# Email
alias marchive="mflag -fSt"
alias mspam="mflag -fST"
alias mkeep="mflag -FSt"
alias munread="mdirs /data/mail | mlist -nds | mseq -S && mscan"
alias minbox="mdirs /data/mail | mlist -ndt | mpick -t 'flagged || ! seen' | msort -d | mthread | mseq -S && mscan | sed 's/^\(...\)\(...\)  \(..........\)  \(.................\)  \(.*\)$/$(tput setaf 119)\1$(tput sgr0)\2  $(tput setaf 8)\3$(tput sgr0)  \4  $(tput setaf 148)\5$(tput sgr0)/'"
export MBLAZE_PAGER='less -RF'

# There is only one vis
alias vim="vis"
alias vi="vis"
alias nano="vis"

# Ready for ssh'ing
alias agent='eval "$(ssh-agent)" && ssh-add'
alias unlock='gpg-connect-agent <<<bye'

alias weechat="ssh -t weechat@Hetzner abduco -A weechat"
alias ncspot="abduco -A ncspot ncspot"

function agenda() {
	khal calendar --format '{calendar-color}{cancelled}{start-end-time-style}{repeat-symbol} {title}{reset}' ${@:-today 2d}
}

# Ledger
alias haccounts="hledger -I --alias '/.*:Accounts [^:]*:(.*)/=Accounts:\1' bal accounts"
alias is='hledger is -b $(date -d "7 months ago" +%Y-%m) -e $(date +%Y-%m) -MTA --tree -2'
alias cf='hledger cf -b $(date -d "7 months ago" +%Y-%m) -e $(date +%Y-%m) -MTA --tree -2'
alias bs='hledger bs not:accounts'

# Rust debugging
alias rustdb="RUST_TEST_THREADS=1 RUST_GDB=cgdb rust-gdb"
alias rtdb='rustdb $(cargo test -v 2>&1 | grep "Running.*$(pwd)" |  cut -f2 -d"\`")'

go() {
    dir="$(lr /home /data /etc -t '(name ~~ ".*" && prune || print) && type = d && !(name = ".git")' \
          | sk --height 10 \
          )"
    [ -n "$dir" ] && cd "$dir" || false
}

terminfo() {
    infocmp -x | ssh $@ 'cat > $TERM.info && tic -x $TERM.info && rm $TERM.info'
}
