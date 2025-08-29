# System
alias shutdown='sudo shutdown now'
alias restart='sudo reboot'
alias suspend='sudo pm-suspend'
alias sleep='pmset sleepnow'
alias c='clear'
alias e='exit'

# zhs config
alias reload-zsh="source $ZDOTDIR/.zshrc"
alias edit-zsh="nvim $ZDOTDIR/.zshrc"

# Stow
alias stow='stow --target=$HOME/.config'
alias chkstow='chkstow --target=$HOME/.config'

# Git
alias g='git'
alias ga='git add'
alias gd='git diff'
alias gf='git fetch'
alias gs='git status'
alias gss='git status -s'
# pull commands
alias gpl='git pull'
alias gplo='git pull origin'
alias gpr='git pull --rebase'
# branch commands
alias gb='git branch '
alias gbr='git branch -r'
alias gres='git remote show'
# log commands
alias glgg='git log --graph --max-count=5 --decorate --pretty="oneline"'
# push commands
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpo='git push origin'
alias ggpush='git push origin $(current_branch)'
# commmit commands
alias gc='git commit -v'
alias gcm='git commit -m'
alias gcma='git commit --amend'
alias gcan='git commit --amend --no-edit'

# Folders
alias doc="$HOME/Documents"
alias dow="$HOME/Downloads"

# Better ls
alias ls="eza --icons=always"

# Better cat
alias cat="bat"
