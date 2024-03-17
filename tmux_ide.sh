
INITDIR=$(pwd)
WORKDIR=$(dirname "$0")
cd "$WORKDIR"

SESSION=$(basename "$INITDIR")
export EDITOR=nvim


tmux \
	new-session -s "$SESSION" \; \
	send-keys 'nnn -c '"$INITDIR"' -f -o -e' Enter \; \
	split-window -c "$INITDIR" -h -p 80 hx \; \
	send-keys 'hx' Enter \; \
	send-keys " " "f" \; \
    split-window -c "$INITDIR" -h -p 20 bash \; \
    split-window -c "$INITDIR" -v -p 60 lazygit \; \
     
 
