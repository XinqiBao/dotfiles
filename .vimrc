syntax enable
"colorscheme wombat256mod
set background=dark

"In order to display chinese in GBK
let &termencoding=&encoding
set fileencodings=utf-8,gbk

set t_Co=256 "terminal color
set t_ut=""
"set term=xterm-256color
set encoding=utf-8 "required for ycm
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set backspace=indent,eol,start
set number
set nowrap
set smartcase
set incsearch
set hlsearch
set ignorecase
set cursorline
set autochdir
set mouse=a
set showtabline=2
set laststatus=2 "always show status line
set noshowmode
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
"change kernel version to your version, for kernel development
set path=.,lib;,include;,includes;
set path+=/lib/modules/5.4.46-1-lts/build/include
set path+=/lib/modules/5.4.46-1-lts/build/arch/x86/include
set path+=/usr/include,/usr/include/c++/*
set path+=/usr/local/include
set path+=~/lib


" Writes to the unnamed register also writes to the * and + registers. This
" makes it easy to interact with the system clipboard
if has ('unnamedplus')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

call plug#begin()

Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

Plug 'morhetz/gruvbox'
Plug 'ycm-core/YouCompleteMe'
Plug 'kien/ctrlp.vim'
Plug 'mbbill/undotree'

Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'rhysd/vim-clang-format'
Plug 'ludovicchabant/vim-gutentags'
Plug 'plasticboy/vim-markdown'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

colorscheme gruvbox

"tabline with airline
":help airline-tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#show_close_button = 0

autocmd StdinReadPre * let s:std_in=1
"when vim openning with no file, open NERDTree
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_use_caching = 0

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_always_populate_location_list = 1
"let g:ycm_show_diagnostics_ui = 0
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_auto_hover = 'no'

let mapleader = " "
nnoremap J :tabprevious<CR>
nnoremap K :tabnext<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <silent> <Leader>+ :resize +5<CR>
nnoremap <silent> <Leader>- :resize -5<CR>
nnoremap <silent> <Leader>v+ :vertical resize +5<CR>
nnoremap <silent> <Leader>v- :vertical resize -5<CR>

nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <leader>gr :YcmCompleter GoToReferences<CR>

"HighLight trailing whitespace"
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

"use powerline-vim for normal use
"instead of installing for both user and root
"run to install lib: pip3 install --user powerline-status
"python3 from powerline.vim import setup as powerline_setup
"python3 powerline_setup()
"python3 del powerline_setup
