# Navigation aliases
alias .. "cd .."
alias ... "cd ../.."
alias .... "cd ../../.."

# File listing
alias ll 'ls -alhG'
alias vi vim
alias dotfiles 'cd ~/dotfiles'

# Git aliases and functions
function g
    if test (count $argv) -gt 0
        git $argv
    else
        git status
    end
end

function gg
    if not git rev-parse --is-inside-working-tree >/dev/null 2>&1
        if command -v ag >/dev/null 2>&1
            ag $argv
        else
            grep -r $argv .
        end
    else
        git grep $argv
    end
end

# macOS specific aliases
if test (uname) = Darwin
    if test -f (brew --prefix)/bin/ctags
        set -l brew_ctags (brew --prefix)/bin/ctags
        alias ctags $brew_ctags
    end
else
    alias pbcopy 'xclip -selection clipboard'
end