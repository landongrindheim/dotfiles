#!/usr/bin/env fish

# Delete all local branches that have been merged into HEAD (works with squash-merge).
function git-delete-local-merged
  # Clean up local git branches — prunes remotes and removes
  # Usage: git delete-local-merged

  # Detect main branch name
  set main_branch (git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
  if test -z "$main_branch"
      set main_branch "main"
  end

  echo "Switching to $main_branch..."
  git checkout "$main_branch"
  git pull --ff-only

  echo "Pruning remote tracking branches..."
  git fetch --prune

  # Find local branches whose upstream is gone
  set gone_branches (git branch -vv | grep ': gone]' | awk '{print $1}')

  if test -z "$gone_branches"
      echo "No stale branches to remove."
  else
      echo "Removing branches with deleted upstreams:"
      for branch in $gone_branches
          echo "  deleting $branch"
          git branch -D "$branch"
      end
  end
end
