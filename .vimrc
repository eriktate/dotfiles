""" START PLUGIN CONFIGS
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'scrooloose/nerdtree'
Plugin 'w0rp/ale'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'fatih/vim-go'
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'easymotion/vim-easymotion'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'majutsushi/tagbar'
Plugin 'jiangmiao/auto-pairs'
Plugin 'ElmCast/elm-vim'
Plugin 'hashivim/vim-terraform'
Plugin 'junegunn/goyo.vim'
Plugin 'kylef/apiblueprint.vim'
Plugin 'cespare/vim-toml'
Plugin 'alvan/vim-closetag'
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'
Plugin 'tikhomirov/vim-glsl'
Plugin 'elixir-editors/vim-elixir'
Plugin 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plugin 'junegunn/fzf.vim'
Plugin 'alx741/vim-hindent'
Plugin 'justinmk/vim-syntax-extra'
Plugin 'udalov/kotlin-vim'

" Completion support
if has('nvim')
	Plugin 'Shougo/deoplete.nvim'
	Plugin 'zchee/deoplete-go', {'do': 'make'}
	Plugin 'tweekmonster/deoplete-clang2'
	Plugin 'neovimhaskell/haskell-vim'
else
	Plugin 'Shougo/deoplete.nvim'
	Plugin 'zchee/deoplete-go', {'do': 'make'}
	Plugin 'roxma/nvim-yarp'
	Plugin 'roxma/vim-hug-neovim-rpc'
endif

Bundle 'morhetz/gruvbox'
Bundle 'eriktate/vim-protobuf'

call vundle#end()

""" GUI CONFIGS
if has("gui_running")
	set guifont=monofur_for_Powerline:h11
	" Hide menubar
	set guioptions -=m
	" Hide right scroll
	set guioptions -=r
	" Hide left scroll
	set guioptions -=L
	" Hide toolbar
	set guioptions -=T
	set mouse=
endif

""" NATIVE VIM CONFIGS
set nocompatible
syntax on
filetype plugin indent on
set modelines=0
set number
set ruler
set visualbell
set wrap linebreak nolist
set noshiftround
set splitright
set splitbelow
set hidden
set ttyfast
set laststatus=2
set showmode
set showcmd
set autoread
set so=7
set hid
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set backupcopy=yes

""" Whitespace settings (defaults)
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab

""" Filetype settings
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype javascript.jsx setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype html setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype elm setlocal ts=4 sts=4 sw=4 expandtab
autocmd Filetype haskell setlocal ts=4 sts=4 sw=4 expandtab
autocmd Filetype terraform setlocal commentstring=#%s
autocmd Filetype c setlocal commentstring=//\ %s
autocmd Filetype cpp setlocal commentstring=//\ %s
autocmd Filetype glsl setlocal commentstring=//\ %s

""" Set language and encoding
set encoding=utf-8
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

""" Map esc to jk
imap jk <Esc>

""" Map <leader> to ','
let mapleader = ","
let g:mapleader = ","

""" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
set magic
map <leader><space> :let @/=''<cr> " clear search

""" Show tabs/newlines in editor
set listchars=tab:▸\ ,eol:¬
set list

""" Move up and down visual lines (works well with wrapping)
nnoremap j gj
nnoremap k gk

""" Change line style (rnu = relativenumber)
nmap <leader>rl :set rnu<cr>
nmap <leader>al :set nornu<cr>
nmap <C-p> :Files<cr>

" File search
nmap <C-p> :Files<cr>

" Working with windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

""" NERDTree stuff
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowBookmarks = 1
let NERDTreeChDirMode = 2

""" Set colorscheme
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
set background=dark
set termguicolors

""" Settings for editing Jenkinsfiles
au BufReadPost Jenkinsfile set syntax=groovy
au BufReadPost Jenkinsfile set filetype=groovy

""" Deocomplete
let g:deoplete#enable_at_startup = 1


""" Go Stuff
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 0
let g:go_updatetime = 500

" Show references to the current token
autocmd FileType go nmap gr <Plug>(go-referrers)

""" Variations of go-to-declaration
autocmd FileType go nmap <leader>ds <Plug>(go-def-split)
autocmd FileType go nmap <leader>dv <Plug>(go-def-vertical)
autocmd FileType go nmap <leader>dt <Plug>(go-def-tab)

""" Show implemented interfaces of type under cursor
autocmd FileType go nmap <leader>s <Plug>(go-implements)
autocmd FileType go nmap <leader>i <Plug>(go-info)

""" ALE
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1
let g:ale_linters = {
\	'go': ['gometalinter', 'gofmt'],
\	'jsx': ['eslint']
\}

let g:ale_linter_aliases = {'jsx': 'css'}

let g:ale_go_gometalinter_options = '--fast'

""" Statusline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
set laststatus=2

""" Tagbar
nmap <leader>t :TagbarToggle<CR>

""" Autopairs
let g:AutoPairsCenterLine = 0

""" Javascript
" would prefer for this to be 1.
let g:jsx_ext_required = 0

""" Elm
let g:elm_format_autosave = 1

""" Terraform
let g:terraform_align=1

""" Protobuf
augroup filetype
  au! BufRead,BufNewFile *.proto setfiletype proto
augroup end

""" Goyo
nmap <leader>df :Goyo<cr>

""" Markdown
autocmd BufEnter *.md exe 'noremap <F5> :!open -a "Google Chrome" %:p<CR>'
autocmd BufEnter *.md exe ''

""" HTML
let g:html_indent_inctags = "main,p"

""" C
"let g:clang_library_path='/usr/lib/libclang.so.4.0'
let g:deoplete#sources#clang#libclang_path='/usr/lib/libclang.so'

""" GLSL
autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glsl

""" Rust
let g:rustfmt_autosave = 1
set hidden " Not sure if I need this
let g:racer_cmd = "~/.cargo/bin/racer"
let g:racer_experimental_completer = 1

" Goto def for rust
autocmd FileType rust nmap <leader>gd <Plug>(rust-def)
autocmd FileType rust nmap <leader>gs <Plug>(rust-def-vertical)

""" Haskell
let g:hindent_on_save = 1
let g:hindent_indent_size = 4

let g:haskell_indent_guard = 4

""" FZF
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,md,html,config,py,cpp,c,h,hpp,rs,elm,jsx,toml,go,hs,rb,conf}"
  \ -g "!{.git,node_modules,vendor,.DS_Store}/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
