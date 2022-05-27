zstyle :compinstall filename "$HOME/.zshrc"
export FZF_BASE="$HOME/.fzf"
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

fpath+=$HOME/.zsh/pure
autoload -Uz promptinit; promptinit
prompt pure

zmodload zsh/nearcolor
zstyle :prompt:pure:path color cyan
zstyle :prompt:pure:virtualenv color green
zstyle :prompt:pure:host color white
zstyle :prompt:pure:user color white
zstyle :prompt:pure:git:branch color red
zstyle :prompt:pure:status show


plugins=(
    fast-syntax-highlighting
    mysql-colorize
    zsh-autosuggestions
    arcanist
    autopep8
    aws
    fzf
)


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
# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:opt/homebrew/bin:$PATH"

HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=10000000
unsetopt sharehistory

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1

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

export EDITOR=nvim

hash -d d="$HOME/dotfiles"


if [ -f ~/dotfiles/.functions ]; then
    . ~/dotfiles/.functions
fi

function exit_venv {
  if [[ -n "$VIRTUAL_ENV" ]] ; then
    deactivate
  fi
}

bindkey -e
bindkey '^R' history-incremental-search-backward

export FD_OPTIONS="--follow --exclude .git --exclude node_modules"

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

export FZF_DEFAULT_COMMAND='rg --files --hidden'

export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || bat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f3:execute(bat --style=numbers {} || less -f {}),f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy)'"

export PYTHONBREAKPOINT=ipdb.set_trace

#easypost
if [ -d ~/ssh-setup ]; then
    export PATH="$HOME/ssh-setup:$PATH"
fi

#GOSETUP
export GOROOT="/usr/local/go"
export LDFLAGS="-I/usr/local/opt/openssl/include -L/usr/local/opt/openssl/lib"

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

#easypost ssh setup
export PATH="$HOME/easypost/ssh-scripts:$PATH"

#GOSETUP
export GOROOT="/usr/local/go"

#iterm2 shell integraiton script
source ~/.iterm2_shell_integration.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#initialize ssh keys
if [ -z "$SSH_CLIENT" ] || [ -z "SSH_TTY" ];
then
    eval $(/opt/homebrew/bin/brew shellenv)
    keyup 2>/dev/null
else
  echo "No need to setup ssh-agent, already in server"
fi
if [ -f /usr/local/etc/1pass/bash_completion.sh ]; then
    source /usr/local/etc/1pass/bash_completion.sh
else
    echo "Please configure onepassword cli"
fi

echo ".zshrc file loaded successfully for $USER"
