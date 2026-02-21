syntax enable
let mapleader=" "

set background=dark
set termguicolors
set t_Co=256 "terminal color
set t_ut=""
"set term=xterm-256color

"In order to display chinese in GBK
"let &termencoding=&encoding
set fileencodings=utf-8,gbk
set fileformat=unix
set foldmethod=indent
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

" auto added comment leader, detail for :h formatoptions
set formatoptions+=/ro

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

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'ludovicchabant/vim-gutentags'

    Plug 'mbbill/undotree'
    Plug 'preservim/nerdtree'
    Plug 'majutsushi/tagbar'

    Plug 'plasticboy/vim-markdown'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'kdheepak/lazygit.nvim'

    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    Plug 'nvim-treesitter/nvim-treesitter'

    """
    "" avante and its dependents
    " Deps
    Plug 'nvim-lua/plenary.nvim'
    Plug 'MunifTanjim/nui.nvim'
    Plug 'MeanderingProgrammer/render-markdown.nvim'

    " Optional deps
    Plug 'hrsh7th/nvim-cmp'
    Plug 'nvim-tree/nvim-web-devicons' "or Plug 'echasnovski/mini.icons'
    Plug 'HakonHarnes/img-clip.nvim'
    Plug 'zbirenbaum/copilot.lua'
    Plug 'stevearc/dressing.nvim' " for enhanced input UI
    Plug 'folke/snacks.nvim' " for modern input UI

    " Yay, pass source=true if you want to build from source
    Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make' }
    ""
    ""

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
    nnoremap <leader>u :UndotreeToggle<CR>
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
" tagbar setting
"----------------------
if has_key(plugs, 'tagbar')
    nnoremap <leader>t :TagbarToggle<CR>
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
                \'coc-pyright',
                \'coc-lua',
                \'coc-sh',
                \'coc-cmake',
                \'coc-xmake',
                \'coc-json',
                \'coc-yaml',
                \'coc-vimlsp',
                \]
endif

"----------------------
" nvim-treesitter setting
"----------------------
if has_key(plugs, 'nvim-treesitter')
    lua require('plugin-config/nvim-treesitter')

    "set foldmethod=expr
    set foldmethod=indent
    set foldexpr=nvim_treesitter#foldexpr()
    set foldlevel=99
endif

"----------------------
" copilot.lua setting
"----------------------
if has_key(plugs, 'copilot.lua')
    lua require('plugin-config/copilot')
endif

"----------------------
" avante.nvim setting
"----------------------
if has_key(plugs, 'avante.nvim')
    lua require('plugin-config/avante')
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

" shortcut for folding
nnoremap <silent> <Leader>fi :set foldmethod=indent<CR>
nnoremap <silent> <Leader>fd :set foldmethod=manual<CR>ggVGzD

" 禁用 <C-a>
nnoremap <C-a> <Nop>
xnoremap <C-a> <Nop>

"HighLight trailing whitespace"
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

"use powerline-vim for normal use
"instead of installing for both user and root
"run to install lib: pip3 install --user powerline-status
"python3 from powerline.vim import setup as powerline_setup
"python3 powerline_setup()
"python3 del powerline_setup
