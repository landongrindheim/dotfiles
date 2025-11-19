# FZF configuration
set -x FZF_DEFAULT_COMMAND 'fd --type f --hidden --exclude .git'
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

# Source FZF Fish keybindings if available
if test -f ~/.fzf/shell/key-bindings.fish
    source ~/.fzf/shell/key-bindings.fish
end
