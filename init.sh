#!/bin/bash

GO_VERSION=${GO_VERSION:-1.25.4}
NODE_VERSION=${NODE_VERSION:-v24.11.0}
GO_TOOL_VERSION=${GO_TOOL_VERSION:-$GO_VERSION}
PYTHON_VERSION=${PYTHON_VERSION:-3.14.0}

function prepare() {
	mkdir -p $HOME/tools
	if [ ! -f $HOME/.zshrc ]; then
		touch $HOME/.zshrc
		echo "source $HOME/dotfiles/.zshrc"
	fi

	mkdir -p /usr/local
	mkdir -p $HOME/.config
	mkdir -p $HOME/.local
	sudo ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
}

function dnfUpdate() {
	sudo dnf update
	sudo dnf install -y ca-certificates git make cmake gettext curl wget xz-utils \
		gcc g++ binaryen sudo zsh zsh-syntax-highlighting tmux jq dnsutils

}

function setupGo() {
	echo "setting up go..."
	arch=$ARCH
	if [ $arch -eq "aarch64" ]; then
		arch="arm64"
	fi

	rm -rf /tmp/go-install
	mkdir -p /tmp/go-install
	cd /tmp/go-install
	url="https://go.dev/dl/go${GO_VERSION}.linux-${arch}.tar.gz"
	echo "downloading from ${url}"
	curl -L0 $url
	tar xzf go${GO_VERSION}.linux-${arch}.tar.gz
	sudo mv ./go $GOROOT
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

	rm -rf /tmp/node-install
	mkdir -p /tmp/node-install
	cd /tmp/node-install

	curl -LO https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-${arch}.tar.xz
	tar xf node-${NODE_VERSION}-linux-${arch}.tar.xz
	sudo mv node-${NODE_VERSION}-linux-${arch} $NODE_ROOT
	rm -f node-${NODE_VERSION}-linux-${arch}.tar.xz

	corepack enable pnpm
	corepack install -g pnpm
	echo "nodejs setup complete!"
}

function setupPython() {
	echo "setting up mise & python..."
	curl https://mise.run | sh
	$HOME/.local/bin/mise --version
	$HOME/.local/bin/mise activate bash >> ~/.bashrc
	$HOME/.local/bin/mise activate zsh >> ~/.zshrc
	$HOME/.local/bin/mise use --global python@$PYTHON_VERSION
	echo "mise & python setup complete!"
