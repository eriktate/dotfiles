local api = vim.api
local HOME = os.getenv('HOME')

-- BEGIN PLUGINS
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"nvim-telescope/telescope.nvim",
	"neovim/nvim-lspconfig",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",
	"tpope/vim-commentary",
	"tpope/vim-surround",
	"tpope/vim-repeat",
	"jiangmiao/auto-pairs",
	"airblade/vim-gitgutter",
	"tpope/vim-fugitive",
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = {
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
		},
	},
	{
		"stevearc/aerial.nvim",
		opts = {},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{ "prettier/vim-prettier",           build = "yarn install --frozen-lockfile --production" },
	-- "wakatime/vim-wakatime",
	"APZelos/blamer.nvim",
	{ "stevearc/oil.nvim",    opts = {},                                                          dependencies = { "nvim-tree/nvim-web-devicons" } },
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
	"habamax/vim-godot",
	"leoluz/nvim-dap-go",
	{ "davidmh/mdx.nvim", config = true, dependencies = { "nvim-treesitter/nvim-treesitter" } },
	"tpope/vim-dadbod",
	"kristijanhusak/vim-dadbod-ui",
	"Almo7aya/openingh.nvim",
	"sindrets/diffview.nvim",

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
	"leafoftree/vim-svelte-plugin",
	"elkowar/yuck.vim",
	-- { "evanleck/vim-svelte", branch="main" },
	"othree/html5.vim",
	"lifepillar/pgsql.vim",
	"NoahTheDuke/vim-just",
	"elixir-editors/vim-elixir",
	"dag/vim-fish",
	"Tetralux/odin.vim",
	"gleam-lang/gleam.vim",
	"joerdav/templ.vim",

	-- visuals
	"morhetz/gruvbox",
	"nvim-lualine/lualine.nvim",
	"kyazdani42/nvim-web-devicons",
	"airblade/vim-gitgutter",
	"folke/tokyonight.nvim",
	"rebelot/kanagawa.nvim",
	"norcalli/nvim-colorizer.lua",
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
-- vim.opt.shortmess:remove { "F" }
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
vim.diagnostic.config({ virtual_lines = true })

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
	"json",
	"ocaml",
	"nix",
	"yml",
	"yaml",
	"markdown",
}

local group_id = api.nvim_create_augroup("LocalAutos", { clear = true })
api.nvim_create_autocmd(
	"FileType",
	{
		group = group_id,
		pattern = two_space_filetypes,
		command = [[setlocal ts=2 sts=2 sw=2 expandtab]],
	}
)

api.nvim_create_autocmd(
	{ "BufNewFile", "BufRead" },
	{
		group = group_id,
		pattern = { "*.vs", "*.fs" },
		command = "set ft=glsl",
	}
)

api.nvim_create_autocmd(
	{ "BufNewFile", "BufRead" },
	{
		group = group_id,
		pattern = { "*.md", "*.mdx" },
		command = "set ft=markdown",
	}
)

api.nvim_create_autocmd(
	"FileType",
	{
		group = group_id,
		pattern = { "glsl", "rescript", "c", "cpp" },
		command = [[setlocal commentstring=//\ %s]],
	}
)

api.nvim_create_autocmd(
	"FileType",
	{
		group = group_id,
		pattern = { "sql", "pgsql" },
		command = [[setlocal commentstring=--\ %s]],
	}
)
-- END FILETYPE

-- BEGIN THEME
vim.opt.termguicolors = true
-- vim.cmd("colorscheme gruvbox")
-- vim.g.gruvbox_contrast_dark = "medium"
--
-- require("tokyonight").setup({
-- 	style = "moon",
-- 	styles = {
-- 		comments = { italic = true },
-- 		keywords = { italic = false },
-- 		functions = { italic = false },
-- 		variables = { italic = false },
-- 	}
-- })
-- vim.cmd("colorscheme tokyonight-moon")

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
-- END THEME

-- BEGIN KEYMAPS
vim.keymap.set("i", "jk", "<Esc>")
vim.g.mapleader = ","

-- window traversal
vim.keymap.set("", "<C-j>", "<C-W>j")
vim.keymap.set("", "<C-k>", "<C-W>k")
vim.keymap.set("", "<C-h>", "<C-W>h")
vim.keymap.set("", "<C-l>", "<C-W>l")

-- window size
vim.keymap.set("", "H", "20<C-w><")
vim.keymap.set("", "L", "20<C-w>>")
vim.keymap.set("", "J", "20<C-w>+")
vim.keymap.set("", "K", "20<C-w>-")

-- window move
vim.keymap.set("", "<C-Space>h", "<C-w>R")
vim.keymap.set("", "<C-Space>j", "<C-w>r")
vim.keymap.set("", "<C-Space>k", "<C-w>R")
vim.keymap.set("", "<C-Space>l", "<C-w>r")

-- visual line traversal
vim.keymap.set("n", "j", "gj", { remap = true })
vim.keymap.set("n", "k", "gk", { remap = true })

-- enhanced text search
vim.keymap.set("n", "/", [[/\v]])
vim.keymap.set("v", "/", [[/\v]])

-- line style
vim.keymap.set("n", "<leader>rl", ":set rnu<cr>")
vim.keymap.set("n", "<leader>al", ":set nornu<cr>")

-- column limit/cut line
vim.keymap.set("n", "<leader>cl", ':execute "set colorcolumn=" . (&colorcolumn == "" ? "120" : "")<CR>')

-- telescope
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")

vim.keymap.set("n", "<leader>fmt", vim.lsp.buf.format)
-- ez delete
vim.keymap.set("n", "<leader>dd", "<cmd>call delete(expand('%'))<cr>")

-- END KEYMAPS

-- BEGIN PLUGIN CONFIGS
-- vim-go
vim.g.go_metalinter_command = "golangci-lint"
vim.g.go_imports_mode = 'gopls'
vim.g.go_gopls_local = 'github.com/gravitational/teleport'

-- vim-svelte
-- evanlecke
vim.g.svelte_preprocessor_tags = {
	{ name = "ts", tag = "script", as = "typescript" },
}
vim.g.svelte_preprocessors = { "ts" }

-- leafoftree
vim.g.vim_svelte_plugin_use_typescript = 1
vim.g.vim_svelte_plugin_load_full_syntax = 1
vim.g.vim_svelte_plugin_has_init_indent = 0

-- prettier
vim.g["prettier#config#parser"] = "typescript"
vim.g["prettier#autoformat"] = 1
vim.g["prettier#autoformat_require_pragma"] = 0
vim.g["prettier#quickfix_auto_focus"] = 0

-- postgres
vim.g.sql_type_default = 'pgsql'

-- rust
vim.g.rustfmt_autosave = 1

-- goyo
vim.g.goyo_linenr = 1


local telescope = require('telescope')
telescope.setup {
	defaults = { file_ignore_patterns = { "vendor", "deps", "_build", "target" } }
}

-- treesitter
require('nvim-treesitter.configs').setup({
	ensure_installed = { "c", "cpp", "lua", "go", "rust", "zig", "odin", "typescript", "tsx", "ocaml", "gleam", "vim", "glsl", "fish", "bash", "hcl", "markdown", "html", "css", "proto", "json", "sql", "templ" },
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

-- aerial
require("aerial").setup({
	on_attach = function(bufnr)
		vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
		vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
	end,
})
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")

-- Trouble
-- show diagnostics for the entire project
vim.keymap.set("n", "<leader>xa", "<cmd>Trouble diagnostics toggle<cr>")
-- show diagnostics for the current buffer
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>")

-- END PLUGIN CONFIGS
--
-- BEGIN LSP CONFIG
local nvim_lsp = require('lspconfig')
local cmp = require('cmp')

cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end
	},
	mapping = {
		['<C-Space>'] = cmp.mapping.complete(),
		['<Tab>'] = cmp.mapping.confirm({ select = true }),
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'buffer' },
	}
})

vim.api.nvim_create_augroup('AutoFormatting', {})

local lsp_format = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return true -- no LSPs being filtered right now
		end,
		bufnr = bufnr,
	})
end

local tscope_builtin = require("telescope.builtin")
local on_attach = function(client, buf)
	vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = buf })

	local bufopts = { noremap = true, silent = true, buffer = buf }
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', '<leader>i', tscope_builtin.lsp_implementations, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', 'gr', tscope_builtin.lsp_references, bufopts)

	vim.api.nvim_create_autocmd('BufWritePre', {
		buffer = buf,
		group = 'AutoFormatting',
		callback = function()
			lsp_format(buf)
		end,
	})
end

local lsps = {
	{
		name = "gopls",
		core = true,
		cfg = {
			settings = {
				analyses = {
					-- shadow = true,
					unusedvariable = true,
				},
				staticcheck = true,
				["local"] = "github.com/gravitational/teleport",
			},
		},
	},
	{
		name = "zls",
		core = true,
		cfg = {},
	},
	{
		name = "clangd",
		core = true,
		cfg = {
			cmd = { "clangd", "--log=verbose" }
		},
	},
	{
		name = "rust_analyzer",
		core = true,
		cfg = {},
	},
	{
		name = "ts_ls",
		core = true,
		cfg = {},
	},
	{
		name = "lua_ls",
		core = true,
		cfg = {
			on_init = function(client)
				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if path ~= vim.fn.stdpath('config') and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
						return
					end
				end

				client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
					runtime = {
						version = 'LuaJIT',
						path = {
							'lua/?.lua',
							'lua/?/init.lua',
						},
					},
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME
						},
					},
				})
			end,
			settings = {
				Lua = {},
			},
		},
	},
	{
		name = "terraformls",
		core = true,
		cfg = {},
	},
	{
		name = "pyright",
		core = true,
		cfg = {},
	},
	{
		name = "html",
		core = true,
		cfg = {},
	},
	{
		name = "cssls",
		core = true,
		cfg = {
			init_options = {
				provideFormatter = true,
			}
		},
	},
	{
		name = "marksman",
		core = true,
		cfg = {},
	},
	{
		name = "rescriptls",
		core = false,
		cfg = {
			cmd = { "node", HOME .. "/.vim/plugged/vim-rescript/extension/server/out/server.js", "--stdio" }
		},
	},
	{
		name = "svelte",
		core = false,
		cfg = {},
	},
	{
		name = "gleam",
		core = false,
		cfg = {},
	},
	{
		name = "ols",
		core = false,
		cfg = {},
	},
	{
		name = "nixd",
		core = false,
		cfg = {},
	},
	{
		name = "templ",
		core = false,
		cfg = {},
	},
	{
		name = "ocamllsp",
		core = false,
		cfg = {},
	},
	{
		name = "gdscript",
		core = false,
		cfg = {},
	},
}

-- flip this to false to enable all LSPs
local core_only = false

-- this is a function just because lua doesn't support continue statements...
local init_lsp = function(lsp)
	if core_only and not lsp.core then
		return
	end

	local cfg = lsp.cfg
	cfg.on_attach = on_attach
	if cfg.flags == nil then
		cfg.flags = {}
	end

	if cfg.flags.debounce_text_changes == nil then
		cfg.flags.debounce_text_changes = 150
	end

	cfg.capabilities = require("cmp_nvim_lsp").default_capabilities()


	nvim_lsp[lsp.name].setup(cfg)
end

for _, lsp in ipairs(lsps) do
	init_lsp(lsp)
end

-- DAP configurations
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

dap.adapters.lldb18 = {
	type = 'executable',
	command = '/usr/bin/lldb-dap-18',
	name = 'lldb18',
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.odin = dap.configurations.cpp
dap.configurations.zig = {
	{
		name = 'Launch',
		type = 'lldb18',
		request = 'launch',
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/zig-out/bin/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
		args = {},
	},
	{
		name = 'Attacdh to process',
		type = 'lldb18',
		request = 'attach',
		pid = require('dap.utils').pick_process,
		args = {},
	}
}

vim.keymap.set('n', '<leader>dc', function() dap.continue() end)
vim.keymap.set('n', '<leader>dj', function() dap.step_over() end)
vim.keymap.set('n', '<leader>dl', function() dap.step_into() end)
vim.keymap.set('n', '<leader>dh', function() dap.step_out() end)
vim.keymap.set('n', '<leader>b', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<leader>b', function() dap.toggle_breakpoint() end)

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

-- END LSP CONFIG
