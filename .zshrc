
zstyle :compinstall filename "$HOME/.zshrc"

export ZSH="/Users/gpappu/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

zmodload zsh/nearcolor
zstyle :prompt:pure:path color white

setopt EXTENDEDGLOB

for dump in $ZSH_COMPDUMP(#qN.m1); do
  compinit
  if [[ -s "$dump" && (! -s "$dump.zwc" || "$dump" -nt "$dump.zwc") ]]; then
    zcompile "$dump"
  fi
  echo "Initializing Completions..."
done

unsetopt EXTENDEDGLOB
compinit -C

plugins=(
    git
    npm
    macos
    fast-syntax-highlighting
    zsh-256color
    virtualenv
    zsh-autosuggestions
)


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=10000000
unsetopt sharehistory

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1

bindkey -e
bindkey "^U" backward-kill-line
bindkey "^X^_" redo
bindkey "^[f" vi-forward-word-end

function pet-select() {
  BUFFER=$(pet search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}

zle -N pet-select
stty -ixon
bindkey '^s' pet-select

export TERM=xterm-256color


[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=246"

export EDITOR=vim

if [ -f ~/dotfiles/aliases ]; then
    . ~/dotfiles/aliases
fi

function color {
    echo -n -e "\033]Ph$1$2$3\033\\"
}

function reset_color {
    color 00 00 00
}

function textcolor {
    printf "\x1b[38;5;$1m$($@[2,-1])\x1b[0m\n"
}

function exit_venv {
  if [[ "$VIRTUAL_ENV" != "" ]] ; then
    deactivate
  fi
}



export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export PYTHONBREAKPOINT=ipdb.set_trace

#dotfiles
hash -d d="$HOME/dotfiles"

#easypost 
if [ -d ~/ssh-setup ]; then 
    export PATH="$HOME/ssh-setup:$PATH"
fi 

hash -d hq="$HOME/easypost"


#GOSETUP 
export GOROOT="/usr/local/go"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

