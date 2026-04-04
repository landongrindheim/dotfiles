#!/usr/bin/env fish
#
# Show Homebrew packages installed but not listed in the Brewfile.
# Helps keep the Brewfile in sync with what's actually installed.

function brew-diff
    set -l brewfile_dir

    if test -f Brewfile
        set brewfile_dir .
    else if test -f ~/dotfiles/Brewfile
        set brewfile_dir ~/dotfiles
    else
        echo "No Brewfile found" >&2
        return 1
    end

    brew bundle cleanup --file="$brewfile_dir/Brewfile"
end
