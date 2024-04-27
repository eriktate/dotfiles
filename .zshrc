# Wayland/sway stuff
export LIBVA_DRIVER_NAME=nvidia
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export WLR_NO_HARDWARE_CURSORS=1
export XWAYLAND_NO_GLAMOR=1
export GDK_BACKEND=wayland
export MOZ_ENABLE_WAYLAND=1

export WLR_RENDERER=vulkan

# Env setup
export GOPATH=~/go
export GOBIN=$GOPATH/bin
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

export EDITOR=nvim
export NVIM_PATH=/usr/local/nvim
# export ZIGBIN=$HOME/zig/build/stage3/bin
export ZIGBIN=/usr/local/zig
export ZLS_PATH=~/tools/zls/zig-out/bin
export PATH=$PATH:$GOBIN:$ZIGBIN:$ZLS_PATH:$NVIM_PATH/bin:$HOME/.cargo/bin:/usr/local/bin:$HOME/.local/bin:/opt/homebrew/opt/llvm/bin:$HOME/.cache/rebar3/bin
if [[ $(uname) == "Darwin" ]]; then
	eval $(/opt/homebrew/bin/brew shellenv)
	source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
	source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' (%b)'
setopt PROMPT_SUBST
NEWLINE=$'\n'
PROMPT='%F{blue}%n@%m%f[%*]:%F{yellow}[%~]%f%F{green}${vcs_info_msg_0_}%f${NEWLINE}$ '

# Aliases
alias ls='ls --color=auto'
alias gs="git status"
alias vim="nvim"
alias vimrc="vim ~/.config/nvim/init.vim"
alias bashrc="vim ~/dotfiles/.bashrc"
alias gocover="go test -covermode=count -coverprofile=coverage.out ./... && go tool cover -html=coverage.out"
alias gotest="go test -cover -v"
alias gofulltest="go test -v -cover -covermode=count -coverprofile=.coverage.out ./... && go tool cover -func .coverage.out | grep total: | awk '{printf \"total code coverage: %s\\n\", \$3}' && go tool cover -html=.coverage.out -o coverage.html"
alias glint="golangci-lint run"
alias gch='git checkout $(git branch -a | grep -v "^*" | fzf)'
alias docker-rm="sudo docker container rm \$(sudo docker container ls -aq)"
alias docker-rmi="sudo docker image rm \$(sudo docker image ls -aq)"

# Vi keybinds
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode

# Highlighting
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=blue
ZSH_HIGHLIGHT_STYLES[precommand]=fg=blue
ZSH_HIGHLIGHT_STYLES[arg0]=fg=blue

# Git completion
zstyle ':completion:*:*:git:*' script ~/dotfiles/git-completion.bash
fpath=(~/dotfiles $fpath)
autoload -Uz compinit && compinit

