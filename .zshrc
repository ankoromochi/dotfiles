export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>+"
autoload -U colors
colors
PS1='[%{${fg[green]}%}%t%{${fg[default]}%}]%# '
autoload -U compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
SAVEHIST=100000
HISTSIZE=100000
HISTFILE=~/.histfile
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_NO_STORE
if [ $UID = 0 ]; then
    unset HISTFILE
    SAVEHIST=0
fi
DIRSTACKSIZE=10
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward
setopt prompt_subst
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

function rprompt-git-current-branch {
  local name st color gitdir action
  if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
    return
  fi
  name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
  if [[ -z $name ]]; then
    return
  fi

  gitdir=`git rev-parse --git-dir 2> /dev/null`
  action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    color=%F{green}
  elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
    color=%F{yellow}
  elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
    color=%B%F{red}
  else
     color=%F{red}
  fi
  echo "$color$name$action%f%b"
}

RPS1='[`rprompt-git-current-branch`]'"[%{${fg[cyan]}%}%2~%{${fg[default]}%}]"

setopt NULL_GLOB
setopt EXTENDED_GLOB
setopt MENU_COMPLETE
setopt IGNORE_EOF
setopt NO_CLOBBER
setopt RM_STAR_WAIT
setopt CORRECT_ALL
alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias vi='nocorrect vim'
alias git='nocorrect git'
alias touch='nocorrect touch'
alias mkdir='nocorrect mkdir'
alias sl=ls

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# plenv
export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init - zsh)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# direnv
export EDITOR=vim
eval "$(direnv hook zsh)"

# google cloud SDK
export GOOGLE_CLOUD_SDK_ROOT=~/google-cloud-sdk/
for f (
    $GOOGLE_CLOUD_SDK_ROOT/completion.zsh.inc
    $GOOGLE_CLOUD_SDK_ROOT/path.zsh.inc
) {
    [ -f $f ] && source $f
}

# nodenv
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"
