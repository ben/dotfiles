export PATH=$PATH:~/Library/Python/3.7/bin:~/Library/Python/2.7/bin

# Add pyenv executable to PATH and
# enable shims by adding the following
# to ~/.profile and ~/.zprofile:
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# Load pyenv into the shell by adding
# the following to ~/.zshrc:
eval "$(pyenv init -)"

# Make sure to restart your entire logon session
# for changes to profile files to take effect.
export ANSIBLE_NOCOWS=1
