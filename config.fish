set -gx EDITOR nvim
set -gx NVIM_PATH /usr/bin/nvim

# don't do anything in non-interactive shells
if not status is-interactive
	return
end

# make it look nice
theme_gruvbox dark medium

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
alias vimrc="vim ~/.config/nvim/init.vim"
alias bashrc="vim ~/.config/fish/config.fish"
alias flmngo="~/projects/flmngo/api/tmux.sh"

# lang stuff
set -gx GOPATH ~/go
set -gx GOBIN $GOPATH/bin
set -gx ZIGPATH $HOME/zig/build
set -gx ZIGBIN $ZIGPATH/stage3/bin
set -gx RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/sr

# the path
fish_add_path $GOBIN
fish_add_path $ZIGBIN
fish_add_path $HOME/.cargo/bin
fish_add_path /usr/local/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.yarn/bin
fish_add_path $HOME/.pyenv/bin
fish_add_path $HOME/aseprite/build/bin

nvm use 14
