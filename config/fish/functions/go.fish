function go --description 'Jump to directories'
    lr /home /data /etc -L -t '(name ~~ "^\." && prune || print) && type = d && !(name = ".git")' \
        | fzf \
        | read -l dir
    [ "$dir" ]; and cd $dir; and clear
end
