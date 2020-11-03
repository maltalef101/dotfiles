syntax on
" change cursor style (block cursor on visual/normal, bar/line cursor on insert)
    set guicursor+=v-n-c:block-Cursor
    set hidden
    set history=100
" error bells can suck my juicy toes
    set noerrorbells
" make indenting have some logic (tabs are four spaces because yes :] )
    set tabstop=4 softtabstop=4 shiftwidth=4 smartindent autoindent
" line numbering (this one is kinda obvious don't you think)
    set number relativenumber
" turn off line wrapping
    set nowrap
" add system clipboard. makes using p and P much easier
    set clipboard+=unnamedplus
" only does case sensitive searching if the search term has upper
" case characters
    set smartcase
" don't use swapfiles for buffers
    set noswapfile
" dont use backups, use an undodir
    set nobackup undodir=~/.config/nvim/undodir undofile
" find command stuff
    set path+=**
    set wildignore=**/node_modules/**
" incremental searching: shows and jumps to results while typing
    set incsearch
" removes the retarded vim splitting defaults
    set splitright splitbelow
" uses 24-bit colors
	if has("termguicolors")
		set termguicolors
	endif
" removes autocommenting for new lines
    set formatoptions=tqjl
" give more space for displaying messages.
    set cmdheight=2
" having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
    set updatetime=50
" don't pass messages to |ins-completion-menu|.
    set shortmess+=c
" mouse usage
    set mouse=a
" show cursor line and column
    set cursorline
    set cursorcolumn

" colorscheme setting !!
    colorscheme gruvbox
    set background=dark
    highlight Normal guibg=none
	let g:gruvbox_italics='1'

" better leader key
    let mapleader = " "
