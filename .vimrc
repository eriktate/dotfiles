set nocompatible
filetype off
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
nnoremap j gj
nnoremap k gk

" Change line style (rnu = relativenumber)
nmap <leader>rl :set rnu<cr>
nmap <leader>al :set nornu<cr>

" Working with windows/buffers/tabs
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

""" START PLUGIN CONFIGS
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'fatih/vim-go'
Plugin 'airblade/vim-gitgutter'
Plugin 'Shougo/neocomplete'
Plugin 'bling/vim-airline'
Plugin 'pangloss/vim-javascript'
Plugin 'easymotion/vim-easymotion'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'vim-airline/vim-airline-themes'
Bundle 'morhetz/gruvbox'

call vundle#end()

filetype plugin indent on

" NERDTree stuff
map <C-n> :NERDTreeTabsToggle<CR>
autocmd VimEnter * NERDTreeTabsOpen
let g:nertdtree_tabs_open_on_console_startup = 1
let NERDTreeShowBookmarks = 1
let NERDTreeChDirMode = 2

" Set colorscheme
colorscheme gruvbox
set background=dark

au BufReadPost Jenkinsfile set syntax=groovy
au BufReadPost Jenkinsfile set filetype=groovy

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


""" Vim Go
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
let g:go_updatetime = 500
" Variations of go-to-declaration
autocmd FileType go nmap <leader>ds <Plug>(go-def-split)
autocmd FileType go nmap <leader>dv <Plug>(go-def-vertical)
autocmd FileType go nmap <leader>dt <Plug>(go-def-tab)
" Show implemented interfaces of type under cursor
autocmd FileType go nmap <leader>s <Plug>(go-implements)

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
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

