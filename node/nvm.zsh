if [[ -f "$(brew --prefix nvm)/nvm.sh" ]] then
  export NVM_DIR="$HOME/.nvm"
  . "$(brew --prefix nvm)/nvm.sh"
fi
