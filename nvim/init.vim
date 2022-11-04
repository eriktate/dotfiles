filetype off
call plug#begin('~/.vim/plugged')

""" Tooling
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'bronson/vim-trailing-whitespace'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'wakatime/vim-wakatime'
Plug 'dag/vim-fish'
Plug 'APZelos/blamer.nvim'
Plug 'folke/trouble.nvim'
Plug 'ruanyl/vim-gh-line'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

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
Plug 'jparise/vim-graphql'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'eriktate/vim-protobuf'
Plug 'eriktate/vim-syntax-extra'
Plug 'evanleck/vim-svelte', { 'branch': 'main' }
Plug 'othree/html5.vim'
Plug 'lifepillar/pgsql.vim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'
Plug 'simrat39/rust-tools.nvim'
Plug 'NoahTheDuke/vim-just'

""" Visuals
Plug 'morhetz/gruvbox'
Plug 'Rigellute/shades-of-purple.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'

call plug#end()

filetype plugin indent on
syntax enable
set t_Co=256

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
" imap ht <Esc>
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
" colorscheme shades_of_purple
set background=dark
set termguicolors

" fzf config
let g:fzf_layout = { 'window': 'bot20new' }
autocmd! FileType fzf tnoremap <buffer> jk <cmd>bdelete!<CR>

" ctrl-p fuzzy file match
nnoremap <C-p> <cmd> Files<cr>
" nnoremap <C-p> <cmd> Telescope find_files<cr>
nnoremap <leader>ff <cmd> Telescope live_grep<cr>
nnoremap <leader>fb <cmd> Telescope .buffers<cr>

""" Default indention
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab

""" Filetype settings
autocmd! BufNewFile,BufRead *.vs, *.fs set ft=glsl
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype javascript.jsx setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype typescript setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype typescript.tsx setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype typescriptreact setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype svelte setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype rescript setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype html setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype glsl setlocal commentstring=//\ %s

""" CoC settings
" let g:coc_global_extensions = ['coc-tsserver', 'coc-prettier']
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

""" Telescope settings
command F Telescope live_grep

""" vim-svelte
let g:svelte_preprocessor_tags = [
	\ { 'name': 'ts', 'tag': 'script', 'as': 'typescript' }
	\ ]
let g:svelte_preprocessors = ['ts']

""" prettier config
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#exec_cmd_async = 1
let g:prettier#quickfix_auto_focus = 0

""" postgres
let g:sql_type_default = 'pgsql'

""" rust
let g:rustfmt_autosave = 1

""" NVIM LSP Config
lua << EOF
local telescope = require('telescope')
telescope.setup{
	defaults = { file_ignore_patterns = {"vendor"} },
}
telescope.load_extension('fzf')

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

local opts = { noremap=true, silent=true }

local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	local bufopts = { noremap=true, silent=true, buffer=bufnr }
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end

local servers = { 'tsserver', 'gopls', 'svelte', 'zls', 'rescriptls'}
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

local rt = require("rust-tools")
 rt.setup({
	server = {
		on_attach = on_attach,
		standalone = true,
	}
})
EOF
