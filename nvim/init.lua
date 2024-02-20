local api = vim.api

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
	{ "nvim-treesitter/nvim-treesitter", build=":TSUpdate" },
	"nvim-telescope/telescope.nvim",
	"neovim/nvim-lspconfig",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"tpope/vim-commentary",
	"tpope/vim-surround",
	"tpope/vim-repeat",
	"jiangmiao/auto-pairs",
	"airblade/vim-gitgutter",
	"tpope/vim-fugitive",
	"folke/trouble.nvim",
	{ "prettier/vim-prettier", build="yarn install --frozen-lockfile --production" },
	"wakatime/vim-wakatime",
	"APZelos/blamer.nvim",
	"mfussenegger/nvim-dap",
	"junegunn/goyo.vim",
	{ "stevearc/oil.nvim", opts = {}, dependencies = { "nvim-tree/nvim-web-devicons" } },
	"mfussenegger/nvim-dap",

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
	"Tetralux/odin.vim",

	-- visuals
	"morhetz/gruvbox",
	"nvim-lualine/lualine.nvim",
	"kyazdani42/nvim-web-devicons",
	"airblade/vim-gitgutter",
	"folke/tokyonight.nvim",
	"rebelot/kanagawa.nvim",
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
	"FileType",
	{
		group = group_id,
		pattern = {"glsl", "rescript", "c", "cpp"},
		command = [[setlocal commentstring=//\ %s]],
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

-- visual line traversal
vim.keymap.set("n", "j", "gj", { remap=true })
vim.keymap.set("n", "k", "gk", { remap=true })

-- enhanced text search
vim.keymap.set("n", "/", [[/\v]])
vim.keymap.set("v", "/", [[/\v]])

-- line style
vim.keymap.set("n", "<leader>rl", ":set rnu<cr>")
vim.keymap.set("n", "<leader>al", ":set nornu<cr>")

-- telescope
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")

-- ez delete
vim.keymap.set("n", "<leader>dd", "<cmd>call delete(expand('%'))<cr>")

-- END KEYMAPS

-- BEGIN PLUGIN CONFIGS
-- vim-svelte
vim.g.svelte_preprocessor_tags = {
	{ name = "ts", tag = "script", as = "typescript" },
}
vim.g.svelte_preprocessors = { "ts" }

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

-- treesitter
local treesitter = require('nvim-treesitter.configs')
treesitter.setup({
	ensure_installed = { "go", "rust", "c", "typescript", "tsx" },
	auto_install = true,
	ignore_install = { "javascript" },
	highlight = {
		enable = true,
	}
})

-- oil
require("oil").setup()

-- END PLUGIN CONFIGS

local telescope = require('telescope')
telescope.setup{
	defaults = { file_ignore_patterns = {"vendor", "deps", "_build", "target"} }
}

-- treesitter
require('nvim-treesitter.configs').setup({
	ensure_installed = { "c", "cpp", "lua", "go", "rust", "zig", "odin", "typescript", "ocaml", "vim", "glsl", "fish", "bash", "hcl", "markdown", "html", "css", "proto", "json", "sql"},
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
-- END PLUGIN CONFIGS
--
-- BEGIN LSP CONFIG
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

vim.api.nvim_create_augroup('AutoFormatting', {})

local on_attach = function(client, bufnr)
	api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', 'gr', require("telescope.builtin").lsp_references, bufopts)

	vim.api.nvim_create_augroup('AutoFormatting', {})
	vim.api.nvim_create_autocmd('BufWritePre', {
	  -- pattern = '*',
	  group = 'AutoFormatting',
	  callback = function()
		vim.lsp.buf.format()
	  end,
	})
end

local servers = { "tsserver", "gopls", "zls", "rescriptls", "rust_analyzer", "svelte", "tailwindcss", "terraformls", "pyright", "ols", "clangd", "ocamllsp"}
for _, lsp in ipairs(servers) do
	config = {
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150,
		},
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
	}

	-- if lsp == 'zls' then
	-- linux
	--	config.cmd = { "/home/erik/zls/zig-out/bin/zls" }
	-- macos
	--	config.cmd = { '/Users/ETate1/zls/zig-out/bin/zls' }
	-- end

	if lsp == "rescriptls" then
		config.cmd = {"node", "/home/erik/.vim/plugged/vim-rescript/extension/server/out/server.js", "--stdio"}
	end

	nvim_lsp[lsp].setup(config)
end

local dap = require('dap')
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

-- END LSP CONFIG
