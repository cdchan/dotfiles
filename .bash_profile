# colors
CYAN='\[\033[36m\]'
GREEN='\[\033[32m\]'
YELLOW='\[\033[33m\]'
OFF='\[\033[0m\]'

# simple prompt
# export PS1="${CYAN}\u@${GREEN}\h:${YELLOW}\w${OFF}$ "

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# detect OS
# OSX doesn't use gnu ls
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias ls='ls -GFh'
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    alias ls='ls --color=always -Fh'
fi

function git_prompt () {
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    return 0
  fi

  git_branch=$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')

  # Different colors if the branch is clean or dirty
  if git diff --quiet 2>/dev/null >&2; then
    git_color="${c_git_clean}"
  else
    git_color=${c_git_cleanit_dirty}
  fi

  echo " [$git_branch]"
}

# disable prompt change from virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=1

function virtualenv_info() {
  if [[ $VIRTUAL_ENV != "" ]]
    then
      venv="(${VIRTUAL_ENV##*/})"
  else
    venv=""
  fi

  echo $venv
}

# this includes username in prompt
# export PROMPT_COMMAND='PS1="$(virtualenv_info)${CYAN}\u@${GREEN}\h:${YELLOW}\w${OFF}$(git_prompt) $ "'

# sets prompt and window title
export PROMPT_COMMAND='PS1="$(virtualenv_info)${GREEN}\h:${YELLOW}\w${OFF}$(git_prompt) $ " ; echo -ne "\033]0;$(virtualenv_info) [${HOSTNAME:0:3}] ${PWD##*/}\007"'

# BuzzFeed dev
source ~/.bash_profile_buzzfeed
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

