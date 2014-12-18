xclip -o | sed -n 's/view/download/p' | xargs transmission-remote --add 
