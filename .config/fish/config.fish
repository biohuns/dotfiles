##################
###### Init ######
##################

# fisher
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

##################
##### VISUAL #####
##################

set -g theme_date_format "+%Y/%m/%d %H:%M %a"

##################
###### ENV #######
##################

set -x EDITOR vim
set -x PATH "/usr/local/opt/openssl/bin" $PATH

##################
###### LANG ######
##################

# golang
set -x GOPATH $HOME
set -x PATH $GOPATH/bin $PATH

# ruby
status --is-interactive; and source (rbenv init -|psub)

# python
status --is-interactive; and source (pyenv init -|psub)
set -x PATH $HOME/.ebcli-virtual-env/executables $PATH

# node.js
status --is-interactive; and source (nodenv init -|psub)

# php
set -x PATH $HOME/.composer/vendor/bin $PATH

##################
###### Tool ######
##################

# alias
alias l 'ls'
alias pbc 'pbcopy'
alias tree 'tree -N'
alias cdr 'cd (git root)'
alias home 'cd ~'
alias mm 'cd ~/Documents/memo'
# window size
alias max "printf '\e[9;1t'"
alias mid "printf '\e[8;28;100t'"
alias min "printf '\e[8;24;80t'"

alias update "brew update; and brew upgrade; and brew cleanup; and fisher"
alias sshadd "ssh-add -K ~/.ssh/**/*"

# key bindings
function fish_user_key_bindings
  # peco
  bind \co peco_recentd
  bind \cr peco_select_history (commandline -b)
  bind \c] peco_select_ghq_repository 
  bind \cx\ck peco_kill
end

# git
alias g 'git'
alias t 'tig'

# AWS
alias start-session 'peco_ssm_start_session'
