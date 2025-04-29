# Loaded for:
# [x] INTERACTIVE, LOGIN
# [ ] INTERACTIVE, NON-LOGIN
# [x] NON-INTERACTIVE, LOGIN
# [ ] NON-INTERACTIVE, NON-LOGIN
#
# Explanation: https://www.freecodecamp.org/news/how-do-zsh-configuration-files-work/
#
# I personally treat that file like .zshenv but for
# commands and variables which should be set once or
# which don't need to be updated frequently:
#
# - environment variables to configure tools (flags for compilation, data folder location, etc.)
# - configuration which execute commands (like SCONSFLAGS="--jobs=$(( $(nproc) - 1 ))") as it may take some time to execute.
#
# If you modify this file, you can apply the configuration updates by running a login shell:


# If Homebrew appears to be installed, then add brew to $PATH
[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

# Add pip-installed CLI tools (like ansible) to PATH, if the directory exists
if [ -d "$HOME/Library/Python/3.9/bin" ]; then
  export PATH="$HOME/Library/Python/3.9/bin:$PATH"
fi

# Add personal bin directory to PATH
if [ -d "$HOME/bin" ]; then
  export PATH="$HOME/bin:$PATH"
fi