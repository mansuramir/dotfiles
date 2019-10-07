call plug#begin()

Plug 'kaicataldo/material.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'connorholyday/vim-snazzy'

" Langguages plugin supports
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

call plug#end()

set number
set tabstop=2
set softtabstop=2
set expandtab


" to easily jump to files
set hidden
set path+=**

if (has('nvim'))
        let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

if (has('termguicolors'))
        set termguicolors
endif

" colourscheme
let g:material_terminal_italics = 1
let g:material_theme_style = 'palenight'
" colorscheme material

colorscheme snazzy

" airline config
let g:airline_powerline_fonts = 1



" Languages specific settings
let g:rustfmt_autosave = 1
