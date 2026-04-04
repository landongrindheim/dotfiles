#!/usr/bin/env fish
#
# Quick project directory switcher using fzf.
# Searches common project directories for git repos.

function proj
    set -l search_dirs ~/src ~/code ~/projects ~/work ~/dotfiles

    set -l dirs
    for d in $search_dirs
        test -d $d; and set -a dirs $d
    end

    if test (count $dirs) -eq 0
        echo "No project directories found" >&2
        return 1
    end

    set -l choice (find $dirs -maxdepth 2 -name .git -type d 2>/dev/null \
        | xargs -I{} dirname {} \
        | sort -u \
        | fzf --layout=reverse --preview 'ls {}')

    if test -n "$choice"
        cd $choice
    end
end
