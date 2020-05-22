syntax enable
"colorscheme wombat256mod
set background=dark

set t_Co=256 "terminal color
set encoding=utf-8 "required for ycm
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set number
set nowrap
set smartcase
set incsearch
set hlsearch
set ignorecase
set cursorline
set autochdir
set mouse=a
set laststatus=2 "always show status line
set wildmenu

" Turn backup off
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.vim/undodir
set undofile

"ColumnLimit
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

set tags=tags~;,tags~
"setting gf (go file) path
set path+=/usr/include/c++/*,include;,includes;,lib;


call plug#begin()

Plug 'morhetz/gruvbox'
Plug 'ycm-core/YouCompleteMe'
Plug 'kien/ctrlp.vim'
Plug 'mbbill/undotree'

Plug 'preservim/nerdtree'
Plug 'rhysd/vim-clang-format'
Plug 'ludovicchabant/vim-gutentags'
Plug 'plasticboy/vim-markdown'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

colorscheme gruvbox

autocmd StdinReadPre * let s:std_in=1
"when vim openning with no file, open NERDTree
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_use_caching = 0

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_always_populate_location_list = 1

let mapleader = " "
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>v :NERDTreeToggle<CR>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <leader>gr :YcmCompleter GoToReferences<CR>

"HighLight trailing whitespace"
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

"use powerline-vim for normal use
"instead of installing for both user and root
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
