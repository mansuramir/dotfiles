set number                    " Shows line numbers on the left.
set nocompatible              " Disables Vi compatibility mode to enable Vim’s full features.
syntax on                     " Enables syntax highlighting based on file type.
filetype plugin indent on     " Enables:
                              "     - filetype: detect file type
                              "     - plugin: load filetype-specific plugins
                              "     - indent: enable indentation rules per filetype
set tabstop=2                 " Sets the number of spaces that a <Tab> character equates to.
set shiftwidth=2              " Sets the number of spaces used for each step of (auto)indent.
set expandtab                 " Converts tabs to spaces.
set autoindent                " Uses the indent from the previous line when starting a new line.
set smartindent               " Smart autoindenting based on syntax.
set clipboard=unnamedplus     " Integrates Vim with the system clipboard (use y and p for system copy/paste).
set mouse=a                   " Enables mouse support in all modes.
set hidden                    " Allows you to switch buffers without saving.
set incsearch                 " Highlights matches while typing the search.
set ignorecase                " Ignores case when searching…
set smartcase                 " …unless the search pattern contains uppercase letters.

" These options clean up the home directory
set viminfofile=$HOME/.config/vim/viminfo
set runtimepath^=$HOME/.config/vim

" Leader key
let mapleader="\<Space>"

" Displays a warning if Node.js is not installed, which coc.nvim depends on.
if empty(exepath('node'))
  echohl WarningMsg
  echom "Node.js is not installed. coc.nvim requires Node.js (https://nodejs.org)"
  echohl None
endif

" Auto-installs vim-plug if it's not present, then installs the plugins on first run.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.vim/plugged')
" auto-inserts closing brackets/quotes.
Plug 'jiangmiao/auto-pairs'
" powerful language server and auto-completion framework.
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" file tree explorer.
Plug 'preservim/nerdtree'
" git integration.
Plug 'tpope/vim-fugitive'
" shows git diff info in the gutter.
Plug 'airblade/vim-gitgutter'
" statusline plugin.
Plug 'itchyny/lightline.vim'
" syntax highlighting for many languages.
Plug 'sheerun/vim-polyglot'
" comment/uncomment lines using gcc or gc.
Plug 'tpope/vim-commentary'
" Dracula color scheme.
Plug 'dracula/vim', { 'as': 'dracula' }
" Shades of Purple theme.
Plug 'Rigellute/shades-of-purple.vim'
call plug#end()

" Lightline with git status & Powerline Seperators
let g:lightline = {
  \ 'colorscheme': 'shades_of_purple',
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' },
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead'
  \ }
  \ }

" Always show the status line (0 = never, 1 = only if more than one window).
set laststatus=2

" enable 24bit true color
if (has("termguicolors"))
 set termguicolors
endif

" Applies the Dracula color scheme.
colorscheme shades_of_purple

" Toggle NERDTree with <Space>fe.
nnoremap <silent> <Leader>fe :NERDTreeToggle<CR>
" Move focus between splits with Ctrl-h and Ctrl-l.
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-l> :wincmd l<CR>

" Enables GitGutter by default (shows changes in the gutter).
let g:gitgutter_enabled = 1

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use Tab for completion (if popup is visible), otherwise insert a tab
inoremap <silent><expr> <Tab>
  \ pumvisible() ? coc#_select_confirm() :
  \ "\<Tab>"

" Use Shift-Tab to go to previous item in the popup
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"

" Auto install language servers (Rust, JS, HTML)
let g:coc_global_extensions = [
  \ 'coc-rust-analyzer',
  \ 'coc-tsserver',
  \ 'coc-html'
  \ ]

" Auto-sources .vimrc whenever you save it.
autocmd BufWritePost *.vim source $MYVIMRC
" Shortens the idle time before triggering things like GitGutter or CursorHold events.
set updatetime=300
" Reduces verbosity in messages, especially related to completion.
set shortmess+=c
