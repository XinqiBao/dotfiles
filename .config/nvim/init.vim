syntax enable
let mapleader=" "

set background=dark
set termguicolors

"In order to display chinese in GBK
set fileencodings=utf-8,gbk
set fileformat=unix
set foldmethod=indent
set foldlevelstart=99
set foldlevel=99
set encoding=utf-8

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
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'vim-airline/vim-airline'

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'ludovicchabant/vim-gutentags'

    Plug 'mbbill/undotree'
    Plug 'preservim/nerdtree'
    Plug 'majutsushi/tagbar'

    Plug 'MeanderingProgrammer/render-markdown.nvim'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

    Plug 'tpope/vim-fugitive'
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'kdheepak/lazygit.nvim'

    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    Plug 'nvim-treesitter/nvim-treesitter'

    Plug 'zbirenbaum/copilot.lua'

    " execute 'source' fnameescape(expand('<sfile>:p:h') . '/opt/avante.vim')
    " execute 'source' fnameescape(expand('<sfile>:p:h') . '/opt/leetcode.vim')

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
    function! s:ProjectRg(query) abort
        let dir = expand('%:p:h')
        let dir = isdirectory(dir) ? dir : getcwd()
        let root = systemlist('git -C ' . shellescape(dir) . ' rev-parse --show-toplevel 2>/dev/null')
        if v:shell_error || empty(root)
            echoerr 'Not in a Git repository'
            return
        endif
        call fzf#vim#grep2(
                    \ 'rg --hidden --glob "!.git" --column --line-number --no-heading --color=always --smart-case -- ',
                    \ a:query, fzf#vim#with_preview({'dir': root[0]}))
    endfunction

    command! -nargs=* ProjectRg call <SID>ProjectRg(<q-args>)
    nnoremap <C-p> :GFiles<CR>
    nnoremap <C-f> :ProjectRg<CR>
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
endif

if has_key(plugs, 'indent-blankline.nvim')
    lua require('ibl').setup({ scope = { enabled = false } })
endif

if has_key(plugs, 'gitsigns.nvim')
    lua require('plugin-config/gitsigns')
endif

if has_key(plugs, 'lazygit.nvim')
    nnoremap <silent> <leader>lg :LazyGit<CR>
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

"----------------------
" leetcode.nvim setting
"----------------------
if has_key(plugs, 'leetcode.nvim')
    lua require('plugin-config/leetcode')
endif

nnoremap J :tabprevious<CR>
nnoremap K :tabnext<CR>
nnoremap <leader>J :tabmove -1<CR>
nnoremap <leader>K :tabmove +1<CR>
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
