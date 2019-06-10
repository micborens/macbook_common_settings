## COMMON
alias ls='/bin/ls -bFHGLOPW'
alias tar='gtar'
alias cs='cd ~/Documents/Development/ContentSquare/Git/'
alias tcurl='curl -L -w "@$HOME/.curl-format.txt" -o /dev/null -s'
alias azswitch='az fzf subscription'
alias sed='gsed'

## DOCKER
#alias docker='podman'

## KUBERNETES
alias kctx='kubectx'
alias kns='kubens'
alias ctx='kubie ctx'
alias ns='kubie ns'

## GIT
alias glg='git lg -25'
alias gmerge='git merge --no-ff'
alias grebase='git rebase -r'
alias up='git fetch -p --all --tags -P -f && git pull --rebase'

## TERRAFORM
alias tp='terraform plan --var-file=$(fzf -q vars/)'
alias td='terraform destroy --var-file=$(fzf -q vars/)'
alias ta='terraform apply --var-file=$(fzf -q vars/'
alias tws='terraform workspace select $(terraform workspace list | fzf)'
alias tfmt='terraform fmt -recursive'
alias tflock='terraform providers lock -platform=linux_amd64 -platform=linux_arm64 -platform=darwin_amd64 -platform=darwin_arm64 -platform=windows_amd64'
