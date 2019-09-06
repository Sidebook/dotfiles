# Install zplug

if [[ ! -d ~/.zplug ]];then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

source ~/.zplug/init.zsh

zplug "yous/vanilli.sh"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "b4b4r07/enhancd", use:init.sh
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "zsh-users/zsh-syntax-highlighting", defer:2

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
# Then, source plugins and add commands to $PATH
zplug load

# Setup history-substring-search
# Better history searching with arrow keys
if zplug check "zsh-users/zsh-history-substring-search"; then
  bindkey "$terminfo[kcuu1]" history-substring-search-up
  bindkey "$terminfo[kcud1]" history-substring-search-down
fi
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=bg=cyan,fg=white,bold

zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

autoload -Uz colors
colors

PROMPT_PREF=$'%{\e[38;5;242m%}%n@%m %{\e[0m%}%~%{\e[0m%}'
PROMPT_SUF=$'\n%(?.%B%F{cyan}.%B%F{red})%(?!$ !$ )%f%b'
PROMPT="$PROMPT_PREF$PROMPT_SUF"
RPROMPT=$'%{\e[38;5;242m%}%D %T %(?..%F{red})(%(?!\'-\' !;_; ))%{\e[0m%}%b'

autoload -Uz compinit
compinit

# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
setopt prompt_subst

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "+"
zstyle ':vcs_info:git:*' unstagedstr '*'
zstyle ':vcs_info:*' formats $'%{\e[38;5;242m%} at %F{white}%b%c%u %{\e[0m%}'
zstyle ':vcs_info:*' actionformats $'%{\e[38;5;242m%} at %F{red}%b%c%u(%a) %{\e[0m%}'
function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    PROMPT="$PROMPT_PREF${vcs_info_msg_0_}$PROMPT_SUF"
}
add-zsh-hook precmd _update_vcs_info_msg
precmd() { vcs_info }

setopt print_eight_bit
setopt interactive_comments
setopt share_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt extended_glob

function select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="bck-i-search > ")
  CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^R' select-history

ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=cyan,underline
ZSH_HIGHLIGHT_STYLES[precommand]=fg=cyan,underline
ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=white

case ${OSTYPE} in
    darwin*)
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        alias ls='ls -F --color=auto'
        ;;
esac
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias sudo='sudo '

if type pyenv >/dev/null 2>&1; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init -)"
    fi
fi

export FZF_DEFAULT_OPTS='
--color dark,hl:51,hl+:51,fg:249,bg+:238,fg+:254
--color info:30,prompt:123,spinner:30,pointer:37,marker:235
'

alias gb='git checkout $(git for-each-ref --format="%(authorname) %09 %(refname:short)" --sort=authorname | sed "/origin/d" | peco | awk "{print \$NF}")'

