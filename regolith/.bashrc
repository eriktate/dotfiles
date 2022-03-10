#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Make sure ssh-agent is running
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi

if [[ ! "$SSH_AUTH_SOCK" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi

export LANG="en_US.UTF-8"
export LC_ALL=$LANG
export LC_CTYPE=$LANG

# Load fzf config if present
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,vendor,target,*.bs.js,zig-cache}" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
bind -x '"\C-p": vim $(fzf);'

alias ls='ls -G'
alias chrome="google-chrome-stable & disown"
alias starti3="startx ~/.xinitrc i3"
alias startflux="startx ~/.xinitrc flux"
alias startmonad="startx ~/.xinitrc monad"
alias startsteam="startx ~/.xinitrc steam"
alias crankit="sudo cpupower frequency-set -g performance & sudo sysctl vm.swappiness=30"
alias coolit="sudo cpupower frequency-set -g schedutil & sudo sysctl vm.swappiness=60"

# Aliases for OS dev
alias qemu='qemu-system-x86_64'


#### LANG STUFF ####
export GOPATH=~/go
export GOBIN=$GOPATH/bin
export PYENV_ROOT=$HOME/.pyenv
export ANDROID_HOME=$HOME/Library/Android/sdk

#### ENV VARS ####
export EDITOR=nvim
export NVIM_PATH=/usr/local/nvim
export PATH=$PATH:$GOBIN:$HOME/.cargo/bin:/usr/local/bin:~/.local/bin:/home/eriktate/.gem/ruby/2.5.0/bin:/home/eriktate/.yarn/bin:~/apps/protoc/bin/:/usr/local/go/bin:/usr/local/Postman:/usr/local/openresty/bin:/usr/local/openresty/nginx/sbin:/usr/local/janet:/usr/lib/zig/0.8.0
export PATH=$PATH:$PYENV_ROOT/bin:~/aseprite/build/bin:~/bin:$NVIM_PATH/bin
# android paths
export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:/usr/local/google-cloud-sdk/bin


#### RUST STUFF ####
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

#### BECAUSE I'M LAZY ####
alias gs="git status"
alias vim="nvim"
# alias vimrc="vim ~/dotfiles/.vimrc"
alias vimrc="vim ~/.config/nvim/init.vim"
alias bashrc="vim ~/dotfiles/regolith/.bashrc"
alias gowork="cd $GOPATH/src/github.com/eriktate"
alias gogfx="cd ~/projects/learn-graphics"
alias golingo="cd $GOPATH/src/github.com/eriktate/lingo"
alias gocover="go test -covermode=count -coverprofile=coverage.out ./... && go tool cover -html=coverage.out"
alias gotest="go test -cover -v"
alias gofulltest="go test -v -cover -covermode=count -coverprofile=.coverage.out ./... && go tool cover -func .coverage.out | grep total: | awk '{printf \"total code coverage: %s\\n\", \$3}' && go tool cover -html=.coverage.out -o coverage.html"
alias glint="golangci-lint run"
alias updateme="git fetch && git merge --no-edit origin/master && yarn && yarn build"
alias aws-stg="aws-vault exec -t $(op get totp "Truebill AWS") tb-stg-eng -- aws"
alias aws-prod="aws-vault exec -t $(op get totp "Truebill AWS") tb-prod-eng -- aws"
alias dif="git difftool"
alias jsonclip="pbpaste > jq"
# git checkout fuzzy finding
gch() {
 git checkout $(git branch | fzf | tr -d " *")
}

#### DOCKER ALIASES ####
alias docker-rm="sudo docker container rm \$(sudo docker container ls -aq)"
alias docker-rmi="sudo docker image rm \$(sudo docker image ls -aq)"


# Add tab completion to git things
if [ -f ~/dotfiles/git-completion.bash ]; then
	. ~/dotfiles/git-completion.bash
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
source ~/dotfiles/git-prompt.sh

export PS1='${BLUE}\u@\h${RESET}[\t]${RESET}:${YELLOW}[\w]${GREEN}$(__git_ps1)${RESET}\n\\$ '

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


# Application Environments
export LOCAL_DYNAMO="http://localhost:8000"
export INKWELL_BLOGS_TABLE="blogs"
export INKWELL_BLOGS_BUCKET="inkwell-test"
export CPATH="./include:./lib"

# source ~/.awsrc
alias aws-et="export AWS_SECRET_ACCESS_KEY=${ET_SECRET_KEY} && export AWS_ACCESS_KEY_ID=${ET_ACCESS_KEY}"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# export LDFLAGS="-L/usr/local/opt/lapack/lib -L/usr/local/opt/openblas/lib"
# export CPPFLAGS="-I/usr/local/opt/lapack/include -I/usr/local/opt/openblas/include"

export PKG_CONFIG_PATH="/usr/local/opt/lapack/lib/pkgconfig:/usr/local/opt/openblas/lib/pkgconfig"

# TRUEBILL THINGS
export BASE_DATABASE_URL=postgres://truebill@localhost:25432
export DATABASE_URL=$BASE_DATABASE_URL/truebill_development
export TRANSACTIONS_DATABASE_URL=$BASE_DATABASE_URL/truebill_transactions?sslmode=disable
export REDIS_URL=redis://localhost:26379
export REDIS_SESSIONS_URL=$REDIS_URL
source ~/.truebill.sh
source ~/.tmux.bash

# init pyenv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
