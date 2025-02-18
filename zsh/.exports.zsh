## COMMON
export LSCOLORS=gxfxcxdxbxegedabagacad
export CLICOLOR=1
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel

## AWS
#export AWS_PROFILE=default
#export AWS_REGION=eu-west-1

## KUBERNETES
export KUBECONFIG=$HOME/.kube/config

## ARTIFACTORY
export ARTIFACTORY_USER=""
export ARTIFACTORY_TOKEN=""

## GO
export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

## TERRAFORM
export TF_VAR_vault_location=$HOME/Documents/Development/ContentSquare/Git/ansible-dev/group_vars/vault/vault.yml
export TF_VAR_okta_token=""
export PATH=$PATH:$HOME/bin

## GITHUB
export GITHUB_TOKEN=""

## TOKEICH
export CARGOPATH="${HOME}/.cargo/bin"
export PATH="$PATH:${CARGOPATH}"

## SLACK
export SLACK_TOKEN=""
