#####################
## ZSH Preferences ##
#####################

# default permission
umask 022

# global
export PATH=${HOME}/bin:/usr/local/bin:${PATH}

# tmux
alias tm='tmux'
alias tma='tmux a'
alias tmn='tmux new'
alias tml='tmux ls'
alias tmr='tmux source-file ~/.tmux.conf'

if [[ -z "$TMUX" ]]; then
    tmux new -A -s Default
    exit
fi

# ssh agent
#eval `ssh-agent`
#ssh-add -q ~/.ssh/keys/*

#############
## History ##
#############

export HISTSIZE=1000000 # メモリに保存される履歴の件数。(保存数だけ履歴を検索できる)
export SAVEHIST=1000000 # ファイルに何件保存するか
setopt extended_history # 実行時間とかも保存する
setopt share_history # 別のターミナルでも履歴を参照できるようにする
setopt hist_ignore_all_dups # 過去に同じ履歴が存在する場合、古い履歴を削除し重複しない
setopt hist_ignore_space # コマンド先頭スペースの場合保存しない
setopt hist_verify # ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt hist_reduce_blanks #余分なスペースを削除してヒストリに記録する
setopt hist_save_no_dups # histryコマンドは残さない
setopt hist_expire_dups_first # 古い履歴を削除する必要がある場合、まず重複しているものから削除
setopt hist_expand # 補完時にヒストリを自動的に展開すã
setopt inc_append_history # 履歴をインクリメンタルに追加

#############
## Plugins ##
#############

# ZPlug
export ZPLUG_HOME=$HOME/.zplug
source $ZPLUG_HOME/init.zsh

# memo
zplug 'mattn/memo', use:'misc/completion.zsh'
alias m='memo'

# fzf
zplug 'junegunn/fzf-bin', as:command, from:gh-r, rename-to:fzf
zplug 'junegunn/fzf', as:command, use:'bin/fzf-tmux'

# ghq
zplug 'x-motemen/ghq', as:command, from:gh-r

function powerline_precmd() {
    PS1="$(powerline-shell --shell zsh $?)"
}

function install_powerline_precmd() {
  for s in ${precmd_functions[@]}; do
    if [ "$s" = 'powerline_precmd' ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != 'linux' ]; then
    install_powerline_precmd
fi

# zsh
zplug 'zsh-users/zsh-autosuggestions'
zplug "zsh-users/zsh-history-substring-search"
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-syntax-highlighting'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=75'
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# anyframe
zplug 'mollifier/anyframe'
zstyle ':anyframe:selector:' use fzf
bindkey '^R' anyframe-widget-put-history
bindkey '^]' anyframe-widget-cd-ghq-repository

# docker-zsh-completion
zplug 'felixr/docker-zsh-completion'

# node
zplug 'lukechilds/zsh-nvm'

# Go
export GOPATH="$HOME"

# ssh
complete-ssh-host() {
    local host="$(command egrep -i '^Host\s+.+' $HOME/.ssh/config $(find $HOME/.ssh/conf.d -type f 2>/dev/null) | command egrep -v '[*?]' | awk '{print $2}' | sort | fzf)"

    if [ ! -z "$host" ]; then
        LBUFFER+="ssh $host"
    fi
    zle reset-prompt
}
zle -N complete-ssh-host
bindkey '^w' complete-ssh-host

#############
## Aliases ##
#############

# general commands
alias ..='cd ..'
alias ls='ls -F --color=auto'
alias l='ls'
alias ll='ls -l'
alias la='ls -la'
alias tree='tree -N'

# git
alias g="git"
alias t="TERM=xterm-256color tig"
alias cdr='cd $(git rev-parse --show-toplevel)'

# aws
alias instances="aws ec2 describe-instances | jq -r '.Reservations[].Instances[] | {\"InstanceID\": .InstanceId, \"Name\": (.Tags[] | select(.Key == \"Name\").Value)} | @text' | fzf | sed -e 's/.*\"InstanceID\":\"\(.*\)\",\"Name\":.*/\1/' | tr -d '\n' | pbcopy"

#############
## Install ##
#############

if ! zplug check --verbose; then
    printf 'Install? [y/N]: '
    if read -q; then
        echo; zplug install
    fi
    zplug load --verbose
else
    zplug load
fi
