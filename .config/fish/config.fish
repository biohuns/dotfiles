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
#### ENVs ########
##################

set -U EDITOR vim
set -g fish_user_paths "/usr/local/opt/openssl/bin" $fish_user_paths

##################
###### LANG ######
##################

# golang
set -Ux GOPATH $HOME
set -U fish_user_paths $fish_user_paths $GOPATH/bin

# ruby
status --is-interactive; and source (rbenv init -|psub)

# python
status --is-interactive; and source (pyenv init -|psub)

# node.js
status --is-interactive; and source (nodenv init -|psub)

##################
###### Tool ######
##################

# alias
alias l 'ls'
alias pbc 'pbcopy'
alias maximize "printf '\e[9;1t'"
alias mediumize "printf '\e[8;33;119t'"
alias minimize "printf '\e[9;0t'"

# key bindings
function fish_user_key_bindings
  # window size
  # peco
  bind \co peco_recentd
  bind \cr peco_select_history (commandline -b)
  bind \c] peco_select_ghq_repository 
  bind \cx\ck peco_kill
end

# git
alias g 'git'
alias t 'tig'
alias tree 'tree -N'

# AWS
alias start-session 'peco_ssm_start_session'
