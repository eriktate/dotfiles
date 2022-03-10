filetype off
call plug#begin('~/.vim/plugged')

""" Tooling
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'bronson/vim-trailing-whitespace'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'mfussenegger/nvim-dap'
Plug 'folke/trouble.nvim'

""" Language plugins
Plug 'fatih/vim-go'
Plug 'hashivim/vim-terraform'
Plug 'rust-lang/rust.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'shiracamus/vim-syntax-x86-objdump-d'
Plug 'ziglang/zig.vim'
Plug 'cespare/vim-toml'
Plug 'elm-tooling/elm-vim'
Plug 'rescript-lang/vim-rescript'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'jparise/vim-graphql'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'eriktate/vim-protobuf'
Plug 'eriktate/vim-syntax-extra'
Plug 'evanleck/vim-svelte'
Plug 'udalov/kotlin-vim'

""" Visuals
Plug 'morhetz/gruvbox'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'

call plug#end()

filetype plugin indent on
syntax enable

set encoding=utf-8
set autoindent
set backspace=indent,eol,start
set complete-=1
set smarttab
set nrformats-=octal
set ttimeout
set ttimeoutlen=100
set incsearch
set laststatus=2
set number
set ruler
set list
set wildmenu
set autoread
set scrolloff=5
set sidescrolloff=5
set display+=lastline
set listchars=tab:▸\ ,eol:¬,trail:-,extends:>,precedes:<,nbsp:+
set sessionoptions-=options
set viewoptions-=options
set whichwrap+=<,>,h,l
set linebreak
set splitright
set splitbelow

imap jk <Esc>
let mapleader = ","
let g:mapleader = ","

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set magic
map <leader><space> :let @/=''<cr> " clear search

""" Move up and down visual lines (works well with wrapping)
nnoremap j gj
nnoremap k gk

""" Change line style (rnu = relativenumber)
nmap <leader>rl :set rnu<cr>
nmap <leader>al :set nornu<cr>

" Working with windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

""" Theme
let g:gruvbox_contrast_dark = 'medium'
colorscheme gruvbox
set background=dark
set termguicolors

""" Telescope
" ctrl-p fuzzy file match
" nnoremap <C-p> :lua require("telescope.builtin").find_files({find_command={"rg", "--no-ignore", "--files", "--hidden", "--follow"}})<cr>
nnoremap <C-p> <cmd> Telescope find_files<cr>
nnoremap <leader>ff <cmd> Telescope live_grep<cr>
nnoremap <leader>fb <cmd> Telescope .buffers<cr>

""" Default indention
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab

""" Filetype settings
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype javascript.jsx setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype typescript setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype typescript.tsx setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype typescriptreact setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype svelte setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype rescript setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype html setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype python setlocal ts=4 sts=4 sw=4 expandtab

" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

""" Telescope settings
command F Telescope live_grep

""" vim-svelte
let g:svelte_preprocessor_tags = [
	\ { 'name': 'ts', 'tag': 'script', 'as': 'typescript' }
	\ ]
let g:svelte_preprocessors = ['ts']


""" NVIM LSP Config
lua << EOF
local nvim_lsp = require('lspconfig')
local cmp = require('cmp')

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end
	},
	mapping = {
		['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 'c'}),
		['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 'c'}),
		['<Tab>'] = cmp.mapping.confirm({ select = true }),
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'buffer' },
	}
})

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	local opts = { noremap=true, silent=true }

	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
	-- vim.api.nvim_command('autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 5000)', opts)
end

local servers = { 'rust_analyzer', 'tsserver', 'gopls', 'pylsp' }
for _, lsp in ipairs(servers) do
	cfg = {
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150,
		},
		capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	}

	if lsp == 'pylsp' then
		-- cfg.cmd = { "pipenv", "run", "pylsp" }
		cfg.settings = {
			pylsp = {
				plugins = {
					pylint = {
						enabled = true,
						executable = "pipenv",
						-- args = { "pylint", "run" } -- these are flipped for some reason...?
						args = { "run", "pylint" } -- ...or not...?
					}
				}
			}
		}

		-- print(vim.inspect(cfg))
	end

	nvim_lsp[lsp].setup(cfg)
end

EOF
