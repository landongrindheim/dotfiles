#!/usr/bin/env fish
#
# Pretty-print $PATH, one entry per line.

function path-list
    for p in $PATH
        echo $p
    end
end
