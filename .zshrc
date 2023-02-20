zstyle :compinstall filename "$HOME/.zshrc"
export FZF_BASE="$HOME/.fzf"
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# init prompt
ZSH_THEME_GIT_PROMPT_PREFIX="git:%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[magenta]%})💩 "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[cyan]%})👌 "

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function git_prompt_info_short() {
  # If we are on a folder not tracked by git, get out.
  # Otherwise, check for hide-info at global and local repository level
  if ! __git_prompt_git rev-parse --git-dir &> /dev/null \
     || [[ "$(__git_prompt_git config --get oh-my-zsh.hide-info 2>/dev/null)" == 1 ]]; then
    return 0
  fi

  local ref
  ref=$(__git_prompt_git symbolic-ref --short HEAD 2> /dev/null) \
  || ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null) \
  || return 0

  # Use global ZSH_THEME_GIT_SHOW_UPSTREAM=1 for including upstream remote info
  local upstream
  if (( ${+ZSH_THEME_GIT_SHOW_UPSTREAM} )); then
    upstream=$(__git_prompt_git rev-parse --abbrev-ref --symbolic-full-name "@{upstream}" 2>/dev/null) \
    && upstream=" -> ${upstream}"
  fi

  echo "${ZSH_THEME_GIT_PROMPT_PREFIX}%20>…>${ref}%>>${upstream}${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}

export VIRTUAL_ENV_DISABLE_PROMPT=1

PROMPT='%{$fg_bold[blue]%}$(virtualenv_info)%{$fg_bold[green]%}%3~ %{$fg_bold[blue]%}$(git_prompt_info_short)%{$fg_bold[white]%} ❯❯❯ %{$reset_color%}'

plugins=(
    colors
    fast-syntax-highlighting
    zsh-autosuggestions
    colored-man-pages
    brew
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

function env_history_search() {
    env | cut -d'=' -f1- | sort --reverse | fzf
}

zle -N env_history_search


bindkey -e
bindkey '^R' history-incremental-search-backward
bindkey '^E' env_history_search
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^b' backward-word
bindkey '^f' forward-word

export FD_OPTIONS="--follow --exclude .git --exclude node_modules --exclude .venv"

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

export FZF_DEFAULT_COMMAND='rg --files --hidden'

export FZF_DEFAULT_OPTS="
--layout=reverse
--info=inline
--height=80%
--multi
--preview-window=:hidden
--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
--prompt='∼ ' --pointer='▶' --marker='✓'
--bind '?:toggle-preview'
--bind 'ctrl-a:select-all'
--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
--bind 'ctrl-e:execute(echo {+} | xargs -o vim)'
--bind 'ctrl-v:execute(code {+})'
"

export PYTHONBREAKPOINT=ipdb.set_trace

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


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
