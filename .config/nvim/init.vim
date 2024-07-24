set number
set paste
set autoindent
set tabstop=2
set shiftwidth=2
set smarttab
set softtabstop=2
set belloff=all

" enable CTRL+C for copying text to system clipboard
nnoremap <C-c> "+y
vnoremap <C-c> "+y

" set default register to unnamed plus
set clipboard=unnamedplus

call plug#begin()

Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/preservim/nerdtree' " NERDTree
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation


call plug#end()


" :NERDTree Customizations
nnoremap <C-n> :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"


" :Tagbar
nmap <F8> :TagbarToggle<CR>

" Enter insert mode on startup
autocmd VimEnter * startinsert
