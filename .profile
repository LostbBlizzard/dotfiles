alias c="clear"
alias ls='ls --color=auto'

export EDITOR="nvim"
export SHELL="zsh

if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
. "$HOME/.cargo/env"

export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:/opt/nvim-linux64/bin"
export EDITOR=nvim
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/.premake"
export PATH="$PATH:$HOME/prebuilt"
export PATH="$PATH:$HOME/mystuff/rust/lazyspell/target/debug"
export GIT_ASKPASS="$PATH:$HOME/dotfiles/git_env_password.sh"
