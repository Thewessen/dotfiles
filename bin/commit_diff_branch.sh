#!/usr/bin/env sh

gitcommands=(
  "git stash push"
  "git checkout master"
  "git pull"
  "git checkout -b $1"
  "git stash pop"
  "git add ."
  "git commit -v"
  "git push"
)

# Check branchname argument exists
if [ $# -ne 1 ]; then
  echo "Branchname should be given as an argument. Aborting..." >&2
  exit 1
fi

# Check if their are any changed files
if [[ -z `git status -s` ]]; then
  echo "No files for commiting to a new branch. Aborting..." >&2
  exit 1
fi

# Check git stash not empty or abort
if [[ ! -z `git stash show 2>/dev/null` ]]; then
  git --no-pager stash show
  echo "Stash is not empty! Aborting..." >&2
  exit 1
fi

# # Run all git commands in order
for command in "${gitcommands[@]}"; do
  echo "Running $command..."
  $command
  # If some command has errors, abort
  if [ $? -ne 0 ]; then
    echo "Some errors occured. Aborting" >&2
    exit 1
  fi
done

# Succeed msg
echo "Enjoy your new branch"
exit 0
