# Enable vcs_info for Git branch in prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats '%F{magenta}(%b)%f '

# Enable prompt substitution and colors
setopt prompt_subst
autoload -U colors && colors

# Configure Kube context & vcs_info before each prompt
precmd() {
  vcs_info
  KUBE_CONTEXT=$(kubectl config current-context 2>/dev/null)
  KUBE_CONTEXT_TRIMMED=${KUBE_CONTEXT%-context}
}

# Prompt: ➜ (green/red), current dir, git branch, and root/normal user indicator
PROMPT='%(?.%F{green}➜%f.%F{red}➜%f) %F{cyan}%~%f ${vcs_info_msg_0_}%F{blue}%(!.#.$)%f '

# Right prompt: Kubernetes context
RPROMPT='%F{green}($KUBE_CONTEXT_TRIMMED)%f'

# Colorize CLI output
export CLICOLOR=1

# Load Zsh plugins (syntax highlighting & autosuggestions)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Load kubectl.zsh (assumed to define useful kubectl aliases or prompt info)
source ~/Settings/zsh-kubectl-prompt/kubectl.zsh

# Load NVM initialization script (installed via Homebrew)
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# Display a short random quote with a speech bubble using cowsay
fortune -s | cowsay
