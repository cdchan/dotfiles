# colors
CYAN='\[\033[36m\]'
GREEN='\[\033[32m\]'
YELLOW='\[\033[33m\]'
OFF='\[\033[0m\]'

##### fix ls

export CLICOLOR=1  # show colors for ls on macOS

# detect OS, macOS doesn't use gnu ls
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias ls='ls -GFh'
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    alias ls='ls --color=always -Fh'
fi

##### git branch

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

##### virtualenv info

# disable prompt change from virtualenv because I have a custom prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

# define virtualenv for custom prompt
function virtualenv_info() {
  if [[ $VIRTUAL_ENV != "" ]]
    then
      venv="(${VIRTUAL_ENV##*/})"
  else
    venv=""
  fi

  echo $venv
}

##### set prompt and window title

# simple prompt
# export PS1="${CYAN}\u@${GREEN}\h:${YELLOW}\w${OFF}$ "

# this includes username in prompt
# export PROMPT_COMMAND='PS1="$(virtualenv_info)${CYAN}\u@${GREEN}\h:${YELLOW}\w${OFF}$(git_prompt) $ "'

export PROMPT_COMMAND='PS1="$(virtualenv_info)${GREEN}\h:${YELLOW}\w${OFF}$(git_prompt) $ " ; echo -ne "\033]0;$(virtualenv_info) [${HOSTNAME:0:3}] ${PWD##*/}\007"'
