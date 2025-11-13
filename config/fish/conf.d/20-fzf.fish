# FZF configuration
set -x FZF_DEFAULT_COMMAND '(git ls-tree -r --name-only HEAD || find . -path "*/\\.*" -prune -o -type f -print -o -type l -print ! -name "*.rbi" | sed s/^..//) 2> /dev/null'
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

# Source FZF Fish keybindings if available
if test -f ~/.fzf/shell/key-bindings.fish
    source ~/.fzf/shell/key-bindings.fish
end