-- plugins
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
	{ "ibhagwan/fzf-lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
	{ "junegunn/fzf", build = "./install --bin" },
	{ "saghen/blink.cmp", version = "v0.*" },
	"neovim/nvim-lspconfig",
	{ "nvim-treesitter/nvim-treesitter", build=":TSUpdate" },
	"tpope/vim-commentary",
	"tpope/vim-surround",
	"tpope/vim-repeat",
	"airblade/vim-gitgutter",
	"tpope/vim-fugitive",
	"folke/trouble.nvim",
	"wakatime/vim-wakatime",
	"APZelos/blamer.nvim",
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
	"leoluz/nvim-dap-go",
	{ "stevearc/oil.nvim", opts = {}, dependencies = { "nvim-tree/nvim-web-devicons" } },
	"Almo7aya/openingh.nvim",
	"sindrets/diffview.nvim",
	"nvim-lualine/lualine.nvim",
	"rebelot/kanagawa.nvim",
	"norcalli/nvim-colorizer.lua",


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
	{ "davidmh/mdx.nvim", config = true, dependencies = { "nvim-treesitter/nvim-treesitter" } },
	"othree/html5.vim",
	"lifepillar/pgsql.vim",
	"NoahTheDuke/vim-just",
	"elixir-editors/vim-elixir",
	"dag/vim-fish",
	"Tetralux/odin.vim",
	"gleam-lang/gleam.vim",
	"joerdav/templ.vim",

	-- TBD on whether or not they should stay
	-- "jiangmiao/auto-pairs",
	-- { "prettier/vim-prettier", build="yarn install --frozen-lockfile --production" },
})


vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")
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
vim.opt.mouse = nil
vim.opt.list = true
vim.opt.listchars = {
	tab = "→ ",
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


-- filetypes with 2 space indentation
local two_space_filetypes = {
	"javascript",
	"javascript.jsx",
	"typescript",
	"typescript.tsx",
	"typescriptreact",
	"svelte",
	"rescript",
	"html",
	"json",
	"ocaml",
	"nix",
	"yml",
	"yaml",
	"markdown",
}

local local_autos = vim.api.nvim_create_augroup("LocalAutos", { clear = true })
vim.api.nvim_create_autocmd(
	"FileType",
	{
		group = local_autos,
		pattern = two_space_filetypes,
		command = [[setlocal ts=2 sts=2 sw=2 expandtab]],
	}
)

vim.api.nvim_create_autocmd(
	{ "BufNewFile", "BufRead" },
	{
		group = local_autos,
		pattern = { "*.vs", "*.fs" },
		command = "set ft=glsl",
	}
)

vim.api.nvim_create_autocmd(
	{ "BufNewFile", "BufRead" },
	{
		group = local_autos,
		pattern = { "*.md", "*.mdx" },
		command = "set ft=markdown",
	}
)

-- fix comment strings (mostly for vim-commentary)
vim.api.nvim_create_autocmd(
	"FileType",
	{
		group = local_autos,
		pattern = {"glsl", "rescript", "c", "cpp"},
		command = [[setlocal commentstring=//\ %s]],
	}
)

vim.api.nvim_create_autocmd(
	"FileType",
	{
		group = group_id,
		pattern = { "sql", "pgsql" },
		command = [[setlocal commentstring=--\ %s]],
	}
)


-- theming
vim.opt.termguicolors = true
require("kanagawa").setup({
	commentStyle = { italic = false },
	keywordStyle = { italic = false },
	variablebuiltinStyle = { italic = false },
})
vim.cmd("colorscheme kanagawa")

require("lualine").setup({
	options = {
		theme = "kanagawa",
		icons_enabled = true,
	},
})


-- keymaps
vim.keymap.set("i", "jk", "<Esc>")
vim.g.mapleader = ","

--- window traversal
vim.keymap.set("", "<C-j>", "<C-W>j")
vim.keymap.set("", "<C-k>", "<C-W>k")
vim.keymap.set("", "<C-h>", "<C-W>h")
vim.keymap.set("", "<C-l>", "<C-W>l")

--- window size
vim.keymap.set("", "H", "20<C-w><")
vim.keymap.set("", "L", "20<C-w>>")
vim.keymap.set("", "J", "20<C-w>+")
vim.keymap.set("", "K", "20<C-w>-")

--- window move
vim.keymap.set("", "<C-Space>h", "<C-w>R")
vim.keymap.set("", "<C-Space>j", "<C-w>r")
vim.keymap.set("", "<C-Space>k", "<C-w>R")
vim.keymap.set("", "<C-Space>l", "<C-w>r")

--- visual line traversal
vim.keymap.set("n", "j", "gj", { remap=true })
vim.keymap.set("n", "k", "gk", { remap=true })

--- enhanced text search
vim.keymap.set("n", "/", [[/\v]])
vim.keymap.set("v", "/", [[/\v]])

--- line style
vim.keymap.set("n", "<leader>rl", ":set rnu<cr>")
vim.keymap.set("n", "<leader>al", ":set nornu<cr>")

--- file searching
--  ignore patterns for fzf: defaults = { file_ignore_patterns = {"vendor", "deps", "_build", "target"} }
local fzf = require("fzf-lua")
local fd_cmd = "fd --type f --strip-cwd-prefix"
local ignore_patterns = { "vendor", "deps", "_build", "target" }

for _, pattern in ipairs(ignore_patterns) do
	fd_cmd = fd_cmd .. " -E " .. pattern
end

print(fd_cmd)
fzf.setup({"telescope"})
vim.keymap.set("n", "<C-p>", function() fzf.files({ cmd = fd_cmd }) end, { desc = "Fzf Files" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Fzf Buffers" })
vim.keymap.set("n", "<leader>ff", fzf.live_grep, { desc = "Fzf Live Grep" })

-- ez delete
vim.keymap.set("n", "<leader>dd", "<cmd>call delete(expand('%'))<cr>")


-- vim-go
vim.g.go_metalinter_command = "golangci-lint"
vim.g.go_imports_mode = 'gopls'
vim.g.go_gopls_local = 'github.com/gravitational/teleport'


-- vim-svelte
vim.g.svelte_preprocessor_tags = {
	{ name = "ts", tag = "script", as = "typescript" },q
}
vim.g.svelte_preprocessors = { "ts" }


-- postgres
vim.g.sql_type_default = 'pgsql'


-- rust
vim.g.rustfmt_autosave = 1


-- treesitter
require('nvim-treesitter.configs').setup({
	ensure_installed = { "c", "cpp", "lua", "go", "rust", "zig", "odin", "typescript", "tsx", "ocaml", "gleam", "vim", "glsl", "fish", "bash", "hcl", "markdown", "html", "css", "proto", "json", "sql", "templ"},
	auto_install = true,
	highlight = {
		enable = true,
	},
})


--oil
require('oil').setup({
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-s>"] = "actions.select_vsplit",
    ["<C-t>"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-;>"] = "actions.refresh",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",
  },
  use_default_keymaps = false,
})


-- lsp config
local lspconfig = require('lspconfig')
local blink_cmp = require('blink.cmp')
local on_attach = function(client, bufnr)
	print("attaching lsp")
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', 'gr', fzf.lsp_references, bufopts)

	vim.api.nvim_create_augroup('AutoFormatting', {})
	vim.api.nvim_create_autocmd('BufWritePre', {
	  -- pattern = '*',
	  group = 'AutoFormatting',
	  callback = function()
		vim.lsp.buf.format()
	  end,
	})
end

local language_servers = {
	ts_ls = {},
	gopls = {
		settings = {
			gopls = {
				analyses = {
					shadow = true,
					unusedvariable = true,
				},
				staticcheck = true,
				["local"] = "github.com/gravitational/teleport",
			},
		},
	},
	zls = {},
	rescriptls = {},
	rust_analyzer = {},
	svelte = {},
	terraformls = {},
	pyright = {},
	ols = {},
	clangd = {},
	ocamllsp = {},
	nixd = {},
	gleam = {},
	templ = {},
	htmx = {},
	html = {},
	cssls = {},
}

for server, config in pairs(language_servers) do
	config.capabilities = blink_cmp.get_lsp_capabilities(config.capabilities)
	config.on_attach = on_attach
	lspconfig[server].setup(config)
end


-- dap for go
local dap = require("dap")
local dapui = require("dapui")
local dap_go = require("dap-go")
-- dap_go.setup()
dap_go.setup({
	dap_configurations = {
		{
			type = "go",
			name = "Attach remote",
			mode = "remote",
			request = "attach",
		},
	},
})

dap.configurations.cpp = {
	{
		name = 'Launch',
		type = 'lldb',
		request = 'launch',
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
		args = {},
	},
	{
		name = 'Attach to process',
		type = 'lldb',
		request = 'attach',
		pid = require('dap.utils').pick_process,
		args = {},
	}
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.odin = dap.configurations.cpp

dapui.setup({
	layouts = {
		{
			elements = {
				{
					id = "scopes",
					size = 0.25,
				},
				{
					id = "breakpoints",
					size = 0.25,
				},
				{
					id = "stacks",
					size = 0.25
				},
				{
					id = "watches",
					size = 0.25,
				},
			},
			position = "left",
			size = 80,
		},
	},
})

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end

dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end

dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end

dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

-- DAP keybinds
vim.keymap.set("n", "<leader>dc", function() dap.continue() end)
vim.keymap.set("n", "<leader>da", function() dap_go.attach() end)
vim.keymap.set("n", "<leader>dt", function() dap_go.debug_test() end)
vim.keymap.set("n", "<leader>dl", function() dap_go.debug_last() end)
vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end)
vim.keymap.set("n", "<leader>dab", function() dap.clear_breakpoints() end)
vim.keymap.set("n", "<leader>dj", function() dap.step_over() end)
vim.keymap.set("n", "<leader>dl", function() dap.step_into() end)
vim.keymap.set("n", "<leader>dh", function() dap.step_out() end)
vim.keymap.set("n", "<leader>dr", function() dap.repl.open() end)
vim.keymap.set("n", "<leader>ds", function() dapui.toggle() end)

