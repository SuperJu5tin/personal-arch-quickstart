#!/bin/bash

# autosuggesions plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions.git ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-history-substring-search.git ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search

echo "
# Terminal autocomplete fix
autoload -Uz compinit && compinit

plugins=(
    git
    docker
    asdf
    nvm
    npm
    zsh-autosuggestions
    zsh-completions
    zsh-history-substring-search
    zsh-syntax-highlighting
)
source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
source /usr/share/nvm/init-nvm.sh
export ANDROID_HOME=~/Android/Sdk
export PATH=/emulator:/tools:/tools/bin:/platform-tools:/sbin:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl

lfcd() {
    tmpfile="${XDG_CACHE_HOME:-$HOME/.cache}/lf/lastdir"
    mkdir -p "$(dirname "$tmpfile")"

    lf -last-dir-path="$tmpfile" "$@"

    if [ -f "$tmpfile" ]; then
        dir=$(cat "$tmpfile")
        [ -d "$dir" ] && cd "$dir"
    fi
}


" >> ~/.zshrc
