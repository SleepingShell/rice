HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

# The following lines were added by compinstall
zstyle :compinstall filename '/home/tyler/.zshrc'

autoload -Uz compinit promptinit
compinit
promptinit
# End of lines added by compinstall

# Config
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

export EDITOR=vim

# Applications
source /usr/share/nvm/init-nvm.sh
alias k='kubectl'
alias kbug='kubectl run --generator=run-pod/v1 -i --tty bug --image=alpine -- sh'
alias kdns='k run dnstest --image=tutum/dnsutils -- sleep 3600'

alias ls='ls --color=auto'
alias ydl='yt-dlp -f ba -x'

# Path
export PATH=$PATH:~/.cargo/bin
export PATH="$PATH:/home/tyler/.foundry/bin"
export PATH=$PATH:~/.local/bin
export PATH=$PATH:$HOME/.nargo/bin
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
eval "$(starship init zsh)"
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
source <(talosctl completion zsh)
eval "$(direnv hook zsh)"


# NVM
autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

export PATH="$PATH:/home/tyler/.huff/bin"

# pnpm
export PNPM_HOME="/home/tyler/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
