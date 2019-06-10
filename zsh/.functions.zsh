function vlogin {
  lassPassLogin
  unset VAULT_TOKEN
  export VAULT_TOKEN=$(vault login -token-only -method=okta username=michael.borens@contentsquare.com password="$(lpass show okta.com --fixed-strings --password)")
  echo $VAULT_TOKEN > ~/.vault-token
}

function varys {
  lassPassLogin
  unset VAULT_ADDR
  unset VAULT_TOKEN
  echo -n "Choose your varys env (staging/production/mgmt): "
  read env
  echo -n "Choose your varys region (eu-west-1/us-east-1/eastus2/northeurope): "
  read region
  export VAULT_ADDR="https://varys-${env}.${region}.csq.io"
  export VAULT_TOKEN=$(vault login -token-only -method=okta username=michael.borens@contentsquare.com password="$(lpass show okta.com --fixed-strings --password)") 
  echo $VAULT_TOKEN > ~/.vault-token
}

function oktalogin {
  lassPassLogin
#  echo -n "Enter you MFA Code: "
#  read mfa
  csq okta set-aws-creds --config $HOME/.config/csq-go-cli.toml -p "$(lpass show okta.com --fixed-strings --password)"
}

function onelogin () {
  lassPassLogin
  echo -n "Enter you MFA Code: "
  read mfa
  csq ol login --config $HOME/.config/csq-go-cli.toml -p "$(lpass show onelogin --fixed-strings --password)" --mfa-code "${mfa}"
}

function lassPassLogin {
  lpass status > /dev/null
  if [[ $? -eq 1 ]]; then
    lpass login appo.esl@gmail.com
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

function ansible() {
  gsed -i 's/^strategy =/#strategy =/' ${ANSIBLE_DIR}/ansible.cfg
  source ${ANSIBLE_DIR}/.venv/bin/activate
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
