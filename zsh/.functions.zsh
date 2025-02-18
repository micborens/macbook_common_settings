function varys {
  lassPassLogin
  unset VAULT_ADDR
  unset VAULT_TOKEN
  envs=("dev" "staging" "production" "mgmt" "drp" "drptest")
  regions=("eu-west-1" "us-east-1" "eastus2" "northeurope")
  selected_env=$(printf '%s\n' "${envs[@]}" | fzf --prompt="Choose your varys env: ")
  if [[ -z "$selected_env" ]]; then
    echo "No environment selected. Exiting."
    return 1
  fi
  selected_region=$(printf '%s\n' "${regions[@]}" | fzf --prompt="Choose your varys region: ")
  if [[ -z "$selected_region" ]]; then
    echo "No region selected. Exiting."
    return 1
  fi
  export VAULT_ADDR="https://varys-${selected_env}.${selected_region}.csq.io"
  export VAULT_TOKEN=$(vault login -token-only -method=okta username="" password="$(lpass show okta.com --fixed-strings --password)")
  echo $VAULT_TOKEN > $HOME/.vault-token
}

function lassPassLogin {
  lpass status > /dev/null
  if [[ $? -eq 1 ]]; then
    lpass login 
  fi
}

function update_providers() {
  if [[ -z "${GITHUB_TOKEN}" ]]; then
      echo "GITHUB_TOKEN is not defined"
  else
      latest_version=$(curl -u micborens:$GITHUB_TOKEN https://api.github.com/repos/contentsquare/platform_terraform_modules/releases/latest -s  | jq .tag_name -r)
      gsed -i "s/?ref=.*/?ref=$latest_version\"/" *tf
  fi
}

function tf_remove_empty_ws() {
    terraform workspace select default
    for WS in $(terraform workspace list | cut -c3-); do
        if [ $WS != "default" ]; then
            echo "Removing ${WS} workspace"
            terraform workspace delete $WS
        fi
    done
}

function update_dir {
  for dir in */; do
    if [ -d "$dir/.git" ]; then
      echo "Processing repository: $dir"
      cd "$dir" || continue
      echo "Fetching updates from remote..."
      git fetch --all --prune
      default_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
      if [ -z "$default_branch" ]; then
        echo "No default branch detected in $dir, skipping."
        cd - > /dev/null
        continue
      fi
      echo "Switching to default branch: $default_branch"
      git checkout "$default_branch"
      echo "Updating $default_branch with 'git pull --rebase'"
      git pull --rebase
      cd - > /dev/null
    fi
  done
}
