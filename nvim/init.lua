-- BEGIN PLUGINS
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- tooling
	"nvim-lua/popup.nvim",
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	"neovim/nvim-lspconfig",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"tpope/vim-commentary",
	"tpope/vim-surround",
	"jiangmiao/auto-pairs",
	"airblade/vim-gitgutter",
	"tpope/vim-fugitive",
	"folke/trouble.nvim",
	{ "prettier/vim-prettier", build="yarn install --frozen-lockfile --production" },
	"wakatime/vim-wakatime",
	"APZelos/blamer.nvim",

	-- language plugins
	"fatih/vim-go",
	"hashivim/vim-terraform",
	"rust-lang/rust.vim",
	"tikhomirov/vim-glsl",
	"shiracamus/vim-syntax-x86-objdump-d",
	"ziglang/zig.vim",
	"cespare/vim-toml",
	"elm-tooling/elm-vim",
	"rescript-lang/vim-rescript",
	"pangloss/vim-javascript",
	"jparise/vim-graphql",
	"maxmellon/vim-jsx-pretty",
	"eriktate/vim-protobuf",
	"eriktate/vim-syntax-extra",
	{ "evanleck/vim-svelte", branch="main" },
	"othree/html5.vim",
	"lifepillar/pgsql.vim",
	"NoahTheDuke/vim-just",
	"elixir-editors/vim-elixir",
	"dag/vim-fish",

	-- visuals
	"morhetz/gruvbox",
	"kyazdani42/nvim-web-devicons",
	"itchyny/lightline.vim",
	"airblade/vim-gitgutter",
})

vim.cmd("filetype plugin indent on")
vim.opt.syntax = "on"
vim.opt.complete:remove { 1 }
vim.opt.nrformats:remove { "octal" }
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.wildmenu = true
vim.opt.smartcase = true
vim.opt.scrolloff = 5
vim.opt.whichwrap:append("h")
vim.opt.whichwrap:append("l")
vim.opt.linebreak = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = {
	tab = "▸ ",
	eol = "¬",
	trail = "-",
	extends = ">",
	precedes = "<",
	nbsp = "+",
}
vim.cmd([[match errorMsg /\s\+$/]])

-- tab behaviour
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false

-- BEGIN FILETYPE
-- configure 2 space indents
local two_space_filetypes = {
	"javascript",
	"javascript.jsx",
	"typescript",
	"typescript.tsx",
	"typescriptreact",
	"svelte",
	"rescript",
	"html",
}

vim.api.nvim_create_autocmd(
	"FileType",
	{ pattern = two_space_filetypes, command = "set local ts=2 sts=2 sw=2 expandtab" }
)

vim.api.nvim_create_autocmd(
	{ "BufNewFile", "BufRead" },
	{ pattern = { "*.vs", "*.fs" }, command = "set ft=glsl" }
)

vim.api.nvim_create_autocmd(
	"FileType",
	{ pattern = "glsl", command = [[setlocal commentstring=//\ %s]] }
)
-- END FILETYPE

-- BEGIN THEME
vim.opt.termguicolors = true
vim.cmd("colorscheme gruvbox")
vim.g.gruvbox_contrast_dark = "medium"
-- END THEME

-- BEGIN KEYMAPS
vim.keymap.set("i", "jk", "<Esc>")
vim.g.mapleader = ","

-- window traversal
vim.keymap.set("", "<C-j>", "<C-W>j")
vim.keymap.set("", "<C-k>", "<C-W>k")
vim.keymap.set("", "<C-h>", "<C-W>h")
vim.keymap.set("", "<C-l>", "<C-W>l")

-- visual line traversal
vim.keymap.set("n", "j", "gj", { remap=true })
vim.keymap.set("n", "k", "gk", { remap=true })

-- enhanced text search
vim.keymap.set("n", "/", [[/\v]])
vim.keymap.set("v", "/", [[/\v]])

-- line style
vim.keymap.set("n", "<leader>rl", ":set rnu")
vim.keymap.set("n", "<leader>al", ":set nornu")

-- telescope
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope .buffers<cr>")
-- END KEYMAPS

-- BEGIN PLUGIN CONFIGS
-- vim-svelte
vim.g.svelte_preprocessors = { "ts" }

-- prettier
vim.g["prettier#autoformat"] = 1
vim.g["prettier#autoformat_require_pragma"] = 0

-- postgres
vim.g.sql_type_default = 'pgsql'

-- rust
vim.g.rustfmt_autosave = 1
-- END PLUGIN CONFIGS

-- BEGIN LSP CONFIG
local telescope = require('telescope')
telescope.setup{
	defaults = { file_ignore_patterns = {"vendor", "deps", "_build", "target"} }
}

local nvim_lsp = require('lspconfig')
local cmp = require('cmp')

cmp.setup({
	mapping = {
		['<C-Space>'] = cmp.mapping.complete()
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'buffer' },
	}
})

local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end

local servers = { 'tsserver', 'gopls', 'svelte', 'zls', 'rescriptls', 'rust_analyzer'}
for _, lsp in ipairs(servers) do
	config = {
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150,
		},
		capabilities = require('cmp_nvim_lsp').default_capabilities(),
	}

	if lsp == 'zls' then
		config.cmd = { '/home/erik/zls/zig-out/bin/zls' }
	end

	if lsp == 'rescriptls' then
		config.cmd = {'node', '/home/erik/.vim/plugged/vim-rescript/server/out/server.js', '--stdio'}
	end

	nvim_lsp[lsp].setup(config)
end
-- END LSP CONFIG
