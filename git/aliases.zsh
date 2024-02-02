alias gs='git st'
alias ta='tig --all'
# eval "$(hub alias -s)"

alias gdb="gh repo view --json defaultBranchRef -q .defaultBranchRef.name"

function gbdn() {
  default_branch=$(git config remote.origin.defaultbranch)
  if [ $? -ne 0 ]; then
    default_branch=$(gh repo view --json defaultBranchRef -q .defaultBranchRef.name)
    echo "setting default branch to $default_branch"
    git config --local remote.origin.defaultbranch $default_branch
  fi

  git checkout $default_branch && git pull && git bclean $default_branch;
}
