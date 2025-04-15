# Loaded for:
# [x] INTERACTIVE, LOGIN
# [x] INTERACTIVE, NON-LOGIN
# [ ] NON-INTERACTIVE, LOGIN
# [ ] NON-INTERACTIVE, NON-LOGIN
#
# Explanation: https://www.freecodecamp.org/news/how-do-zsh-configuration-files-work/
#
# Generally used to capture everything for interactive usage:
# prompt, completion, correction, suggestion, highlighting, output coloring,
# aliases, key bindings, commands history management, and
# other misc interactive tools (auto_cd, manydots-magic)...

##################################################
# PROMPT
##################################################

# Otherwise add-zsh-hook won't work in iTerm for some reason
autoload -Uz add-zsh-hook

# Function to get current Git branch and status
git_prompt_info() {
  local branch git_status
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    [[ -z $branch ]] && return  # safety check
    if git_status=$(git status --porcelain 2>/dev/null) && [[ -n $git_status ]]; then
      echo "on 🌿 %F{red}$branch ✗%f"
    else
      echo "on 🌿 %F{green}$branch ✓%f"
    fi
  fi
}

function prep_for_prompt() {
  GIT_INFO=$(git_prompt_info)
  print ""
  print -P "%{\e(0%}${(r:$COLUMNS::q:)}%{\e(B%}\n"  # Horizontal line
}
add-zsh-hook precmd prep_for_prompt

function newline_before_execution() {
  print ""
}
add-zsh-hook preexec newline_before_execution

# Prompt should say "[user] in [folder] on [git branch] ->"
setopt promptsubst
PROMPT='%F{208}%n%f in %F{226}%~%f ${GIT_INFO} -> '


##################################################
# ALIASES
##################################################

# cd
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# tree
alias tree="tree -A"
alias tree1="tree -L 1"
alias tree2="tree -L 2"

