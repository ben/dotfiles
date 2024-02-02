function precmd() {
  printf "\033]1337;SetUserVar=%s=%s\007" kubecontext `kubectl config view --minify --output 'jsonpath={..current-context}' | base64`
  printf "\033]1337;SetUserVar=%s=%s\007" kubens `kubectl config view --minify --output 'jsonpath={..namespace}' | base64`
}

# printf "\e]1337;SetBadgeFormat=%s\a" \
#   $(echo -n "\(session.name) \(user.gitBranch)" | base64)
