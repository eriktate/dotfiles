set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
" Language and Syntax Support
Plugin 'fatih/vim-go'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'ElmCast/elm-vim'
Plugin 'hashivim/vim-terraform'
Plugin 'rust-lang/rust.vim'
Plugin 'tikhomirov/vim-glsl'
Plugin 'shiracamus/vim-syntax-x86-objdump-d'
" Plugin 'eriktate/zig.vim'
Plugin 'ziglang/zig.vim'
Plugin 'eriktate/vim-syntax-extra'
Plugin 'eriktate/vim-svelte'
Plugin 'eriktate/vim-protobuf'
Plugin 'reasonml-editor/vim-reason-plus'
Plugin 'cespare/vim-toml'
Plugin 'elixir-editors/vim-elixir'

" Tooling and Completions
Plugin 'dense-analysis/ale'
Plugin 'racer-rust/vim-racer'
Plugin 'prettier/vim-prettier', { 'do': 'yarn install' }
Plugin 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plugin 'junegunn/fzf.vim'
Plugin 'diepm/vim-rest-console'
Plugin 'majutsushi/tagbar'
Plugin 'neoclide/coc.nvim', { 'branch': 'release' }
" Plugin 'Shougo/deoplete.nvim'
" Plugin 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh', }
" Plugin 'zchee/deoplete-jedi'
" Plugin 'deoplete-plugins/deoplete-clang'

" Editing Extensions
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'easymotion/vim-easymotion'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'jiangmiao/auto-pairs'
Plugin 'junegunn/goyo.vim'
Plugin 'alvan/vim-closetag'

" Themes
Plugin 'morhetz/gruvbox'

call vundle#end()

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
autocmd Filetype typescript setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype reason setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype css setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype scss setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype html setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype elm setlocal ts=4 sts=4 sw=4 expandtab
autocmd Filetype terraform setlocal commentstring=#%s
autocmd Filetype c setlocal commentstring=//\ %s
autocmd Filetype cpp setlocal commentstring=//\ %s
autocmd Filetype glsl setlocal commentstring=//\ %s
autocmd Filetype reason setlocal commentstring=//\ %s
autocmd FileType svelte setlocal formatoptions+=ro commentstring=//\ %s

""" Set language and encoding
set encoding=utf-8
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

""" Preferred escape
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

" File search
nmap <C-p> :Files<cr>

" Working with windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

""" NERDTree stuff
" map <C-n> :NERDTreeToggle<CR>
" let NERDTreeShowBookmarks = 1
" let NERDTreeChDirMode = 2

""" Gruvbox
let g:gruvbox_contrast_dark = 'medium'
colorscheme gruvbox

set background=dark
set termguicolors

""" Settings for editing Jenkinsfiles
au BufReadPost Jenkinsfile set syntax=groovy
au BufReadPost Jenkinsfile set filetype=groovy

""" Deoplete
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#disable_auto_complete = 1
" let g:deoplete#auto_complete_delay = 147

" Enable tab completion for deoplete
" inoremap <expr><TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : deoplete#mappings#manual_complete()
" function! s:check_back_space() "{{{
" 	let col = col('.') - 1
" 	return !col || getline('.')[col - 1] =~ '\s'
" endfunction"}}}

""" CoC
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Launch gopls when Go files are in use
let g:LanguageClient_serverCommands = {
	\ 'go': ['gopls'],
	\ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
	\ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
	\ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
	\ 'python': ['/usr/local/bin/pyls'],
	\ 'reason': ['/usr/bin/reason-language-server'],
	\ }

""" Go Stuff
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 0
let g:go_updatetime = 500
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

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
	\ 'go': ['gopls', 'gofmt', 'golangci-lint'],
	\ 'jsx': ['eslint'],
	\ 'svelte': ['svelte-check'],
	\ }

let g:ale_linter_aliases = {'jsx': 'css'}
let g:ale_go_golangci_lint_options = ''
let g:ale_go_golangci_lint_package = 1

""" Statusline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
set laststatus=2
set noshowmode

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
" let g:deoplete#sources#clang#libclang_path='/usr/lib/llvm-10/lib/libclang.so'

""" GLSL
autocmd! BufNewFile,BufRead *.vs,*.fs,*.vertex,*.fragment set ft=glsl

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

""" Binary/Hex
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END

""" NASM
au BufRead,BufNewFile *.asm set filetype=nasm

""" FZF
let g:rg_command = ' rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always" -g "*.{js,json,md,html,config,py,cpp,c,cs,h,hpp,rs,elm,jsx,toml,go,hs,rb,conf,tf,yml,ts,vim,re,svelte}" -g "!{.git,node_modules,vendor,.DS_Store,target,build,obj}" -g "!*.{bs.js}" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

""" VRC
let g:vrc_curl_opts = { '--connect-timeout' : 10, '-b': '/path/to/cookie', '-c': '/path/to/cookie', '-L': '', '-i': '', '--max-time': 60, '--ipv4': '', '-k': '', '-s': '',}

""" Reason format on save
autocmd BufWritePre *.re :call LanguageClient#textDocument_formatting_sync()

" let g:svelte_preprocessors = ['typescript', 'scss']

""" Svelte
let g:svelte_preprocessor_tags = [
  \ { 'name': 'ts', 'tag': 'script', 'as': 'typescript' }
  \ ]

let g:svelte_preprocessors = ['ts', 'scss', 'sass']

