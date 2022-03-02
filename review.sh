#!/bin/sh

# set branch from first argument or use current branch by default
BRANCH="$1"
[ -z "$BRANCH" ] && BRANCH="$(git branch --show-current)"

echo "Checking out develop branch and updating it with master"
git checkout develop && \
git pull && \
# automatically merge master with develop and accept auto-generated commit message
git pull --rebase=false --no-edit origin master && \

# only only merging when fast forwarding is possible
echo "Merging $BRANCH with -ff" && \
git merge --no-edit "$BRANCH" && \

echo "Pushing to origin" && \
git push || \
echo 'review failed'

echo "Going back to $BRANCH"
git checkout "$BRANCH"

exit 0
