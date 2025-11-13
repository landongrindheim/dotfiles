#!/usr/bin/env fish
#
# Attach or create tmux session named the same as current directory.

function tat
    set path_name (basename $PWD | tr . -)
    set session_name $argv[1]

    if test -z "$session_name"
        set session_name $path_name
    end

    function not_in_tmux
        test -z "$TMUX"
    end

    function session_exists
        tmux list-sessions | sed -E 's/:.*$//' | grep -q "^$session_name\$"
    end

    function create_detached_session
        env TMUX='' tmux new-session -Ad -s "$session_name"
    end

    function create_if_needed_and_attach
        if not_in_tmux
            tmux new-session -As "$session_name"
        else
            if not session_exists
                create_detached_session
            end
            tmux switch-client -t "$session_name"
        end
    end

    create_if_needed_and_attach
end
