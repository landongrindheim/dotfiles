#!/usr/bin/env fish
#
# Attach or create tmux session named the same as current directory.

function tat
    set -l path_name (basename $PWD | tr . -)
    set -l session_name

    if test (count $argv) -gt 0
        set session_name $argv[1]
    else
        set session_name $path_name
    end

    if test -z "$TMUX"
        # Not in tmux, create new session or attach
        tmux new-session -As "$session_name"
    else
        # In tmux, switch to session
        if not tmux list-sessions | sed -E 's/:.*$//' | grep -q "^$session_name\$"
            # Session doesn't exist, create it detached
            env TMUX='' tmux new-session -Ad -s "$session_name"
        end
        tmux switch-client -t "$session_name"
    end
end
