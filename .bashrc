#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load fzf config if present
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,vendor}" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
bind -x '"\C-p": vim $(fzf);'

alias ls='ls --color=auto'
alias chrome="google-chrome-stable & disown"
alias starti3="startx ~/.xinitrc i3"
alias startflux="startx ~/.xinitrc flux"
alias startmonad="startx ~/.xinitrc monad"
alias startsteam="startx ~/.xinitrc steam"
alias crankit="sudo cpupower frequency-set -g performance & sudo sysctl vm.swappiness=30"
alias coolit="sudo cpupower frequency-set -g schedutil & sudo sysctl vm.swappiness=60"

#### GO STUFF ####
export GOPATH=~/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN:$HOME/.cargo/bin

#### RUST STUFF ####
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

#### BECAUSE I'M LAZY ####
alias gs="git status"
alias vimrc="vim ~/dotfiles/.vimrc"
alias bashrc="vim ~/dotfiles/.bashrc"
alias gowork="cd $GOPATH/src/github.com/eriktate"
alias gogfx="cd ~/projects/learn-graphics"
# Add tab completion to git things
if [ -f ~/git/contrib/completion/git-completion.bash ]; then
	. ~/git/contrib/completion/git-completion.bash
fi


#### BASH PROMPT SETTINGS ####
RESET="$(tput sgr0)"
BLUE="$(tput setaf 4)"
AQUA="$(tput setaf 6)"
GREEN="$(tput setaf 2)"
RED="$(tput setaf 1)"
YELLOW="$(tput setaf 3)"
PURPLE="$(tput setaf 5)"
LIGHT="$(tput setaf 7)"

# Access to git branch information.
source ~/git/contrib/completion/git-prompt.sh

export PS1='${BLUE}\u@\h${RESET}[\t]${RESET}:${YELLOW}[\w]${GREEN}$(__git_ps1)${RESET}\n\\$ '

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


# Application Environments
export LOCAL_DYNAMO="http://localhost:8000"
export INKWELL_BLOGS_TABLE="blogs"
export INKWELL_BLOGS_BUCKET="inkwell-test"
export CPATH="./include:./lib"

source ~/.awsrc
source ~/aur/nvm/init-nvm.sh
