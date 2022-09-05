#!/usr/bin/env bash
# Make sure this file is executable
# chmod a+x .github/script/create-workflow-pr.sh

git config user.name github-actions
git config user.email github-actions@github.com

# If --pull-first is set, pull latest from main
# before creating pull request
if [ "$1" = "--pull-first" ]
then
    git pull
    git checkout -b $PR_BRANCH
    git pull origin main --no-rebase -X theirs --no-edit
    git push origin $PR_BRANCH
else
    echo "Merging main into $PR_BRANCH"
    git fetch --all
    git pull
    git checkout -b $PR_BRANCH
    git pull origin main --no-rebase -X theirs --no-edit
    git push origin $PR_BRANCH
fi
echo "Create pull request for $PR_BRANCH into main"
gh pr create --head=oadeniran:$PR_BRANCH --title="$PR_TITLE" --body=""
