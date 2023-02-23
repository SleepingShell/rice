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

# Applications
source /usr/share/nvm/init-nvm.sh
alias k='kubectl'
alias kbug='kubectl run --generator=run-pod/v1 -i --tty bug --image=alpine -- sh'
alias kdns='k run dnstest --image=tutum/dnsutils -- sleep 3600'

# Path
export PATH=$PATH:~/.cargo/bin
export PATH="$PATH:/home/tyler/.foundry/bin"



source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
eval "$(starship init zsh)"
