# Set up the prompt

#autoload -Uz promptinit
#promptinit
#prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Activate colors
autoload -U colors && colors

# zsh-syntax-highlighting
source ~/Projets/Tierce/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# autojump
source /usr/share/autojump/autojump.sh

# todotxt
PATH="$HOME/Projets/Tierce/todo.txt-cli/:$PATH"
alias t=todo.sh
compdef _todo.sh todo.sh=t

# return code of the last command
local return_code="%(?..%{$fg[red]%} %? ↵ %{$reset_color%})"

# git prompt 
# /etc/bash_completion.d/git
setopt PROMPT_SUBST
source /etc/bash_completion.d/git
GIT_PS1_SHOWDIRTYSTATE=1 
GIT_PS1_SHOWUNTRACKEDFILES=1 
GIT_PS1_SHOWSTASHSTATE=1 
GIT_PS1_SHOWUPSTREAM="verbose"
PROMPT='%{$fg[cyan]%}%n%{$fg[blue]%}@%{$fg[magenta]%}%m %{$fg[yellow]%}%~ %{$fg[red]%}$(__git_ps1 " (%s)")
%{$fg[blue]%}$[HISTCMD] ${return_code}%{$fg[green]%}%#%{$reset_color%} '
