# Git-aware prompt configuration
function git_status_flag
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set -l git_status_output (git status --porcelain 2>/dev/null)
        if test -n "$git_status_output"
            echo -e " "(set_color red)"✗"
        else
            echo -e " "(set_color green)"✓"
        end
    end
end

function parse_git_branch
    git branch 2>/dev/null | sed -n 's/\* \(.*\)/(\1)/p'
end

function fish_prompt
    set_color blue
    echo -n $USER
    set_color normal
    echo -n " "

    set_color yellow
    echo -n (parse_git_branch)
    set_color normal
    echo -n (git_status_flag)
    set_color normal
    echo

    echo -n " $PWD"
    set_color cyan
    echo -n " \$ "
    set_color normal
end
