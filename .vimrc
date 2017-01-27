set nocompatible
filetype off
syntax on
filetype plugin indent on
set modelines=0
set number
set ruler
set visualbell
set tabstop=4
set shiftwidth=4
set softtabstop=4
set wrap
set expandtab
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

map <D-j> <C-W>j
map <D-k> <C-W>k
map <D-h> <C-W>h
map <D-l> <C-W>l

nnoremap <D-[> :bp
nnoremap <D-]> :bn

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/vim-fugitive'
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
Bundle 'morhetz/gruvbox'

call vundle#end()

filetype plugin indent on

" NERDTree stuff
map <C-n> :NERDTreeTabsToggle<CR>
autocmd VimEnter * NERDTreeTabsOpen
let g:nertdtree_tabs_open_on_console_startup = 1
let NERDTreeShowBookmarks = 1


colorscheme gruvbox
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

"Vim Go
let g:go_fmt_command = "goimports"
map <leader>d :GoDef<CR>

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
