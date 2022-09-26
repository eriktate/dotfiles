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

# Load fzf config if present
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,vendor,target,*.bs.js,zig-cache}" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
bind -x '"\C-p": vim $(fzf);'

alias ls='ls --color=auto'
alias chrome="google-chrome-stable & disown"

# Aliases for OS dev
alias qemu='qemu-system-x86_64'

#### LANG STUFF ####
export GOPATH=~/go
export GOBIN=$GOPATH/bin
# export ZIGPATH=/usr/local/zig
export ZIGPATH=$HOME/zig/build
export ZIGBIN=$ZIGPATH/bin
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

#### ENV VARS ####
export EDITOR=nvim
export NVIM_PATH=/usr/local/nvim
export PATH=$PATH:$GOBIN:$ZIGBIN:$HOME/.cargo/bin:/usr/local/bin:~/.local/bin:/home/eriktate/.gem/ruby/2.5.0/bin:/home/eriktate/.yarn/bin:~/apps/protoc/bin/:/usr/local/go/bin:/usr/local/Postman:/usr/local/openresty/bin:/usr/local/openresty/nginx/sbin:/usr/local/janet:/usr/lib/zig/0.8.0
export PATH=$PATH:~/.pyenv/bin:~/aseprite/build/bin:~/bin:$NVIM_PATH/bin:/usr/local/jre/bin:~/wabt/build:/usr/local/firefox

#### BECAUSE I'M LAZY ####
alias gs="git status"
alias vim="nvim"
alias vimrc="vim ~/.config/nvim/init.vim"
alias bashrc="vim ~/dotfiles/.bashrc"
alias gocover="go test -covermode=count -coverprofile=coverage.out ./... && go tool cover -html=coverage.out"
alias gotest="go test -cover -v"
alias gofulltest="go test -v -cover -covermode=count -coverprofile=.coverage.out ./... && go tool cover -func .coverage.out | grep total: | awk '{printf \"total code coverage: %s\\n\", \$3}' && go tool cover -html=.coverage.out -o coverage.html"
alias glint="golangci-lint run"
alias clip="xclip -sel clip"
alias kill-screenkey="kill -9 $(ps aux | grep screenkey | grep -v grep | awk '{print $2}')"
alias flmngo="~/projects/flmngo/api/tmux.sh"

#### DOCKER ALIASES ####
alias docker-rm="sudo docker container rm \$(sudo docker container ls -aq)"
alias docker-rmi="sudo docker image rm \$(sudo docker image ls -aq)"

# Add tab completion to git things
if [ -f ~/dotfiles/git-completion.bash ]; then
	. ~/dotfiles/git-completion.bash
fi

#### BASH PROMPT SETTINGS ####
source ~/dotfiles/git-prompt.sh

RESET="$(tput sgr0)"
BLUE="$(tput setaf 4)"
AQUA="$(tput setaf 6)"
GREEN="$(tput setaf 2)"
RED="$(tput setaf 1)"
YELLOW="$(tput setaf 3)"
PURPLE="$(tput setaf 5)"
LIGHT="$(tput setaf 7)"

export PS1='${BLUE}\u@\h${RESET}[\t]${RESET}:${YELLOW}[\w]${GREEN}$(__git_ps1)${RESET}\n\\$ '


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


# Application Environments
export CPATH="./include:./lib"

source ~/.awsrc
source ~/.linode
source ~/.vultr
alias aws-et="export AWS_SECRET_ACCESS_KEY=${ET_SECRET_KEY} && export AWS_ACCESS_KEY_ID=${ET_ACCESS_KEY}"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# init pyenv
eval "$(pyenv init --path)"
. "$HOME/.cargo/env"

# pnpm
export PNPM_HOME="/home/erik/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin
