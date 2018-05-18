. `brew --prefix`/etc/profile.d/z.sh
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
setopt appendhistory
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/binarytiger/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
export ZSH=~/.oh-my-zsh

# Install antigen for this to work (https://github.com/zsh-users/antigen)
source /usr/local/share/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle git
antigen bundle heroku
antigen bundle z
antigen bundle taskwarrior
antigen bundle yarn
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle docker
antigen theme steeef
antigen apply
# bindkey -v

# https://github.com/zsh-users/zsh-history-substring-search
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
export ANDROID_HOME=/Users/aracine/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export PATH=$PATH:$(go env GOPATH)/bin
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"
eval "$(rbenv init -)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

alias weather='weather Montreal'
alias emberserver='nv .env ember s'
alias kill8080='lsof -ti:8080 | xargs kill'

# added by travis gem
[ -f /Users/aracine/.travis/travis.sh ] && source /Users/aracine/.travis/travis.sh
