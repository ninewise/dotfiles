function agent --description 'Runs ssh-agent'
    eval (ssh-agent -c)
    and ssh-add
end
