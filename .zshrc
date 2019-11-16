#####################
## ZSH Preferences ##
#####################

export ZPLUG_HOME=$HOME/.zplug
source $ZPLUG_HOME/init.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

#############
## History ##
#############

HISTFILE=~/.zsh_history #履歴ファイルの設定
HISTSIZE=1000000 # メモリに保存される履歴の件数。(保存数だけ履歴を検索できる)
SAVEHIST=1000000 # ファイルに何件保存するか
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

# fzf
zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:fzf, \
    use:"*darwin*amd64*"

function powerline_precmd() {
    PS1="$(powerline-shell --shell zsh $?)"
}

function install_powerline_precmd() {
  for s in ${precmd_functions[@]}; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi

# zsh-autosuggestions
zplug "zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=75'

# zsh-completions
zplug "zsh-users/zsh-completions"

# zsh-syntax-highlight
zplug "zsh-users/zsh-syntax-highlighting"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# anyframe
zplug "mollifier/anyframe"
zstyle ":anyframe:selector:" use fzf
bindkey '^R' anyframe-widget-put-history
bindkey '^]' anyframe-widget-cd-ghq-repository

# docker-zsh-completion
zplug 'felixr/docker-zsh-completion'

#############
## Aliases ##
#############

alias l='ls'
alias ll='ls -l'
alias la='ls -la'
alias pbc='pbcopy'
alias tree='tree -N'

alias python="python3"
alias pip="pip3"

# git
alias g="git"
alias t="tig"
alias cdr='cd $(git rev-parse --show-toplevel)'

# window size
alias max="printf '\e[9;1t'"
alias mid="printf '\e[8;28;100t'"
alias min="printf '\e[8;24;80t'"

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

if [[ "$TERM" != "screen-256color" ]]; then
    max && tmux new-session
fi