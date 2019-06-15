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

set -U EDITOR vim
set -g fish_user_paths "/usr/local/opt/openssl/bin" $fish_user_paths

##################
###### LANG ######
##################

# golang
set -Ux GOPATH $HOME
set -U fish_user_paths $fish_user_paths $GOPATH/bin
status --is-interactive; and source (goenv init -|psub)

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
alias tree 'tree -N'
alias mm 'cd ~/Documents/memo'
# window size
alias max "printf '\e[9;1t'"
alias mid "printf '\e[8;33;119t'"
alias min "printf '\e[9;0t'"

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
