""" START PLUGIN CONFIGS
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'fatih/vim-go'
Plugin 'airblade/vim-gitgutter'
Plugin 'Shougo/neocomplete'
Plugin 'OmniSharp/omnisharp-vim'
Plugin 'tpope/vim-dispatch'
Plugin 'bling/vim-airline'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'leafgarland/typescript-vim'
Plugin 'ternjs/tern_for_vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'majutsushi/tagbar'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'jiangmiao/auto-pairs'
Bundle 'morhetz/gruvbox'

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
set wrap
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

" Whitespace settings (defaults)
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab

" Whitespace settings (filetype)
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype html setlocal ts=2 sts=2 sw=2 expandtab

" Set language and encoding
set encoding=utf-8
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Map esc to jk
imap jk <Esc>

" Map <leader> to ','
let mapleader = ","
let g:mapleader = ","

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
set magic
map <leader><space> :let @/=''<cr> " clear search

" Show tabs/newlines in editor
set listchars=tab:▸\ ,eol:¬
set list

" Move up and down visual lines (works well with wrapping)
nnoremap j gj
nnoremap k gk

" Change line style (rnu = relativenumber)
nmap <leader>rl :set rnu<cr>
nmap <leader>al :set nornu<cr>

" Working with windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

nmap <S-Down> :res -16<cr>
nmap <S-Up> :res +16<cr>
nmap <S-Left> :vertical resize -16<cr>
nmap <S-Right> :vertical resize +16<cr>

" NERDTree stuff
map <C-n> :NERDTreeTabsToggle<CR>
let g:nertdtree_tabs_open_on_console_startup = 1
let NERDTreeShowBookmarks = 1
let NERDTreeChDirMode = 2

" Set colorscheme
colorscheme gruvbox
set background=dark

" Settings for editing Jenkinsfiles
au BufReadPost Jenkinsfile set syntax=groovy
au BufReadPost Jenkinsfile set filetype=groovy

" Settings for using riot.js with typescript.
au BufNewFile,BufRead *.tag set ft=typescript
au BufNewFile,BufRead *.tag set syntax=typescript

"Neocomplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.cs = '.*[^=\);]'

""" Vim Go
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 0
let g:go_updatetime = 500

" Show references to the current token
autocmd FileType go nmap gr <Plug>(go-referrers)

" Variations of go-to-declaration
autocmd FileType go nmap <leader>ds <Plug>(go-def-split)
autocmd FileType go nmap <leader>dv <Plug>(go-def-vertical)
autocmd FileType go nmap <leader>dt <Plug>(go-def-tab)

" Show implemented interfaces of type under cursor
autocmd FileType go nmap <leader>s <Plug>(go-implements)
autocmd FileType go nmap <leader>i <Plug>(go-info)

" Statusline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
set laststatus=2

""" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_go_checkers = ['gometalinter']
let g:syntastic_go_gometalinter = "--vendor, --disable-all, --enable=vet, --enable=golint, --enable=ineffassign, --enable=gocyclo, --json, ."
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

""" Tagbar
nmap <leader>t :TagbarToggle<CR>

""" Autopairs
let g:AutoPairsCenterLine = 0

""" Javascript
let g:jsx_ext_required = 0

""" CtrlP
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git|vendor'

""" Omnisharp
let g:OmniSharp_server_type = 'roslyn'
let g:Omnisharp_start_server = 0
let g:Omnisharp_stop_server = 0
