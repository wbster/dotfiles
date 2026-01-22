#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
# PS1='[\u@\h \W]\$ '

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PROMPT_DIRTRIM=2

PS1="\[\e[32m\]\u@\h \[\e[34m\]\w\[\e[33m\]\$(parse_git_branch)\[\e[0m\] \$ "

alias config='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias config-ui='lazygit --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

# Загрузка пользовательских alias
if [ -f ~/.bash_alias ]; then
    . ~/.bash_alias
fi

# Check if file exists and is not empty, then source it
[[ -s ~/.bash_functions ]] && . ~/.bash_functions

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [[ "$OSTYPE" == "linux-gnu"* ]]; then

    source /usr/share/bash-completion/bash_completion
    source <(docker completion bash)

elif [[ "$OSTYPE" == "darwin"* ]]; then

    eval $(/opt/homebrew/bin/brew shellenv)

    [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

    if [ -f "$BREW_PREFIX/etc/profile.d/bash_completion.sh" ]; then
        . "$BREW_PREFIX/etc/profile.d/bash_completion.sh"
    fi

    source <(docker completion bash)
fi

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export SITL_RITW_TERMINAL="kitty --hold sh -c"

if command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --bash)"
fi

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash)"
    alias cd="z"
fi