fish_vi_key_bindings


# set -x PATH $PATH ~/gitahead/GitAhead
# set -x PATH $PATH ~/.local/bin
set -x PATH $PATH ~/scripts/path
set -x PATH $PATH ~/scripts/python/.venv/bin
set -x PATH $PATH ~/.cargo/bin
set -x APPDATA "C:\Users\DSE52233\AppData\Roaming"
set -x EDITOR nvim

set -x RIPGREP_CONFIG_PATH ~/.config/ripgrep

if status is-interactive
	set fish_greeting
	# Commands to run in interactive sessions can go here
    # Initialize zoxide for fish
	zoxide init fish --cmd cd | source
end

# Aliases
alias ll 'ls -lash --color'
# alias cd 'z' # zoxide does this already
alias gd 'git diff'
alias tm 'tmux new -t 0'
alias initlua 'nvim ~/.config/nvim/init.lua'
alias nz "nvim /c/Users/DSE52233/Documents/Notizzettel.md"
alias gits "git status"
alias pos "PYTHONPATH=. poetry shell"
alias n "nvim"
alias n. "nvim ."
alias hf "history | fzf"

# ANTLR stuff
set -x CLASSPATH .:/usr/local/lib/antlr-4.13.1-complete.jar:$CLASSPATH
alias antlr4 'java -Xmx500M -cp "/usr/local/lib/antlr-4.13.1-complete.jar:$CLASSPATH" org.antlr.v4.Tool'
alias grun 'java -Xmx500M -cp "/usr/local/lib/antlr-4.9.3-complete.jar:$CLASSPATH" org.antlr.v4.gui.TestRig'
