#!/usr/bin/env fish

# Delete all local branches that have been merged into HEAD.
#
# Credit: https://github.com/smashwilson/dotfiles/blob/9369a4acca/bin/git-delete-local-merged
# Based on script from @tekkub

function git-delete-local-merged
    git fetch
    git branch -d (git branch --merged | grep -v '^\*' | grep -v -E 'main|master' | tr -d '\n')
    git remote prune origin
end