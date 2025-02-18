###########
# EXPORT ##
###########
export ZSH="/Users/michael.borens/.oh-my-zsh"

export PATH=/usr/local/bin:$PATH
export PATH="/usr/local/opt/python@3.7/bin:$PATH"
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export PATH="/usr/local/sbin:$PATH"
export TERM=xterm-256color
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/

# To use custom functions
[[ ! -f ~/.exports.zsh ]] || source ~/.exports.zsh



# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"

# CASE_SENSITIVE="true"

# HYPHEN_INSENSITIVE="true"

# DISABLE_AUTO_UPDATE="true"

# DISABLE_UPDATE_PROMPT="true"

# export UPDATE_ZSH_DAYS=13

# DISABLE_MAGIC_FUNCTIONS="true"

# DISABLE_LS_COLORS="true"

# DISABLE_AUTO_TITLE="true"

# ENABLE_CORRECTION="true"

# COMPLETION_WAITING_DOTS="true"

# DISABLE_UNTRACKED_FILES_DIRTY="true"

# HIST_STAMPS="mm/dd/yyyy"

# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(
  encode64
  extract
  fzf
  git
  jsontools
  kubectl
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
)

source $ZSH/oh-my-zsh.sh

############
# FUNCTION #
############
# To use custom functions
[[ ! -f ~/.functions.zsh ]] || source ~/.functions.zsh

###########
## ALIAS ##
###########
alias ohmyzsh="mate ~/.oh-my-zsh"
## For terrafom 0.12 --> export AWS_SDK_LOAD_CONFIG=1

# To use custom aliases
[[ ! -f ~/.aliases.zsh ]] || source ~/.aliases.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
# append completions to fpath
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

eval "$(csq aws sso init-plugin zsh)"
