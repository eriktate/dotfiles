#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias chrome="google-chrome-stable & disown"

#### GO STUFF ####
export GOPATH=/go
export GOBIN=/go/bin
export PATH=$PATH:$GOBIN

#### BECAUSE I'M LAZY ####
alias gs="git status"
alias vimrc="vim ~/dotfiles/.vimrc"
alias gowork="cd /go/src/github.com/eriktate"
# Add tab completion to git things
if [ -f ~/.git-completion.bash ]; then
	. ~/.git-completion.bash
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

source ~/.awsrc
