syntax enable           " enable syntax processing
"colorscheme badwolf
"set termguicolors
colorscheme elflord


set number          " show line numbers
set showcmd             " show command in bottom bar
" set cursorline          " highlight current line

filetype indent on      " load filetype-specific indent files
set shiftwidth=4
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing

set wildmenu            " visual autocomplete for command menu
set showmatch           " highlight matching [{()}]
set incsearch           " search as characters are entered
set hlsearch            " highlight matches

call plug#begin()
Plug 'lervag/vimtex'
Plug 'tpope/vim-sensible'
call plug#end()
" &runtimepath
" autocmd VimEnter * nohlsearch ^d
map 1 :nohlsearch
