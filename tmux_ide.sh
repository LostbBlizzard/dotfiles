
INITDIR=$(pwd)
WORKDIR=$(dirname "$0")
cd "$WORKDIR"

SESSION=$(basename "$INITDIR")



tmux \
	new-session -s "$SESSION" \; \
	send-keys 'nnn -c '"$INITDIR"' -f -o -e' Enter \; \
	split-window -c "$INITDIR" -h -p 80 hx \; \
	send-keys 'hx' Enter \; \
	send-keys " " "f" \; \
    split-window -c "$INITDIR" -h -p 15 sh \; \
    split-window -c "$INITDIR" -v -p 40 lazygit \; \
     
 