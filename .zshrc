# Vi keybinds (happen first just in case something later in the file fails)
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode

setopt extendedglob

# auto-init SSH
eval $(ssh-agent) &> /dev/null
ssh-add ~/.ssh/id &> /dev/null

export GOROOT=$HOME/.local/go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export LIMA_HOME=$HOME/projects/.lima
export EDITOR=nvim
export NVIM_PATH=$HOME/.local/nvim
export ZIG_ROOT=$HOME/.local/zig
export ODIN_ROOT=$HOME/.local/odin
export NODE_ROOT=$HOME/.local/node
export TOOLS=$HOME/tools

if command -v rustc &>/dev/null; then
	export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

export PATH=$PATH:$GOBIN:$GOROOT/bin:$ZIG_ROOT:$ODIN_ROOT:$NVIM_PATH/bin:$HOME/.cargo/bin:/usr/local/bin:$HOME/.local/bin:$HOME/bin::/usr/local/lua_ls/bin:$HOME/tools/aseprite/build/bin:$NODE_ROOT/bin
export PATH=$PATH:$TOOLS/tfenv/bin

# optionally source scripts in home directory
for f in $HOME/scripts/**/*; do
	source "$f"
done

# mac specific
if [ "$(uname)" = "Darwin" ]; then
	eval $(/opt/homebrew/bin/brew shellenv)
	source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

	# Snap
	emulate sh -c 'source /etc/profile.d/apps-bin-path.sh'

	# Lima networking fix
	export PATH="/opt/homebrew/opt/socket_vmnet/bin:$PATH"
else # linux specific
	source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' (%b)'
setopt PROMPT_SUBST
NEWLINE=$'\n'
PROMPT='%F{blue}%n@%m%f[%*]:%F{yellow}[%~]%f%F{green}${vcs_info_msg_0_}%f${NEWLINE}$ '

# Highlighting
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=blue
ZSH_HIGHLIGHT_STYLES[precommand]=fg=blue
ZSH_HIGHLIGHT_STYLES[arg0]=fg=blue

# Aliases
alias ls='ls --color=auto'
alias vim="nvim"
alias vimrc="vim ~/.config/nvim/init.lua"
alias glint="golangci-lint run"

# Git alias
alias gs="git status"
alias gfp="git push --force-with-lease"
alias gch='git checkout $(git branch -a | grep -v "^*" | fzf)'

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# opencode
export PATH=/home/soggy/.opencode/bin:$PATH
