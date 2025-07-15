# Wayland/sway stuff
# export LIBVA_DRIVER_NAME=nvidia
# export GBM_BACKEND=nvidia-drm
# export __GLX_VENDOR_LIBRARY_NAME=nvidia
# export WLR_NO_HARDWARE_CURSORS=1
# export XWAYLAND_NO_GLAMOR=1

# export WLR_RENDERER=vulkan
# export QT_QPA_PLATFORMTHEME="qt6ct"

# Comment out for X11
# export GDK_BACKEND=wayland
# export MOZ_ENABLE_WAYLAND=1
# export QT_QPA_PLATFORM=wayland

eval $(ssh-agent) &> /dev/null
ssh-add ~/.ssh/id &> /dev/null

# helpers
function is_darwin() {
	[[ "$(uname)" == "Darwin" ]] && return
	false
}

# Env setup
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
export LIMA_HOME=$HOME/projects/.lima

export EDITOR=nvim
export NVIM_PATH=/usr/local/nvim
# export ZIGBIN=$HOME/zig/build/stage3/bin
export ZIGBIN=/usr/local/zig
export PATH=$PATH:$GOBIN:$GOROOT/bin:$ZIGBIN:${ZIGBIN}13:$NVIM_PATH/bin:$HOME/.cargo/bin:/usr/local/bin:$HOME/.local/bin:/opt/homebrew/opt/llvm/bin:$HOME/.cache/rebar3/bin:/usr/local/lua_ls/bin

# mac stuff
is_darwin && eval $(/opt/homebrew/bin/brew shellenv)
is_darwin && source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
is_darwin || source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' (%b)'
setopt PROMPT_SUBST
NEWLINE=$'\n'
PROMPT='%F{blue}%n@%m%f[%*]:%F{yellow}[%~]%f%F{green}${vcs_info_msg_0_}%f${NEWLINE}$ '

# Aliases
alias ls='ls --color=auto'
alias vim="nvim"
alias vimrc="vim ~/.config/nvim/init.lua"
alias bashrc="vim ~/dotfiles/.bashrc"
alias gocover="go test -covermode=count -coverprofile=coverage.out ./... && go tool cover -html=coverage.out"
alias gotest="go test -cover -v"
alias gofulltest="go test -v -cover -covermode=count -coverprofile=.coverage.out ./... && go tool cover -func .coverage.out | grep total: | awk '{printf \"total code coverage: %s\\n\", \$3}' && go tool cover -html=.coverage.out -o coverage.html"
alias glint="golangci-lint run"
alias gch='git checkout $(git branch -a | grep -v "^*" | fzf)'
alias docker-rm="sudo docker container rm \$(sudo docker container ls -aq)"
alias docker-rmi="sudo docker image rm \$(sudo docker image ls -aq)"
alias tpbuild="~/projects/tpbuild/tpbuild"

# Git alias
alias gs="git status"
alias gf="git fetch"
alias girb="git rebase -i"
alias gfp="git push --force-with-lease"
alias lg="lazygit"

source ~/scripts/*

# Vi keybinds
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode

# Highlighting
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=blue
ZSH_HIGHLIGHT_STYLES[precommand]=fg=blue
ZSH_HIGHLIGHT_STYLES[arg0]=fg=blue

# Git completion
zstyle ':completion:*:*:git:*' script ~/dotfiles/git-completion.zsh
fpath=(~/dotfiles $fpath)
autoload -Uz compinit && compinit

# Snap
is_darwin || emulate sh -c 'source /etc/profile.d/apps-bin-path.sh'

# Turso
export PATH="$HOME/.turso:$PATH"

# mac stuff
eval "$($HOME/.local/bin/mise activate zsh)"
source ~/work.sh
export PATH="/opt/homebrew/opt/socket_vmnet/bin:$PATH"

# pnpm
export PNPM_HOME="/home/soggy/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
