#!/bin/bash

# configs
ARCH=${ARCH:-$(arch)}
NODE_VERSION=${NODE_VERSION:-v20.16.0}
GO_VERSION=${GO_VERSION:-1.23.5}
GO_TOOL_VERSION=${GO_TOOl_VERSION:-$GO_VERSION}
PYTHON_VERSION=${PYTHON_VERSION:-3.12.5}


function prepare() {
	echo "preparing environment..."
	mkdir $HOME/tools
	if [[ ! -f $HOME/.zshrc  ]]; then
		touch $HOME/.zshrc
		echo "source ~/dotfiles/.zshrc"
	fi
	mkdir -p /usr/local
	mkdir -p ~/.config
	mkdir -p ~/.local
	sudo ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
	echo "environment prep complete!"
}


function doApt() {
	echo "doing apt things..."
	sudo apt update
	sudo apt install -y ca-certificates git make cmake gettext curl wget xz-utils \
		gcc g++ binaryen sudo zsh zsh-syntax-highlighting tmux jq dnsutils
	echo "apt things complete!"
}


function setupGo() {
	echo "setting up go..."
	arch=$ARCH
	if [[ $arch -eq "aarch64" ]]; then
		arch="arm64"
	fi

	url=https://go.dev/dl/go${GO_VERSION}.linux-${arch}.tar.gz
	echo "downloading from ${url}"
	curl -LO $url
	tar xzf go${GO_VERSION}.linux-${arch}.tar.gz
	sudo mv ./go /usr/local/go
	rm -f go${GO_VERSION}.linux-${arch}.tar.gz
	export PATH=$PATH:/usr/local/go/bin
	go install golang.org/dl/go${GO_TOOL_VERSION}@latest
	echo "go setup complete!"
}

function setupRust() {
	echo "setting up rust..."
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	rustup toolchain install stable
	echo "rust setup complete!"
}


function setupNode() {
	echo "setting up nodejs..."
	arch=$ARCH
	if [[ $arch == "amd64" ]]; then
		echo "$arch == amd64"
		arch="x64"
	fi

	curl -LO https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-${arch}.tar.xz
	tar xf node-${NODE_VERSION}-linux-${arch}.tar.xz
	sudo mv node-${NODE_VERSION}-linux-${arch} /usr/local/node
	rm -f node-${NODE_VERSION}-linux-${arch}.tar.xz

	export PATH=$PATH:/usr/local/node/bin
	corepack enable pnpm
	corepack install -g pnpm
	echo "nodejs setup complete!"
}

function setupPython() {
	echo "setting up mise & python..."
	filename="Python-${PYTHON_VERSION}.tgz"
	curl https://mise.run | sh
	~/.local/bin/mise --version
	~/.local/bin/mise activate bash >> ~/.bashrc
	~/.local/bin/mise activate zsh >> ~/.zshrc
	~/.local/bin/mise use --global python@$PYTHON_VERSION
	echo "mise & python setup complete!"
}


function setupNeovim() {
	echo "setting up neovim..."
	pushd $HOME/tools
	git clone https://github.com/neovim/neovim.git
	cd neovim
	make CMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make install
	sudo ln -s ~/dotfiles/nvim ~/.config/nvim
	echo "neovim setup complete!"
}

prepare
doApt
setupGo
setupRust
setupNode
setupPython
setupNeovim

echo "switching default shell to zsh"
sudo chsh -s $(which zsh)
