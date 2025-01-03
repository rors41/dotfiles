# aliases
alias vim=nvim

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# prompt
export CLICOLOR=1

function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/(\1) /p'
}

COLOR_DEF=$'%f'
COLOR_USR=$'%F{202}'
COLOR_DIR=$'%F{208}'
COLOR_GIT=$'%F{33}'
TIME_COLOR='%F{196}'

setopt PROMPT_SUBST
export PROMPT='${TIME_COLOR}[%D{%H:%M}]${RESET} ${COLOR_USR}%n:${COLOR_DIR}%~ ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF}➤ '

# vi zsh setup
bindkey -v
set editing-mode vi
set show-mode-in-prompt on

BLOCK='\e[1 q'
BEAM='\e[5 q'

function zle-line-init zle-keymap-select {
  if [[ $KEYMAP == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne $BLOCK
  elif [[ $KEYMAP == main ]] || [[ $KEYMAP == viins ]] ||
       [[ $KEYMAP = '' ]] || [[ $1 = 'beam' ]]; then
    echo -ne $BEAM
  fi
}

zle -N zle-line-init
zle -N zle-keymap-select

bindkey -M vicmd 'vv' edit-command-line
bindkey ^R history-incremental-search-backward 
bindkey ^S history-incremental-search-forward

# syntax highlight
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# cargo
export PATH="$HOME/.cargo/bin:$PATH"
