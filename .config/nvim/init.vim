syntax enable
let mapleader=" "

set background=dark
set termguicolors
set t_Co=256 "terminal color
set t_ut=""
"set term=xterm-256color

"In order to display chinese in GBK
let &termencoding=&encoding
set fileencodings=utf-8,gbk
set fileformat=unix
set foldmethod=manual
set encoding=utf-8 "required for ycm

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set backspace=indent,eol,start

set number
set nowrap
set signcolumn=auto
set smartcase
set incsearch
set hlsearch
set ignorecase
set cursorline
set conceallevel=0
set showtabline=2
set laststatus=2 "always show status line
set noshowmode
set wildmenu

set mouse=a
set autochdir
set updatetime=300
set noerrorbells

" Turn backup off
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.cache/nvim/undodir
set undofile

set tags=tags~;,tags~
"setting gf (go file) path
"change kernel version to your version, for kernel development
set path=.,lib;,include;,includes;
set path+=/usr/include,/usr/include/c++/*
set path+=/usr/local/include

"ColumnLimit
set colorcolumn=120
highlight ColorColumn ctermbg=0 guibg=lightgrey

" Writes to the unnamed register also writes to the * and + registers. This
" makes it easy to interact with the system clipboard
if has ('unnamedplus')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

call plug#begin()
    Plug 'morhetz/gruvbox'
    Plug 'Yggdroot/indentLine'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'vim-airline/vim-airline'
    "Plug 'vim-airline/vim-airline-themes'

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'ludovicchabant/vim-gutentags'

    Plug 'mbbill/undotree'
    Plug 'preservim/nerdtree'
    Plug 'plasticboy/vim-markdown'

    Plug 'tpope/vim-fugitive'
    Plug 'kdheepak/lazygit.nvim'

    "Plug 'ycm-core/YouCompleteMe'
    "Plug 'rhysd/vim-clang-format'

    Plug 'neoclide/coc.nvim'

    Plug 'nvim-treesitter/nvim-treesitter'
    "Plug 'mfussenegger/nvim-dap'
    "Plug 'puremourning/vimspector'
call plug#end()

"----------------------
" gruvbox setting
"----------------------
if has_key(plugs, 'gruvbox')
    colorscheme gruvbox
endif

"----------------------
" vim-airline setting
"----------------------
if has_key(plugs, 'vim-airline')
    "tabline with airline
    ":help airline-tabline
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#show_buffers = 0
    let g:airline#extensions#tabline#show_splits = 0
    let g:airline#extensions#tabline#show_tab_count = 0
    let g:airline#extensions#tabline#show_close_button = 0
endif

"----------------------
" fzf.vim setting
"----------------------
if has_key(plugs, 'fzf.vim')
    "mapping for fzf.vim
    nnoremap <C-p> :GFiles<CR>
    "as default <C-f>/<C-b> pair used to page down/up entire page
    nnoremap <C-f> :Tags<CR>
endif

"----------------------
" undotree setting
"----------------------
if has_key(plugs, 'undotree')
    nnoremap <leader>u :UndotreeShow<CR>
endif

"----------------------
" nerdtree setting
"----------------------
if has_key(plugs, 'nerdtree')
    autocmd StdinReadPre * let s:std_in=1
    "when vim openning with no file, open NERDTree
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    nnoremap <leader>n :NERDTreeToggle<CR>
endif

"----------------------
" YouCompleteMe setting
"----------------------
if has_key(plugs, 'YouCompleteMe')
    let g:ycm_global_ycm_extra_conf = '~/.config/nvim/ycm_extra_conf.py'
    let g:ycm_confirm_extra_conf = 0
    let g:ycm_enable_diagnostic_signs = 0
    let g:ycm_always_populate_location_list = 1
    "let g:ycm_show_diagnostics_ui = 0
    let g:ycm_add_preview_to_completeopt = 1
    let g:ycm_autoclose_preview_window_after_completion = 1
    let g:ycm_auto_hover = 'no'

    nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
    nnoremap <silent> <leader>gr :YcmCompleter GoToReferences<CR>
endif

"----------------------
" coc.vim setting
"----------------------
if has_key(plugs, "coc.nvim")
    " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
    nmap <silent> <leader>g[ <Plug>(coc-diagnostic-prev)
    nmap <silent> <leader>g] <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> <leader>gd <Plug>(coc-definition)
    nmap <silent> <leader>gr <Plug>(coc-references)
    nmap <silent> <leader>gy <Plug>(coc-type-definition)
    nmap <silent> <leader>gi <Plug>(coc-implementation)

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    " Formatting selected code.
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    " Apply AutoFix to problem on the current line.
    nmap <leader>qf  <Plug>(coc-fix-current)

    " clangd
    nmap <leader>gh :CocCommand clangd.switchSourceHeader<CR>

    " Use K to show documentation in preview window.
    nnoremap <silent> <leader>h :call <SID>show_documentation()<CR>
    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
      else
        execute '!' . &keywordprg . " " . expand('<cword>')
      endif
    endfunction

    let g:coc_default_semantic_highlight_groups = 1
    let g:coc_global_extensions = [
                \'coc-marketplace',
                \'coc-highlight',
                \'coc-clangd',
                \'coc-jedi',
                \'coc-vimlsp',
                \'coc-sh',
                \'coc-json',
                \'coc-yaml'
                \]
endif

"----------------------
" nvim-treesitter setting
"----------------------
if has_key(plugs, 'nvim-treesitter')
    lua require('plugin-config/nvim-treesitter')
endif


nnoremap J :tabprevious<CR>
nnoremap K :tabnext<CR>
nnoremap <leader>J :tabmove -1<CR>
nnoremap <leader>K :tabmove +1<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
nnoremap <silent> <Leader>+ :resize +5<CR>
nnoremap <silent> <Leader>- :resize -5<CR>
nnoremap <silent> <Leader>v+ :vertical resize +5<CR>
nnoremap <silent> <Leader>v- :vertical resize -5<CR>


"HighLight trailing whitespace"
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

"use powerline-vim for normal use
"instead of installing for both user and root
"run to install lib: pip3 install --user powerline-status
"python3 from powerline.vim import setup as powerline_setup
"python3 powerline_setup()
"python3 del powerline_setup
