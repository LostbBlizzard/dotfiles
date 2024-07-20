alias c="clear"
alias sd="cd ./ && cd \$(find * -type d | fzf)"
alias tp='tmux new-session -s nvim_session "nvim ."'
alias sp="cd ~ && cd \$(find * -type d | fzf) && tp"
alias sr="cd \$(find ~/ -type d -name \".git\" -not -path '*/.*/*' | fzf)/../"

alias pbcopy="xsel --clipboard --input"
alias pbpaste="xsel --clipboard --output"
