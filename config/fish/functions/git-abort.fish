#!/usr/bin/env fish

# Abort a rebase, merge, `am`, a cherry-pick or a revert, depending on the situation.
# credit: @christoomey
# https://github.com/christoomey/dotfiles/blob/master/bin/git-abort

function git-abort
    if test -e .git/CHERRY_PICK_HEAD
        exec git cherry-pick --abort $argv
    else if test -e .git/REVERT_HEAD
        exec git revert --abort $argv
    else if test -e .git/rebase-apply/applying
        exec git am --abort $argv
    else if test -e .git/rebase-apply
        exec git rebase --abort $argv
    else if test -e .git/rebase-merge
        exec git rebase --abort $argv
    else if test -e .git/MERGE_MODE
        exec git merge --abort $argv
    else
        echo "git-abort: unknown state"
        exit 1
    end
end