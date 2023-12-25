bindkey -v

eval "$(starship init zsh)"

source "$HOME/.fzf.zsh"

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^f' autosuggest-accept

export ZSH_AUTOSUGGEST_STRATEGY=(history completion match_prev_cmd)
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=0,bg=none,bold"

source /usr/local/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
:

. /usr/local/etc/profile.d/z.sh

[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin

export PATH=$PATH:$HOME/.cargo/bin

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export HISTFILE=~/.history
export HISTSIZE=8912
export SAVEHIST=8912

export EDITOR='nvim'
export VISUAL='nvim'
export LC_ALL='en_US.UTF-8'
export PAGER='less'
export MANPAGER='nvim +Man!'
export NO_COLOR=1
export LESS='-g -i -J -n -R -s -w -z-4 --mouse'
export LESSHISTFILE=-

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

export STARSHIP_CACHE="$XDG_CACHE_HOME/.starship/cache"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude node_modules --exclude .git'
export FZF_DEFAULT_OPTS="--height 60% \
--color=fg:gray,hl:yellow \
--color=fg+:white,bg+:gray,hl+:yellow \
--color=info:green,prompt:green,pointer:yellow \
--color=marker:green,spinner:yellow,header:yellow \
--color=border:gray \
--prompt '█  ' \
--pointer '█' \
--marker '█'"

setopt auto_cd
setopt auto_pushd
setopt chase_links
setopt pushd_ignore_dups
setopt pushd_minus
setopt always_to_end
setopt complete_in_word
setopt list_rows_first
setopt extended_glob
setopt glob_star_short
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt inc_append_history_time
setopt correct
setopt correct_all
setopt path_dirs
setopt rc_quotes
setopt auto_resume
setopt long_list_jobs
setopt prompt_subst

unsetopt menu_complete
unsetopt case_glob
unsetopt append_history
unsetopt share_history
unsetopt global_rcs
unsetopt flow_control
unsetopt beep

alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias mv='mv -v'
alias rm='rm -i -v'
alias cp='cp -v'
alias ..='cd ..'
alias li="gls --ignore=.DS_Store"
alias ls="li -la --color"
alias ll='ls -FGlAhp'
alias curl="curl -L -S -R -A '' --connect-timeout '10' --referer 'NCC-74656' --compressed"
alias remove='trash -Fv'
alias key="ssh-keygen -t ed25519 -f $HOME/.ssh/key"

alias gc="git clone --depth=1"
alias gs="git status"
alias gp="git pull"
alias gl="git log"
alias gg='git push -u origin'
alias ga='git add -A'
alias gm='git commit -av'
alias gmm='git commit -am'
alias gd='git diff'

autoload -Uz compinit
compinit -i -C

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zcompcache"
zstyle ':completion:*' file-list all
zstyle ':completion:*' complete-options true
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*' format '%F{green}%d%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _extensions _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

extract() {
    if [ -f "$1" ]; then
        case $1 in
            *.tar.bz2) tar -jxvf "$1" ;;
            *.tar.gz) tar -zxvf "$1" ;;
            *.bz2) bunzip2 "$1" ;;
            *.dmg) hdiutil mount "$1" ;;
            *.gz) gunzip "$1" ;;
            *.tar) tar -xvf "$1" ;;
            *.tbz2) tar -jxvf "$1" ;;
            *.tgz) tar -zxvf "$1" ;;
            *.zip) unzip "$1" ;;
            *.ZIP) unzip "$1" ;;
            *.pax) cat <"$1" | pax -r ;;
            *.pax.Z) uncompress "$1" --stdout | pax -r ;;
            *.rar) unrar x "$1" ;;
            *.Z) uncompress "$1" ;;
            *) echo "'$1' cannot be extracted/mounted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
