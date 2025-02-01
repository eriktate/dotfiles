set -gx EDITOR nvim
set -gx NVIM_PATH /usr/bin/nvim
set -gx SSH_AUTH_SOCK ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

# set trusted_fish_config $HOME/rkt/share/fish
# set fish_data_path $trusted_fish_config $__fish_sysconf_dir $__fish_sysconfdir $__fish_data_dir $__fish_datadir

set fish_greeting
# don't do anything in non-interactive shells
if not status is-interactive
	exit
end

# make it look nice
# theme_gruvbox dark medium
# fish_config theme choose tokyonight_moon
source ~/.config/fish/themes/kanagawa.fish

function fish_mode_prompt
	echo ""
end

function fish_prompt -d "Write out the prompt"
	printf '%s%s@%s%s[%s]:%s[%s]%s%s\n%s$ '  (set_color blue) $USER $hostname (set_color brwhite) (date +%H:%M:%S) (set_color yellow) (prompt_pwd) (set_color green) (fish_git_prompt) (set_color white)
end


# make it work nice
fish_vi_key_bindings
bind -M insert -m default jk backward-char force-repaint

# aliases because I'm lazy
alias vim=nvim
alias gs="git status"
alias vimrc="vim ~/.config/nvim/init.lua"
alias bashrc="vim ~/.config/fish/config.fish"
alias flmngo="~/projects/flmngo/api/tmux.sh"
alias versate="cd ~/projects/versate/api && ./tmux.sh"
alias rust-analyzer="rustup run stable rust-analyzer"
alias gch='git branch --all | grep -v "^\*" | fzf --height=20% --reverse --info=inline | xargs git checkout'
alias tmux="TERM=xterm-256color command tmux"

# lang stuff
set -gx GOPATH ~/go
set -gx GOBIN $GOPATH/bin
set -gx GOROOT /usr/local/go
set -gx ODIN_ROOT $HOME/odin
set -gx ZIGPATH $HOME/zig/build
set -gx ZIGBIN $ZIGPATH/stage3/bin
set -gx RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/sr
set -gx RUSTUP_STABLE_BIN $HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin
set -gx ODIN ~/odin

# the path
fish_add_path /usr/local/nvim/bin
fish_add_path $GOBIN
fish_add_path $ZIGBIN
fish_add_path $RUSTUP_STABLE_BIN
fish_add_path $HOME/.cargo/bin
fish_add_path /usr/local/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.yarn/bin
fish_add_path $HOME/.pyenv/bin
fish_add_path $HOME/aseprite/build/bin
fish_add_path $GOROOT/bin
fish_add_path $GOROOT/bin
fish_add_path $ODIN

nvm use latest &> /dev/null

# pnpm
set -gx PNPM_HOME "/home/erik/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end

# pyenv
# status is-interactive; and pyenv init --path | source
# pyenv init - | source
# pyenv end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# ocaml
eval (opam env --switch=5.1.0)
