syntax on

" !!PLUGINS!!
call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
" Syntax highlighting for vim
    Plug 'PotatoesMaster/i3-vim-syntax'
" Plugin made for vim practice
    Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh'}
" Autocomplete
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
" pairs and correct indenting for functions (coc-pairs has some limitations and i don't want redundancy in my plugins)
    Plug 'Raimondi/delimitMate'
    Plug 'tpope/vim-surround'
" Git-related plugins
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
" indent level lines markers
    Plug 'Yggdroot/indentLine'
" Commenter (bc i don't like to use vblocks)
    Plug 'scrooloose/nerdcommenter'
" nerdtree bc netrw is kinda junky
    Plug 'preservim/nerdtree'
" View man pages inside vim
    Plug 'vim-utils/vim-man'
" Gives you a nice undo tree for easy unfuckup-ing
    Plug 'mbbill/undotree'
" Literally the only good language pack for vim
    Plug 'sheerun/vim-polyglot'
" Fuzzy file searching
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
" Write CSS faster
    Plug 'rstacruz/vim-hyperstyle'
" colorschemes!!
    Plug 'gruvbox-community/gruvbox'
    Plug 'sainnhe/gruvbox-material'
    Plug 'flazz/vim-colorschemes'
" Status bar/Tab bar/Buffer bar
    Plug 'vim-airline/vim-airline'
" Goyo for nice prose writing
    Plug 'junegunn/goyo.vim'
call plug#end()

" change cursor style (block cursor on visual/normal, bar/line cursor on insert)
    set guicursor+=v-n-c:block-Cursor
    set hidden
    set history=100
" error bells can suck my juicy toes
    set noerrorbells
" make indenting have some logic (tabs are four spaces because yes :] )
    set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smartindent autoindent
" line numbering (this one is kinda obvious don't you think)
    set number relativenumber
" turn off line wrapping
    set nowrap
" add system clipboard. makes using p and P much easier
    set clipboard+=unnamedplus
" only does case sensitive searching if the search term has upper case characters
    set smartcase
" don't use swapfiles for buffers
    set noswapfile
" dont use backups, use an undodir
    set nobackup
    set undodir=~/.config/nvim/undodir
    set undofile
" find command stuff
    set path+=**
    set wildignore=**/node_modules/**
" incremental searching: shows and jumps to results while typing
    set incsearch
" removes the retarded vim splitting defaults
    set splitright
    set splitbelow
" uses 24-bit colors
    set termguicolors
" how many lines from cursor to the end of the viewport until it scrolls
    set scrolloff=10
" removes autocommenting for new lines
    set formatoptions=tqjl
" Give more space for displaying messages.
    set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
    set updatetime=50
" Don't pass messages to |ins-completion-menu|.
    set shortmess+=c
    set nocompatible

" airline config
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#show_buffers = 0
    let g:airline#extensions#tabline#show_tabs = 1

" nerdcommenter config
    let g:NERDSpaceDelims = 1       " adds space between comments and code

" indentline config
    let g:indentLine_char = '|'
" indentline messes with markdown
    let g:indentLine_concealcursor = "nv"

" gitgutter config:
    let g:gitgutter_signs = 0

" delimitMate config:
    let g:delimitMate_expand_cr = 1
    let g:delimitMate_expand_space = 1

" coc config.
  let g:coc_global_extensions = [
    \ 'coc-snippets',
    \ 'coc-tsserver',
    \ 'coc-eslint',
    \ 'coc-prettier',
    \ 'coc-json',
    \ ]

" better searching:
    " highlights words while searching (fzf style)
    set hlsearch
  " add the ability to cancel the search with escape
    nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>

" prettier command for coc
    command! -nargs=0 Prettier :CocCommand prettier.formatFile

" colorscheme setting !!
    colorscheme gruvbox
    set background=dark
    highlight Normal guibg=none

if executable('rg')
    let g:rg_derive_root='true'
endif


" for when i do use netrw
    let g:netrw_browse_split = 2
    let g:vrfr_rg = 'true'
    let g:netrw_banner = 0
    let g:netrw_winsize = 25

" better leader key
    let mapleader = " "

" better split navigation
    nnoremap <leader>h :wincmd h<CR>
    nnoremap <leader>j :wincmd j<CR>
    nnoremap <leader>k :wincmd k<CR>
    nnoremap <leader>l :wincmd l<CR>

" undotree
    nnoremap <leader>u :UndotreeShow<CR>

" better splitting
    nnoremap <leader>z :split<CR>
    nnoremap <leader>v :vsplit<CR>

" nerdtree bind
    noremap <leader>pv :NERDTreeToggleVCS<CR>

" activate goyo bind
    nnoremap <leader>GG :Goyo \| :highlight Normal guibg=none<CR>

" if you use ripgrep, have this
    nnoremap <Leader>ps :Rg<SPACE>

" show uncommited but tracked files
    nnoremap <C-p> :GFiles<CR>

" show fzf search
    nnoremap <Leader>pf :Files<CR>

" substitute in entire file
    nnoremap S :%s//g<Left><Left>

" source config
    nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>

" split resizing
    nnoremap <Leader>+ :vertical resize +5<CR>
    nnoremap <Leader>- :vertical resize -5<CR>
    nnoremap <Leader>m+ :resize +5<CR>
    nnoremap <Leader>m- :resize -5<CR>

" move selected lines up or down
    vnoremap J :m '>+1<CR>gv=gv
    vnoremap K :m '<-2<CR>gv=gv
" Comment multiple lines using nerdcommenter
    map ++ <plug>NERDCommenterToggle

" tabs keybinds
    nnoremap <leader>n :tabnew<CR>
    nnoremap <leader><Tab> :tabnext<CR>
    nnoremap <leader><S-Tab> :tabprev<CR>

" arrow keys disable:
    vnoremap <Up> <Nop>
    vnoremap <Down> <Nop>
    vnoremap <Left> <Nop>
    vnoremap <Right> <Nop>
    inoremap <Up> <Nop>
    inoremap <Down> <Nop>
    inoremap <Left> <Nop>
    inoremap <Right> <Nop>
    noremap <Up> <Nop>
    noremap <Down> <Nop>
    noremap <Left> <Nop>
    noremap <Right> <Nop>

    vnoremap X "_d
    inoremap <C-c> <esc>

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <C-space> coc#refresh()

" GoTo code navigation.
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next)
nnoremap <leader>cr :CocRestart

" Sweet Sweet FuGITive
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
nmap <leader>gs :G<CR>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd BufWritePre * :call TrimWhitespace()
